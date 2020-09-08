Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA026108D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 13:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIHLRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 07:17:04 -0400
Received: from sonic310-13.consmr.mail.bf2.yahoo.com ([74.6.135.123]:45650
        "EHLO sonic310-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729729AbgIHLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599563586; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=le/xon49wr8SXRbH81T9NKanZMoj/MiPlvxxzDVY8PUc4sOYPDnPlZw71fa/pCWhq4Lla9hQaZMjaDq0GTnV6IpvHU3+mDQUnwrWDmLNSI/yIDiIf7ua4H1l8AWigKnJT+O4qGM3qjvT39K7KklBvwSLFr+lKBz2rS+09QDHARS2SXt+gU7fvXjlE6XtAyzLQib7JqP+9MWuepVaqkm+1TrD0g/lv/htTkwMu83LyKdFXlIry/MauVS0Xjst4AwcJ+eROGhZP17sXGvZHaALt5iCVwiklecbP2G648hx/N9suPIQs+vL+zd0UeDRrKJSqnadLjgtxJW0INTcv8EZyw==
X-YMail-OSG: qTJRIqUVM1kQdwlsweRg_NBGJx2mkI7Hruq0C8sELMQJ90FhEY54gku2cHJtlA5
 Ps_seEEzg.EOkt4.YSRscGW3ImLLzGRjdGs1sA3RuHWH4mNm12Fm1DjUKmvTGbHv7YITmWwCxqiw
 pcaTUdHDORFzjLXLzo0ma4JfkiSS7ZP5eUrvwWqyRcweWB5_RbY0oHpu2l5JrVzMRIRU_uTYih3o
 9IB.Uw.cCNfQsP8rVR2MLjYR_VaXkdX0A5ePK8RyfcNZ.10RCZBYMcFhAaV8zxsDJz370jKjHFlk
 aLHkT2wTrNynrPe6ridkeuYNoOWOAUoTVImnGMFtzTsXf3tELLw6ng66bFfg6JPmY5q7LLUvNd4g
 rTzlxjKLFA.CrcwJfrvL9mf0no0oPLlPY8RJEO4QXOIk_7BhLKFxjNlddFJqzXSTPm0Q5OpdY8Z9
 sb8rfQGhcghg9KRiqym_7af9rseQuq9.auFugyr8E1XfY20cV6G.WSrS7bQpak.wntLU0UhMUC5c
 juuow2ceNfqz4qj7vtAodziu9VhEwuwI_37ZQL.PbjbIL1fJ1S43IRyk2hUfwJ36F.r.vAiT8W1V
 Q4qAoG8n1CWI09hjUJVeHTqjwjJX94K_x4UDQx3ud3AIPM_PRONBGKC4Pns5WsNIazPyaLbCNcdf
 nX3n4le9lA0qrN3Cdei8GUTiAjMJy_1vX6j4kgkD_EOEEA0rAyfVeLjlQ0D2kWBBIoAQkbXDlqIT
 yDzkK5dVAIU7N7QxSBW20KDEofkGFwpR2Cy25ieiYzvcDEqt2RCCLq9p2Qhy7VuJqrfFglpb23g5
 6F.cYvROe2y6mtFutletC85AYpVx9eDVUVSQr3ER50fQYsPYjblz3GvOopKARn1AEUlKSDdYkdnu
 rTkLbSVow1puqT.Qo0bhq8hKrzR7wS4a5Xcxu2eUocKz.tMwNihVx_NWzl7KZVWrSWUljhPgO.Y3
 PKSmT.wFXaW.rpQ3eZU3hjXCT_8D1cwTsetQvf3tBnNW2nq9LW9MGGCkc3zPvUtQPkVOdsUzQk8u
 rX2aC3egzpD3HtIdXdXBXpC6VKVZVf9Kw4IPqf6IjRC2yBCZt2GZLlQXwGH8i_YTA1ftXmbsSJoj
 IqJixVX2lz3yGUpCzQRvlulRx3jQc76Cc4xXcU_YjuDqrqyVpWoeEXe8lbcrfJq8lcYl6qvj_nfh
 VwJ6BHno6Wfu2WuNWbkf.7p5vrN4ByB91NddJzz7xMplhhETXqz7m.cBEm_57i2amOOgSN1SjeRs
 kahRwGpdVDuWw1Zy57S3GOUzyapxShC8idXor8dj8NiwjiVwhYmisI3OBf6rmfmjafitW4nJ0NeI
 9jNCLPg1Zzl83X_SejIGSfhcYf3Gof8wE7WeyBeTHUV.c4CkyuhTmGrcEht6v0RX66ynhzJwUwRH
 vh.08Q90xYOWLBion0EVi2CyFq3eUK6q.AxSLHSbHovM2WL6J
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 8 Sep 2020 11:13:06 +0000
Date:   Tue, 8 Sep 2020 11:13:03 +0000 (UTC)
From:   "Mrs. Mina A, Brunel " <mrs.minaaaliyahbrunel216@gmail.com>
Reply-To: mrs.minaaaliyahbrunel31@gmail.com
Message-ID: <617829211.3354373.1599563583015@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <617829211.3354373.1599563583015.ref@mail.yahoo.com>
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
