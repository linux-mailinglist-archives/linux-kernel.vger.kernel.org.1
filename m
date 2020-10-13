Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1604728D642
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 23:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgJMVkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 17:40:42 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:48172 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgJMVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 17:40:42 -0400
Received: from macbookpro-ed.wildgooses.lan (unknown [212.69.38.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4C9pr70CNtzTh4v;
        Tue, 13 Oct 2020 22:40:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1602625240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSpYESXi/pIEBc7J9tBus1E4Xbha+rUuF8RFle6D0x0=;
        b=QRNMnEpWYsYbgmgWCPQz9rztR6RtgXRiKm7PlUqGhkb1inULSpEMVB5KMUHa+u729JUlbJ
        AzzOjz1ku9RdN/SllVveBU0Zt3PmrNo0tyBLI2BmbDYBt0d3BOLHMqzGF+b5DILPZ5GrLH
        fR5hAQhHHROjszUUD6Y8uW9UC8biELs=
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
From:   Ed W <lists@wildgooses.com>
Message-ID: <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
Date:   Tue, 13 Oct 2020 22:40:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2020 20:39, Enrico Weigelt, metux IT consult wrote:
> On 22.09.20 00:17, Ed W wrote:
>> Hi, I've been adding support for the PC Engines APU5 board, which is a variant of the APU 2-4 boards
>> with some nice features. The current platform driver for pcengines boards has some redundant
>> features with regards to recent bios/firmware packages for the board as they now set the ACPI tables
>> to indicate GPIOs for keys and leds. 
> NAK. Breaks existing userlands in the field (literally field), forcing
> users to fw upgrade is not an option (field roll would be realy expensive).


But why are users "in the field" updating a kernel willy nilly without also updating the userland
software that talks to it? Why is the kernel upgrade trivial, but the fw upgrade is not an option?
Why not also update the app or setup a udev rule?

I would understand if we were talking something fairly major, but it's the case of matching a
filename that YOU changed from an old name to the current name and it's now changing back to the
original name?


>> So I've submitted a patch to eliminate this. It could be argued
>> that it's useful to support older firmware versions, but there is also a 'leds-apu' driver which a)
>> probably ought to be marked deprecated with a view to removing it and b) implements the leds even on
>> antique firmware versions.
> leds-apu is only for *OLD* apu1 - it does *not* work with v2/3/4,
> completely different chipset.


That's extremely disingenuous!!

It USED to work for the APU2-4 except that YOU removed support for APU2-4 from that module!!


>> In implementing the APU5 I changed some of the exported gpio names to make them more closely match
>> functionality across all the boards. > For example APU2 vs APU4 both support 2x LTE options, but in
>> different mpcie slots and this affects the numbering of options, but not the sense of them (so I
>> renamed them based on the intention of the option). This is particularly true on APU5 which supports
>> 3x LTE cards
> Dont break existing userlands.


But YOU already did that!!

Look, the original situation was that:

- up to July 2019 there was a kernel module that named the LEDs in the form apu2:green:1, etc.

- In July 2019 you removed that and "broke all of userland by renaming the LEDs" (never break
userland right?)

- Then in Sept 2019, PCEngines released a new bios/firmware line which setup ACPI correctly to
register these GPIOs with some default names along the lines of apu2:green:1 or similar. So now we
are back to the original naming convention

- This meant that from Sept 2019 your module created duplicate LEDs with a different set of names


So the situationt boils down to:

- LEDs have been named like "apu2:green:1" continuously, with a brief outage in Aug-Sep 2019.

- You have introduced a new module which unnecessarily duplicates those LEDs for users of this board
with a bios/firmware post Sep 2019.

- Your new naming convention isn't the same as this historic naming convention


Now don't get me wrong, I prefer your module naming, but you are very disingenuous to claim that I'm
trying to break userspace when you already did it!

Plus I see no future for the LED piece of your module given that it's done by ACPI in all modern
bios? Do you really want a duplicate set of LEDs to exist forever in userspace? This doesn't seem to
be workable?


Lets be clear, the current situation is:

- LED names change from "apu:green:1" to "apu2:green:1".

- This can be trivially worked around with some symlinks and/or a udev rule

- The historic name has been "apu2:green:1" in the original LED module and now in ACPI. I'm not wild
about this naming convention, but it's been around longest. If one has to pick which userspace to
break, then this seems to have precedence.

- Your LED based SIM toggle HAS already gone. So you have another example of userspace being broken
right there. (Seems that this rule isn't so concrete?). So you already need to (significantly?)
adjust your userspace code - I'm not seeing how/why the LED change is such a blocker?


>> Can I get some advice: It would be helpful if the kernel would export the GPIOs to user-space
>> automatically since toggling SIM slots is fairly useful task in userspace. 
> This is planned to be moved to either an own subsystem or into rfkill
> (which would have to be extended for such things).


Can you send me a pointer to this planning? Is this something concrete or aspirational?

I need something I can use right now for SIM swap. exporting GPIOs with known names seems no more
evil than exporting LEDs with known names? Do you have any concrete suggestion for the here and now?

Given that the LED based sim swap is already removed from the kernel, how are you planning to toggle
SIM swap in userspace?


Hans, can I ask you to look again at the history of this please. Bearing in mind the speed kernel
stuff takes to get to end users, we are talking about a very small window of userland changes here.
I would vote for simplifying this module and trying to reduce some baggage. However, my main goal is
to get support in for APU5. Second goal is to reduce the duplicate LED devices. Beyond that I'm not
so fussed?

Thanks all

Ed W


