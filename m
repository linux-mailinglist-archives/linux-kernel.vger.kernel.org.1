Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A0279CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 01:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgIZXsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 19:48:17 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com ([77.238.178.202]:41065
        "EHLO sonic303-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgIZXsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 19:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601164094; bh=YiBnr4Uk8siI0dhikjlKOiXekrwpOWZKz+TPVjgu4sY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PWumUxoE7NMy4ciV48SjkRCIs2CCc2Vp5601hrpkdOnACbB7iYEtJIWRpu8cp3DJh0HHxPScH/J2xUPofdQAoHKHQFdMKePuUg35/lXAMCLNJYEHBlsAa0VKfbO7eqDNpd9fuNCbnrlnz2i7ACtyDAp/DpSxXRhNTJGkJyUZKCznSkKO09f7fazj2WtG4YJqdrPCX/mNioINfxPnp0r10s3XdZTXr6dM7ntYu7xmJWIGrh0mTFx81XRQpvoCzMnfkSRRJjs3sKInMuxWGDSHIO/L/W9MId40vzKNarowWaVmImf0Gv25SSuiPZc/zt55luLAiC00m+4fSA3ZAaBP2Q==
X-YMail-OSG: ChhvHJoVM1njkEq.MihcyGXwUa7_s2Jslriv9grlnjvWfQX.WPifF7E6vQOzTs3
 Bks8FELXSjG2pq5Vo_adhQvvUk5WLcn8P4KEZYcLJoiO380NMU6vS4MUGvUkJ0ieq9kqTubUlwkk
 Xx4o8smSexHRh_S49Qbsqe.Gk90bYnMKv5gxiZt2hDnCBDjf5IEvWLONYPc6MWd7Nl_T_qKLx91S
 5Fw5tcGsTQoXArlHx4N5TAJtduqr7Fw75mUz4rBabLOV5hUPrdLFpQIWr6QLcOkNTMJbbQbJS7ja
 MI9qepbN7o9CdTIODqJ9o771ZfJb5uTplaIEjX6p_8NHq1Vq9ugciD7nsnE22pD5xzUlzxVSHyJL
 LP4E_rlPtywBWP6J9.0nxMoB83GIMLjfM9FtQOySaJCQOdhKWtRTEZ.DEG0yLNiVOFDwuBPbHw2y
 D7JQhkOMcbH9DCsKW_hMIoyOZlhKVNrP48gTVnPUfMFVUDfvnUOjDrSvCnX_QbyVxTa1ivkCuttn
 khOc3IsfPxAi1IXPMWC2RJGdtwxFB4a.TRYLQVV1Ml52aiXeYjIZUPlBQntF.5GZi9Oe1oWYLL3K
 yxHaF0PU1v765W1VuySnW19vq9euhkJD4aFL9xIj8eqsb0xthDzJsChmKPKNjvzk8WzF0e0TLTbd
 RA5i1RkMgODRtmpjlumBKsRn3KkOicSaDWQNCp3fgF4TGTTk0RPeRIC9nqQDI2oSkp9nPCa1ViK5
 HMk.S9kstrtKqguzL0bUWbZ5vIDCvU213z6NtV3kDcUzO96iM7twG1jvJxNI4upzdJ_wtDsSkXAQ
 Gl3S41TaAU1qxqgUiRSk_dydt1GHaWVCnfu71I55fKxg_Fy_tw6cAWZ27xj6L4TSm.9SDgU.BPPR
 YRPPIK8z.cQdB2RBdOryw1.CIbaIURC6XatcCM32cJoiPgurfHFx0H7G2_DeUFJcwijlxNdhxDai
 _9fEVNyiuFEMMWiB_693OAxorW54Nlt9kuMNOlbVr76xiOyN29S9WeLhweDckI4Cf4d_B_pR1QUQ
 wT.aTZZH9S_0a_2OjMPV7Er_GlBuEvKYA2tFPc.4GvWUP8z12_UV5wCkfASsWZnX9l1lz7LvxGHL
 3MkyIxV2uL6pcXwvzUHs2.ZyKEjVS7UGM7n6tMHIQjqvZcYffwYHpclpYnZgUB5VC3a2F8jj1IcH
 G77mZkNqRsZoZYn0Ekf6iQ8jDe_aMKshs2qY3lckpidTKB.umoTS42QnpGK5OoqoSvxSiFbMUzvX
 nMlM9tUpXC_hQKTo61oyUub0UeFwW1srmpBy5qde2Gyg6MvAUY2Fq0bgiuoDu2MGpoTQAkeU6kqg
 O6ElaL2.SslLpKHq0O7aNYOLGf4GNCioIQyZeaBW..MxDbKAmwTh1JroFa5EGLeAggk.7Zj5dN84
 7.reSvBuBCyPWGiqq5UnmC35m_WE6mg3T9.rp_fR4iAsnyDFoLT8xFLXHLsqi9IlpB8BtRoDZs4B
 mbgIXXvDL
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Sat, 26 Sep 2020 23:48:14 +0000
Date:   Sat, 26 Sep 2020 23:48:09 +0000 (UTC)
From:   " MRS. MARYAM COMPAORE" <mrscompaoremary2222@gmail.com>
Reply-To: mrscompaoremary2222@gmail.com
Message-ID: <2102333716.1786581.1601164089945@mail.yahoo.com>
Subject: FORM.MRS.MARYAM C. RICHARD.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2102333716.1786581.1601164089945.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Beloved Friend In The Lord.

Greetings in the name of our Lord Jesus  Christ. I am Mrs. Maryam C. Richar=
d, From Poland, a widow to late (MR.RICHARD BURSON from Florida , U.S.A) l =
am 51 years old and I am a converted born again Christian, suffering from l=
ong term  Cancer of the KIDNEY, from all indication my condition is really =
deteriorating and it is quite obvious that I might not live more than two (=
2) months, according to my Doctor because the cancer has gotten to a very w=
orst / dangerous stage.

My late husband and my only child died last five years ago, his death was p=
olitically motivated. My late husband was a very rich and wealthy business =
man who was running his Gold/Diamond Business here in Burkina Faso. After h=
is death, I inherited all his business and wealth. My doctors have advised =
me that I may not live for more than two (2) months, so I now decided to di=
vide the part of this wealth, to contribute to the development of the churc=
hes in Africa, America, Asia, and Europe. I got your email id from your cou=
ntry guestbook, and I prayed over it and the spirit our Lord Jesus directed=
 me to you as an honest person who can assist me to fulfill my wish here on=
 earth before I give up in live.

My late husband, have an account deposited the sum of $5.3 Million Dollars =
in BANK OF AFRICA Burkina Faso where he do his business projects before his=
 death, So I want the Sum $5.3 Million Dollars in BANK OF AFRICA Burkina Fa=
so to be release/transfer to you as the less privileged because I cannot ta=
ke this money to the grave. Please I want you to note that this fund is lod=
ged in a Bank Of Africa in Burkina Faso.

Once I hear from you, I will forward to you all the information's you will =
use to get this fund released from the bank of Africa and to be transferred=
 to your bank account. I honestly pray that this money when transferred to =
you will be used for the said purpose on Churches and Orphanage because l h=
ave come to find out that wealth acquisition without Christ is vanity. May =
the grace of our lord Jesus the love of God and the fellowship of God be wi=
th you and your family as you will use part of this sum for Churches and Or=
phanage for my soul to rest in peace when I die.

Urgently Reply with the information=E2=80=99s bellow to this My Private E-m=
ail bellow:=20

( mrscompaoremary392@gmail.com )

1. YOUR FULL NAME..........

2. NATIONALITY.................

3. YOUR AGE......................

4. OCCUPATION.................

5. PHONE NUMBER.............

BEST REGARD.
MRS.MARYAM C. RICHARD.

