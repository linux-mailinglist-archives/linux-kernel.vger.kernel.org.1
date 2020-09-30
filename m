Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8727EB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgI3OwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:52:07 -0400
Received: from sonic307-54.consmr.mail.ir2.yahoo.com ([87.248.110.31]:42207
        "EHLO sonic307-54.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729767AbgI3OwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601477525; bh=7PUrz7v13XZDkUHQ72RKX5eruhHSBppdn3HEsndeWz4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=tO2RVlD3PoqPdTTOREt/cF9CaUmIc58/f3Qunr07JOcIxWplJ+CAXDBbFUnND8MvadRVCq3VSKyg9KsJ3D/Y22m7EQPrfvF9+pgHOudSzznf5se4m9G59CZ0c1i5/nQwpppyi7PvJaisgPYtP2ctlHStrRrGx7WTSJm2dXsL+hCErX3l2uUWqQIvNgdZLKpOFhjuVIbBMaJeYn2rcsqKg4cvvr5m+JNbgMxjRw4eiOtx9ysjAUaXcRj/mL5RrUyQ9qrCtQfBTG+3+DS1zVFuhhr4fXMK8vZe7S5CsPb+YdwACE/CwXycZnoEgZdm6Yjs+nT3Y/JO9smrJfaFLCNkHg==
X-YMail-OSG: tdzCWCQVM1kXkRSIaVhbCqppWsA1Q7OkX8_Bm.IthjkplEu1N78Sil036WikTL6
 rEdet690SC2Gax4w8EJRVAu1lsrTyo2.vcyotsCKYiWIv9TJ3u0V5S0oc.UuJu8Tmw7Jvd5Oybn9
 U5Go5KtOiThn0tc6ErM0OgLCgFavWrdaS55WhRBvkSSdbH35YQBYJ83jHrAdVO49k8cWHwqaK4lT
 _aRNx.AH8vjj9Y7CMoigb.WxR7if7NrSKp0A4sgltoFfa.ygkRtMemxCIQKv24tAREB8cA1vegUn
 gUrmKw8IHbM8ClNuJYUI_cdWSVRncjwSEjnmt6KGj4GATq9AZfjMO0ItfyJwCgirU4Kss7g6WzPw
 Nnj9u4Nhf0L5Tjy7YvFbzRUCtzOtIBlFRoBOX7_sbGd4MWSqX1QQ0js9jSBtFdtWqYwLrwL9Y3bg
 pOLYrjho2aqKD2JevlIZdbf0aCQgkxLVqWV2_anX.8TDSui8TB4GTerQ1DNQKFb0eLQsTN5BL01F
 ZRI9dJvhgYEaYGYUmKqM7ELHWPU3yIQRgRqhvLZUrgEX8YtzW1zXkPRsNyX5r_Qu3Sr9sQJyadv3
 gfNoGSR13nDWc8TJZ.BT0Aay2Tc08turmeq7y57JuRMNxfEPowYjOIlm4sJ9B7_hLhwQATtz7JvJ
 kM.szhh8g438C1x0OGtd7eXk1L4yBrP7A30IkSVd_jtrsFruBrjprcxY3tlZuEoGp68i8Cy9bjC1
 7kNrrGFLp_3pvqrcEHZSCwUEu6vvlUUAF4gho7jLEkeg1yky_TZN7pwQT_NwdnwqtFKwy4khzeX7
 LKuL7IRAanOgPfe2EKx5w3TO.2uAdwrpA98hOIPGe5Br3fP9CNE5Sa2UcTv8kILsU0qVDWebqVsy
 SdIs_mLqY7TOTRGwifV.a.wKEort7tcI0D0tnSpMGPj_pA55aA5TLV5qiafglVgYptTWoKPOThrt
 7dLmmytHywC0DwqS5zpU8clWKJbkJblu5lSPP4ROGOI4dLgMixjyiJcMHTLdoYXCfuNeQ7t8uwha
 AEVo9OGiQrKliD80axhRg3D6IEPpsnzJT0UmmH6d88eRb6hxWtTuZn_saPWOGNpDf1nSH_sgZ3.h
 SMUZock5hUSIFNjnCE051fugHryRHiyqxrksHPtu6asS8AtMkCi7C1L.DINz.Ovq.LYtnVdmbxBH
 E36HbSWzYmgQw_sWhbYuOBNnqbGQAx25iXVXbWogYwrpK39wRDQlVJ0PIuimqAkNOMM4yJQXb.hy
 DakpE_Ru5NxNexjYG53.F7yaLhxa1KQtfIqt7m3X0Ttg9orrunUML4cDF2kDkACOGHGGnCnjrw4i
 3emJfRhnKh7WErI9DIE.GiO0lxTvbgewpMydp6BrJGzDhtD08QfFYPlmJowY_tTnDwMtvq42p08W
 JReh.G3q6_hAexmWsb4nbJRbjRnkwJZnhv5AoNKjdo5F__g97RA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 30 Sep 2020 14:52:05 +0000
Date:   Wed, 30 Sep 2020 14:52:03 +0000 (UTC)
From:   Sgt Vivian Robert <sgtvivianrobert1@gmail.com>
Reply-To: sgtvivianrobert1@gmail.com
Message-ID: <816352826.454094.1601477523791@mail.yahoo.com>
Subject: kindly respond to my mail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <816352826.454094.1601477523791.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.96 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Good Day, I am glad to contact you through this medium I=E2=80=99m Sgt Vivi=
an Robert am from united state, 28 years old single I am the only surviving=
 child of my late parents, I am America female soldier presently in Afghani=
stan for the training, advising the Afghan forces and also helping in stabi=
lizing the country against security challenges, am Actually seeking your as=
sistance to evacuate the sum of $3.5 million, This money I got it as my rew=
ard in service by Afghanistan government to support me for my Good job in t=
heir land. Right now, I want you to stand as my beneficiary and receive the=
 fund my certificate of deposit from the Bank where this fund deposited and=
 my authorization letter is with me now.My contact with you is not by my po=
wer but it is divinely made for God's purpose to be fulfilled in our lives.=
 I want you to be rest assured that this transaction is legitimate and a 10=
0% risk free involvement, all you have to do is to keep it secret and confi=
dential to yourself , this transaction will not take more than 7 working ba=
nking days for the money to get into your account based on your sincerity a=
nd cooperation. i want you to take 40% Percent of the total money for your =
personal use While 20% Percent of the money will go to charity, people in t=
he street and helping the orphanage the remaining 40% percent of the total =
money .you will assist me to invest it in a good profitable Venture or you =
keep it for me until I arrive your country. If you=E2=80=99re willing to as=
sist me contact me through my email address =E2=80=9Csgtvivianrobert1@gmail=
.com.

Sgt Vivian Robert
