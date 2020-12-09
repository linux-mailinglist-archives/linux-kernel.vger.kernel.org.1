Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EDB2D48CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbgLISSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:18:24 -0500
Received: from sonic308-2.consmr.mail.bf2.yahoo.com ([74.6.130.41]:33062 "EHLO
        sonic308-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728488AbgLISSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1607537837; bh=BIAED5lyxrQqSGuEmcGxTkuJ0CSfx5g73a3a2AcUX4A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=GG1bRipxdQrTBWduDBaoXrvr98VTNCM/kwhavvnr9G+M9ZwNANtA5QAHLCBhC7ZiRPQoUYa7qb3X58w+Nn8+OFAopek0ep/ffdAiZLOmb+7DHLiNDbV68B5j9pAynwOB8aQbNLyIwVclrrHOoY33EAsWsu9PwDRZ0nMygif0v5WZAwdpVLIhHyOv2XbRVNuSyB2shRvmnhUw5TqURpCH1AdTJiix89tT+DY0nlUUykmjNfYW3djubqpqv1V/bYOscfRt5vHYooo0Vo2+n0ylXzE6SwKe5hD+/2EK0nBiayt4vHs0iPYM33kmgq/AGfCvGl+r7utgKSWAMc+PNfNSmw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607537837; bh=4RTYAD3kKnOr3+ghtE2YmOMXf4sDuS1H0ce0/JoobzQ=; h=Date:From:Subject:From:Subject; b=mSLQoSWeCeeYP2myo+oL9V+IdRo5ocuuIUAdb8tVK5j41R04bFZLEzxXMB75RKTf8cBvxcFZpsgJ+zjcu92Dx9T1cV71rKZwtE/iOFDEElc6eB/H5Nt8NeOcsudTVVLfC1m/vokjCt8CezmTRrJKz1LK/2fLpNUHyYBDi9IiYohHJVSu1ebbhFWkljHTBdleIynfHvIfuFqBjwGC13VoujDo1foILjBK/+nkr0zsI2ss1klsn5u6TeLyqiBO3juHBKmDS/UKq/eng4MYkn/Bb89xYDJsF7WgYTdzehb3F5xk4cCUHJ/fHMoZYxS8GBLmyTo6Ijm7/Pa2V642l6VF4Q==
X-YMail-OSG: Fr.9NmoVM1nh7rz7b1Octe1VKbOBqYRPpvMvmQn.jfsB_UsVkpf3UbBtNmKiF97
 U4JWjRiuVYoZ5.ZH29rAgnezP7yBIeFQXqwuElG6Zj5kViV6ao4XoBUqF2Vd5DsogAAbZXdY_g3h
 dEJp6LVhKlhFJn45HxFU5KHLOnSK1W8HH7W7Q9BbfF2_EeUhvgS.aQl92PL4j8Vixe_PcPgwh9vE
 GozTBOUKJskq13Bm9GqMVQKIF_dS4C31d46U_K2_YFgeESj57K4x_LTpzlrEhzNdBw7kQQVCfJIU
 xzdqGuolFvQlDoyBzftgdqGZKg.eL418SXJ5yMxrKSILodUyGCOXeEKFWhUeAQVfo_2yaWAJUEtD
 VzkFZNcYoaf9LQKsXmXmW2a58DJKO_2_w9HEmhM0JybJAVKTV_EkvI2x6ur6I8eTtMigY082.MYE
 QZvdUqZ7SaMhp1fHRJ11iRnPLVitO_Jv3HG8Mmlb1RdhqDOUQDu4fSZzHgjqXgFLQQy4zClg9KJw
 I7GRapHQzebufOed5jVfqcIDZ25IdoFH_Bnf2oXrW5fOiM1JEXmDxxyRPKzTUNJrPkJYBy6K_a1.
 lhXPlkLSiTb0LOZhh7oFs5kK2uVkVlVAirbzexBMuGyYhCN_1nGHao3eqCxuu9VjVUI.wOX17mbO
 Cp8hY9uu39L33RofHuQ61f4ks74ucMKswPXflw817avFAyGAMCHda72OmXW6xiHpMf5RpraCLlKM
 _pup3.JDDcIr0VUeU4xp3s2gwj7kFmsMjOycYdNur5OuSMytWPvt4bBq6epuFKCHbL8F73q7RwAA
 XY.ptGj5_1NgijEv9KrrA0nqscYPEgCp7Eyx2R_DkkwZupYA4jxpeQLWkoNNdznKPU3DjZltCT1s
 aL78w1KA.1Icv3EuwNns5Xk7b6Vy33JBI0mW9pWJguHKrjwIcnSOe1HpCNBc_b5R2NKalvVFjV2A
 CEMW7_PXVinKfFVphGE6gUQFI9xhjE.2HLAYbFm.GKAha90rR5AnF9RXPnMNLwdxXLL.X2CfGSEs
 1BeaM.Lf5B3CSl_sBqqQayPvUOKnvf74JvrGVil._.t1bxo2aQrSoaiaonCa0hOmnIAs0cSeLEGw
 MyaOY7YSlBNhxz7_tAoM1F0rMicf50kEfvsddtW2OlKmXGLpPrAqsrEo8tT8t_RHCt8pgvJoZ3tU
 nGBwwwSOnZYMaG.4mHO1ryiONlMqh7NiNjiV7qKC5.Rw0mX9zgGGUqSqHsw8oUXs.ipiar6JBsnO
 .y4hrbSvRgoYtVuZcogVUOj2G8AA3wzhtwlBxKK1MliUXqcJi8BVNzXBywh5MjekA6qloO4XFT1f
 Uimu59P3mv_4ayFO2m3hiQUCmrrOxAZhcuV0iU9cQlvx0.2zdnDT7rAMKqidEYeNr0la7ir7cTdP
 IuFMaskptErvQZOnICDDwZ71SYwMcq7lzgVISXXBDCvpZJcjB7MLlMAFu97HqyoJiWfpqJTvvufW
 LHJKAjuLMNj9vZUCyCku7YOJGV2VKZXWE0QB9qvE3P6MFTGmGQXNLwBFtJzC3dpLicqjGcFgPlK_
 PHyV5FwIfdnK0AO0nYUa3IqM762ln_X1ZiuUtZIt5P0Xyk9mQgN9zcyjNqso85dFKpL.E_IEPZ4Z
 K.UbP3sKumL3GKnFy4SxS2TDhdCdqgx4daWsxALnHnTNxeyjPLi79ZWxqY6Ix.mmIB8KNWHQ5Oqe
 aHLS8P96rwYWTjTE3dL1D2v3moFdBsnRYoStqsvzqb_ZPFIRo4RPsQOm.QDFKDTmD5GKikm8uOW2
 6ktdSbYyxmhBehyYMYcEfYh4v88Yy85Gj3q9nIouK.lgoVGNYLrbT64MCc62eL7k4jUbSMK2BDJg
 mEeMrpembNk1C.T5pyfM0i_hPfsS8If2wQrXhMeX5ox5IfZ75h.YD1eAEQoCgY9WYXdzL9VPfWMF
 oSzuB7yy4jQqgdIMEsOF6LFAL0xwLuuEorF7Q0ZZTCGboeEFJljnP3z3E9PhtsuSeDZWuVrqvEmr
 BFl4MWN2ZLRY2Fs05bYJbBe.FRN8AiUcPe1q9PMTJTNRpGGJJ1zV4ICVl_aaBAbVui138JWDmoSV
 ZG.K8kgIRPIFzOfMB6I0TNF0DgUHAL0K7wzXNsfQrq8dimILL3NADkWxNjjMHd3Bf9PEAImMNZPX
 eewK8KHknbBLT3.0wKT1fv9JyxFdBiCyPaS4ihusYJ0pai_JGkMQUrweCFIxVpI87chKsIFdelZA
 52GMAg9pX.KefND5vXU7ZR52hRvfyidB8dC.gWtCwZ3Twn1N7Isnxb632CeUXunENGrzO_hbuI3H
 TThyzI7MGx3ej9fprBuvzRWrOtlqHNrMLrLCiXaeCTNIrB.FrBp6lkX6AMepSi5s8RDB9GCLamed
 Ixz.2f9GvCSPXmRCTw.H.egzaE_Wv4n3mxL.4er987AKiPKrVpkvrcrUqLC9sy6PhVdF6Fns4P6S
 1CzO1Ahhq5E7eYlTwlnuQTdzSdLZ6e.XhYxhexLz1wyylaX8q0MTrFc5OCM4Qx5PuumQmiXWQNFF
 OGm8dbEIKA4u_icv7lYo81iILetK5ittSoG4tW2M_C35Z3wbhg5oEDap_B3og9D3BPVYBTzquHRZ
 X_o7OwugLeOa98TIEeFHibz0kzgYE0qq8tzBImYFlhWWdNTeYN6jXTIIyVyQGD5zI8GQpddVkxxi
 S7ffg5GwnIShpiLTT0ifze6B1igdjoUuugQ8_JL8FpWjilL1w8QVK00QXsQPE2cURKQlM.5HE5jg
 lFqZneWTfcpQ0empLmkXG61TrZPxuYJhebjZtPbMtO9TiVCXGMAOunTE9NCHEyayk4XbCSagH7PT
 cCFf0Av88dc7V9auu0iJquCqpFu4iVE4if1CCs0l5cCMRPcxmoLqpIcs7B7txWZ9qEuW8x7cXDBE
 eyyTbTt3jTReC_y8ZMA.hNRmZ5_OQNbSQiuDnXXChDDrjpOb03rTG_WuZCaVXmSKg78sq1wF7vp3
 8Aqg3r.UvIZ4oRrVBZJB8cQFGcwj.KDbdx6bUP5SLQfx32nspzl.Fan5Xo3IzN67jcHGAt.ugd3R
 TCz4wL1BAsvkNvnVCgXWOyyYPd_y5gmkW_tzOxUf9TxughdtK2pLXqixMhDxKHIKDuwu5blDVZva
 qbZgTLN_.EFFVO7DEiwbZYVNZL4E5MQFi1vA6Qw71YV_yXBSlIEZQQzNAcTqvMPEZ.HC4O3xe1NF
 2cMKyKxLiobkTnS2XmqrV__vlHH3STjNgApjX6F3CK2ssJNDFQXL5.bHEXL4CkQnJmIEYvuQVGHk
 Rhw0vwsvJ4xKF_D1bYE9mRMTMmEJM7hEa.bxW0Xd_2TdKD53ogR74eZMlNmS4H_p9c64Tn0UUcRU
 r7UMJZxxkh_1fOzSWCLkzVhCwoTQ56t8.NuImhurNMrAburKO_swJ4pyQ.43fePeW.EPJtAoqpTx
 GyEaIifqyeQyVASxFHjg0Eo0.1f9M3dh8Uu.43eGG51Ly9FrLDe1Klr0wzd0jlfKDNOaGRyS58Ta
 KSEyioEDB4xApMeLsCxCsb2bqwl7n1hkLEuygpLS193QjK7Zfrp1IUqSjA5u00QC1wMXAmQ7aljq
 mU9GdZMase5d5SGDepXXpshqUkva_rZKI.IrJbVU_1ZiJ0.ja362Itwa.lk7ginlc4NMZe3PMJRm
 awAXtjOuG6uH9B1Qv8ooxtv7o1zfrGSCqt4jPmf0TUeHhYQt55ac851VE66Ew1DbBEy3pOt7nyO2
 zE6km8JmbX97LZ2I.QWD41oHWmyMRnNj3c_8z4NREh7zpbUr26um4JqzniPvc1O8JZiRewMwMJ.7
 T16RJnWGUhhQPjaJBJvLC6qnjAf4VWBvscJSC4CKBrKT9rEGFqlCH9HrNmO_Q.bdXS6DkKtH4ywc
 pSe7T3thxp8Ngmaiu2G2DNuZGzJc_Rb20WVB_PrxcmrwwN7ym3sRY0rp4OPmgt2e4kAOY_md0li2
 hJ4OK2t00emb96mFnWHAxqzlddZdqLUBe07RplR34sikVYI9avADccgc3Sjrelim4Nz9WKEfIyrD
 K6kHf1Tj0ac0byQx8RsnahETKjxvgtxhgP6VHetY4JFGys9IFIrpRe1RvcH11Cyb0Mg9QsNNqGX8
 S7.HMwyMPmBlE.KHvETA0iU7CRi5R9nvkt2bh3s22MKcDfdvlTEXoFK1WKReg5DcCjyW0JBVG08B
 ER2Bs7JkhANyVighaJJ4FxdIABhx0IzXp9fs30x3QehInH33Eejkh3eEKtJ1417HFRzs5ITWgO4G
 FZf9qzcW7a2Q3wSwjtZ.3BrjkCHHyKkez9UvW6yI3GQ.h4bWO0KJnW_4xXQ9aVMzl5.DlCwYBUip
 fRb0AoZyWl0h9ohe77bBeN8uV5IYODfF9nxlhIRiqwvE5lajRss8iWvC.HiMCZ_LuzvgaKo96w_r
 RnblsRezHIaJFBuVhAJqIwwJHWlmUT9nuaVH8qHKJr7bfvs5DGiRAWAjOPjBy6C.otXid3eFuJ1a
 kJVtNpqGXM4sMXvURjVMu2YLGTfpKdqQISSgNJ.8ZafeWWh9924GW98ZQoWDbPyEMjMqJWEW7cu8
 JYLhlXiZGlQpoTE5oLheIUSFzzPlei0Qa1oF0vojCYann2VPQCb1.8Dbylqnw65nD8F44f4V1L9Q
 snZukXbIBVgmr8GLiwHHJlgKpY_nK.HUY2plBI4C9ln2ie3XBotGxIZXXbuDrd3suvzYew3uk9NM
 VS2GIOVMwpfvF462VEKDJaLUdm_qVIAvpx2dyv8hI6Sgw1207_gRxf8o0Zt37l5xisLxAEA.Gvym
 2Jlya1Yetq9hijaPlm9XyppAHkeOXA.hhqjDf9a8P_WMpLJo7wQL_PTNDf0b8J7k_A_WJj_cL0GO
 dbUZcSnJzqWJBEpplbcL0jupZkqinC7Yz9JcjHK.EaQTjheP1.UVQ5CG6cqhWI8OeVjeIRrwlXUl
 D4nODQ3O9.KuwpRUJoLQrk8DaAe4Zyo6hB9PBpnJVMKELYXYLUVOfF24vcySywcRT2hhJp_GAALq
 11dW4ckdc7zO_A34.kFBmWyxotG9tmyZocyP_nYZBuikiyySMjLePAGbvJ0J8gBV5FXuEmNIvysL
 8MFX0UCgrSiMc8JlktYG5rzWjyBFcHjYe7W1uRMo0f36TAx5kmvuTxanlzuswznu0H6e6l_j7bip
 Bxx9JurafS8d3ckE.FWHXfTSEG9NO0jUjsXPaU96IIp4.TjwWCybP0IqtVsbsl83sj6mqEPJ4Z_W
 VaEWCDMRnLEyKfJ2CTh5N0unFy.pW9aWXz6U77dh2r6o.V9.oxHsWtJE.GVIggFadT7vNEmVfofC
 s2xUSDl2Yaq.DV60PxyCpUseqDBu1BtrDIrmOgkVRR08M6Qwv68VYypnGMJN0paOG.2LS90rGrZm
 H1LpRFciJWIu1PCrpPh83OGG4dI8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Wed, 9 Dec 2020 18:17:17 +0000
Date:   Wed, 9 Dec 2020 18:17:16 +0000 (UTC)
From:   "Mrs. Suzanne Kingston" <mrsemailcontact1@aol.com>
Reply-To: mrsemailcontact1@aol.com
Message-ID: <760160434.3911446.1607537836313@mail.yahoo.com>
Subject: Dearest beloved in the Lord,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <760160434.3911446.1607537836313.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17111 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Dearest beloved in the Lord,

I am Mrs.Suzanne Kingston,a 75 years old woman,i am from United Kingdom Eng=
land,i was born an orphan and GOD blessed me abundantly with riches but no =
children,i am not a happy woman because i have no husband and children,my h=
usband died 21 years ago.i affected with cancer of the lung and breast i al=
so had partial stroke which has affected my speech.I can no longer talk wel=
l and half of my body is paralyzed, i send this email to you with the help =
of my private female nurse who is typing my request at China cancer researc=
h facility.

My condition is really deteriorating and is quite obvious that i may not li=
ve more than 3 weeks, because the cancer stage has gotten to its 3rd stage.=
After my Doctor Notice, i have decided to divide part of my fortune by cont=
ributing to the Charities & Motherless.I don't know you but i am contacting=
 you with the hope that,you will be able to carry out my wish for the sake =
of humanity.i am willing to donate the sum of =EF=BF=A110,500,000.00,Ten Mi=
llion Five Hundred Thousand,Great Britain Pound to the poor through you.I h=
ave also made some cash donations to orphanage children in Somalia, Syria,E=
thiopian,Cambodia,Philippines,south Sudan and some in south Africa and Euro=
pe.

If you are willing and able to do this task for the sake of humanity then s=
end me below information for more details to receive the funds.


1. Name...................................................
2. Phone number...............................
3. Address.............................................


May GOD guide you.


Mrs.Suzanne Kingston .
