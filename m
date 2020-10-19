Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830B329294D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgJSO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:28:33 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgJSO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:28:32 -0400
Received: from [192.168.1.155] ([77.2.107.242]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mdvyi-1judMc4BMc-00b5lp; Mon, 19 Oct 2020 16:28:17 +0200
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Ed W <lists@wildgooses.com>, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
 <9fb836bc-7d8a-b6e2-8d73-8e74a8f2e38b@redhat.com>
 <2ecbe677-8f80-17a1-dbf9-dfffa867805c@wildgooses.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <4a6fe2bc-a4a5-c214-e7fd-2a429dc960e1@metux.net>
Date:   Mon, 19 Oct 2020 16:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2ecbe677-8f80-17a1-dbf9-dfffa867805c@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xbMRXUpzFNUkny2+TfTzHE8Qceb1YpYmx4n0gU6SRm/g5vXt+8P
 zLJ+FWd2UgGo6omcanyBbHMEQY7N4f57h6zKt/6V+yrsmhyS6a57P1/hK8WiEP5lfDXgHNA
 EF6a/Tl05mGQeoiziC+15NiMeNWVXXPeiiFEbIB2fZd1tIxa68nZoV/vCrJ/Ztz1PXmJo37
 Wxs+y39iAkglUVF1UBAow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EwAfrfpyJe4=:ZrtqEuBAJTBH22ouQPfFql
 mJMSys2lfwL7cc3rYBF4as2x9lkp2T9mg4UJoacgOHfL02EtfP1liFQnnhRiGbpAAelbIF4dR
 VFeq1fkvr0uXVKXbyfkoh/GdtAhR6nhmuuNHDqsoFROnCbTW09iyn7zeYJ6aqobxO2WVnXKiA
 bjUnvg0vi53Aew2h4OyT+vVwYwfQxdIl+P2bkqr0SpOw9/e+UZu2yyT2+d+qiAff619r1JDXl
 xDPi86OJPTagfPcExHtQLtv5IO/DgVHKXgYQzq8th187DHjMm8aQ6juQeOe5c0w9LK437+FiR
 XJZ9LodBZLlHAjrrDjPL5mh20EoWgc5m0/YKKTfE+GCpDSbzfNJKnNSKO8XEVQiTf7J9rR3aO
 QAWjrwA6GdwwsTwDkW8lPeE7KDCFNV8U3wdSUdgyhIrvDFykYIZs8zX+0lVcA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.20 23:46, Ed W wrote:

> The original naming was board specific. Then Enrico (not unreasonably - I actually prefer his
> naming) changed the naming to be non board specific. Then within 2 months PC Engines introduced ACPI
> based config using the old names.

Which "old names" are you referring to ?
The really old apuv1 led-only driver ?

> So if we are holding "userspace breakage" as the gold standard, then the original (also the current)
> names have actually been around longest and likely cause the least userspace breakage.

Exactly. Linus often stated "dont break userland" as a primary goal, and
that with really good reasons: the kernel is *the* hardware abstraction
layer. Having userland to deal with thousands of hardware details in
userland would cause extreme management complexity.

> Also, some other pieces of this module have already been removed (SIM Swap), so there is an existing
> precedent for "userspace breakage" and trimming down this platform driver.

Not quite. SIM swap hasn't been actually used in the field (at least as
far as I know). And we're planning to put it into different subsystem
(probably rfkill) anyways.

> In big picture terms, changing the name of the LED device doesn't seem a huge concern to me... A
> udev rule can setup compatibility forwards/backwards quite trivially I think?

Small kernel update causes existing applications to FAIL. Applications
now have to be changed to deal with *different* configuration, based on
factors like BIOS version.

We're dealing with embedded applications. There is no operator of these
boxes. Maybe some times an operator of the machinary comes around - and
needs to rely on the LEDs. Not as critial as an direction indicator in
a car, but still important.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
