Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8444420B3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 16:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgFZOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 10:37:43 -0400
Received: from sonic302-20.consmr.mail.ir2.yahoo.com ([87.248.110.83]:41097
        "EHLO sonic302-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgFZOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593182260; bh=AIANIItPD3HSZqQg1A8+qKlShcdqanJrJKT1smNj1sU=; h=Date:From:Reply-To:Subject:References:From:Subject; b=A9Lsj1p7o8qfmPYZ2fuZhk0hvH48tR57l4glVSyq+o4KD4Y07sYbSRJFrWpzOLFSVrbf7arsvzHW0ZVE4qpoeXd4iBpkHATKt6B4C3Jg+saZlDIApiUtZtZwi6Nbm9eCBsq6awX6tmWRGu2IJm1PW04wHMYkfvO9RtTMlXpQ29z5axo9NokrPJLSuLI5f7j1eM1LUftWWX9ZQ/9D8DcU/kk9VSkAvWOw+QRLjtmE5SMJ3PeaUi3f38C1QmdgpZTnMxoJevx7UzSjbyWEhTv0iWgkbHAk3ceLwVStyvfxFdZecxp1Wnk6dKr/zAMNJNwMiCzVcj17fF8TVCeEqVAiNQ==
X-YMail-OSG: s8hPQ9UVM1kXVMxo0Hv8eGc9lSGYuyPNHWbA2a0Iuz_C36smySYW498lVmBmZZ.
 cohVIJmFfAHBVTwfhCse01eqVhGQpvdSgMgKrX4kWhquBE5GQj3aD9XwHc4ZsyIJHzObCikXeG5O
 TDNFC7K4vno_yErPwIBcSXRK_4e6gJiZK7KD0q64PyA1z5OxIYcfkat1usVCy8OIY6HKnbSJfMjo
 9uf6iBEXEuTUj4HKmsVycHGQkn4QMTg6pgO4yzRbz2x_GB2WxY.IEiPexMDgL0OnM2HRBtQcX2z6
 NSGn_KQ2XMqZ26oZGDSYMrgEm.BXmVQcoTUiGXBjktbew2bLtfeYxaMEpNYy8USUi_m_1zVn1Q6Z
 o9SpXnrqZBKASitnAxqhkl4uJ8FRlBAKAzCLEK78JVe0D3oj_MjIOXRW1sPMKmUxG83YFotdKMsl
 .nzOzzjgeeDBVGKocsbJMCTIxv09qbDX8TjjjS..Lq8gZCWkeSyy1x1LEOEnUFhkWQRqB0edsqHG
 WKNTv9sJMHAtxZg8urV3JsXEBMqi69gs_j4RtO9PrIZuMnjvrjLwacc2j2USofJOBWCaXPT6tUl0
 F9sEjuHQuyKq9prrSCPOWrkxx2MuCUOkymgvHli02L5WEoCA5TC2FkMnqT9uRfIFIgvnxJY6E77R
 weoQYPC_1RrfCZ0pYCSXBF68YX9cv2Xz078Rt0zYkqOlsbmNjLHEi7bYCoAeyzO86wZIrE8l6okA
 08LryvBAzJ2gYg1WM4j4gJF3vkytLeqU0QkZecr8KrfLqp2oConzSC9hlzP0y3gYOQU_akGdH3yK
 qrbcXTEf5shiR7Sm0pSITB2N_1DFY43JCGUJas1BK3MLhuwLHfLnC.MYJKM69CMX_3gIG2ywJcQK
 IExewQj20Avz.vTDolLH1ZV1aoXjlmY.6NuX1eBunVangAwxWbrXsViY.ircqEoXCSq4zPMaScPw
 FBFcAT5b5ARUu.fCcsBNqYH8SVoe4Z36AQgh1aesjFsZ8mt61fN7i.DEeZ61D23YBwVSEPUusz4Q
 H7MQiAnXBg9gtQvsS4msE5zULeQ1Ywo8CiQkza03r68L1RuuP0VOVcRvps5hSCUWFjcJaGXCw35Q
 C_7wMsbM67NYFomOLBbgbhbGo7WZSmhomDgw8Yx0LDErGlUhptyOm6BMbsyZG9hSnUBYaVcxu.kk
 V00dcZRXvgTPYH44aToHPS5jkZCtH26o1hXeo3A2rBh3hWvV3lHY9DqypHGOgDlK.chyBEJdyGQY
 Q8I8KnqdyMp7SeBvxecH_HD5eaFk4bSQfX74ttyqiO2z1PP3wH0FvI5k4GG5QXb0sSoR5ZpYdg02
 uvFWsPA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Fri, 26 Jun 2020 14:37:40 +0000
Date:   Fri, 26 Jun 2020 14:37:35 +0000 (UTC)
From:   Theresa Han <serena@lantermo.it>
Reply-To: han.theresa2017@gmail.com
Message-ID: <694971252.7445405.1593182255347@mail.yahoo.com>
Subject: =?UTF-8?Q?Ich_gr=C3=BC=C3=9Fe_dich_im_Namen_des_Herrn?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <694971252.7445405.1593182255347.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lieber geliebter,
=20
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
