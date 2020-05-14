Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A401D258D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 05:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgENDtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 23:49:32 -0400
Received: from sonic315-15.consmr.mail.bf2.yahoo.com ([74.6.134.125]:46605
        "EHLO sonic315-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENDtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 23:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589428169; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=UZJtWbiMBbMcQdBHHmeZteEs19SgkHBgiVxdE6Bq9+RfMXrr2Oc46K6QrzPlcZXxHDbb1BBGbvjoXtmAZaCcOJWSd6HRsq25YpOKNVNdmF5yOntOV9XIGJAdtslFSiDWCIefFc5pQbWphDer+nlYic0ADzjAs4glBCFhqGX17V1awBG73Xhf7I4GA36NnH9TQHajhrnOAhYY0NHebJRNRY01FeSgsoqCzCd7QtL/IlctzZccLkMOHpzrToJH1DckfJ1XuXl6UpaMVTddm9avYuMNgDRfDcjWWrY8bFJ+XLxPAEQJoNdhF9exF/VgL1tyfhj1iOXbZi9TWSaeLgYraw==
X-YMail-OSG: WCP.vicVM1nectM3fvYdZJk1FCxLXQifweQiApCF.Fh7FIM_LSETmRROjx3FmUe
 LB44iS0jrCAo.FRU0X.AJ6Ev0xuFHnxv9UXP2dxvfXcDyb8AOuLd2IyEsZx87otal5bXysgn03bz
 TvrG.6CSWtxX9hBto7AKbnT2n4DOXsMWwS3tasMwdxCtS05xogMMIFXzZkxZ7tEB.eQt2g9vyvbc
 gJgCGMEtfd_0GNN7cTZVKONUUBDICWn38yMISXgenLahhLiT9dGIWpLHMnhf5CAvd5AJBqSXU2zs
 UY2.So1.9Yg6JgoK_YPRqpKvf05CgxUHEpOT247MUP9zB22amJpLLSH0YtA0vfveEF9Z0INaT7eM
 OhIabzVoPOR_EDYEU1YnqnwXhkGL1Jyc.RWmDv2f3I_7ywBDSUs2_TR2mvB4SAnrVMqPIyQezLM5
 R3L3QRoZcsx7Eld0IcKE65sVAkFPfyJE_ruf121DHh9cCp5f9B5mp5v924VGfPqNxC9FrWJf2O.K
 YHyNKuToOs17x6NLA8qhFmDdPlHqL.dEaSwbGG2MJKZbZQhHxHkpdYMVrbnaKxGJAZ_6s_OekJu7
 Jg3hUw78pEXseTW6Qn8m22mUh42ITokKEbzPcIBtC_VajG1fD.XIvvXE0Glj0gxPQKkTmRnv2IgU
 RFoJf74NeK9JbJd9nZMUo5jqZwGw.YzOVQTjPWI0MecBnRvGte8gO31glvDq0k8ACi8jo5cbAc_H
 D8vQgy6ecX25U_hUaHoMgLvEJRYRpdP_MYRhYHVodHMWw5OtU0BSm6_zL.hoDU0JCNiM7K0loFGe
 Rfhj9LjX8zXTDASDqhgL1lzVvkKL2KJdn0wiD62HvkpPE_Nhmgg3m0aOC31MckJaCwlXnpLZ8GdZ
 UJ_cDtpRkXEqiAz4hKJRMOGSiO1iwmbxxRCa_l1HQ4SThgFRyAykz1dRFg5kQRzRfJw5GoMS8X11
 Kr0Oezj6ePafNH7er0aosdvfujs2RYWafYaTcgcHSIN6rtDY5TACFMM67lieHLlO6k0j5HjV41QE
 nzWr4ijg3mcmzLtEJgNI5X03xAzupdCFk8LBgjuLh60iEIrOsAsrnQ00MK85RnQu0vx.GzHEP1MP
 JHuO1QJPQz0VYc1FeQcf69OHVe3lqatlBlbCWa4xjapitttpbke5DOAXEpnFKxdFDZZeW4Xu28TU
 DzGQaDiYX4JRPL_hVc3M1sm89K0k3ZeNoK3sviVEVeODus0uDZQs6zXBm.3Zow_aTgcqkGvmkOsE
 8MuNJn4Get1IS4MpBk5KpSBZgkZc0NgBx4cqyUwNUcVlie3tSBFyhIwRYCRlqR3tczzaRFwQ0hQI
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Thu, 14 May 2020 03:49:29 +0000
Date:   Thu, 14 May 2020 03:49:27 +0000 (UTC)
From:   "Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: bmrsminaa232@gmail.com
Message-ID: <351383128.610846.1589428167392@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <351383128.610846.1589428167392.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15904 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36
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
