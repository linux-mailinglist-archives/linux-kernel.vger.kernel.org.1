Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37C52B559E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 01:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgKQASg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 19:18:36 -0500
Received: from sonic308-10.consmr.mail.ne1.yahoo.com ([66.163.187.33]:40822
        "EHLO sonic308-10.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgKQASf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1605572314; bh=BWuTiosmYCs0z5gGMgh/jpovc8K3GZ6phG13Hn6dvQM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=uNAJRTMK1UuDCF8BFBCVVmlGDlM/fhpZC70/5GvibEcqQzNZdNEjDu9FhpMQ5wlXtwa2Cw250Z8QRwvUvXtze68gP5oDRNDxTHkBa7r+BkyHKQ1GbQk7CdPE9WR1MCwCH6mygqDN14zjZICEZBEUNGpX9/um+Kgbjw72WT65Vuhc/zYK0dNGjSenC4p32nG0FFC7x/zdaYssqjz9j73QEJTVP6pdoPk+D2cJgYLsh+M8ZullQO2gxWrPmQZq4hLRQqkMX660wRdcD4oZeev3cVzmz6/B2VtIdu4SYnLZDS5TlCq7P0ZScGjLzuWGZjVX9Yp1m5E/eZcBT7tpJ38S1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605572314; bh=v15Qtw1zkSR97JtSmGPmFxP4nssRTc4tmcerNSfuaVM=; h=Date:From:Subject:From:Subject; b=c1//WJl8r7AF7rWR0dkSKQoFKDpNDlyfShdb7OtFEBzIP5uEtqKsbqJkV9xwywJJJLVREjghrxPD9MR/VJduh83YM7UDUfGG3WNcsCMjiwCqAyhsKd0yMMa4GDQ62uX6xzo+GcJ3mqcR9A37QnUyGUXR11iD28RoXAOg/AEovxxYCz7goCZsTokXEjQV839tOXWmSfjxYPlIK8XxwS7Vb6kaQQ4zV6KuiP4PSF59VFiDQ3OP4FfGY6wNpKJs+AT9P4mdp+sSDLmd8YtYalFE9QIinaqH4aqCvHueVs5w7t9Ha7ok0xjb5qw6PbkYCCDELroINR7BIGy/oKnxJzf1lA==
X-YMail-OSG: K.GP8KEVM1n6HhfQOZ.HR38iIX8xTbLhmNHt3Lrc47OPFRTLDql3u3.scpT2QQn
 tZ4rHqUXaj8d28yhN8pIiFRwa_rnsUtWcY9_IU_5rrg2aSQ.F7pDZoF6v1j9vBW.9UZfL.LR12Xa
 fX7D6Xiw428nd3u8jVVkJ04gCzZWXjBeBnRxK9jdROUOKErL.tZAGo3ZjVtsOZPXUm4WfGkazqvW
 sa3zZfL0SiUBjAFIijrlKleRU.59ZU_1BKjWEyBhdJ5OXlJJCXhDJc9xhDUsSu8ANZTJ.jHndxvW
 OeKDxtp36GwNo3vuYWgnsOB6feRuxXfUlEO73fbNrrHz_Qg.ZYg5hQNyvrXB5r6.BVelaQLIuJOG
 BGg_oubDjY0N54CzOESL.LK5bs7Osgk4gKaPKgW31LRQLDOd8TSBRQxg1pbBGo9hec392gG2MsM9
 Yr1eBhMBxhMdm02xd3fKOFRIaq_CufG7Us68sk21FpkSTEyUfqP5n5fHN7ZVDyT8SszZjZbFpeGv
 OlP6UOMopAE7b.RtKHBNwvs1dGVZdS0HClrRWykRleiumMrgRvvmvWUWuWLgJQi2Q5vzdeKyTKfy
 N6OiM2mwwXQNj.PNhQZWdHsSH_hIVOJMcjF_zUMWFL61CKQEu8EuJvm6kmVewkgQNR8vCIQcrHQP
 3BcIYV51xAnIS.ed.h0N3UePOr_fPfd6bvdt2CBTP1bVSBV1tSoDgDOYYX8iB378J9yFZfh3HjhL
 Vu3AZXb0BFNXT5VysaOnUpKiT5SN9wTtctPq.1bnRpF8qoAAr6a6MDaScFQfxS2tR_FyHlUCPMgI
 BCZ7DVnSNt5NZsQe3Wnk_6mY9ekEpB4mLZpT0sfzOAzFZ0TU3W2ty_DaWZXqZ4F48YLa8e3V2HKF
 .fHqL7fuHr7Fa0OG__XMVVh.y0JboXnr6y6RXiPNg5CtlIya9ZgQa7SzsjzoUZ.w.h9R3efagm.d
 b2MDNV8T1icU1zmRF7qR9JHXJMQslNxfIVeh8xeOqwRiQRUQwdv.lF1jeHZ1ACbjGGhOWXd9hCFe
 DBVEoGn19dDDcicy9zUPGrvhvFavW3FJJxxmVuxQer2B7gmj1a9vbyddMuFAgP8FKNQ_jHoKvotr
 NP9wMwg0_N6rb1lDZch2dAxu9v6fjjhhjnXQGO1RorNz2iqoiP5EdL.M.H_wHKthq4IrEAEMKfs.
 I6xFwtHFWpaxL0Dr4f5ZFgJX4P_IlgJZTNGgYh2hLMcK02mop7FnUQeeRJR7XQk6Oat8C_lud0ZG
 7a8Or6NQiEWNh3l4j7vmZKM3M8TSgZjhn8pap1zOMjdTu.dP1Bn1nP1vjxDGkv.YyrWs2Ob.YvtD
 ZbfaHapyjxwW90TcyfxmTCI7JBe0M1xYGu_AVdNI2QI_xmNEj4xLTrYdQmFSb_DehN1d6W7Pcqbx
 w7AgsgKG1t0niNYWzSckfBT691KFsdd764IOUJ74A1vps5jKtwgZ83FTPSCFgRjp9kpwIybkFHR2
 lBNznBpSbTcEMiqnoEWDCRfkFg9jegtQJUEItf_G5JB_o7tKrZTwkFOTEApbllDHqnIgWOuu144h
 DCNfp.CI_OZNVMFO80aCQczEy2Ekpcssbrtv_DaPJcLVeaGmiFLTYJCpRdNgC8et27TsHX.L4fex
 XjEe1icADeU9QVHCYrlIpV0FAf9h4HWfUq74L4dVTm7lBgJefIJEd.OSUEUfD_KPotpZEIaSsxN0
 tWY1EX0cGfCrvPfFPY7GdmwItXSx04wxlRm6g9L.Y_JWX0d6nFciBkD5UtSgxoUJn0_uCs03sCVB
 reyen.eaeLjcy83p5N7lOOjfLhM0Xn8u.3coMJiOIXEYS505mGSL3oziOwT_mVBRWo9UaYgd9oF4
 fT6_sX99XTPWiEuPJwzyXNZ_60_meto11Kw7VJpAXvE84rSN3lpw6tSnZbBmBMkBZGaUOe1zq7WK
 Fa29YSD4Psxd.QPQ_3e3_wKyvtq1jwvzhgHcf1SOZ3vZJQTWETbacHNOYh7VcJM_ZI40KbpE_vD5
 xCT_T6eQpZssz6hYl_AiVo.7VY3wdUqcxcOjG3cEs0V9LANYdflaXvqKu0iWCoYWdQFDkGhC6EMM
 T1tlOpvmA_ddjWIj0oN35l0yO9MEldEB9.t68rHOF9J4iCY_LtIQeyLGuzc_6hUF6.lURYPM9Xaf
 MkJyN50X53pQS46IXEBOTPxHeEMBUSRayUdq1AxplBtx_B80DOp3wPuRpILju.STX7E_gf29Pzug
 j7yDR721NDP8X83SSW5MKkmzQudGX.6TE0SeaLQRTcvGtQHwqu0Xnng1yIg3uevhZiGRXvroLaQE
 fttAc7.yeg3QmeWpfF6n5sygO9lVrM7szNuMYB2Yt4NtM_yvMKzLOUtBx6QRJaZ84t9S1_KACTOL
 f5Pk.r2s.1ITEH.VyoY6rvTv6HDSRni5kLsOb_0hxvocg6AhnX5MnSTeAbi.8G2_ZKOVIAiiwetv
 Sp.l8Gz0xtSmI31rcMJ07H20KdKL_wDaF3NUbaZrGeNxh0c8IggkcHKcPwjVVDYOtACbE2p.a1NP
 FwZxYxA1StmIaIztXhK5McuJWcgvQbhTzdSRAO988sqAucE72Vp36qJG5HKdpsKYmXZU.WeK_HoM
 Gy13A2b0ob3MQDou6jKnFo405neGVJ5t3CwgRzW.1Lse7kk6Sr88zOhQhMCuoqv5hprpc_AdtSDM
 JxHUuLGzrphNbubXT3ooeyLzr8sy2vk5JaE0AoGZmy2rFAQL09s7tkMr3bX64VdB0EDC2AtL434t
 u813uxY99k.SksYwO2WdbON48xM51QjTC0v1Zhy7F4vivhN_pEd62XQrgWhJ6ixDHsk93QaDyepz
 3U7nRjfKPn_0flwhPo30MmFbS94ezZy_M9E1gRm6dJSnsnPUvNKMro_CtZcqTecoObyJ6BwA8aRL
 lQRqag15cgDpoO6oFcorixArdXunOg1i2Lu0pxecIFITUUfN0L3yfMZsaAMgyqKnNEs66Bt7Ftc3
 O1vhSRpwMpPbMbzdDQk7z4Cl1Lm8XM.LKF1Pm0D4AvuGzyIgqdd0V2RibdAOT40SaVRAgYSCbhak
 8HF6k338CxyES8GgWu2pZNaWLCzz4iNWXBILnWRc_kkgkTb302zYcFB6_TQe3cSg9ed8xKASDu4A
 fMF6RLrG4bv6pzDYW9MNnUugc05ScMlJ1muviAYmV86W59bVDOkUWacbPzAWhS97Of2hw4jeysr.
 JFlm_7obOesBgK4WRKfIWzWBYU3H5y8sMABZlgmup2itxzbrUH_BngrngEWXFmbvu5wDdMNzR83W
 BxAkIfQtiWo.wyJgqiTLkwwvy73Y2VyQyYmgvt51fgiQcFwTvPCE16bkhuZqF0Issll8NTICT9xg
 2f65FXkiBfNXhVzqHE6QHadjcPmb8uLcTNvwv.Vh8V0EskDUgP7bccC.CJljJojh3J9lC4K5J6b6
 6HXvtwYv1JWj2whGS01EImb8mqSe7hdWzJ5sQHjd9_kgHXDErW9xHScJTR4rs5_0MkEiCutKrUFu
 b2iK6FtGkFdyc14zOMyDza3juGovgKB0ycx9K_nhuhU0arbezDrTqtqQ3.LXKmngW4OOEshp0aUx
 gxL8AeaQZpPvS7fhvMWewoeH7JAjydosgmmAXzr4HUW8Y7vY9t__kKjlFoH2lZxzny4tX3HyZuSE
 t.QmObckBNrYKpBkEhPZPm.eYa3aXkBMWpxAH6hXPS9HTHDme4VH0.8c9hBcz2RCd_o4HJ1SgggK
 9.RjnY.HEoJb__5E90jynqLcyaLOrql1WEPh09gzZ1aCN5UawHGuj1eF8PL1uEka.5xwMmuRDo_Y
 u6qO8Y4UeHMwnAIBJSsI0fI_mSnXqa3qds8FvbwicuRJBg5benJlqqL6UiuvQKbo4CXLEYWz9LUD
 FJsbxSBKyQePC44H9k41u3erVid0LNn0WMZ_pb8pTjQSKk9.wsjaj1CfrBlzBFz17DmVdFxRV0Bn
 RaZMCI5SbO00F28hqdd_QuMlRkkLFh_9g5aNiZi.wRJYS8OfQJXoXY2DguEMeZgsybWEROgKH8R4
 Ttfiwu8rKNFKW20sLtw1S4Ve4uHC024bDUzJ23b0itjz0rXp90_0U_xn_SrwFg_pjpv8OtpacYd9
 UfNzV1MMYiUJy9OsHdKZSZfwXhziTHoFrSfiVIH41GjBM5NjEeH82rtMQNzCzicwNjuM26Q.RD6M
 Wfpx3TlwhZqyKrAnNNFqNzeyWcJEKQ4.ta6it3uFi_ypVVwjfrX5UO_rm3wEUvXW4aIm9GBpUEJr
 yT3ChEF2TR99wZk5NZshM1eE2Y0MuxOs443Ktsxu1QzF2FZxam_9Q.4QD3AhIEaDRvQxao_4neXn
 SdkzLEVHRd788r7MhBzekmHYZ7DsnHgsfB2QiEixOgmwqE5X0nwv.NOI.PFEMzPeGJn6IQPltNWJ
 X08ldh0B6RgrAgkr4atO1ualRYOxucNdmki3kgDSWox4mMDAPdPQEYi5qLSfu2kUQ7ODAI9LoOzD
 WfCompMNkMy0R0QcruOZ.cg_h7O7OHEk9PwBfGcb0OBjattQPl3H4MnaC5NTIu7VLdDIEIDgGQ4E
 BykebtVib051SUdiN.TzW3o5uJJum0DDai6VkBSMhfQw6fOs5f8G1JAc8Mw3lL60Vh1W2VD.SziI
 WFmyoz2H0NILHJKSv3vdJz4XD2sqpnceAr0I3Xe06W9lprpjaA8s_bXLGI9PydRZfT2jHC3kKVoo
 ZlC13b5teTnPNQlo57QowzJ0rKpYpNmGPoA0kSh1Bm4DaNIgQosR1EtGk12Mst1rzkO2MMnCRzNe
 N1tr_cptGUbR7mhUU6A0xScBSo9KhNLKw6lBYl6L9jAVPyqBL7wPSjt8WqD13LmplBALzAtqsfGE
 JqFr90wpS9D0iJ0rsUalwzHeuUGUSlQQZwg.IasejoxO_UXMrMlhz_4roxHA6CnDgO05zLgV_GqB
 oCsrulSta4GN_TrUMbvm_laRmE1prgoFccPTChCwGJYm7UlF3QkIbd3mmBUaUlFPrY3Mr9UW2nAS
 itlCd7h8CqLW8Tr37LIO4WkYPbVUnFpXdyRcQLgAI.xeZ19HlfWkGvBkG51kXPh8uif5E68dcSaU
 xs.As_pnxcqDeGr6dhBx8DMEvzqKNqo8ZtTF6yN2vPT3vrp27.SqGKyK4MLzhUxuUS4cTFgW6n1O
 nSItrKHh26Xksshc_rqNoksjLJqYzj3FoDy4UXhMM7xMfs3AZPLJVdUFVXRFtxnpRx8muKdEP8XN
 d2miqUHW.uKuJ5W02J1qrif5N3GuoGZX48SmKhF0L71n07GrIjQE5jaZIDbs8myDt55HlCY3yz0N
 7UyLdYtKmInAStZ1w9vu5qMaezbvmWQUg.BbupLogxYJnxxRAuynDCxYjAH1bDIVezJ1Tw1.l4Dn
 vUQFyA6VV1yikwKnj9k1Z4INedYMyVoan7PukyTMcLFnYy6HimxGSoFIOqon_tVQaBX0PrmPb7qD
 xhDa4ob8WSXMfIVFvVo6p7Bm5R7MjItaD5amk_4ndLhCjZdLpeAKfaL17_s4s79wVQn9ihq7dHlB
 f0WwUSGBNuH.3RJx5.aJzPXFCu2.FEORiWqWrLX0oHrSrUsXgzqrPQEkqSP8B4F6qJEJMYaJjWx_
 fHt0TmZ4uuqhe7qar8B5MhzPhfD_ZZO8rL1Oe1i2U6T4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Nov 2020 00:18:34 +0000
Date:   Tue, 17 Nov 2020 00:18:29 +0000 (UTC)
From:   "Mr. Hassan Rouhani" <suzansuzan41@aol.com>
Reply-To: mrhassanr900@gmail.com
Message-ID: <1397340730.6302912.1605572309094@mail.yahoo.com>
Subject: GET BACK TO ME IMMEDIATELY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1397340730.6302912.1605572309094.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16944 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:82.0) Gecko/20100101 Firefox/82.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend

I believe this email meet you in good health can you assist me in securing USD$37.6 Million Dollars. You will be rewarded with 35% of the total sum for your partnership. Can you handle this? Your assistance and support is needed to transfer the Thirty Seven Million Six hundred Thousand US Dollars out of the Firm where I work, to your bank account in your Country.

SOURCE OF FUNDS:
This is an abandon sum and it belongs to our late customer Mr. Heidi salf al-islam, a Libya oil tycoon who died with his family as result of war in Libya on 31th of December 2010/2011. This fund was left unclaimed in custody of the Firm for safe keeping and without a beneficiary.

YOUR ROLE:
All I need from you is to stand as the beneficiary of the above mentioned sum and I will re-profile the Fund with your data, which will enable the Financial Firm transfer the sum to you. I have decided to use this sum to relocate to any continent that will safe for me and my family. The processing of the transaction will take up to 10 days for a successful completion of the fund transfer to your bank account. Immediately the fund is transferred to your bank account, I will come over to your country for sharing of the sum as agreed.

The transaction has to be concluded as soon and as I confirm your readiness to proceed with me, I will provide you with details.please get back to me through this email.(mrhassanr900@gmail.com)

My best regards,
 Mr Hassan Rouhani
