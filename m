Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3653B24C2A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 17:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgHTP5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 11:57:00 -0400
Received: from sonic305-20.consmr.mail.ir2.yahoo.com ([77.238.177.82]:39236
        "EHLO sonic305-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbgHTP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597939010; bh=ZWeDLwf4cGlLDzTwCuOen1zTINlp5j+f2ywobrqBR9o=; h=Date:From:Reply-To:Subject:References:From:Subject; b=JFA2in8cTfn0Z9XxcEiG/es2xsCiyBNpnMLoWt0olVzprJOCMtRqUZI1KP9tyChe89aDqL+oE/Yt7go0pYqlkgbQpXO1eHTvyv0y6vGi5yUTn+A+GuZEkGALsdkArWrj8Q7I5jyPvHiabOYtJ5RQok0M0G4heu98HvRob0wA/KNyMVZpKU0Y2ujSYKQM+OVGb93OuVbo2zEfYAHLYLMuX8FUqj6S+aVom6+xWLtLTDHU6hqIyTG4X77P7pWYX5zkSbrvpZIMXwn+lLcebJ1pE2jyNBDtZ4Wn70l1NOPJcInZA32Mallxn0130Cqd9ebd2PGiKLElGwPrfEjHmElGUg==
X-YMail-OSG: iry2DJwVM1lNFEdEzKFMawUXugLqD4ZMM_gOsfIuXeV0rRa_xM4E7lce1gXdqcl
 1jR0__L8ZNczQNFv_C7cc908Zp90MHImn4fxrGc86zJibiwbDhpiEo6FrMoha3tlMhV.dkAwSYaJ
 8cD5ppgSBElGmeH9idOfZE4MJBU_CBQLzDWu5HKyY2kjYMrsvI62gz9HcrYMlVM3bgWO9K8ECuoD
 fi.QqlVcIIVOvcC9cGhC.hexUTYG0IHUYh8CSAf.daop8WxaivNYE_mWuktz8Cfm84Dv4.CJRzQU
 M4je7jCzRA6rzg7P3_cpiZXIkZk2.Mo.oZPNZK_X9pFL0xQ8QGdn2EkRf.4QaOWhXyBaxpQn6Dw4
 rszqT5Eakca1VcZdlerZSPZeBzy2J4vosg3SFLRjUelmr7cQM6wzxIwhadNM51iKTQQ4jgkzNv81
 xjH_dh8kiCvnJkmoCIUMylFV0mMY0J724QXDtAgPZKejXRNVUpqYRwoFjDVfG1e15alx_xyvEljp
 aTGd6i2.OlwAWuNKIoE4.s1qysEq4hB7JRjZUixBkllUdvjNnK_5OAMkSalYxlHdcjJF_gS31KZ8
 .4Rq2iZmk7H.P6izQBWMP7KOWvAA6tEbqreebaN74PQxEbnRCpBiW2KxLHRFIBrLB1Mlpvo1Bx3D
 Ln5BcBEADPUGGVl.ayyHuz5a2gfjCPQe4iHmPTxVZkuv76eYSlCh8CJ5kr.IgFSn4OyjwyoOTTXx
 SgHG1YQVB2aNlgQVONcCXXw1twI8JuqkZK01usYEoF1T7YiTUkRE8jEXxKiGYeSWLvCXyO.6Fntj
 VtedfDoSPUgLprLAXpyx4m8GcxBquJxvcwqaQQI1Vg2ZJ_933XQ9QafJQfrkqRwj9Rruuy9hO32i
 _E4Jqxo.x8Mdc4hYh4sh_qO9DR7GqqYm5k0FuCAviQvVIlSvFE2aqQxKCGKGRGjgrtmazwJl45Lf
 iC8OmIUcaCEiwAd3frXZ3UQyn8U8SmZ.R9CYiQHz_ZW6gILtVvi4hZhdVe5TJndP.RBVSu89wBst
 t2L2Q6Jn9h7jEakEgtiGa49gvEZsiftSq2.I9OES0XhBPkO9iRxnK.GrAmSJqv62gEDjyYrzR02g
 aSI7j5.O02XE6JvLoOf12Qdr3coxLh0WAsUyx0VdSGUX3tanelMuZFIqGw0H6ikSPeh23sJY9SFS
 KlmoAkPNtTVu8FBj5k1VVqbDGLwWGbEA1Bi98N.8Jb.oHLw6JXHvdZIz9wpmFfat.Wq.ClCaC3tJ
 k8i1wmfLQtnbs2UeNWCKetY57ZbnVMTbu1HKqmpxwc4GHGdEkICRtxGn1h4st_Ix0LgA65teVlcB
 1hkRo89qQBx3QWHTd9otuFWKrQ6432pql5GoxShccrK_at2W8yqJEzwwC
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Thu, 20 Aug 2020 15:56:50 +0000
Date:   Thu, 20 Aug 2020 15:56:49 +0000 (UTC)
From:   Theresa Han <serena@lantermo.it>
Reply-To: theresahan21@hotmail.com
Message-ID: <1293944127.5787555.1597939009757@mail.yahoo.com>
Subject: =?UTF-8?Q?Ich_gr=C3=BC=C3=9Fe_dich_im_Namen_des_Herrn?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1293944127.5787555.1597939009757.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:79.0) Gecko/20100101 Firefox/79.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ich gr=C3=BC=C3=9Fe dich im Namen des Herrn

