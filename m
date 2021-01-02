Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B32E8694
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 08:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbhABGyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 01:54:53 -0500
Received: from sonic305-53.consmr.mail.ne1.yahoo.com ([66.163.185.179]:38520
        "EHLO sonic305-53.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbhABGyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 01:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609570446; bh=lsPgZn9jhB5fugv0kGd9OZcz14/U+k3DIdpLHUsoiUM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=MroB/1Lti8lzn7bOfPBf6ChjiodtgSW/brwBFCZ+olUvGRVu7I+iCF0sFdMY+kj1qXjSODxyBGPfcyFiXXlqKR8fYX/bx9UL0MXQhNVZGTfYzPcUN2mRQZbnr+VeVZ1wlOSZcpXD3x2186pUTvatLugfXvkEpNxfsSfXABOoyDtrsEjs2vW1baB0y6Y6CU/Ak06mVkO+HnlqqIcnEZ+S9dsoXa1f2ra6g4KlZ+WU5JkjNiufMYpjSXemyB6yNzTO+Qws2vf2TzdfunrC3iik5DXqsSxoqjlzEFopRAr1URPPs+DfPNE0uI3CD8kH+Gl1/lAob4Vtub6pDEl6Vz/Yxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609570446; bh=tEmHMcPc2t/48vy20KvmBqBV/rYseS8tzy16iIChMPb=; h=Date:From:Subject:From:Subject; b=U3jkrhT1Larta6/v3l5nNdYu6SbyqK2SSif5Gj5Lxx/GVg8w2hd/KbA7AdD2cSktaPom00pmQxB0J7Rs7q7z1R1GjTEHXhSsFKHwu6VnV2usBNMJgGDWQy+OuHOtxOpoSYlRDv74pNNrS2dbufEYrzRXbrXMlWS8gUlb8eTg3lvjqnBEUb7a+8vRuaTJ2IpjflUuYXAJu85hcdlCpUFNIrx1VxadE0s+zLixM8H8Y7zIg7IJmhSFzD9Bh5R1Of1l/Rpri/Qt0SgUak5goD7AOSoLYMGIVJGeQntT+4sRIaohy0ai+kxnNpA1Q5dnCAF2fYgFRvrg/viiJwQvF7SDjQ==
X-YMail-OSG: FBqmxlkVM1k8XvfDpyBGXzwSOIMDE8np9fUGH4ub2NabHJ5ymCxyzX0qWiT3ZZs
 qO165.FnmDhcIKolEe6rqCL_mZbgwhi7PdhTgqN98fDf_fyNPSkyKc8_Udf.Xo7WTjUWCsnhIQ9S
 ojpKfLEKTgNsXWWpR5hLXOOMyWZY5v.ZE28GGwSQn7wKbiIMMhLmZrBAIevBx0CCeG9LLbYeNDD3
 nKDsCgZSMMEFg6xSQ7QFeYs1wcShxpX2KkZJYTf_vc6vUAhz83V9D07gSrR57.PidRBYLaGUApF2
 sHGmUeE3EmY.uIZ761jmXkvCHYtDJvnyzlvqP8qV.ot1LaACgB1Ed.m4D7t2H6NHtV2cnrIRRScF
 s69vixtUiA6GfoV04_oMVbtc1Cl5M7egpurlkbrkFUpoOv16pxSWcBHOctS6KBUGCKlFMsB20Kmv
 PdiWUp3M9XhnpDHXKWsUzfUfzJlHLCzLWdXCZVxthCJWNK8v8oHF2flC5gl68IHirPObsSiX5hhS
 qdopr4oZxZc9I2Jvz9QzOFfaKUD9SpHKk6hc.x_jIribMj28GPEfSz4wBeUFDgBBvLOOJwOT_kwG
 1JDG8MrRjognT3pNouTY9.zrlTIvrXd01gUgIN3gvlLgda3KUKXP14WcIw4pG0oH9HLKQfQvHILh
 Ae1kNxr0EauB39gDfR1lQL5YVWmXSIcUhnyvo2SJkfk5tmhpZnYoMFZ0OajVZGFSwzJeGZrbew4J
 y7rLcb_bpcENbtCHKPvuW8P5sTuJ5CVoDWnrCHMdqRtbBPjFGl6dy9HFrun2aELFrXfYB0XN9PRD
 SwQ18K_jRjfKFPKLRKqrXDJs5QE83Icfcwbybim7m93ZgQom1HuHqa4OUG1HmuiI2NZPkpHhPmPO
 YHKkSA32E0rObLxM6pd.eA7xSxymEiOdBvmLHY5AfM4No9E9vGLmjK61zSm55QWA2FsSWWaFa5qq
 fVs6eE3tlWygFahBOJy2EtMncsRZNLuvmDKBl5QOeWbGanUb1FBWT2yGK.MTIstF_6pM1MNtNhhd
 Nq_N7IkmAmidQQaBPPm3QZWNwk94bGjE4tBGet4yIJd7mLwvyRV73YDh6WR4fXW2LmCxWUiIzP.b
 jDrf3i9vqayvD2Rz7vHTZI7oi17yabc_IyUYa5S3LecylZCvz8olpT3WRPJ0IBvOZPZ4fzJSYdhL
 o6YEIbhwKbPt6jRefNrBlTN0eVlVdaGKpErmfrTueCaDwZpy6cTuaWHtSKUtop7yrrfbMdPsmt.S
 _1MIwIBGPol69cOj5CDDIN9yzYq0BxlNMHdELdTI6Qq6djdiFjuwM6Jt._I1w1PgTB.TEuLrR8zF
 kGXz4xCK9ELxQfOsOUC15fXGBhVfdJHGO9wRb1i9xDfG_xOW4G13zvskazDw0TT5RcrQo2AvzaJL
 YP9Umaf3ebM9Scll5VoL9qn0RhQtFayt0sidaTsroEUfpfBtcfmnAi1vtngoXOcWMKUkcEzjr3SN
 SHxs.Or7LjPRyv3zXzPPWiDzo1p0h_H94mqZxSRzWE2ZQawqZR9OJ2mcOQ4ZS7LxFlCqUaBXa0Rw
 hhQWEkdTVC4GVOzW7tlSHTAmnnMT7e5z_ebkX5yNleXBtNhzAhAgvrEPY87NC2X9IlU49L34S_L1
 N3Dinp84LLsiCGqAH2kB1aPrB89ySMcnt4xYzplTvTd5gbvUmBIcBUqar7a8SC2aYDFvEdEtHN5e
 fNfZRedwO_0yAzpi1LheakyF7lh0Wz8POpBC6kYbOh9UkSzyW9zEkpMBzCCSmfkMmTYW6R3jx16q
 uNKcYMi6J4eNEVNGJhO0r5gy_YEh1qwSTpM.ltSr7_R1qejH56hejaV.j5JeKR8uIb8JZTkqF_sC
 DfwbchHusl0uKhKzxhK2BueXcEVxzUIoaHJoH8k9.KiNnJj9NApGkAcnN7MHl3sTYF8S0elho8g3
 Cuir2KYgzChQhtOqAUbvQR75tE_O0sRR.sRGj5txK_GhsnkJsOjzjMZKRFNNBzFfZV6J7cdYfxcE
 ypW7KmyS8jHCmYNraKOKatj8UKKsHyvGynW9Z0061yFYoDuXjLToJWXzGZFXLdLHODXcuva5sCBW
 NqvEo58ECVq72WpvdLCUTxZv6.d1nEA7GqIkRPitmbR5XfZtsqVwu_7bI9LYJqQ1KE7px1Suz2r5
 u.huWMCFZaSDZJzovzlmO52iuX8P4ZNGzNHJ6nTzq06qQzb.PK7xjGoCzseQwXfCNkgiPur4joac
 0PHrWnSzlC1GCfZO3LcmvtK5JY7P7nFhmWWrO0ps6_g5.hcew0uk2MjU7GBBaJntE82CsW7UWirk
 HctRBgw6jpU7p2Ck37NZAFeb7yYPPvVOkGI58W4IiN_6.ec2BGNl1GUy4q8GMKP2MxO9pgGPo02B
 aVB3Z.7B3BzaoTiHvFQXTwfzqc78kcQyK.Y8w5FMn_844.UI5qp54yme77liRPMLaA6Y6xWR0YfD
 VQyU0pzrHARKwxDKJQfQby9ipx1Npo8IL0ZmLqd24PkhvBuMyb0J7BtN98VCIw9HLx3bUGM_NA0D
 q5tO3LGQP_xJfDaK.YcJefVwlOxt1qS8eUycrwzcdthtFWg5JCO2wqHNk9jKhwk6Wqi6BX2n8Owh
 bw9L4RSr_vsYSosaRlCWyXlGKLV_4iyDVe.6pvcx9Tvai0LYCfdcR9d75ZAwo0bkjjTTX6WuwbAM
 2cB9OkwM1bSJv6c9BsJr68P1vNFGrAtOrr6Fh.6ugeaxN7LsdRIQlPc7Hgcf2OxIiAexPQclCylT
 _QOK0BGdOi26ecKYni3.b.LSeT481HMjHfKkcAlv4Dq.nRhATtLoKfMkHK_uk5k67jjcieGbNrWE
 a_cIOkt0OnIxZ.aSPZ1._5DnwwLgsDgNOSRfkKWfme8QfE_UyO1eyDlkmMca_whxidh6U3_WiaFZ
 0VV1cua2LpXbULtgE_7Xt38tDJJwJI6w_Dp0mzwgk5YdWNS8Y83_62ok0k.W349HRSNDkNVPEjhR
 QFcvrDWjDd7kb4AMWVyrP9FLFbnoVvYo1NAXwF_Z2w43xPK21L85z1vda0xhfiiWbMA5rI4KLNVU
 YA9qS78mJGwe1euetxcxeHQKVFc6ijlrZEsbRnjfPbJhTdm_OeqKR3Tg0o457afaKlITu0sKPQpw
 x_V1VMghgCmw9piF7.i_sTdC0XukMKmz_tGTuntSgs4YA2xeWd6NwkmSfu.XvWPcTWwSwUYmT.uP
 Zhd7E6V7nrWprTS7fN7TFsLk4LQ839Hu4KQvYQbxdXA8L4kTo1XCBA7ilA9zXBtRsJlppZ0LTQnx
 t8pjyzdNjDEZ6Hgq6itcRISzZhpn5cWvMMr3b22G_Mrd1ahl8.4Em9Lm55dS7BIgOqjqgDQQ_.Vc
 9PA1R.T9CVBkKClI9Jm5hPRFXwMyQqetsX_9_azHrG8gX.IhF2tgXuKnZzIkrXir99rSKEa.7vcr
 4hYwMkXYsLu3gjtXFhp9RNPdgOB9fSW0mmPRXQbs3Pj_eFaDEm20Z0BcVe954.g6MYg2mFuw2K3o
 Q4VmWL7lmA57Zs84HbFjH1y2QkheTG7KY1K51MJd6_hab7l2Uexj7SJCPDXLbq1Nx6seILEQAlQm
 XRKuf.zfddGv2X81M58gIcpIXnqNWlJ3d8oEGhj66hitC1CU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sat, 2 Jan 2021 06:54:06 +0000
Date:   Sat, 2 Jan 2021 06:52:06 +0000 (UTC)
From:   "info6 ." <info6@ghxlo.in>
Reply-To: mrsmercyt@gmail.com
Message-ID: <2136529541.6353716.1609570326344@mail.yahoo.com>
Subject: re
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2136529541.6353716.1609570326344.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17278 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:84.0) Gecko/20100101 Firefox/84.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings
Compliment of the day and hope you are in good health in this time of pandemic crisis! You have been chosen to partake in a charity project in which you will get a cash donation of $16.5 million dollars to help victims Of Covid 19. And Less Privileges in your region. I look forward to your prompt reply.
Your sincerely,
Mrs. Mercy Taylor
