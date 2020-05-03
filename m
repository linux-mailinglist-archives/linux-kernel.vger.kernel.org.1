Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084AE1C2A0F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 07:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgECFCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 01:02:30 -0400
Received: from sonic302-20.consmr.mail.ne1.yahoo.com ([66.163.186.146]:37367
        "EHLO sonic302-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726762AbgECFCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 01:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588482148; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=MDyqgZ9ndfP91e0OPCguHcpuzVNKqHV7RBbeHNA9JFPTBePA8YYVCrTn7DEb4JwHqeMFcXihtfRVJrCLsmLeICiIq8cp+HdAFMrJjX14H9rg8MojotVqgL20XUTVTa8Ps97qzeZztwVeQSWEyMmxtsyIKfpW/4bAtdM0kdSvtTXIf306YSHAqRkpok12SEXFGslJ0xdhP0M8EOVJy02n87wxqmFNp4A+OHeV1W1uUefp/bNerhnzYaXxfWRrbT1WmHH196qn0+CntXsgE38lOQoCwFeAkkr/fDtYeuQGeJPpudYYdxlwFTe2d0xkbm+upCIFzDzKmThCMCtdn+Aj1w==
X-YMail-OSG: X1vdBOsVM1k2BtyDDAMI_p1yzzVuXCANW0S4UT7edq5R2nH.DBiCZePFn5pDhux
 02v.in_olwSTWXr6QZ2ITcVmzZLcZZUYuYcjURcTaqhGldiROJ0ASjXojZeVQhvOsWrwDcefReSX
 PLSxeobOmj.MgHf4VeQzYh_6z0OdDW6gq9KYGCHalo.6W3RM4l2.dFoGor1ucP3DxcU_NCIHGe77
 OzC0SDAqr0NTGvw1Nv6HfVNM_ZljRv7Eu11wDEHvXe265MRvfQ0uqzW44sWBGFfNO7u5voCpqu24
 JCNTRyOImo1YhYo1wRvZ8biGYCtVm5rf2TvHuT3pn3K1ZN5kG1DY26t_A_mg2syNddScG50qMwCA
 nAInF4VqnkDTJZgbOjfLClGiQwpbJKLLgK9pqFPuLQzywudQx3KYkxn4vSO0fd_jXZJtNZDL2vnI
 HKRPM2aSpKAi6dGAmNJS5r2z1Clb7A4Jvnfq5CVc7WCqEklk0TkaAVKtfyNBQ5qIs_oRzm6f9Nnz
 cTNV__kz1qQkcICs4BMlrrGrL5Trwot6W8QEJf1HvDkxIAIg0wi5rB2_sU9tATop04hVwGAgyv9Z
 XgrzZE3IYkGLGYOYh4j24ztw28jDh89bVDVRCt6ktRBZqoyBvS3KdVKQB6_chPHpeZgWdgtwWipJ
 5PgB12t0IuRJvVBPEWodQvwEK5j3g.f3DyaOaX.i4ePIDcZjJsLnMMetytfN6_bkoSgCtxVlrkEx
 lzb7r24bleMLdNblxbSkPkN_uFlP0LjaIDBo1tDzWtvqWFpWCgY8AFZ2QrvQtUFxLSQ1fJLbSALp
 .Zm.rqw7UH7PLpVqOZIRtuzawcp901otTB.tLcvAUJP6JS3074i362lbnlO7ZLdkfvycPK6bpkR3
 lSRu.gEMG2hgYApQREmi5A3XLeF2aDsm8DWz9sOOq_EPNYBbK3_f_WjbVZVUQtpJpiReLwTbAai8
 i0MUxuCn2XqtnlP0flALODRpmrjru0erI7yJBa9Ji2OYRvd9zxd9ehTepggEhQXFB51JIKbleutC
 Z7NzhaWi3fz.phZy7q5BBgimNTVRh_col7.NuBWim26SQy.3BGLm_CdwfiepIV.m8lgZyKdbWVKK
 HN_sj8Zw3lY2dc7nHVMScIXDCJWm15hpSUr_W92JSd8rY3.2sS7W6pg5jSZJAf3T3lAOyhkSnYzN
 7VHK.OXG8xAB3f4oi1M.6x7dOkHn7h_5leQnmL.eZUq3cMKbQMEk6y.BjplRAZK32WbCzRAxbCo7
 5PTDpRJi2wEzW5IcD3ozXQIuz8qaorpRKEyJaQ_2E.J5qbv.I.bH8JiThRJXi1p_Qc_roYk4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Sun, 3 May 2020 05:02:28 +0000
Date:   Sun, 3 May 2020 05:02:26 +0000 (UTC)
From:   " Mrs. Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: bmrsminaa232@gmail.com
Message-ID: <552735495.405958.1588482146712@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <552735495.405958.1588482146712.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36
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
