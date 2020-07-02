Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB42120AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgGBKMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 06:12:43 -0400
Received: from sonic304-21.consmr.mail.ir2.yahoo.com ([77.238.179.146]:39217
        "EHLO sonic304-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727057AbgGBKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 06:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593684760; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Vvqbaxcr2RyWbLNB51iAsvK+hwYs4vdrAZukTfnWGA7AnktmrVy5MN70lGWOLtYOJPOSin2zBB7aev7anp18mX+mf3y7ms/FyWGaEe2fshoi70wu5ftDkPpos9ftSgQS73DtF+ty99yFcqE39I9GnVYUsJU1TaKh9hfwihZAPUMLz/kwRHIYT+1mnqtGDaJ9p3rOuOqjFLv231O1wC6R3zYthL/ajDHuk72EwZPtpEotX+9S7D03q5V48AFTR4q8x2TjuZuAIiYVAmYpqCkzv72Us1f2aN1JE6da/9kH5H2Vv9ccYOZ5qYWVvO2sgwnJ1S9h+sbmf63IrHS2AAzCCw==
X-YMail-OSG: QvcF20MVM1nga6DI0bfp1HYbOOs1T.BWj6MAqO0NocpFJVDYmiQ_xNGVIl8oQ6M
 Yw5QzFQZYHtu19D4T1g5Km4QafT0OeiyXm91wce_u2yj6YO7u6RbxnDTnQ06gHHZ0gi8jJ27vmP3
 WTsD84mWxsWUvLp05UgelaLG3_qrpqaiYunnLsKLWGfUkcgg7zvxeFCJDqWLo6z4XHZjf7wUjL7e
 lD9EsIPBihxI3jkoOd.8EyqzdZCuoGenupcOsCJ981TxcQcX6CDwUKc0WBPXVpeAbQMIfSzeszvD
 s4aPqVvykVWUjQdD7aZmOLnrwamUMklrdxUeINdiW8Wj7yc6wToY9zp4C2KpYJGu4ydkXdsFANmC
 Nr3_Etlhn8QcJJxc7TBumnYkyERsxPOhvYYso9J6RC7mdpLa9Qb.hD7SAxNpUr4mAFFHZe3yo_QG
 lw5pEFnpS346rPCP586DGKh2e8OrkAXREhBAIvgHsUjptpqvqMBmR82mV_AbA7C4q4tcnKt6Npfs
 0QjdiAkW3AL26HvVOfhuoCO_3b46e5EEO6IAan71shaG2DFzVDnqNvDIb45FZ_0m9mqa4x9vSUhF
 Bqb5ATD5hfLl6uCcOjfcytCc674UiK2frMUtfp0M9nSKjOrug9E5jLCHkT0cQs._jN8jc5IaFVS.
 vdv9tdNy2xvym7hkN783Pht7NYHxcQGw8RikOZCCwcpSu.utsGIG61lMm25flPMfzXDOSFsUH_a7
 g1xSQHkhR1hQARH5OyB9QSvxpbFtMb6I.RjVgI4gaEvw1STQIIfvuW0Hcj105mOyoR99cJtbKFiM
 2kVyJF_2PYJF6QyxbvojaM6vpTTXZ6vy11_ooN9mXOZrMAvZTOeyp05chtEzp70HAEKOGS7XbZRl
 2PRz94Zh6425DX6AZwEk2UNhYvcIWzVcegD6_9v6DBFlBDoeF0vkglinKjzJRMw3PJkmUYcHu9a5
 ZpwqsaYAQsGF.xl7VFxkAil6hK.aS57p_9i6H9wdpnUiixGOYWsH8gZvuzzCx6tD7wCNsFNe..Er
 s6wKnM9GrvHlKqTziVU1LQ7jexQ6EsuSWLKbXllIhW_d21Vb_9mMae4BOPqYPf9i3c3zjpfhp1XC
 RFfoHN.pnKMb0XbWIaVbU6Z4DweUy9rT5mWpI6MEPC685buYj578PuQIGPxaFLxry5.Qfuxf27I.
 uiGLQGqiT7XCW8TvwScpBBQnPKl4accPuf_EFbXnn_v8hX83cuuLHpAY19virDJ3VBXhsphVJP0z
 7jflf8fmyCOrqViXR._wY1rwKDF3pJwiAUPirhMAogiG9tJ80aEnk6Qerb.m63Bsz7uGX0QHgxQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Thu, 2 Jul 2020 10:12:40 +0000
Date:   Thu, 2 Jul 2020 10:12:39 +0000 (UTC)
From:   " Mrs. Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: mrsminaabrunel57044@gmail.com
Message-ID: <712946485.2454594.1593684759795@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <712946485.2454594.1593684759795.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
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
