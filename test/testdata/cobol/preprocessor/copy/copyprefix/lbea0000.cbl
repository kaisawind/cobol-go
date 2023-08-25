000100*T   仕入先マスタ更新
000200 IDENTIFICATION                    DIVISION.                      P
000300 PROGRAM-ID.                       LBEA0000.                      P
000400* PATTERN-ID.                      CONVT001.                      P
000500 AUTHOR.                           HITACHI.                       P
000600** 入出力ファイル：                                               P
000700** USER-S:                                                        P
000800**     I01  :         仕入先ファイル
000900** USER-E:                                                        P
001000** 使用ソース部品：                                               P
001100*   +-------------------------------------------------+           P
001200*   | 使用したソース部品を記述する 。                 |           P
001300*   +-------------------------------------------------+           P
001400** USER-S:                                                        P
001500** USER-E:                                                        P
001600** 使用サブルーチン部品：                                         P
001700*   +-------------------------------------------------+           P
001800*   |  使用したサブルーチン部品を記述する。           |           P
001900*   +-------------------------------------------------+           P
002000** USER-S:
002100*      LBEDC000       仕入先マスタ
002200** USER-E:                                                        P
002300 ENVIRONMENT                       DIVISION.                      P
002400 CONFIGURATION                     SECTION.                       P
002500 SOURCE-COMPUTER.                  3500.                          P
002600 OBJECT-COMPUTER.                  3500.                          P
002700 SPECIAL-NAMES.                                                   P
002800                                   C01       IS   PCHANGE.        P
002900 INPUT-OUTPUT                      SECTION.                       P
003000 FILE-CONTROL.                                                    P
003100*C 入力ファイル（I01)                                             P
003200*   +-------------------------------------------------+           P
003300*   | 入力ファイルの数だけ指定する。                  |           P
003400*   +-------------------------------------------------+           P
003500*L  (仕入先ファイル）                                             P
003600** USER-S:                                                        P
003700  SELECT I01                                                      P
003800      ASSIGN    TO       UT-SYS100                                P
003900      ORGANIZATION LINE SEQUENTIAL.                               P
004000** USER-E:                                                        P
004100** 出力ファイル（O01)                                             P
004200*   +-------------------------------------------------+           P
004300*   | 出力ファイルの数だけ指定する。                  |           P
004400*   +-------------------------------------------------+           P
004500*L  (ファイル名を記述。ＤＢの場合はコメントで対応を記述。）       P
004600** USER-S:                                                        P
004700* SELECT O01                                                      P
004800*     ASSIGN    TO       UT-SYS100.                               P
004900** USER-E:                                                        P
005000 DATA                              DIVISION.                      P
005100 FILE                              SECTION.                       P
005200**                                                                P
005300*   +-------------------------------------------------+           P
005400*   |  入力ファイル (I01):（仕入先ファイル）          |           P
005500*   +-------------------------------------------------+           P
005600*USER-S:                                                          P
005700 FD   I01.                                                        P
005800     COPY rlbebh0i        
                                      PREFIXING I01-.
005900   02  I01-NEWLINE              PIC  X(001).                      P
006000**USER-E:                                                         P
007000 WORKING-STORAGE                   SECTION.                       P
007100*D   日付                                                         P
007200 01  W-HIZUKE.                                                    P
007300   03  W-DATE.                                                    P
007400     05  W-D-YYYY.                                                P
007500       07  W-D-YY-U2               PIC  X(02).                    P
007600       07  W-D-YY-L2               PIC  X(02).                    P
007700     05  W-D-MM                    PIC  X(02).                    P
007800     05  W-D-DD                    PIC  X(02).                    P
007900   03  W-TIME.                                                    P
008000     05  W-T-HH                    PIC  X(02).                    P
008100     05  W-T-MM                    PIC  X(02).                    P
008200     05  W-T-SS                    PIC  X(02).                    P
008300     05  W-T-SS100                 PIC  X(02).                    P
008400   03  FILLER                      PIC  X(05).                    P
008500*                                                                 P
008600******************************************************************P
008700*D   表示用時刻                                                   P
008800 01  DISP-HIZUKE-AREA.                                            P
008900   03  DISP-DATE.                                                 P
009000     05  DISP-D-YYYY               PIC  X(04).                    P
009100     05  FILLER                    PIC  X(01) VALUE '/'.          P
009200     05  DISP-D-MM                 PIC  X(02).                    P
009300     05  FILLER                    PIC  X(01) VALUE '/'.          P
009400     05  DISP-D-DD                 PIC  X(02).                    P
009500     05  FILLER                    PIC  X(01) VALUE SPACE.        P
009600   03  DISP-TIME.                                                 P
009700     05  DISP-T-HH                 PIC  X(02).                    P
009800     05  FILLER                    PIC  X(01) VALUE ':'.          P
009900     05  DISP-T-MM                 PIC  X(02).                    P
010000     05  FILLER                    PIC  X(01) VALUE ':'.          P
010100     05  DISP-T-SS                 PIC  X(02).                    P
010200     05  FILLER                    PIC  X(01) VALUE '.'.          P
010300     05  DISP-T-SS100              PIC  X(02).                    P
010400******************************************************************P
010500*D   ABEND メッセージ                                             P
010600 01  MSG-ABN-AREA.                                                P
010700   03  MSG-ABN0.                                                  P
010800     05  FILLER                    PIC  X(15)  VALUE ALL '*'.     P
010900     05  FILLER                    PIC  X(19)                     P
011000                                  VALUE  'ABEND ﾒｯｾｰｼﾞ  START'.   P
011100     05  FILLER                    PIC  X(16)  VALUE ALL '*'.     P
011200*L プログラムＩＤ                                                 P
011300   03  MSG-ABN1.                                                  P
011400     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
011500     05  ABN-PGMID                 PIC  X(08)  VALUE SPACE.       P
011600     05  FILLER                    PIC  X(37)  VALUE ALL '*'.     P
011700*L セクション名                                                   P
011800   03  MSG-ABN2.                                                  P
011900     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
012000     05  ABN-SEC                   PIC  X(30)  VALUE SPACE.       P
012100     05  FILLER                    PIC  X(15)  VALUE ALL '*'.     P
012200*L アベンドコード                                                 P
012300   03  MSG-ABN3.                                                  P
012400     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
012500     05  FILLER                    PIC  X(13)                     P
012600                                          VALUE 'ｱﾍﾞﾝﾄﾞｺｰﾄﾞ = '.  P
012700     05  ABN-CD                    PIC  ----9.                    P
012800     05  FILLER                    PIC  X(27)  VALUE ALL '*'.     P
012900*L アクセスＫＥＹ                                                 P
013000   03  MSG-ABN4.                                                  P
013100     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
013200     05  ABN-KEY                   PIC  X(20)  VALUE SPACE.       P
013300     05  FILLER                    PIC  X(25)  VALUE ALL '*'.     P
013400*L コメント１                                                     P
013500   03  MSG-ABN5.                                                  P
013600     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
013700     05  ABN-CMT1                  PIC  X(40)  VALUE SPACE.       P
013800     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
013900*L コメント２                                                     P
014000   03  MSG-ABN6.                                                  P
014100     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
014200     05  ABN-CMT2                  PIC  X(40)  VALUE SPACE.       P
014300     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
014400*L コメント３                                                     P
014500   03  MSG-ABN7.                                                  P
014600     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
014700     05  ABN-CMT3                  PIC  X(40)  VALUE SPACE.       P
014800     05  FILLER                    PIC  X(05)  VALUE ALL '*'.     P
014900*L アベンドメッセージ終了                                         P
015000   03  MSG-ABN8.                                                  P
015100     05  FILLER                    PIC  X(10)  VALUE ALL '*'.     P
015200     05  FILLER                    PIC  X(17)                     P
015300                                  VALUE  'ｱﾍﾞﾝﾄﾞﾒｯｾｰｼﾞ  END'.     P
015400     05  FILLER                    PIC  X(23)  VALUE ALL '*'.     P
015500                                                                  P
015600*D   開始メッセージ                                               P
015700 01  MSG-START.                                                   P
015800   03  FILLER                      PIC  X(10)  VALUE '       ***'.P
015900   03  START-PGMID                 PIC  X(10)  VALUE SPACE.       P
016000   03  FILLER                      PIC  X(10)  VALUE ' START ***'.P
016100*                                                                 P
016200*D   終了メッセージ                                               P
016300 01  MSG-END.                                                     P
016400   03  FILLER                      PIC  X(10)  VALUE '       ***'.P
016500   03  END-PGMID                   PIC  X(10)  VALUE SPACE.       P
016600   03  FILLER                      PIC  X(10)  VALUE '  END  ***'.P
016700*                                                                 P
016800**USER-S:                                                         P
016900*D   入力件数メッセージ                                           P
017000 01  MSG-CNT-I01.                                                 P
017100   03  FILLER                      PIC  X(30)                     P
017200                   VALUE 'I01                           '.        P
017300   03  FILLER                      PIC  X(10)  VALUE '   レコー '.P
017400   03  FILLER                      PIC  X(10)  VALUE 'ド件数 =  '.P
017500*                                                                 P
017600*D   出力件数メッセージ                                           P
017700 01  MSG-CNT-DO01.                                                P
017800   03  FILLER                      PIC  X(30)                     P
017900                   VALUE '仕入先マスタ                  '.        P
018000   03  FILLER                      PIC  X(10)  VALUE '        追'.P
018100   03  FILLER                      PIC  X(10)  VALUE '加件数 =  '.P
       01  MSG-CNT-DU01.                                                P
         03  FILLER                      PIC  X(30)                     P
                         VALUE '仕入先マスタ                  '.        P
         03  FILLER                      PIC  X(10)  VALUE '        更'.P
         03  FILLER                      PIC  X(10)  VALUE '新件数 =  '.P
018200*D   入力カウント                                                 P
018300 01  CNT-I01-AREA.
018400   03  CNT-I01                     PIC  S9(09).
018500*D   出力カウント                                                 P
018600 01  CNT-DO01-AREA.                                               P
018700   03  CNT-DO01                    PIC  9(09).                    P
         03  CNT-DU01                    PIC  9(09).                    P
018800*D   新日付マスタ 管理情報 更新用ホスト変数
018900 01  HOST-PGMID                    PIC X(08).
019000 01  HOST-BLANK                    PIC X(08)  VALUE SPACE.
019100 01  HOST-HIZUKE.
019200   03  HOST-HI.
019300     05  HOST-D-YYYY               PIC  X(04).
019400     05  HOST-D-MM                 PIC  X(02).
019500     05  HOST-D-DD                 PIC  X(02).
019600   03  HOST-TIME.
019700     05  HOST-T-HH                 PIC  X(02).
019800     05  HOST-T-MM                 PIC  X(02).
019900     05  HOST-T-SS                 PIC  X(02).
020000     05  HOST-T-SS100              PIC  X(02).
020100 01  HOST-HIZUKE-R                 PIC  X(16).
020200*                                                                 P
020300******************************************************************P
020400*D   レコード終了フラグ
020500 01  SW-CUR-END                   PIC  X(001)  VALUE SPACE.       P
020600**USER-E:                                                         P
020700*D  予約定数                                                      P
020800 01  CONTANT-AREA.                                                P
020900*      エンドフラグの定数                                         P
021000   03  CN-TRUE                    PIC  X(001) VALUE '1'.          P
021100*      改行コード                                                 P
021200   03  CN-NEWLINE                 PIC  X(001) VALUE X'0A'.        P
021300*D  プログラム名                                                  P
021400   03  PGMID                      PIC  X(008) VALUE 'LBEA0000'.   P
021500*D  テーブル名称                                                  P
021600*  03  TABLE-NAME                 PIC  X(40).                     P
021700**                                                                P
021800*D  ＳＱＬ使用領域の宣言                                          P
021900*D  CBNABNの引数として使用する領域                                P
022000 01  ABEND-CODE                   PIC S9(004) USAGE  COMP.        P
022100**USER-S:                                                         P
022200***************************************************************** P
022300*D  ＳＱＬ使用領域の宣言                                          P
022400*                                                                 P
022500*D  SQLCAの展開                                                   P
022600*   +-------------------------------------------------+           P
022700*   | 一般の場合はこちらが有効                        |           P
022800*   +-------------------------------------------------+           P
022900     COPY  SQLCA.                                                 P
023000*   +-------------------------------------------------+           P
023100*   | 直接ＳＱＬ記述の場合はこちらが有効              |           P
023200*   +-------------------------------------------------+           P
023300*     EXEC SQL                                                    P
023400*       INCLUDE SQLCA                                             P
023500*     END-EXEC                                                    P
023600*     EXEC SQL                                                    P
023700*       BEGIN   DECLARE SECTION                                   P
023800*     END-EXEC                                                    P
023900**USER-E:                                                         P
024000*   +-------------------------------------------------+           P
024100*   | ＳＱＬ使用領域の追加作業領域                    |           P
024200*   +-------------------------------------------------+           P
024300**USER-S:                                                         P
024400**USER-E:                                                         P
024500*   +-----------------------------------------------------+       P
024600*   |ＤＢを直接使用する際は次の行以降のコメントを除去する |       P
024700*   +-----------------------------------------------------+       P
024800**USER-S:                                                         P
024900*    EXEC SQL                                                     P
025000*      END DECLARE SECTION                                        P
025100*    END-EXEC.                                                    P
025200**USER-E:                                                         P
025300*   +-----------------------------------------------------+       P
025400*   |ＤＢを直接使用する際は前の行までのコメントを除去する |       P
025500*   +-----------------------------------------------------+       P
025600**                                                                P
025700*D   ユーザ追加領域(SQL使用領域以外)                              P
025800*   +-------------------------------------------------+           P
025900*   |ＳＱＬ使用領域の以外のユーザ追加作業領域         |           P
026000*   +-------------------------------------------------+           P
026100**USER-S:                                                         P
026200**USER-E:                                                         P
026300******************************************************************P
026400*D  コピー文展開                                                  P
026500******************************************************************P
026600*C XDATBAS（全体）アクセス領域                                    P
026700*   +-------------------------------------------------+           P
026800*   |ＤＢを使用する際は次の行以降のコメントを除去する |           P
026900*   +-------------------------------------------------+           P
027000**USER-S:                                                         P
027100***   ここから ***************************************************P
027200 01  XDATBAS-MODE                 PIC     X(05).
027300**C データベースアクセス定数                                      P
027400     COPY  rlbedc01.
027500**C SQLCODE定数                                                   P
027600     COPY  rlbedc02.
027700**C ＤＩＡエリア定義
027800     COPY  rlbedd00               PREFIXING  XDATBAS-.            P
027900**C データベース  データエリア定義
028000     COPY  rlbedd0c               PREFIXING  D01-.
028100**C データベース  キーエリア定義
028200     COPY  rlbedd0c               PREFIXING  K01-.
028300***   ここまで ***************************************************P
028400**USER-E:                                                         P
028500 LINKAGE                           SECTION.                       P
028600**USER-S:                                                         P
028700**USER-E:                                                         P
028800 PROCEDURE                         DIVISION.                      P
028900******************************************************************P
029000*                                                                *P
029100*    メイン処理                                                  *P
029200*                                                                *P
029300******************************************************************P
029400 MAIN-PROC                         SECTION.                       P
029500*G   メイン処理                                                   P
029600     PERFORM  JUNBI-PROC
029700     PERFORM  SIIRE-PROC
029800     PERFORM  SYURYO-PROC
029900     MOVE  ZERO                   TO  RETURN-CODE
030000     STOP RUN.                                                    P
030100******************************************************************P
030200*                                                                *P
030300*    準備処理                                                    *P
030400*                                                                *P
030500******************************************************************P
030600 JUNBI-PROC                        SECTION.                       P
030700*G   準備処理                                                     P
030800*G   領域の初期化                                                 P
030900     MOVE  PGMID                  TO  START-PGMID                 P
031000     MOVE  PGMID                  TO  END-PGMID                   P
031100     MOVE  PGMID                  TO  ABN-PGMID                   P
031200     DISPLAY                   MSG-START  UPON  SYSOUT            P
031300*G   日付設定                                                     P
031400     PERFORM  GET-CURRENT-DATE-PROC                               P
031500**USER-S:                                                         P
031600     MOVE     ZERO                TO  CNT-I01
031700     MOVE     ZERO                TO  CNT-DO01                    P
                                            CNT-DU01
           MOVE  SPACE                  TO  SW-CUR-END                  P
           INITIALIZE                   XDATBAS-DIA
                                        SQLCA
                                        D01-RLBEDD0C-AREA
                                        K01-RLBEDD0C-AREA
031800**USER-E:                                                         P
031900*G   ファイルのオープン                                           P
032000*   +-------------------------------------------------+           P
032100*   |ファイル数にあわせ変更する。                     |           P
032200*   +-------------------------------------------------+           P
032300**USER-S:                                                         P
032400      MOVE  'JUNBI-PROC'          TO  ABN-SEC                     P
032500      OPEN                                                        P
032600               INPUT   I01                                        P
032700**USER-E:                                                         P
032800**                                                                P
032900*G   ＤＢの接続                                                   P
033000*   +-------------------------------------------------+           P
033100*   | ＤＢを使用する際は次の行のコメントを除去する    |           P
033200*   | 使用しない時は削除する。                        |           P
033300*   +-------------------------------------------------+           P
033400**USER-S:                                                         P
033500      MOVE  SPACE                 TO  XDATBAS-DIA                 P
033600      CALL  'LBED0000'         USING  SINON                       P
033700                                      XDATBAS-DIA                 P
033800                                      SQLCA                       P
033900       IF ( XDATBAS-STAT  NOT = CN-XDATBAS-OK )                   P
034000         THEN                                                     P
034100*          MOVE  'SINON ERR'      TO  ABN-CMT1
034200           PERFORM  DB-ERR-PROC
034300         ELSE                                                     P
034400           CONTINUE                                               P
034500       END-IF                                                     P
034600**USER-E:                                                         P
034700**                                                                P
034800*G   ＤＢテーブル・ビューの宣言（DECLARE CURSOR)                  P
034900*   +-------------------------------------------------+           P
035000*   |ＤＢテーブル・ビューの宣言を記述する。           |           P
035100*   +-------------------------------------------------+           P
035200**USER-S:
035300**USER-E:                                                         P
035400*   +-------------------------------------------------+           P
035500*   | ＤＢテーブル・ビューのオープン（OPEN CURSOR)    |           P
035600*   +-------------------------------------------------+           P
035700**USER-S:                                                         P
035800**USER-E:                                                         P
035900     CONTINUE.                                                    P
036000******************************************************************P
036100*                                                                *P
036200*    仕入先マスタ  出力処理                                      *P
036300*                                                                *P
036400******************************************************************P
036500 SIIRE-PROC                        SECTION.
036600*G   仕入先マスタ  出力処理
036700**USER-S:
036800     MOVE  'SIIRE-PROC'           TO  ABN-SEC
037600     PERFORM  I01-INPUT-PROC
037700     PERFORM  WITH TEST BEFORE
037800              UNTIL  SW-CUR-END = '1'
037800       MOVE  I01-SHIIRE-REC       TO  D01-RLBEDD0C-AREA
037900       MOVE  I01-SHIIRE-REC       TO  K01-RLBEDD0C-AREA
038000       MOVE  'LBEA0000'           TO  D01-KOSIN-PGM
038100       MOVE  SPACE                TO  D01-TERM-ID
038200       MOVE  W-DATE               TO  HOST-HI
038300       MOVE  W-TIME               TO  HOST-TIME
038400       MOVE  HOST-HIZUKE          TO  D01-KOSIN-NTJ
037900     PERFORM  SIIRE-HANTEI-PROC
038100     PERFORM  I01-INPUT-PROC
038200     END-PERFORM
038300**USER-E:
038400       CONTINUE.
038500******************************************************************P
038600*                                                                *P
038700*      仕入先マスタ  アクセスルーチン                            *P
038800*                                                                *P
038900******************************************************************P
039000 SIIRE-HANTEI-PROC                 SECTION.
039100*G   仕入先マスタ  アクセスルーチン
039200**USER-S:
      **   仕入先マスタ更新
