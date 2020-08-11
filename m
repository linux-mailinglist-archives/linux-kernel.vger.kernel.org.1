Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879AD241DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 18:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgHKQHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 12:07:22 -0400
Received: from sonic311-24.consmr.mail.ne1.yahoo.com ([66.163.188.205]:43648
        "EHLO sonic311-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728920AbgHKQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597162039; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=bEEGNJ3vmLkhsHQjfIm1uEUxz64VIiPP2s3gWAVXGRX7xlTEOIR6qhPNQVOEProvKKg7o8NnZUA8XoGr2VasTQF0/5SmV6NKI1KJ6qidNfGtPd06ciajZn7il3ATHhkQeOeOaipADQVn34M4YYqNEfZEDYYdsjMOge//SbOKFMD2YhuMW6vy2Z76N6aNaijIVSikBKcu+vsP2epEwq9SlPeSwpCMMqPIjvK9tBH6Pwrftrg5PzCWBVur4HuB9XtOOFOCPSbNUg5pWfMzGDAuvzVcT2EpEVT8zRzUZxpqdC+V9qHejtYuWJideSPHCqkUs6PXjOaUlQIMPbAjpwtU0g==
X-YMail-OSG: jjBtou0VM1nFMj9a7.rfVZyut6nIHbwPMVKbothMAFC20ACAxCXDleuxeLroaaB
 xwlVbsEOb3B8Nn7zXrU0QrE7PFVPAKxWYYV4HIwL2WYS975ic_q14Dg0Yn7J0c5mKwX0o_zJzIYI
 peGJaQHEEGAjOC0gvgqVq5Rk9WRs4gCimjDcdsiPmkKhA7BGMM_VfL1NFhVEHgaeLDHATmI8jBvJ
 Wo3bWTeY2BJOPHLfWpJd3P.kZ9ZylAL8khhirwps6j7rDICC4QLiJGzDS9V0sb34j_MLrDyujevU
 OhJlkTSpI5gvV4V7Yc4vveh_v_MAifSjZ7nmc7xS9CiNQFowB8J6nGFWfUNwm3CtyPfqfFVnVFpE
 afgGqxCw4hnzZ.Ajb2EGRtBtt6Bm_x7kuj_YUYulxaiZxyyFrNFmXp.K6mKnR_mE8hDyCKrDAXZ7
 F593CwO2hxkhJuiLYFluboirwSqQjkikaDIP5NEKmV0UswguyQivtHu7_v.C32ZSoRY3BOlBU6PH
 KVOUevREh5xSqR99LaNQTFLTwcmSBeFHEpjxMPmh.qTTnEasA2ivgR5alFlCKgCbI9vQ54gqZVMA
 aIoycAmYwth2sOrD265kjFuq_pCyLVZUkDmTKr7.p2VNSKV86EBj32EA.lzpeeHWP_HrbrmGsoGn
 P2VyWtilsgQykA7GhiK1B1JNyay7b6cfsVVLMJiKW_oT98E2coDdJB6NZF2_RzYFVfLqV7Vi191h
 OmUyD7e38ArF_wfYDj7r5bh6lD7AUKmE9tkwrJRmPpMUVModCDFIRyRI4GFyX88YO3fRlfPr.GHR
 m5woWBKTqcspo17tOsgy_ogy_C.NcwOnq9Cn28aFWWMpAa5oCK3t3UvYhMNbu5_Y3VNXVIFjD0EF
 LnGyHwBiSN.obe1pRpBjqj.zBBT6WL5eTg5OoKubFbWXpdq1KY.yy834OBFFONvifLSREF062yf_
 Z63Nr8xgQefKZolIkb60ulvJFisO1QfIjq3K3d4TNZ1ITxgNo0p7spQjG8bMm7meUUy_WNw_wVi9
 131eGNRKQ_3Pq76r34jxpfwh9DeZswQ8zfLVOPWcfEXh.9HOofbBAYR7iNPD8YmlAPSd5dk72MEo
 JNdeA5rGXPvMYcMJu0rtG3yx5iRYzrDw1GoIlrmmBHzdquFvMRC.Vy8uyKLuC_..P3WLVFXO7sc8
 9Eo_R16lwbKMsB859BBL9U0XFm4vHLoH90PFIhCsnPfdIMukUSLFJz.SSmzInOk3d.9jNn3ROpg_
 2yNlANXOJ9ngPOsUWy3las4hy6siXFBjgS0Er05LHGXiu8zvlREJ1J0EDVjg0bLneYZ3.i5z6h7s
 5yBsbpZXx2YPm28I4o4aPY39ff5CxzLIuP6VTAi31ACe7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Aug 2020 16:07:19 +0000
Date:   Tue, 11 Aug 2020 16:07:16 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <brunelminaa2@gmail.com>
Reply-To: mrsminaabrunel653@gmail.com
Message-ID: <563867142.331124.1597162036487@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <563867142.331124.1597162036487.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
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
