Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4D522A540
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbgGWCbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 22:31:32 -0400
Received: from sonic309-22.consmr.mail.ne1.yahoo.com ([66.163.184.148]:43012
        "EHLO sonic309-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728914AbgGWCbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595471491; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=YuhnkVwba0G0+P/Xbhrb85xNowpY3Z3ZgwmA4Bj+L1KNWzsSG+mfFJFct0ipkhipeCbwMqNrL+sZznFacYkChRDFaJoi8OJOs9vrmSdBZXpQSQxlyGrVVzXnTbYRLQjimakOtXddMCIMjXTfuMhL/yb+z5q//ecG4/WH0Q6QlNwTJVu2kS5/3tolc8omk9mUsiQyEXZpjnKSp4w2NsPTgwYNyKTsUna20dufj113Lp+Dhi7QeKJX/Ik4Do/cEr/if6Old6K4ltouOyHptQlmFk7f1orxA/OX7nRyZwu4u02SyGNHlrig+WK7kNn+gEWXh/ULATaovjljtKgfi/+pQA==
X-YMail-OSG: UPrfCQAVM1nIoNn.ZhHmG12gtKooj40KlnmsAn4egO2gzOmixMtlvqoLC0P9EBq
 yD4rPPAU3m1xpmEDetjhlcuWPoFn6HWzS0K6a9iYSqd_cFzir29JaSTj57cSqqruDG5wrjhI9MIO
 Da_m2POQBeZJ_jjIU3ESMF8.bp56o8V6NSIVdCqdNdM2U7wt.ZGP49vBByBKVlnh2.JWSjFCQepk
 z4ALjvywGvXOXeb1KpAe1GWwNNqdFpyRNoCHa9Bp5rs4i_1.f9YEvlAnKJqN3PTB_ZZwtez1eD92
 _8EkXT9vmseRZIGoiqR1bU9OuDh9Bz8nLjqCQyjX7GPoM__hy2YbrFc5QNfo5mE83084xRYw2t1S
 6geNvVjWinh8G2E9YDoAszVBfRzryVwWAIhcAZkuRVel5eYZZhUnXZRUSgXj2.Xva1s9samXkj8u
 l0t09rE3oEu0fZy4Hujpu.blNg_IHDeXHUGtwxTcRxpPBiH6p6VKQQ.Kb9ULf5yvTdL_Vrre7.bq
 T_XQnXt2KPT85xze3du6bYf66tA0fcEuMVRysaC0FGV7TtxPGu4X8peRVh.ooAv.fHFHkOCNcj2Q
 CohAsJ8d_Igku.2KXMne37jXcN2MkYtrldIFTSwVU1CoglDVeX3dbtAf9s3YX.sBkODrGkhkII_s
 YYghjGR.X6fkf6lWUsVPQh5aREqy8dYBbqe0V0DwQPrSXNKE93oy3_zUJLC56ajxZdxcpOm5bzt8
 .MUoYE.iDlrCAtfAY4Lf8f09eKNsVF_WcRzGdt0ZBVzALbalA7mYAYYqVJdxLEf8Qaxm7bmd5bF.
 34ukZHFc2diFCuObsFpBvg8ogv6qAwflSr6_FkwqJ6JYiQPpJn95kM2YgBEf5kMvr52HlboUg1Ee
 .I6rQcOlUt0P6NVybNGYkAOHJ7P4DkS85qsL.rmsviMD7pPhZAZSBFX6QgWBpQkcPeLv0waCMsqL
 LttQ0TXxghMFyxUah0ntb6LrtgvjoMS.FQ_rK3PY1EK9HR9cCG7OjOxydg1KbWadTFrxPsH3bbGG
 2A2cF2ug4_C7ktDyb4SnlGXgeD2G54EuwRJ4rv2xog.D6K7FSuyUpqTuw3vTPyPCca57VsigMXPz
 wcVhGd7Yk7aA88LU689Tl1cGvQq67v64ORI2_18wMSQ0qpj7epUAgN8sJEydihFLzWU.ZNUTvFTy
 hRsFyCpEoo7nSAztYrSn2h6Fl4jTmakOrMiez35cQtCltscCpPos9cpCzTCtpG5DKFZzJV0z7VzB
 JK8T451q1ULycE__jg8K31d3k3PZiR2bOngz1ozq5p_LaFGzg5Thr7QD_DMdkjGtQW1j.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Jul 2020 02:31:31 +0000
Date:   Thu, 23 Jul 2020 02:31:30 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <1625102110.5851349.1595471490289@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1625102110.5851349.1595471490289.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36
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
