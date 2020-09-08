Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4512620D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbgIHUQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:16:03 -0400
Received: from sonic307-21.consmr.mail.sg3.yahoo.com ([106.10.241.38]:37795
        "EHLO sonic307-21.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730025AbgIHPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599577781; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=csAJ8k31Bq2hCVro7eu6UrT2PLQZKA3kKv+zz+ZFxUTvSXdodyzRjBeETMLIvEVrJeqx3unVOVwcZGjkRE7YEVjpNESP2gD40oEY34oBlfcEnOxE+qBb5JqBeWv1+nujwsi8VNZcTSR55u02kixGFS17yB13QaTf+rozgtdNyhViUAytmEALzEpL/nD2/POZ9vKNFjCw2tajq4Z4cYSHXZe1Ca7BpRZ2+NDAsuhO3N9Zds31aonsEin3GoWAcUDA/VcU3JbUqNPJUo9r7xEZw8lBR4Ze5LeXIAh/6lmKN8AE6O9PZg0ZdGM7hDghuv6x8AkbB0yQQ7B2N+ywIOFrdQ==
X-YMail-OSG: XgcfIUQVM1kbAttkdFgTr6gfZIo2wRwrODKNdul33SVHYdqCMfbNuzqUVbgVJTt
 CGuSkL9.n1.JvKDTkgyuu3M2vVKdzyZKN3xbM8h_P9ktFX.V61Ad5.U7E2DGh3qVeunln.yeKfmK
 6qJdB4ZvbdgcjfB5ERIyB.B2q_x1Fqsls_pA_W4RyoorPLF8SnpDU1CbnzqEwsgvHLI.sx3J9C6f
 80O_PDJFR_Zn01P3YJuCBDrEYX_famVmk2ifftob0lg6VLQVLDkcyJJreEOjzYadWKsbuH_6Ugwg
 RzuCO3cZB.3rO7wX0Y0QXu6Xi0UIrV6czxjxxWvXlH1VpLNW75IlwZOIY2OwHCHhk34NAKsXWrFk
 O1gxo5lMSfu0BDuMVnRa4gY7aoASJ8RLKQ8imx.J6t6gLXnoHHNgZoSC9lWbH3Dtm7bcSRo0AYxb
 AefCILpF4mbmRDxrb9w6vHkVv8DsOjayIl9y6.mr9ym2CEay0fnK3ZarxVCAgl_YINC73ds6F4.2
 vGonCBJWDOjJcxIGsCQpirgKdjm3468y_AgCPYZX7zhA02idI6FvUAHQtKtQrnV1Uso56w46y6zR
 NieFgjNgM3c8MtARz9sFXUq3zpjUPMJlyzfULAODWCpOofW89rWJvj_rHWpXGLg_r8PWlax17veW
 tEmSgCZmFv5_7Bv9dPNivML2g2JadcKUmAwgEQ1iGPqQKremZmr4RscD.FT9I2C95sOegtLTd1q_
 ajIsRrNIUwZkB6nx6o1w3KOIK0XOjQwKdDE1ZdACIa349flkGijByWXszY6qh3RlZDykUYObb.9q
 scNQcATj.T4F84GRtIjrSzg84wnr5pnb3CCsihUIK5Wnll7Qhux3iVoeyAWZz8oLp9aAUTKoh0bi
 .7giwQQ6rQpvb6f.2ugIaAPMNrnjWpxtQDkHWQn8wOX.zxm2YDUfOMdnkzzTrcID0cNmno7BuEU2
 _sm2R9uT9_7rYaf9OM.XNAy8tfLxxM2YMkcM4QQeSc9Z6EHlXzS6YKzuzlHTwYMohTjdvNo9t1IW
 Lp9y8G5Cm9pXWynNqEvi9xCoz3G_xKiShcAwRZXL4AXsvV8D1Kdqw5PKcImtvxXjL.Kb9pEQY8M8
 .3l1OIwJWbm_hN7CI7gignbaIrJhyFTMAN3h.mPwLZswVC8.2vnnt5QI6k946Xv8qRYPvYG3vFd0
 TqhNG4PF8u.07q8z7piTwKEJtdAD0l3Os0vj_Qm1Ubp_MfmbpJ68jxmsHZAwKIKYpibGiOPp8lGs
 qaiJhySeVg4YRL1L4IJ6eBvdoeUnI2Oh4Th_S0BTXVdqZIiJfizQf6KYWzKHQbB.W.QwEh80rr5_
 xb_7Vo7d6Bz0VdekCTuZkuNSny2n.Wp5u8Fvx6_84VPTC4bOwak.t_NYfd0mbeRLqz138_sQqgIM
 ir5LzimdoS9wKR7kaSGGC20ivwaNu5Akc5UJb90t9IK6Y1Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.sg3.yahoo.com with HTTP; Tue, 8 Sep 2020 15:09:41 +0000
Date:   Tue, 8 Sep 2020 12:05:39 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel2@gmail.com>
Reply-To: mrsminaabrunel7@gmail.com
Message-ID: <1437860446.2981367.1599566739872@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1437860446.2981367.1599566739872.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
