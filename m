Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9C42327F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgG2XT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 19:19:29 -0400
Received: from sonic315-21.consmr.mail.ne1.yahoo.com ([66.163.190.147]:38716
        "EHLO sonic315-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbgG2XT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596064768; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=KDM8QcoV2GGvZxoI6Lu168Svm5qcunrUrKhc7t0lms/V7DYB0Exslv9jQDuO3EF3mP0ClGIeDeGBdAPX1whQbEJkdxpoc5T8OKg9Vk4VoTwrErjPG+WR2qCk9wgs2cg27Gi4ZYqequdD804gjByrKI9xjKnfUaP6ZVBFpn1yIcYc60ckb6+supqY30izaeOdb1Yf1jOrrdLw8iYOzGsCCzztIO67AjKk4vzlZg+ZdyuU5XeRFZUXV53EqQsEOZuEzz6AMIpYWF443Sfv+08p1w6fudWSEQCzS/vqfTbuE40HmGP2ECEuXJLlOdXBTCP+X09rNLmwZ9OJ7wPmBfE6CQ==
X-YMail-OSG: hkUI6wUVM1kV1U2LTmY6oy4hynaNxuoHCj_DmQovQwuwDbM9y0EOUjRCg3WbD8N
 NGRNO2v7_2RSjhHyrZ0s61SfSkRzO7WX4LVAbbZJrfA0luaFL4X.jRyMAvLDx_oNUH3MKBePvrID
 hFOFcuoEedqxClFBavnYqVQkPJVsQixfGskq57nIlNTBkPRJPuEdDBJXvau07RIdmmL56nbGcveS
 yU2NLzbZxp4iiIfIOUnBFQSTeZUWJyLs4dcPfj68toT7cdJ1mlDwhl5q_Vs6ehRbZj3E3FRYJ0HF
 0QptTE3q9S4OfZH6gcRW_hgwWUZRrxgDimnWIFqOGOPcHVaKeFhZaeOplxXczqMI6wrx.xcRFXlj
 7Y6A.XKd6hl4bGL9_uzHAYeZi9M72AwkYxU8UHj7mhtHNgBpaSSOdoIX2eTSrMxXSJOd0S7J9pYz
 p8bdyLOroAPTezXjTZqX7wSc_FqT2LS2lQNxYMZ4ZgJ89dff_Dq5kY3Jf.rCPZggwJNvlCdzXnzV
 SnfuQf8v97Wkk7apAOwEh61CFPKJZygl8a7b8l6XkiL28qbf58sZp4A9zqNHP4Kr8Kyj4wU4Z_Tu
 HVJiibEianNTb5YOfJITA1QiU4TavmhiBIOoRAz6wxJPwo3N3cKwKk0MMd.VUF_M.sVGFno0Pwt7
 wUoevKEj0N2UQU8V3lUZnKpW7LuaRH.Q4ixPlNR6uRSazm3IXrrkgkbOIVz1k.p_oo82ATV48d9D
 coP6P4wfLOXH2BlwarJTx8wemGG3Drxl6GBOiNiShSyKS0UNA3hhclluSpe1d6Nypo84ZBJmpLuB
 ZE1Bpg94VKfBPWmj_Cuxw7ZAhXOLWXEmWOrPoGO.d_moTK6vgi0S85QHRgAidwYTSVqwp0V0pZB4
 zRCHZYebbRZ8b9.A4SAXti4STU75HeVfPin0KWIhRLXv3PQqKILRqyFDS9P8fKzDeVQNKIRjeSEl
 hLWWuJLOKrYO1zLnXFFTc79._5K62DAOD2vV02adRSaTZe3j02VNo8y7jWf.hwbrUV9OA9yxe752
 Rlu.ftDG0VnghVF4M.77dWsOz8H67VsTeywCE7phFyZXfG2Y11OaXREIfBuATCVLYMsWNhmI6uAs
 uKlQacD.rYrylmROAeE.N99xYGUeRGNPuad4n6pn1kqNratt5sUISnbBB25y5RzI4..ZHzSFCBmP
 D5432tKxTjIhXuHtgMeyseenOyJejJVUJwAqLTppXuucuIqZNR79yI6bdsU6uutBib5O.LZHa.WL
 7x5GMxSKnBJaEoPi5ikdqCvEsAfp9SRi9DKw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 29 Jul 2020 23:19:28 +0000
Date:   Wed, 29 Jul 2020 23:19:24 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <568704924.9238132.1596064764684@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <568704924.9238132.1596064764684.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
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
