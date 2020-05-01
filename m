Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF51C10DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 12:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgEAKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 06:31:23 -0400
Received: from sonic314-13.consmr.mail.bf2.yahoo.com ([74.6.132.123]:35450
        "EHLO sonic314-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728538AbgEAKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588329081; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=e0L+5b04M44NlfKNru9LMf/JxMumz34rkJF/wPZU1vWbBelc8hl0VKOI+VoQ36JS52Z4nCBPSrJKt0Inqq93J5j9j40Ri1v3uOgcoLrR97d4iv/66WaAU7wiNXguUGbPTNGkM1BRyFeztPA3LD0BcSE7D5MNl/ywIjmOtyFmTicmuwtSdaNNhxFifHK1hZanJR4SmDRnb1PidM5dEq8QiUfWySdcm+uDdujueHIz6qFG589j5eLZX9YSJt/mtUxEZkr05gbjf0pw6UTrBKJeBi+xmm1b3kN0NTLW9i3FijtiXsQocGDZgitsJbtbNO9TwCi1rUlF1JIeJF/2yJ3q5A==
X-YMail-OSG: fYtfDvIVM1nxDoCjkZtu2tGsU4wVvjA4Gt4676r1ERA100uHK0yuy.kPAsMc4Sg
 diB0POcBeU2YFxQHKlNGBc1lloSHlsqf5inhU.I8ctS0yyqDqJlq_jKQq0LPTwqZTjlRrSnBFvVr
 Dk__X.IoGx7.F6JuMpyRTEsAuX1ga5Qi8nG1hGORVidebaacCFuiIilrxfSOUCLC7e.gIpkFybvN
 neGUa4BnlOxl1Cbwu4.jclZRcm5wn7n.pMpmiOvrIwcK0xKmdLABmhZh2_X8Qx2ia1saZRBvm2e4
 H.6dM8IPVfQtqvgLIBvF7NHjDPOPshWd_6XzDGF32hAJsOzVdsWGf5kpc1xgrv4P0IvJutE5CGwL
 qb2Yf2CvuaQIP.Fi1vkxbCA8.yH_50Eg_JKG3ZmE4cT5Qh0zU7_A5kDeoUM3B7kEYmyKl56l0W.h
 a4g6JEchBsri95UqwnTLBkHvYKAHRmPNIzn4cuhQN86V8xLsO6LgJUJYHp47_.oIc4KhCc6eaAYr
 2Ag.s1KyMvCoTDVUs5s1Eu7OOmHWAuYm3iix8yLZF.SoKWR98GbbOtrwLKjaUClckShCymvtvP_X
 vByC9ddNhp5uo5IV09iNWbW0uI1bzV2tfKRTQMMQIMW9zBeFvQG1k2Xhph8AOFzRw6wdejUi9Xd4
 JUGJqiXCudlFXhsS10uxT5yXnMwTzEKOpsu6DOVyGysgUMYFY_F5J3T6dKmRqwHaQX2NxGxz1Gfb
 j7sboV2rEXNrPIkT7rlRJlAXGSW3.06xdfDcRu3ExSNMtODF5XsAaW9cmTnSxCDeDC9BKnIQAOqx
 OfGTONW2ue.zl67Ub4GzRiczEQtE5lRNZQ0tcV8bOIbaZyK1ynT6rf6m8dYz2h0qaK3x4CV_WJka
 sKkZ4H5V67Ux7LzxHGZR9CoIcqQiVOiL6lHlUztwuUZzu27jLczXJlL6qu7m2MLAwRAcLhyOCzCI
 KUUjrdO8CirEPExOGj1MtPyn8ZGx6RDPdCRAwHVXbZK1RmuLNwNVmT2zboBgatscYrC4QIF7.UGm
 IgGrPjHq78DFHTVYnp7gMM9xcxoF_mfAwVKpR7Fk7flBopmmTfzH6I3FXi2_Nvn53ghu4Ha8.SGb
 NdChx.ACKKOsO_pPhGtomq16SrAJNp20Glqp.gnfWwrpsxKn.QkexN2O6ZdweyYHV0pp8vgusXhI
 0n41xiHurNkAZhJOnPw3ghFnEN4Wjg6LhH9hQLc4l8viIhNmrbdhP7f_AvHs9h5HsFkIFU7BHNEn
 cYES_cUmsO7doJ1w5gtmxxBWCmtYRE6sGk2qXiGUtyolVtgB0nXXJF0my.xSItFkOK7YycYxFhGC
 Ubak-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Fri, 1 May 2020 10:31:21 +0000
Date:   Fri, 1 May 2020 10:31:19 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel71@gmail.com>
Reply-To: mrsminaabrunel63@gmail.com
Message-ID: <1393162088.202248.1588329079284@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1393162088.202248.1588329079284.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15820 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36
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