039300     MOVE  'SIIRE-HANTEI-PROC'    TO  ABN-SEC
039400     CALL  'LBED0C00'          USING  WRITV
039500                                      XDATBAS-DIA
039600                                      D01-RLBEDD0C-AREA
039700                                      K01-RLBEDD0C-AREA
039800                                      SQLCA
040100     EVALUATE  XDATBAS-STAT
040200       WHEN     CN-XDATBAS-OK
040300         COMPUTE  CNT-DU01  =  CNT-DU01 +  1
             WHEN     CN-XDATBAS-NODATA
      **       対象データが存在しない場合、追加する。
               CALL  'LBED0C00'      USING  ADD-M
                                            XDATBAS-DIA
                                            D01-RLBEDD0C-AREA
                                            K01-RLBEDD0C-AREA
                                            SQLCA
               EVALUATE  XDATBAS-STAT
                 WHEN     CN-XDATBAS-OK
                   COMPUTE  CNT-DO01  =  CNT-DO01 +  1
                 WHEN OTHER
                   PERFORM  DB-ERR-PROC
               END-EVALUATE
040600       WHEN OTHER
040700         PERFORM  DB-ERR-PROC
040800     END-EVALUATE
041200**USER-E:
041300       CONTINUE.
041400******************************************************************P
041500*                                                                *P
041600*    終了処理                                                    *P
041700*                                                                *P
041800******************************************************************P
041900 SYURYO-PROC                       SECTION.                       P
042000*G   終了処理                                                     P
042100*G   ファイルのクローズ                                           P
042200*   +-------------------------------------------------+           P
042300*   | ファイル数にあわせ変更する。                    |           P
042400*   +-------------------------------------------------+           P
042500**USER-S:                                                         P
042600     MOVE  'SYURYO-PROC'         TO  ABN-SEC                      P
042700     CLOSE                                                        P
042800                  I01                                             P
042900**USER-E:                                                         P
043000**                                                                P
043100*   +-------------------------------------------------+           P
043200*   |ＤＢテーブル・ビューのクローズ（CLOSE CURSOR)    |           P
043300*   +-------------------------------------------------+           P
043400**USER-S:                                                         P
043500**USER-E:                                                         P
043600*   +-------------------------------------------------+           P
043700*   |ＤＢ実更新(COMIT)                                |           P
043800*   +-------------------------------------------------+           P
043900**USER-S:
044000     CALL  'LBED0000'    USING  COMIT                             P
044100                                XDATBAS-DIA                       P
044200                                SQLCA                             P
044300     IF ( XDATBAS-STAT  NOT = CN-XDATBAS-OK )                     P
044400       THEN                                                       P
044500*        MOVE  'COMIT ERR'       TO  ABN-CMT2
044600         PERFORM  DB-ERR-PROC
044700       ELSE                                                       P
044800         CONTINUE                                                 P
044900     END-IF                                                       P
045000**USER-E:                                                         P
045100**                                                                P
045200*G   ＤＢの切断                                                   P
045300*   +-------------------------------------------------+           P
045400*   |ＤＢを使用する際は次の行のコメントを除去する     |           P
045500*   +-------------------------------------------------+           P
045600**USER-S:
045700*
045800     CALL  'LBED0000'    USING  SINOF                             P
045900                                XDATBAS-DIA                       P
046000                                SQLCA                             P
046100     IF ( XDATBAS-STAT  NOT = CN-XDATBAS-OK )                     P
046200       THEN                                                       P
046300*        MOVE  'SINOFF ERR'       TO  ABN-CMT2
046400         PERFORM  DB-ERR-PROC
046500       ELSE                                                       P
046600         CONTINUE                                                 P
046700     END-IF                                                       P
046800**USER-E:                                                         P
046900*   +-------------------------------------------------+           P
047000*   |使用するファイル数にあわせ変更する               |           P
047100*   +-------------------------------------------------+           P
047200*G   終了メッセージの表示                                         P
047300**USER-S:                                                         P
047400     DISPLAY    MSG-CNT-I01       CNT-I01             UPON SYSOUT P
           DISPLAY    MSG-CNT-DU01      CNT-DU01            UPON SYSOUT
