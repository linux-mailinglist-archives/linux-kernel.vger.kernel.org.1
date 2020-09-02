Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A30A25A90C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 12:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBKDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 06:03:15 -0400
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:34630 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599040993; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=t/NRdUlcw0Er9f1wMbvweeXaVGVXj83qBMKGK/VXou2TZGrAXJkqEq4jtJnbxwPQ0SjR4Sm2hXh0NVSK6rwomEqHwXn9s3ZQUDKWUlIfLS7VG1iyuPBH2K13tu/+1XDEKi82WryTwbBYRoVyBv60CsX7JhFG7/lZCcveOwWcA3rNXoo+fUzOTDLNfD2FxQAH07dAvymyuuvswyATO00e3z6R5gdsNPo4/HfCI9rE9ndwO5X67H7Xy+Zrca6VedcKNYC1fXbrWg3ubJ21h8aQRRp3bm9y03Y2cU5cL9FhYAexTChgvA3GsTKpbkpMk9iI41kBNsaa6ZIWcf721kGrTw==
X-YMail-OSG: UxWgFgkVM1lxw1nvspVUY9x6HvO_oyWlQ3nbxm9f3yA3.btbW7xgjnOagapkiPU
 p8nec.UPPwtEcebcbuzJDr3VDfjLLFHk.aKApCOFGACMLKTl5VumhJAHaUIU5ps1mWtte_JzB6y2
 P.k4s58FMW36RZc.o6ckwfsgyyTWeSUrstyRJrsJif.6aTxV8BODjxynzADbvHbU_BxUUp2Mxmfe
 _zPCRDGJVQm.E7WMF_VEw4sVJnIguw.oAfzA3Q__.CBYnDpl4S31EIQj2ovaB2ucnWfOFnr9cBgp
 jSst8IGuEkLbGpfWS_vCvNp20vZo.YAWFfxzznsKBEdrWzqDiZpbSkvXInOS1xYjKArADs_cjB01
 D.fl9.0Brpp9L2FwMnEq8wMAjGzAYZ8fhw7hXtEby9IklqgYdVJUqSamOXSyEEiAsDb8j16Smb6o
 lHDJm_BMbrWvdPz5iKt4c.CvcyYjhW9.4dbLxan5SlNZrJgwGgXnIb9210lWybaL.MSyVqAhPvwC
 vB6ds4.EdtznSQA62Z0DY2EIZXZ.8bgZ57aQ.5ydG2yYkxggsoaszzCzfHVZtGuT0urD9QNF6oZD
 Ajc05aRnr9tW7vBf.i_v9agzprCAnTPdJuucauVB5NP8HPhg9T4QKFmnImjzBSttIYlVaL8Kim4R
 YTmvaW4PrEYWPyKyMhfeR3vnoDl.8hBKQ3m3PWRujEO8mctrn2ILqguGp0JO5kXry2uLUH35ccHl
 .ulBeF17UNO7brqRQeVk_cJAuSExvcnGUtSUzPYF6I713zoYQIZ1ABY1VeqvZwJn5.W02b5fK.2D
 zJDTNwouoP.nhnNwCtypjhHZWmsTmhJLsi9syT_ICE_MeOAMJMuS5JFhZRswQNOnyc8CaFWwicnk
 BTAbVsirA5k5i0YjszOc8bgssrLT2uO6etlhtU6K0_BeP3wOALyHvTiPHq9DotNcjNBAW57ayx3u
 g4nOA2Fe.Y4C40ahBpa.tp9w9Mds8oEFUOKu4NaxaqbrbgFa6Tw92VQ.H8bUNlqEEgAKwlw_A8R8
 NwHY0zGiNeEqKWFcTsc9WkITjM6Q16OVxFIvbINhPc5CfTpAL65iAiZwXvuHDuhO9yfeQzXjquo8
 AVWedOzqQnkU7U8wvb0k.TXSDi3vxWxO3LiuAMNGWAj74GIYn52opDzUVAQ4CKPv9X7YF6szLzQY
 sOzI.O9KKN2b1Y4QtdA3tPwbdLBVi0pSBJPHO6sr4JRF_UvheknA.z_ETR9GyVXDQpdC.HJ_jR1a
 _KTWRD9Pka2HFtDnu8yhmRKHXHLktiFEezU3L1ejbiwBSecnzq0gi2dxsUqO_z9L6ygRjlnQfSNd
 BosuXJpQbiQiVaYg2edKiBDCw2ENmmxLaHShUdqamynhnPyhpvgPRWBF9HWLyMx2dtYWrTcnWOHm
 itudVIify4AbY_MO2ms5GFywodoyhrlyAekZJzBV4CHL_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 2 Sep 2020 10:03:13 +0000
Date:   Wed, 2 Sep 2020 10:03:12 +0000 (UTC)
From:   "Mrs. Mina A, Brunel" <mrs.minaaaliyahbrunel216@gmail.com>
Reply-To: mrs.minaaaliyahbrunel31@gmail.com
Message-ID: <690042691.1457419.1599040992085@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <690042691.1457419.1599040992085.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0
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
