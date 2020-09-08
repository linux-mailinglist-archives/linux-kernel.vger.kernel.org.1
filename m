Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58BA261205
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 15:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgIHNeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 09:34:46 -0400
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:35991 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729725AbgIHLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599563585; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Ni7T7coo+OoOBmdPWQvxv99/MNe9DuV0TJRG1bxTJjYer1edceeONKdZXckIOnltX5zux9lKG0XO1xH0FKcrXftZQ8cLmQodnfUMZ3AoyQ2/KPyhcKoT6cEU7uURhBhO66yUEW1/9ME09JnWNZbiIxV6NJqoy0B6Gi12359ukSj7o5Ai1CPI3FPWuYigRUoUnBa4PuiO9MLDb3Ecjafvdq8BMhamWcuX3a/hcUAFD1V7nfh+YoqyUBDR9FL2ZTvqBFW8GTpVhME+Q71htcPb3VMzfXZRnwZYrnfnGsdp3iH+RH1zGFG/79Vg0b31a6+KnsEEYkbShs0zii/3nKbV3w==
X-YMail-OSG: m6ORi_8VM1mbqvUzNmnzGLRJ_EoHWfFP5YDkXD88ekVWbEjpg26ZKw1TMxtgKIq
 g8Rhu6y4KjVAuehY0uPmNQ2RqVLmP1o.8hckVlDHVFdfRbRW573sdssC2DZaleWYKNNQotLpfJGE
 ZWOR3rEf3RxX5yzu0.wG3f.wGwAiXZO77AWY1jai8NaNCAzOtkVrxtYzGs9m7Aw8MI70JaRQitDW
 YlG42BCmwKxH6Nmz5ryqjxWIA1NVQKlth5j0U4gqQWmn3JmADK1LODnzZorAfy6Xhn.Be3haKcfp
 9t5qXlIfEfrgiwF7mLsLPo60dAD2M9Bs.EXbz.u3.syvtkCXXMyTMZevHnPw6R1meatcobCZwO76
 6rSI4687bLgvQbx_2hg3aH68cyeLA1OW50jdHBDkTXSK2Nh_T.jr..bozApO2g_lM5S6aIfCs4XW
 V4P9kf3Wh9_5SBDRZehtpO2U2zG8wuF1CiO1Nxrgs_N25Fal0l5Jhn_5D.yjBz6huj_UIJt8MHnM
 dyNNPck8FJhPIsTF1ozs9MQfVYCf.00wL0qQ76C_uUkADxygJENJ3cJYtKLKMIWF3.SwbsykrdLm
 2z.6hdbjCJTQSIV5XDMGzqLgKwBED4Hi2MOAw1hYv6zpks3VTfNlOt82S9dSkma2usrzCT1vLAYA
 DMWgtC8SA5ayQNODjnuEX4M4pM2LhEnLenlNAkJ3yK3G7HZTkG0TPJ_kpJoXSO.hIN712rwYqmbl
 SfsTRNSk2kR5L0y8iIL63uZ0CnCTdIdYk2vOPqTg0ySkakAEAziqTgItZ0Yk1A8HJF3OS14JJUu2
 DARtlbJFGpT3EGOm4TDI4vXOUpaNfUycu1XGJ4Ufzvzvk9lMkzX1OvaDT3Eo4bu4uY8LQmyC5_PK
 MjzDyGesT7dfhJS.OxogWm7V8Cj9w.KdWJekY80ZrmyOPH4Ewuhl9CB86MIdp0UztuEdSVy.FnOz
 FTtCz.Li2ZgDZRj5phYRQ8bUoFZv92DZ5LEiOiA5p7F24do6avRMpZp37PbqNaOFDwMVI48ytlVN
 r5S8XRNcC7x7Yghu.kBi7EM3RhRYlNEF4XRnalO4aWjwApVhHIH.rvRBPjJLmzadv3kHzg_mCTat
 8x7XQVGDBTsc9STO5pVKvxyM4y6M1AnmwAimhrGmzstwNJ1eE7mneK.U5Lwa1B5QxugJgcFYukum
 G_6HnwnSGdhp7HM4ZhKCklBHQffZu0Fqwj.naae91wUofw9nqeUJM1GOkV9Piuu3n8EzyVtlQxIs
 _4eGsybr3j9NUzuFm17x0PIxaRmQMyH_p0B.PesbyU9b55xJynFrbKIDARss.ORYyyvuegID4hHs
 XWItr001uo4lnRBPo3xNhv8Bty5rqgkXHkusd7oN1DelYfrnVqgLu4T4tTA8DhMdXtlnibvgbaTa
 WdCrupYnHcCHkFy3NeKJTrcUwLl7lYU5tLM3Oqdb6bSBCELtU
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Tue, 8 Sep 2020 11:13:05 +0000
Date:   Tue, 8 Sep 2020 11:13:02 +0000 (UTC)
From:   "Mrs. Mina A, Brunel " <mrs.minaaaliyahbrunel216@gmail.com>
Reply-To: mrs.minaaaliyahbrunel31@gmail.com
Message-ID: <1063963437.3354017.1599563582944@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1063963437.3354017.1599563582944.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0
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