Ich kann mir nicht vorstellen wie du dich f=C3=BChlen wirst Sie einen pl=C3=
=B6tzlichen Brief aus einem abgelegenen Land in der fernen Elfenbeink=C3=BC=
ste erhalten werden und wahrscheinlich von jemandem, mit dem Sie nicht gut =
verwandt sind. Ich appelliere an Sie, etwas Geduld zu =C3=BCben und meinen =
Brief zu lesen Umgang mit Ihnen in dieser wichtigen Transaktion
=20
Ich bin Frau Theresa Han, 65 Jahre alt, in der Elfenbeink=C3=BCste, an Kreb=
sleiden leidend. Ich war mit Herrn Johnson Han verheiratet, der bei der Reg=
ierung von Elfenbeink=C3=BCste als Auftragnehmer t=C3=A4tig war, bevor er n=
ach einigen Tagen im Krankenhaus starb
=20
Mein verstorbener Ehemann hat die Summe von US$2,5 Millionen (zwei Millione=
n f=C3=BCnfhunderttausend USD) bei einer Bank in der Elfenbeink=C3=BCste hi=
nterlegt. Ich habe an Krebs gelitten. K=C3=BCrzlich sagte mir mein Arzt, da=
ss ich aufgrund der Krebserkrankungen, an denen ich leide, nur noch begrenz=
te Lebenstage habe. Ich m=C3=B6chte wissen, ob ich Ihnen vertrauen kann, di=
ese Mittel f=C3=BCr Wohlt=C3=A4tigkeit / Waisenhaus zu verwenden, und 20 Pr=
ozent werden f=C3=BCr Sie als Entsch=C3=A4digung sein
=20
Ich habe diese Entscheidung getroffen, weil ich kein Kind habe, das dieses =
Geld erben w=C3=BCrde, und mein Ehemann Verwandte sind b=C3=BCrgerliche und=
 sehr wohlhabende Personen und ich m=C3=B6chte nicht, dass mein Ehemann har=
t verdientes Geld missbraucht wird
=20
Bitte nehmen Sie Kontakt mit mir auf, damit ich Ihnen weitere Einzelheiten =
mitteilen kann und jede Verz=C3=B6gerung Ihrer Antwort mir Raum geben wird,=
 eine weitere gute Person f=C3=BCr diesen Zweck zu gewinnen
=20
Warten auf Ihre dringende Antwort Mit Gott sind alle Dinge m=C3=B6glich
=20
Deine Schwester in Christus
=20
Frau Theresa Han