047500     DISPLAY    MSG-CNT-DO01      CNT-DO01            UPON SYSOUT
047600     DISPLAY                      MSG-END             UPON SYSOUT P
047700**USER-E:                                                         P
047800     CONTINUE.                                                    P
047900*                                                                 P
048000******************************************************************P
048100*                                                                *P
048200*    ファイル(I01)入力処理                                       *P
048300*                                                                *P
048400******************************************************************P
048500 I01-INPUT-PROC                   SECTION.
048600*G   ファイル（I01)入力処理
048700     MOVE  'I01-INPUT-PROC'       TO  ABN-SEC
048800**USER-S:
048900     READ  I01
049000       AT END
049100          MOVE  CN-TRUE           TO  SW-CUR-END
049200     END-READ
049300     IF         SW-CUR-END        =   SPACE
049400      THEN
049500        COMPUTE  CNT-I01          =   CNT-I01  +  1
049600      ELSE
049700        CONTINUE
049800     END-IF
049900**USER-E
050000     CONTINUE.
051600******************************************************************P
051700*                                                                *P
051800*    ユーザ コーディング  エリア                                 *P
051900*                                                                *P
052000******************************************************************P
052100*   +-------------------------------------------------+           P
052200*   | ユーザ固有の処理を記述する。                    |           P
052300*   +-------------------------------------------------+           P
052400**USER-S:                                                         P
052500**USER-E:                                                         P
052600******************************************************************P
052700*                                                                *P
052800*    日付取得処理                                                *P
052900*                                                                *P
053000******************************************************************P
053100 GET-CURRENT-DATE-PROC             SECTION.                       P
053200*G   日付取得処理                                                 P
053300     MOVE  FUNCTION  CURRENT-DATE TO  W-HIZUKE                    P
053400     MOVE  W-D-YYYY               TO   DISP-D-YYYY                P
053500     MOVE  W-D-MM                 TO   DISP-D-MM                  P
053600     MOVE  W-D-DD                 TO   DISP-D-DD                  P
053700     MOVE  W-T-HH                 TO   DISP-T-HH                  P
053800     MOVE  W-T-MM                 TO   DISP-T-MM                  P
053900     MOVE  W-T-SS                 TO   DISP-T-SS                  P
054000     MOVE  W-T-SS100              TO   DISP-T-SS100               P
054100     CONTINUE.                                                    P
054200**                                                                P
054300******************************************************************P
054400*                                                                *P
054500*    ＤＢエラー処理                                              *P
054600*                                                                *P
054700******************************************************************P
054800 DB-ERR-PROC                     SECTION.                         P
054900*G   ＤＢのエラー処理                                             P
055000*   +-------------------------------------------------+           P
055100*   | ＤＢを使用する場合は、次のコメントを除去する。  |           P
055200*   +-------------------------------------------------+           P
055300**USER-S:                                                         P
055400       MOVE  SQLCODE              TO   ABEND-CODE                 P
055500       CALL  'LBED0000'    USING  RBACK                           P
055600                                  XDATBAS-DIA                     P
055700                                  SQLCA                           P
055800**USER-E:                                                         P
055900     PERFORM   ABEND-PROC.                                         P
056000*     CONTINUE.                                                    P
056100******************************************************************P
056200*                                                                *P
056300*    アベンドメッセージ表示 と アベンド処理                      *P
056400*                                                                *P
056500******************************************************************P
056600 ABEND-PROC                      SECTION.                         P
056700*G   アベンドメッセージ表示 と アベンド処理                       P
056800     MOVE     W-DATE      TO  MSG-ABN1(20:8)                      P
056900     MOVE     W-TIME(1:6) TO  MSG-ABN1(30:6)                      P
057000     MOVE     ABEND-CODE  TO  ABN-CD                              P
057100     DISPLAY  MSG-ABN0  UPON  SYSOUT                              P
057200     DISPLAY  MSG-ABN1  UPON  SYSOUT                              P
057300     DISPLAY  MSG-ABN2  UPON  SYSOUT                              P
057400     DISPLAY  MSG-ABN3  UPON  SYSOUT                              P
057500     DISPLAY  MSG-ABN4  UPON  SYSOUT                              P
057600**USER-S:                                                         P
057700*    IF  ABN-CMT1       =     SPACE                               P
057800*      THEN                                                       P
057900*        CONTINUE                                                 P
058000*      ELSE                                                       P
058100*        DISPLAY  MSG-ABN5  UPON  SYSOUT                          P
058200*    END-IF                                                       P
058300*    IF  ABN-CMT2       =     SPACE                               P
058400*      THEN                                                       P
058500*        CONTINUE                                                 P
058600*      ELSE                                                       P
058700*        DISPLAY  MSG-ABN6  UPON  SYSOUT                          P
058800*    END-IF                                                       P
058900*    IF  ABN-CMT3       =     SPACE                               P
059000*      THEN                                                       P
059100*        CONTINUE                                                 P
059200*      ELSE                                                       P
059300*        DISPLAY  MSG-ABN7  UPON  SYSOUT                          P
059400*    END-IF                                                       P
059500**USER-E:                                                         P
059600     DISPLAY  MSG-ABN8  UPON  SYSOUT                              P
059700     CALL  'CBLABN'  USING  ABEND-CODE.                           P
059800*    CONTINUE.                                                    P
059900 END PROGRAM LBEA0000.                                            P
