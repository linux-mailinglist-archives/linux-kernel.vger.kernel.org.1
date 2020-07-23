Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA8B22B8A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGWV2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 17:28:15 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com ([77.238.176.163]:40424
        "EHLO sonic311-31.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbgGWV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595539692; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=HJOYkjMg742Np5QTxhH2brDTxEiBscz+PAmLC3a2SiW6C0uL1YER5TLLONJzO3s0s1irCqY+U4M0TCFCjczf+whhwmt05gQMkXhXO/0P/Q7tqEFnc2NyFN2n2pctlDp5248OhxUfQ1P57ulQmpHCk2N+GlV18KvA/OG0teS3wakXtAHPzcRL82qqhK9rGFvwvUOHjcSwR0DyK8MB5j9uDiTssVdVLZPKRP1HV9T+qD/ToJThfGIEC2BydVOdtIB+dJea/sqvhgKh/6cSh7uqGLJkuFYpV1+Sq6jNOq/qUaPcxQfX72PHmC0Gv9QZEMr/1bupg4gE8r6piHAllP8rLg==
X-YMail-OSG: BPdPdGIVM1nJEMxMz7xXiu5A5SFpVhdEBhczJH5i9FQkDt6rbZGpGkwG_djRZOE
 jDjKdHycUIO1Z_TP5EGo0WJm35ZhU.NRFgjZZL4oWqN0NRFTVS_ot5jHes9hJXqSEn3fBAG69ksK
 JMmLTT41KSCAw8gygLLyV2MLlUFM4dYbDzDRAYFBvC2L3rOYLc5DUXMoCSynN3.HTBm5RQB2jPCk
 XFuBbth6.GCz5yBZKz1LLCWE1e.8gW0fFUr4aKYPht1OZjjSKzDKkWPOMXu7zayDOwl60BavZu1R
 K8ouuyQtWWjfHtcDjugSnQqQd0X4ZLMOOQcDLJDKNkAlYWQz2TQjca5ZNFFH7h2aoWkNf8l4EXxQ
 us4Y8EjWEskpAp9s3W.Ok2wK4wWGEyjiir2lVvzn1zlnhQswic03qYt3R_ryl9n2g4rZjkHpPGDp
 gzJUU1M2iXoaFSPgD6PuWXmdwTXoLOuOt06vJJ7J_Gk3eyU.sW114E_3rbUVu.cctJwii55EfXiT
 eYy4mnOC9i7PncPZrHwgg0nPR5fxsfBBCMftAmtAbjYe.P6lvgz3A_oGgXHynFe75g773_Z28RNb
 Lm1HRn.lqOQpwxAs16z4n0_wTBf4Mne.T.mEUP_kbf8PloNxJo5IO14yUj9ZoUZAUiLi6gGVOu4S
 bAVnDFzveXsBd6q7GoT4A_xwyJf.qkSTcC4v9LgC_RJtKOrnDNx3jckga0WApRaQ8ABVlgNwoaCR
 v.K3gXFzz4MvIRYvp6933i8LBe3CYs1NJeqNe2maQrs4xTSqL6BiZHgqqWaqCaNUDp0OgfaKvThf
 PwTUAaut7R9do6JhE1IlNGbdvGMYo3s9NQI3qOJBmYxZhpRR3DlxbbNfRmGVt0WuH29nbYvXGOs2
 Z9x_FiVwt2E57YxugXpA7IaZceHIrYUl72Tdlx6JyoGlfy2D0YDsnY4wjmnM6oY.h6FOGqZHgET.
 mMk2bqvfIxBA.2K67ZDDiFHpIteqoamo7Nuu6abP9qMQBZH.6i4YIFtHn0apllcue9j_v_XtBFXM
 pmKekOd.30ytQS06donNHXF7KfGUwHg3OQCIVQmN7DCUOis8SAP9P479L_EGMHn.cHtfafAFsL7z
 pvx2RJWrgs3DV57SuzrAx7sSynKvT2cm3RP0sOBTstYyIZiJFYZV_.sS9jPMVx.0NvqWcURqB.cl
 rHA.ECe08iV0jUklO6CCK3ak6VP2Jo9yDp531Ab6lZyX1qDj.PAMAXm.QYSTkTj55rXnz79LfnLn
 R9QvSaQwDKyA8w58Imt4dIGOfmLp6E.RtU1bVMIcCWA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Thu, 23 Jul 2020 21:28:12 +0000
Date:   Thu, 23 Jul 2020 21:28:12 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.minaabrunel209@gmail.com>
Reply-To: mrsminaaaliyahbrunel1@gmail.com
Message-ID: <1580323260.9480131.1595539692324@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1580323260.9480131.1595539692324.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Ouagado=
ugou the capital city of Burkina Faso in West Africa. The money was from th=
e sale of his company and death benefits payment and entitlements of my dec=
eased husband by his company.

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
