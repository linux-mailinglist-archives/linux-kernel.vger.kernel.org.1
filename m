Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D1425E5E8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 09:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIEHLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 03:11:31 -0400
Received: from sonic306-1.consmr.mail.bf2.yahoo.com ([74.6.132.40]:32903 "EHLO
        sonic306-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbgIEHL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 03:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599289887; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=irC+/cd2pOYWXMaFgVBDOrKlH0jgbyXYVyQZjSSa36SnxYqTRopObrr8aBZsRLsIV6hhHuZAjtGMQPEfa1vgSIqnFCpKvOF1AXC3nS8MfKH2/CTTmiHE4HTmNEgzLCNoDGwnvEvfXWn2uBJGCKOI2Aj8D3z8yPf2i5ybaQtbZomCadGhRJYpbN6CH+TwJeFqG9i0L0P66CJfI8CrrBpfW2Br76QK9tb1mR12pzSbqA5H+J0mzJNYriu6fT7h06QW152jAVCJW/GmhDhCizLcID0uFjFPrSdXLvQM3sLOiEvI0B6dV7M3dcLUVB8XNa6rdY4p3K8PjYxbxZw5GgymUg==
X-YMail-OSG: 6XGF8I4VM1lS6S4o9sfSl_ZXPglQXqj34UVRP2gkOQrcViIeaT13M6h9CdDRY8L
 CvW3QxOW6H7hWxrGo.6azsruJSzz8G350WPODVyIF16qaP2bpTRg1.kklWnBAZ_fqFJdtAa6Jojj
 wGefdRo_Qj6ZBHKNHQ5fuMLBEVE3gxkFDnU6YUWiTR8I3nQLVGjCZdnVjh38iBf2F9Zd3bl4WcNV
 kj7zyQ.mOuRenmxNZa4ZKe8dkBVgAZNkpvZb3xWCCtiRB98UMzUG6ItVQ0Iapn93KPpfgSAYC_nO
 YPsyxU4m2mXUHTV8BhVbyGz05I1oV3GW59fWCk5A0.4QC7CsmP2CovNXgPmHAENX49.7UJp32P7Z
 TLtXSjc3Ig1MQ0xsADGj0hBTSclvHtvzJss5TTKj6jhI2tPWHoSZyJvwmVzvZ21RtLdxFO18gfR5
 Rq1IOLoU7RwsLoSGnB6wUCxQJAlfLSxm9S8FWV03_EeIbYXULbgJ8iHNJNv.3MFnLdE8vBQEa9_7
 tC.._wi21oZFknX5o8UGCI1Z9.y71h0a737NSE_N558dXKP3KEaBnAB4FQ_efTXV8Pu8hX2r9Ix8
 vrJZ6CzLW3mTq0_eRWUbQ508Fe5SFhJwUevPaoNN8P2xzLpvsJe91kWjlcMBSp8YIjVLgWdRYKkJ
 DXPJrbXrftsCI9EdKm8tVR8azwK372VG9i6iXzSAQi09lDrTUaibSKFfV.x3LBFZphCy_wP.PygG
 KRWmnNngEELlrmzyVwmazjdgR.Q_B53fFdscjQQ6B.eiW_ftHjKLbButaOhG4xqoMsNRf47e3ujC
 enyiZ6LA3wuoxxZG4MXqSbQgci7Q_NMnLM7xG83dnE_Y_crOh9APw9Yk447OkTJPespYFTkjS9pe
 DMtsjiBAHeV_K1Hdvs1LaLLtzp_B_QfFhjL2NWZjIfB7gV8_o5VO6IKT0RIX6.4zu8zJvG5plwms
 c3KuRk81qcRGZhise32LXiLtUgHViQKi2Ng7pvUkdOAfTIgIDnY1_nYXGehK0gAy2q2xS39kEFVf
 R9QDpnq3h2yZpBqhJ9hZCGnYkMWczMjxjo.So4dcbdPdthcln3cSDw8.qhTTyhkdLmhQhraekUww
 BJXtmc4GBHSB2qwn0gN2kxNiu8xtIhO5exACnUAieY8Ivvk.dIw9WpYLQRVLkAzX_bU9aUxHUrZn
 wgrv099lH0pMiXgquaWfeO.3jH3RUFuwxobhDv.qzKKHo1HxnSCPpN2Tgh7.fLG3culwJwRLhbSk
 BdZ4hsyT2hjR3qkILHLDGGYb.ZMNirLc_E1PGa_5.Rgo8D5SOSyjx_HJnxGrZZ35K0yRezBrXVKn
 GD8W4GuPYTo1XNwbNkeo81FGVIC2XcBUM8qgWu_CnojFQKKz0ZuZJiff3F8ArwWRMbv2yuH3_hQ6
 vS3EPGbzchzscXVbcb8wP2tVb07Y08BLiC8ArKpN88utrgDmhwpEkSQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sat, 5 Sep 2020 07:11:27 +0000
Date:   Sat, 5 Sep 2020 07:11:25 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.minaaaliyahbrunel0001@gmail.com>
Reply-To: mrsminaabrunel@myself.com
Message-ID: <1468514772.2614553.1599289885483@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1468514772.2614553.1599289885483.ref@mail.yahoo.com>
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
