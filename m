Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7566297EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 23:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764633AbgJXV2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 17:28:08 -0400
Received: from sonic313-49.consmr.mail.bf2.yahoo.com ([74.6.133.223]:43686
        "EHLO sonic313-49.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1764322AbgJXV2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 17:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603574885; bh=upU+4aEdBIRwzA5DNhbxJzn6VjVuzIQ3LliIDdaejDc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=fTo7P6cJYycx8nND/IgzHXA8jDnFfPXZzXSaTS1I2AG+1f2ygsJowFPLck8geuNIJm3RIl3EnlcibX/Kd9+4S3pIcAHXxPqzpAR0CU0ibw+hwq12aOPWdpDWj5g0Sv8PhXVDUoV1VQbZefFONJpSszKQ9C2yjMuxedJrMBm3r9GiOnazdjKS7QKMpG7/aRFHv6YZP0deAB971gIeSfrzFtCFU2PZukthSk7AHckov1uZrcZ4eoHFlJnytqVhhYaKdEJblRyrRZKaXqPln9mYV1Fw9SQEVHnWzKdWjbN7Yz33UUuErIuWQ2ul5awJtURFl1Z1uZQlGyCjmxYwUj9vOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603574885; bh=U7699mFLOB/fl2tMHHZNaaj9m4PO5SdxPkgoOhMlK72=; h=Date:From:Subject; b=QqS9SonUyOBIrw/MZfuuwuat2S7+e4v3vYUoq0NyrFK6y3Mkn1m0+UvKtVBjCWkyOe9t3kW2vzf3brB9ut5DcAnvXRaE6M/Y+MoloxWbAT5MTEP5I7T8mfSLBs517WOpQPLIIbgFLFt7ZiegqgXlaw3UVcDCiUlf0zc5GehNMo39vwFTIfBIpFvL8bQnAjCHfO+7Hae0zqHCUFbBg/KoZmPYJEar/mtGN2GZtxx9xYj5dEkjKA/Jj12LsvfonuMo7yR/xAeQ8tLfqrpFsiRY0rqVuelQUflNP8PVPMLfQV53lxKqvAw1kL3yLMlUll/nYZk7RsgSHeiaKTRFbGwaJQ==
X-YMail-OSG: OyNrKzwVM1n_Gu2C.Np5FlRujDT6EzqO5jC8h0XyCxzueyYtIc6j6WE6wAcWA.u
 DrgGaeUaeu.tUQlkv8qz7ILIpGxshFPhWW0foZ5kdi7UV1ogGqwgJy3GkcBahvTxjtAwgjUZyJGJ
 UcPsmOuRIGiAwsEtukQJnnin2Mojl8z5Rq2jAQaRQ2I0GR3ky51cIyRWH4JW4_NLnt_V2pulwn_R
 cs8XqrrXGX1Kl14d8lkxJxw7Gm7JQzS2efDyRzCT51NCDhNpx2VmTrPFic2fNRiIU76Z2oWz14tR
 k_DkXiHvkO9M.hvvmM28pSFQppDVUfyArXyBDp28rB3HtahFyaGDK2ZVryaFewDdLpch8yRP6Q5p
 9OJ4hCWHEINShmeL3wsLYoIl4qm8pEZZnHVkQ69LWY71qRErdE8cwNQ2ORqgjY6P3.50b5Hou3sw
 nglTqKehZ_Wy31T3483OQIIlJ6BUeCKF5ECeAd.0475bc03sFSM8H4F97dEuR.z2gDEF_D0zpl3N
 ofN2VLidxgIYMh_m.dSOnkys5ZsKXI0xAG_TyVEPB.Fm66KDCUqq0q3dLlcg7frtR.lTcy8S9IoI
 rAp.dGrYNeJBy_Dva7Oj82SrfnQItsNifPQfrgKFpC2PCnIfauufbelLwGuQNBxnp_.IRWotPwqn
 4WoUosq4w6yHXpoIbj7JT3dzVQOOWgVWRzdt.CMcxAeqcypQsqL1SaN.._4t8wxQ2PJLaXjgYADV
 mCyTmhXrBVJMI9bS.JjgzEvfohuxpXcorjN93RNBVJEwzlPu.tDHS4JSopYN0vRtlUhU5bwYimMK
 u4A2GWhS7HAIXAeJteef2o86mP52ov72RR2slamgLtbcunT0ZTKLMM4.i1tTEs7EbdLdeIhFvZrs
 pgz7Bpod5jPU8Bfd3B4glHSZ5QumT1IBKADRSSqYKQRH4_v3uIvTZUx2ssKpEcb5KniQHW4PRRhZ
 NEBcMBSv5G.izb0fUCCkFQRDOP8M5UQ54FQk7LAHM2gtrSqrwQw8zZIJrCn2MUnAmOY7mXxfM.kw
 WUS.b2J3DNLlqM3NGVyOBWw0zTp0tWqrFs7Qzgfnd7qz_FfPIrZpnpW16vJlPieP6sfGepc6Db4z
 36hchDb7pyRdNZ_muvd.Py.LTyIkCU7pPJOydzxXig.nsfUSfLGr.RXHuDy_2b0_beak2s9ZnVOV
 QaHtPHpzqdxTYKv155zsrFxJ6_7JRag4x9R8kSbzZMVd_foulo.lvhFXejcCUlEa8C1iqCddEh3c
 sHXJc2iZRzQ53EhQr6opYoG0DRUWlifh4yr2vfNUfdoKzSQn.eKzt7WdcQzduIkQtFqyjqvgCCYU
 fUJoSb_gyLYKhEUH_KprCvDrOn6gF.I_B4LCaRhGyKNSZWB2UV23cLPqXIAiAYvFil8lEYrNyZEZ
 JN6AfkjmwwuzO_3Rnx3QveKzXYdSY71lOMyGluJul76FA32u1m4glsUpRGBD91ZgbCr7pcyVsMMp
 EttY5FryKpCXQQ6zpwOw1MRNy27dq.2dKPiA3y.BP5IVA18VzW0m7eUZl_hO8z.YJbOeYUK0DMHM
 suenWOSpCn8Cw4JmPbLEELOU6DTCraYkh7wDiMT0WWEAJryJi3jYe5jp12c_xEiuNIoN9TJgO_1i
 03wWBwwYpuZnFIkMaznZ4fftOIrSiJCz_YrknzfoL.ysyvKThwcxRCBl28QLROhFLyHmEghsi9I4
 SizffFULOntLRzXpXbmzLNbBUiTNKsONiJXVZQCFNe4mWlxCjB6dV7cTrRmhRjq24ZwxaIcbqOk9
 0TiY0aaGGGdvXcXStYcYG19MQTz46GM2hM7t05cOsmcJPD8dpyvXN7CTQiX0kUcJ.2yfLARmwv2g
 6hkXL.IhwnnWpaRI1qv8p3gCs_yPxymxowWAvMIgq8j_cBM020Pahy.rkjgri.HsHdcvaK5W_2Mb
 19NqyMqx0XPVu9vSmqwmq5QKfxkcdrO1.6f8AFGN6RwIkVI1DIQ5gxaz.Z22gasZVZ9MB8oa9xkP
 zH8SFSMjzdTM6eFTwPFFNUuJKg1DUXW7pBjPC8vUvUZA0ld9xONsH8FL5YGVIYHPwdgBS3HTHvcj
 .NVtekQam6QbR9x23OsAXV_iVeKc23P9vwiCSV7DeFL9ctXmNgYE0hcTRlqNI4txwZueN3.FGH6p
 N.wYgJ9LGATwud7O_nAeyj9ZVMR5kjji0LGtDTduDCkqSfZY5bT9aIRg2qk2eOvr2XbV7LlrCE_g
 1_K_oGH.WRqz3.K4a1U0UzGelW_1rlltCRKRpEzhnCmE8FP4j9TGkREqq.FkMxBB_RWZA1E0ToU9
 YKlvjeAw2v5jABwbxxLkDiMLhDsSR9UbkFG648v1CZAOMWAoDQ8uRFdWWtyaRqT4Gxijq_bIvMxD
 0v1d8bYLrcwKD2Jz0TtQOdg0LekSdIy4FNrp7ZMyD8otFtizm5gUCHURLHTP4EBqmVo_fqFUHQAq
 iM2Icfze8rc8t.iKQPSzlfr8OLMp2Bm6XVhNR3CExmJkUeCIvHtzs9yCdrXZimP6vhA6SDtEuNt0
 T7SwOm6IVcU25IBozsV3pGOjYEPwKVPiit7HBRYYZkgTA4RG5cNUTEpy5mV.T.jKG3e3nnY8TMnN
 A9KLmX8qUJBjaYEKCGeuokrIEKZsEIb7tJ0Fr5UPgSSjibOq7Bs8tg6v2OhOBAss9LmkpzzOvuIE
 N_AAc_e4QD5rEdIWlGNd8kG_2NrFCVp2EMOjxs0FZD7Beoc32.OwzlGjQOgwVsVDYg4oLol5DVjy
 Xg9mNMDdeploU7GqOD9RznMmZW82seey8dU_ldcpJv26A3_Tfou5nIOJGzFZ1A7lt__OJrlbNIMh
 ahkTXC_1Zc0Yuwd2rLpBWmDTCF9iaQS3ponmEHs92OOvCQ1YgdWj93PZTJGVrPuzD8i.VRST..KK
 6W7YoWlXpkIsaICbEu2JUEh.HIQXM8Ny8Sp7gGGjSEh1BDEQjEH.2w2s12c5qIpCsbIoVJbCDSf3
 01GMhjR6xLW0I.tt734UGgZQhExKLIi2puBDmDA9r7g1FUPTFTVRTlcULSHiwP_uvtpbUsT1wm4d
 M5D.qdRL_KWBPLnyj6_r2LO3Lg76fiMLg8kJ0kObAUbt.UhS1Xk189J9BweV418dLNvoCdSs3mXc
 ovk1Uat32HOaoqSFksGoIctJue1vt9BuufWXy6xF7sHNLwyKZ_wnjUZRdn5kokYNwwTbF43Gaabk
 amgsEBP5EwEcjrZ_YNfso2v2_gOUq3BQhKarjoagOhmULR4EWQCzlTxeWstj6lydW2TQsfWf1nX5
 WIqeRbdI5ONamIkc_Cj7PUuTmgu.PSKVnThIbD5vskFXrWYerQrFUoEhYknlJmnrFk9EMIKBMIcu
 Xovd6niLvK_TwGaLsKstTiHHl4Txn1TnYZRG_zgD9BwsVpsam1a94TUTHHQFaikIMmcoBJwksE_A
 Z4aoaQPAf0SOv7M0TGCYHm023D96JuFkvuyBk5jORjzzaljSuMy_2SoiTZj7T_c7LrYTf3pLuAQ7
 1XsWsII4FVybjapOO1.fVqvMNzLP_rhEDzqoZZ53U2eWO4lZy.8dP_0Va7ZNp11O5.uwuDAEWv5V
 Kkx0bxYjBRnaEH8Zn91dNVHmHZU00QEu2Furm6dHwf6DBcItIR7rytEdTA8MLEJA.VlDA8pE9nZb
 4B4jfJqv5cSTfKviNbCMgeewIpIY3bM0gdlKMwKzTyPGy4gAGhI4RgjQvhQnmOaoTSSc9JD.rEX0
 5lapPDr2f.yhODwgGRZcX5oZsw45SoOxvGZHWU9n.lVzi9zKL1M.eJ7p.Yj3CaFybszSblpVNnUa
 1aoB5izulQZB4brhnsocCliKUaoZ1eNn5ZiJJkRhGT5h7Igqoxc6zK0VFjfYxqkSNyFbn3hCjNe2
 XUDKevmwRv7Pb9CIgZAclHC4kD9w2..esPuDyKXR1evuSEeA_Y414AJNKVZg8mo7_r0ZpvcyyUJr
 LWGOHok4Tqg9RbV5MAJOle.pTAAudgNNrviOs1CaZjSlgJs5ydDaACF3qJt0L_smoSI9HKOHSU7N
 z6.2YJshoolQ7fzaqGFIF6iUTpQQXCj1qgesrkZuZn6jaChTBWJXFDyMYuctOHPNlGsADjK01gYo
 ElMOv_Fem5sDNTIBUjeeeaFI0eM2KOCvxL6zPnZ2rk1qftYUdhDpUsLFo2NzMmAF5EmNzdd5GGvo
 1wD2smUUW9tDxr91_plGokqR4d55btlWJkS2nYEeHf.8YGeaIWRLMFvNnyRCRxXsQl1sPz7jjsA.
 g0QTypIIhHXAC8syFxOdHMOuStSwPz7j_Vw_FtBLVoDn8e9oCpbbGvlx49gz7cDIRA.VlECAIEVc
 R4gkxaWfmUKCfr3apfUet7RXQ9FiNr28UUBS9t2Cvcyugwb5KditEkKsRuLg.7PillXRxSIchIOc
 ZCILuu54uLamjDXhixNo4R.kELv2pOGMFtFIVBRV45BorbI2T.guwR9RzRcuddCI9rF3.inEd6JV
 h3wtgdOqBNMbgaTHzxDLQl4ns2taMnKwinMwI4V.94HULFiP3cWmsZ5As5p0SNWd_xO_QNYarBfL
 2BZzzd9_tuFi4fi1.RXN2sWAM_iBMXaTsoF9xE1lqqofUEEgbW4uO8pMM2ewu84_6DgXORW6uf8j
 INLhXAERqYm_OZWbQ1MlxrKHiU5If8n30DEYjNYDqeneY4GjNsVhcMOIBX1FfASCazP_en4Iobhe
 d1UKA5Q.54x5p2CRgaVYbUVNGogQAG45JDRKCtFx5UCfbws1agbo8.fJGMbOIbT1UWEwysNNpmsX
 NEiU9ujdZ8zE2hyIaSuquohNUTDJGVhVUu4JUl2rpj7k7c.L6aLkzgRxk_D0jPQTXcuI6npbXlud
 5r_TdBoVEs6jxgaoR1.t9zzTtLRrhDYWx4J9BMnq0EXy61wffrVWYygO4wc8pzPLSC3KQrfVM90A
 tmquA2j_f.Ezyrm3OMOgFzCvNdR5h8sxw04iH2P4pWftUE_Nuq_lQ0gFIfwPgIktMx4pEwl4en6f
 5A1JzqEs2Y8MRUgazdBFm8GLaxfbO7ZWPmWgRnS0WkyPh27Ms1JJg0fj6Hrk5VR.ykXrRQZa6vvD
 fPB3fEaxYG.PMngoGrQGMt_Y34zw7Xyo21Y4DkDUFIk7kXE0FG4MUknEW8OdtBu9ITV6VrFeO8T3
 5WGSgwlt6WoCxCBURTxyBKWNAn0EatScB1saAoZdJvPZfYlr5_NG5t0L7hQyQdbRZPzpWEBmCjFx
 ODG_KIu3JqKYL6tJ_egGkASw.CKjpXLCRxWkemv.GQPd4mXtWunYX0GqED1zqp9MH7pliYDjtBst
 vmESW40UGg0di6DE8wkLyyvjicAJ5oFiLIpm1rzvZRT_v2vt3ZOwsUGbNzLPnJeQaOrAlymO5sZa
 mBuEqFjXQcJ0CtQvkKfbFGQMqf66W8p.y4kWhYVj0lRvAjzEKqNnQjcs73Bsf3b.WpPJY89ebfMx
 P2j1Q.Ft29f_T2H23xWxCKqdXaM97ejbmG9KboRJcDolwLgG6ykAgTQB_pw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Sat, 24 Oct 2020 21:28:05 +0000
Date:   Sat, 24 Oct 2020 21:26:04 +0000 (UTC)
From:   James Phillip Owen <reed@hfgzm.in>
Reply-To: jphillipowen@gmail.com
Message-ID: <308869046.2312004.1603574764784@mail.yahoo.com>
Subject: BUSINESS PROPOSITION
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <308869046.2312004.1603574764784.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I know this email might come as a surprise to you considering the number of=
 junk emails we all receive on a daily basis. I can assure you that this em=
ail is authentic and I would appreciate it if the content of this letter is=
 kept strictly confidential and respects the integrity of the information.

Nevertheless, I have decided to contact you due to the urgency of this tran=
saction. Let me start by introducing myself, I am Mr. James Phillip Owen, a=
n account manager in one of the banks here in the United Kingdom. I have wo=
rked a little more than 15 years now. I am contacting you concerning an aba=
ndoned consignment containing the sum of =C2=A310 million British Pounds. I=
 was the account manager to Late Mr. Philemon Juan Smith, a foreign contrac=
tor with the department of works and housing who has an investment account =
with my bank; I encouraged him to consider various growths of funds with pr=
ime ratings, then he invested =C2=A310million, based on my advice, we were =
able to spin the money around various opportunities and made attractive mar=
gins for the first few months of our operation. The accrued profit and inte=
rest plus capital amount to =C2=A317,352,110 (Seventeen million, three hund=
red and fifty-two thousand, one hundred and ten British Pounds). In mid-200=
7, he instructed that the principal sum of (=C2=A310M) be liquidated and ma=
de available in cash because he needed to make an urgent investment requiri=
ng cash payment of (=C2=A310M), we, however, assisted him and made the cash=
 available in a consignment for him.

After a few months; the management of my bank sent several notices to infor=
m him about the cash but without response, on further inquiries we found ou=
t that my client was poisoned by the same people he wanted to do business w=
ith, that made his request for cash payment for the business. He died witho=
ut leaving a WILL and several efforts were made to find his extended family=
 but without success. Because of the sensitive nature of private banking, m=
ost customers do not nominate next of kin in their investment, also usually=
 in most cases leave their WILLS in our care, in this case; the deceased cl=
ient died intestate. It is quite clear now that our dear client died with n=
o identifiable family member. According to practice, the Private banking se=
ctor will by the end of the year of 2020 broadcast a request for a statemen=
t of claim to my Bank, failing to receive viable claims they will probably =
revert the deposit to the ownership of the UK Government Treasury departmen=
t according to United Kingdom Banking and financial law.

I am proposing that you stand as the business associate/next of kin to the =
late deceased (Mr. Philemon Juan Smith) and after the successful execution =
of the business deal, the funds will be shared in the ratio of 50/50. I wan=
t you to know that I have done my homework already before contacting you. A=
lthough the project is CAPITAL INTENSIVE, I will be able to pull it through=
 following proper banking and legal Channels with your assistance on your e=
nd. This claim will be executed without breaching any UK laws and success i=
s guaranteed if we cooperate on this.

An opportunity like this only comes once in a lifetime. I would want you to=
 think about this and let me know your decision because such a deal happens=
 in the banking industry but only the outside world is not aware. If you gi=
ve me a positive response, I will give you the relevant INFORMATION for the=
 successful completion of this deal and we both enjoy it in peace. All I re=
quire from you is honesty/sincerity; I guarantee that this will be executed=
 under a legitimate arrangement that will protect you from any breach of th=
e law. If you give me positive signals, I will initiate this process toward=
s a conclusion.

Kindly treat this proposal with utmost confidentiality and urgency for a 10=
0% success.

Sincerely,
James Phillip Owen
