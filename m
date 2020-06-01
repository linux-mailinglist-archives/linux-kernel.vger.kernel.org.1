Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FB31E9B78
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 03:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFABuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 21:50:03 -0400
Received: from sonic316-12.consmr.mail.bf2.yahoo.com ([74.6.130.122]:46745
        "EHLO sonic316-12.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbgFABuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 21:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590976201; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=td04MW1zDZ5aZv6oW0XO4z75o1E8LajujZdjgezD9pZFBwf7PC39amS3mWOzquKxFdXJ7Sy99s0BGCHc2k7AehtbiLdzk8Y2O41QNBU4kmacan+TQD64aBu9PHDQrUUwekxJO4CoYbhrci+CmHvLUZZrH7WFjOv2Vnkn3rPohUTu6CDR2pXUjpK0EOYbNf0x1PARQDYWNECCfWWuObZo0YMy7Qocpr+RP+5cHbPtkWlWE3LpJDK1kWNJfu9nufMf/V7lKaT7KC755rvLBIUkmaEvSVpzmAvilA1Hq9jtmxggw0ttn2htQPO2gwl03nlXLbdCrp29nfswMXRHrLVQGg==
X-YMail-OSG: mfQ07w8VM1mG2_TuDjSBJaK1UTSJiLkKe2Zd8yhaYocgorlpYFkupLS5RMdmo2R
 SmaGmZNQ84gYe3GjvRD_nfCBpK2d4PA02PSqMH.jrRe_BaWqyOsltHWRleDkh5N9mDy893Ty7svV
 z1KtbpgJOQWqikkN9EumYdO4qtfX1PY7FR0QitciU96KT0LhWFzTeh8PRrfjRHqeuppu3G8MePfu
 wMreOTCixmIZcnutU5l4tW.HEWiYZ_aEzkyAolW_EE07huYbXELsBTKjoB63WAGDA3M6Lgv5rZpw
 Ey7PIuILRNuJAhkAxQSBK_JME.q1HpdyvcWNdeqk58k2EpoFb3HUY1edXNqVsG61Zuc8lsSplCHk
 4ah5C9AZvcTqpPwff4BTOb6hJ_1Th1E.1A0e67kFbDzWa67coOFl6k3Kwo7YcV0M9UFGpDa6QX4Z
 847teyianmobFzKYuFzeAuPt34Ijdxq4.SYJx5QkPhqNOUeQBZMHBPHWU9JnxhpAwqEiS3BEAf1z
 0EidG57Ub2BlZjz2d1zsV9JSX3G8vHWzkTRDl5NYIHzKycuPge6anrLP2OFtHhnyhPlm8FEeSn0a
 DdxoU0JkOGS4Dap1SLNb8n9AxD3iLGodF9DXN6j9f6c8.TitrwWQJmZcRMcIz_OBrnN1O8PiesdK
 mPwjDNh41drZJta8o5OiGWF1NqZtEzlVTY1gXVT_jcDPNh3z6NkgioIHGJPuZn4VBUSHSAk3lpl9
 0Qpw.uEccY54P1iHp1psUStRft_X0XA98IUfg4EJoO8APeW2KAQNpdnHl3nqJJaiwvW6NI0CvvRV
 fr9wok4u7b8Kz9qu7RXZNpNB19iQmjyJYKoE1b.2.3ErIFmhez9eIY1x4jQ74bsGrBX3fHMTdNVF
 Ru3RB.kVM1wR_WnsfagtrpRLcfxGyoQKrKa2mGUZKe88pvFYmBFB8fil6dMnFjVvL118BbN.pcyW
 YDuLIRFpxZf6kGF2E2erd_uS.S5oyIkTCj94v6wx49rpW_u2ZbEC3Nc9syxhvyHaem1xcpJAdwj7
 q3JoQjQiuoq9dvzm9J8iO9ssTbFMYdJfH5xfrcFQ9Y1e9DIgi4_UeJQvysujAGl4jQjxOMEJWyKg
 .4GTLsGYYmaVij6IqSbaLZW9CYwPuRDxM32RFAVUEV9en2ye3rk1IYxy0X2SESzOO1Zynv8bKPAN
 ZnP7RS.mkvVd468i3Ew8ihPP_snFTFKgi19w4EJei5LQ23abcPWYgBxb7p2N3XSm2SA6HF_M6wRg
 a.Le4nh1NcGDTqGYj.USp23I357Z48zxGhQbAQNZ4W.Ngub7GjQOOXHrHxMuA61gsrT00h5p4vgM
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 1 Jun 2020 01:50:01 +0000
Date:   Mon, 1 Jun 2020 01:49:57 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunelm@gmail.com>
Reply-To: mrs.minaa.brunel703@gmail.com
Message-ID: <322617381.430449.1590976197161@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <322617381.430449.1590976197161.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
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
