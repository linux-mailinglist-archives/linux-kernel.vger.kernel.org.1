Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD6F28C18E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387810AbgJLTjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:39:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgJLTjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:39:40 -0400
Received: from [192.168.1.155] ([77.2.5.48]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLAF0-1kkHGz2KfK-00IBSC; Mon, 12 Oct 2020 21:39:31 +0200
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Ed W <lists@wildgooses.com>, linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
Date:   Mon, 12 Oct 2020 21:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2ccd+HPdvvkssdLpfI7hV7NC7mJ+qYRLJuKjRhJ2yCkArI0+JFV
 yMd4q8+LVMp1g0WJmARd0aqQQC1ht8gWS0VaUP4psg+XnUjPYl6VjBY5cI+dKHJGSZkdj3r
 /B7LKh2i5U1tEMGpa30ILEcVx5ysMwvmUnnuINTjKqRyOf66fiLW/g//rqYbi0DI+8dc/Uo
 Yfyhnu/l9nbhAfyZdbbMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uEtuSCtEiJY=:frRXq3Gq8VuA7Hhyq5PjRN
 /o7ka3UW2Qc3Ls4//UaRqX2HKeY+RphLZ/XSsTpO8grsZZ0NLPCQaz0iDfEWu+IhBRs2Q+A3y
 0+OwuHhG3MiRzC80C7jERrqAMVnC6wHF5DeRXZ5WSTKCukwFWTMgyixm5YEhuje4tfhy89e9N
 dV2rM3MITRv8ltuVhXP2byF4aHg8A95Bn8hNs2O1Bhg/YxRnX53rcx9XhCDt3s21F3vFTFpHR
 PEuGKvDgXEvh6sDU9ispAE81CBzvJC424DXXYe86Y7ZDiGj1cU3voK8T7maxSIO0+gvpl+3qS
 wDieo04YYfRijcatrFYnwtz3vRLt1O3TxEDC/I4fJyJGRtjLjO3K7lABqwBBWsTT5ibKn8/EZ
 O2HgAJa7yfORdCx97x5s3rjPJj07/VIsAtiQMGfjOSTnHgezEX/bvvWkMjaPQWcLU7z1b+2qj
 TQ5KTqhWOBHgQ7BLEGgjGmAzrxwCLnfBDLVoslOLqCGdChUGZ/mDtxbR0Sy1BEEATGrdgDzb8
 jTqYwXyjjQLArlxT3Dt1vvcLDObGbBuFnabacfUsvrn6dVo4EUpUsaYAf1d52zLUePM/PL7lf
 AzljI49MTHOe6cJtNxKRhzao0pxW06k0yTW+/XBUdZtNh/0/Fr7hRwTmNZxajLlG4YeL0MGFo
 aA0n2oa9p+vHh9jy9yCVsPXwPZYv6DSKMYMI0yGoC+Y6v21sE6nx4o+098NttaJ2hlIE4c9zS
 nezcPaIfARIVVw5M7fJz7P1Xp8/HchSx/ghGuSIOPvRVEHtokbs3YnxdHNolJEiBGrbIXnV7P
 dkK+e05SZFwpWOUN5hDFk6XwwiLXAa8zt86HIew3xs2oYNfPTOKoduYeuqI6S79HsFCRJws
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.20 00:17, Ed W wrote:
> Hi, I've been adding support for the PC Engines APU5 board, which is a variant of the APU 2-4 boards
> with some nice features. The current platform driver for pcengines boards has some redundant
> features with regards to recent bios/firmware packages for the board as they now set the ACPI tables
> to indicate GPIOs for keys and leds. 

NAK. Breaks existing userlands in the field (literally field), forcing
users to fw upgrade is not an option (field roll would be realy expensive).

> So I've submitted a patch to eliminate this. It could be argued
> that it's useful to support older firmware versions, but there is also a 'leds-apu' driver which a)
> probably ought to be marked deprecated with a view to removing it and b) implements the leds even on
> antique firmware versions.

leds-apu is only for *OLD* apu1 - it does *not* work with v2/3/4,
completely different chipset.

> In implementing the APU5 I changed some of the exported gpio names to make them more closely match
> functionality across all the boards. > For example APU2 vs APU4 both support 2x LTE options, but in
> different mpcie slots and this affects the numbering of options, but not the sense of them (so I
> renamed them based on the intention of the option). This is particularly true on APU5 which supports
> 3x LTE cards

Dont break existing userlands.

> Can I get some advice: It would be helpful if the kernel would export the GPIOs to user-space
> automatically since toggling SIM slots is fairly useful task in userspace. 

This is planned to be moved to either an own subsystem or into rfkill
(which would have to be extended for such things).

Using raw gpio's isn't a good idea - it's not portable.

> At least for me the gpio
> numbers seem to jump around depending on the order of module loading, so doing something involving
> /sys/class/gpio/export isn't obviously an easy process. 

Exactly. That's why they should be bound to more high level drivers.
Gpio numbers are anything but stable.


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
