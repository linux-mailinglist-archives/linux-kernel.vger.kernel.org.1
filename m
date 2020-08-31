Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5686E257125
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 02:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgHaAKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 20:10:51 -0400
Received: from sonic314-20.consmr.mail.ir2.yahoo.com ([77.238.177.146]:40607
        "EHLO sonic314-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgHaAKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598832648; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=tgSxkm5QkLIAXmj/LRr0x0/CMb75yWlN27RMM94ObCgJeEKHAqk8Qt9F7V4daud1A4sxNyPtn73xHY04lvVAxB1Lm+aYWwVhk6rckyOCtm5tsZEwgYoveE/alGwsbkZfdt33nOdwvif+m56EhWMWeAtEYMrskwWE/n2/KDhRmEt/6VXiIVav30q+4JiDIQwQn+xdUUJCiPJtRCO7c+ev4Z8LUw6Wx+bpOiy6gELz2xxZg0Ls1il8ri3DblWKpTSFq5EK3OXrNK701eYCjTLGDlPca8tGQjOSFH/qTUyYtrTh4iQULMup8zC8dHnkXofaaRuBGjt7V2GR8MXM8H+d/w==
X-YMail-OSG: TBv2q2cVM1mjOHMA1Vqa_qIp_ImaFpK73tqEr.HP6rGB_tjj6sYYMkG8rHjETp5
 jWCiWRuAcRYCr1ztyH9jR91hfSZ1.I2x4AbfA7mdQwac.BdodxnosSEcXVETQQd.q1jQwIwWQp0D
 VqdgmBok7o1K_.jZ_LNy.N9Va.VeNtndQLuNetxKKPElYLNM0LhUHSr872_dje_Y6DheHKX.PC4l
 xSBxMvLJCoVGl5Fnaui3ynyb7DtsFKsgPjJMLdGn5iSy9af_HKdfnD0Xa3kUUK_aEebOZUWrKEGd
 1n.H0a3dY9c5VopckAEryiMeIddjseT2_N1G7gXkbd1l4Y1rvXmU9wckvStYiCoWhP_uyprtURvp
 l1.5MNBkQtzZJj2zpraR6v_Wl9M7Pjzdp.C_N3D6nJ1JW8ej2jn1vX82Yb2j0y41FC0JYOCRK4UH
 ICyu5ODGymXeiSG2.C6DFD2sgE4a6kJQaRWQmgErsUIcz._CxwhO42eJcXI0e5jAgdHaJoXh.oRf
 _x.IB9GguFOXMl5.o_UervEdvMq4hXiIp8xVQP_ug0Q_j3J48PVTno2CFt77mNbaSiDyx1h6ch6f
 6gYaiDxPMnNlMNtrvV6NelzCiNWs0OdbIZdAo6zMJ_I24JB8xK2..pGcZwJkMkplC31mYzJCuhkf
 99KMw7KMFz8N5xZYZ2QQjxepPDnD0KRqfECrHKl6qj10eOmvqI11XxxE9rfTzKYvnC2FvxGORcOd
 aCsOssd7PQ1UOFJ0k0LiB9ww4Eg81aT97jR7cRgxZt4aQ52MAJST1XtOsC_27B9WqK3O4ukSAnL9
 VHheNq8H.bhH9TEtvdvRmaJvTPxMEykIaaYN9vaHN0jHMeUXHWK7q5MG1oO5SsL.NXA_UC2KLa2Z
 gmBC4cWYkZLz8CAvnkuB4jQxNR1v7cNY3vsVSqna.CroMWVxNAP3WPV9krPa.riNTTZ0opl8AzwC
 mp56NvutPD4qhvXBjC.EFf49DV2kNuc57PJNOquwmdk6jsfLMaVRFmBYPqmpbhBlykJUV6lR2kT3
 hTVlLYobxGQiO6GBlrVjjbfNssxEnZueJ7wOcHHxKB_RmtxjQt4.XbfAP7ZwzqfeXUhtXp6YMpTS
 3Me1QbHaChc4JkNClje8Bhl6iMF7DRkkWZ.XNqVKBjIcEwBnQrMUhiF1ikDIAEdaPjYMMhWQvg1r
 y6a03OL9UREAfLs6x91MoDFkUMOOKB1o5TZGkXbWSMoOKSJb13CK1ReGiYsa.zc1pvC4Es6.ydFA
 iBTTI8VPy59DRNhTd0hBr18wYzDD9Ak.CY37Nt58d2WAouK0Wc73MPy.2oO35Mcdp3Z7GHM7C7T5
 h6YX0bHYcemTXN0N6lI84jPF01_2wKhHWNphxdbb2mH8TmiHMJtkaBahy63pfhxK2hpRGDTyr1zn
 eFflG8dgJTG66U3klW0ghZNijrNPK_XPbdtTaILqAnzpvsJqU
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ir2.yahoo.com with HTTP; Mon, 31 Aug 2020 00:10:48 +0000
Date:   Mon, 31 Aug 2020 00:10:44 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.mainaabrunel126@gmail.com>
Reply-To: mrsminaabrunel@myself.com
Message-ID: <1080667786.704131.1598832644559@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1080667786.704131.1598832644559.ref@mail.yahoo.com>
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
