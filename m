Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5C25B3D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 20:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgIBSi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 14:38:56 -0400
Received: from sonic316-20.consmr.mail.ne1.yahoo.com ([66.163.187.146]:46471
        "EHLO sonic316-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgIBSi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599071935; bh=4mWY6N2pvhoYteLll3TsJcj/b3lxDL9fu4mR9DmIf4o=; h=Date:From:Reply-To:Subject:References:From:Subject; b=D+vHZGQed+YWj0npe61PlK9oJ6LV2+Wzpg8WUoHJRxsfNUBxI2CWvcTD1euM4xWgN1mIJzCbkYSI1CZ3ZRakYy0X9ZnLKFaiPneFmRKQwtY2lCOUcJdRt+Amg46pJ8bXt04PEXXCzM7qQY8gOOkfZOSzgGIqWaKOH+A7XfIonXm+AtMyr1wlCK5GvNgt7P5RAvR+GJyzyvG72oLsuc97KbrZDvjW0l8wsO1eXu7G+jMcIy0uvIpTV9p9KYkEl19yt/H9WroyLj9Z8Yp51GsFuhclLq8tWJ//69QGazjiT7k4N+o5mtSIZGHjtAu27FhRtpyWYLbmaAErP/FA/RvNkg==
X-YMail-OSG: 7sETHXoVM1kjTIEvsmxIik9QgzdqDWU.0_6zsPuXmHPWMW1wQ494StdcEHEOLrz
 4Jqu0eCETjf2m9DwDHBgFXgPJYMK2fKJCHG4DrEC5ktxfEsOzlahnWLasPZmd2qPu1L3AR5Am5h7
 Itd1qpbBbzDwKxR3DhLQs054t1S8e27XhOEUkzkqHby9EPCtn1_pVuEM5dAo.D9CcU2xOH7xDCuB
 k7S7Mfgg_acohMeLhkEzLKO.XDlJhbQiJyeNYPAeH.7gkHpD5hVdaqdPz60NHx2hwsoKSYfAYm1u
 uudYoiNno407pg2Ix4LE9rjK8x9.5j1WOu9rJfjAZT3a5MOL2wISLUxJCa6wm7DQqgPrD_Go3zkA
 S5WuOqPillab8.zYZwi2ScdHcl3FlIiiMtZCCp2TcVCH1KGjzfZOKnY6Z3m8tV3.tFaq3USay1Qg
 .xInJice4RlPinAnE_HW4Ik1cHq4RiNeun9Bt7s_XovO5bGSgrwEOMe5YIsP2uqbYnvsmll3tgpd
 XP.mqcCbrHcVgHhdypnMMpWGGDXhcbEoTxJanYytndiqklydvZCAnGb3HNFoeNQTfNDAXJYuWOl9
 y5nHwf9wLNYEuQkpyGuqeDkn4Vs8Vu1S.dxAH8FePplNSgPfaa95bdVyENUA9XWA8b3i0kt4hTsn
 RwVJbYO7ggtwMhQntZxo.SkXh7qpQS5Tltv9hqZkZUN8Kg3W7zJ122kOHk1c9Imh1KOkIG6F7ar.
 TmbFziCJSTXQKhtuvaV3N515gWhqgUaa.7n5EzMlrZp2AhbmO1RyRkbVKiQTkQlEZT_YG4xZOLJz
 kF5WEHuDhxk0rNat.3vIINfAovMyhn4X4dvCRquLG55u1gtXJVgP1R51HadDiKElwfJQ.Hk9FNeW
 in9sW4JQW.ww0PxUU6O1t36Mi4v5EBdBhezLCeRpVZF5MzFcAURF1FjzlCCpWYu63W298rFEA3zA
 fjzEv5ydHIN0qGsLruUUnSQ5_lDHOsPJ0D6xQyfaXdUuGOBCx8toKe__KevUjfJE4FUpJ1zpIov.
 TAMqnS4SzxR0nd9FrrCAzdbwVQARpkXJc3j4VS5ZX_1PRe.cZZOHVWgYrQQEnlPVYJPaaKM0lhfL
 rMh7M6MnycnrZrlFHieTtu6R2E7zXR7FhzwTjR0g9bvBFU0LtGX8Bm1YllqLd0gxnsW8NfiVe_vF
 ZSLeROoklOQ9lpXveqYPAKGIYsz.ADlk.IPVbeHHXR6aBZKexO7VtknHLOA6KjP.S2LTSpegh8Go
 0ckVR71HksQqTJiOFFunNG8.uPFIQm53xLkToz6b5cazgs7yQ93jqIEEkWOmft_bbsb1kWdAqUB9
 D8xVyxMp.tgIKjkJtcahFY9nm._Me0QdhUsrFNmEikYUkcqGua_7Jioe3xEoo6YDEnh1tv95ZGfT
 Ta24UK4H_kRVKezbVb_Q2v7uAW1Sh7Ey716LonDA2QlaOUXCsJSP3pFhUgClTguX3X_avcIkrHBX
 Qmw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Sep 2020 18:38:55 +0000
Date:   Wed, 2 Sep 2020 18:38:52 +0000 (UTC)
From:   "Mr. Milla" <millasth804@gmail.com>
Reply-To: millasmith7010@gmail.com
Message-ID: <499098389.2273025.1599071932260@mail.yahoo.com>
Subject: compensation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <499098389.2273025.1599071932260.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I'm sorry but happy to inform you about my success in getting those funds t=
ransferred under the cooperation of a new partner from Vietnam, though I tr=
ied my best to involve you in the business but God decided the whole situat=
ions. Presently I=E2=80=99m in Vietnam for investment projects with my own =
share of the total sum. Meanwhile, I didn't forget your past efforts and at=
tempts to assist me in transferring those funds despite that it failed us s=
ome how.

Now contact my secretary in Burkina Faso her name is Mr. Milla Smith on her=
 e-mail address below millasmith7010@gmail.com ask her to send you the tota=
l of $450,000.00 which I kept for your compensation for all the past effort=
s and attempts to assist me in this matter. I appreciated your efforts at t=
hat time very much. So feel free and get in touched with my secretary Mr. M=
illa Smith and instruct her where to send the amount to you. Please do let =
me know immediately you receive it so that we can share joy after all the s=
ufferness at that time.

In the moment, I=E2=80=99m very busy here because of the investment project=
s which I and the new partner are having at hand, finally, remember that I =
had forwarded instruction to the secretary on your behalf to receive that m=
oney, so feel free to get in touch with Mr. Milla Smith she will send the a=
mount to you without any delay OK. Extend my greetings to your family.

My Best regards
Yours brother
Mr. Abu Salam
Greetings from Vietnam
