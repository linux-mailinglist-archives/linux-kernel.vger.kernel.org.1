Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F23292B90
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgJSQdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:33:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgJSQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:33:36 -0400
Received: from [192.168.1.155] ([77.2.107.242]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mjjzx-1k22eG17yF-00lC5i; Mon, 19 Oct 2020 18:33:23 +0200
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     Ed W <lists@wildgooses.com>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     fe@dev.tdt.de, "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
References: <20200921215919.3072-1-lists@wildgooses.com>
 <d4b2045c-769b-4998-64cc-682c01c105fb@wildgooses.com>
 <8058a804-a793-a5f8-d086-0bb0f600aef9@metux.net>
 <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <2eb878bf-3ec7-362f-73b3-4192dd183390@metux.net>
Date:   Mon, 19 Oct 2020 18:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hfmAgZ+ZCxJe6x/tpIb/S4CcmfiDBwEn76cyitZ1Y7p00Ybhk69
 IY9gsTMvAJOGmn3QFG8e+lZMJBpns761Ug3TF37EeIoS0edqRGETFAUZPOeGqTX4CKgD8mi
 tuTUzwtkw0A3Jyu/3i0PdneFUIhX6OmbDa3NT8XXXo6gWpmLozy7v/3rPSNd7pKKLBVtjob
 3t2XvTwR8EiSWe9LQi3rA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uBth9DTdfU8=:8vkOnjpFh/iM4t5LCstxNb
 plRiouRN2cf18YumDk0ojcv9+d5UOjyscR6KphVy26uj1sAdR8IgL/V7SxrtIhf977gAB80fc
 3VkgNbUfeafkFNbORzQ9H4+pfOGsNxO8Nhf49L2BYGXQ2L1FSd13GdgEq+2y7797dfg/mPj+X
 hsN/d6wFcIS9img08F7EI7dECOUkw8AMW+bBks3fmD/2DC0/yMZYJhv8Upvv8Kl7tDBugx2Uu
 lkx9iNYNOnTVU6tH299TK20mh4yXG6XatkMScugNK3pQKKo9p943AV4ScbR5kFPtG7m3g9iBu
 dg0ixyWgDxDaoSSVM7UOedeetgrQVT7l2RGbH7WLqj1DMENuDKn6cnskxgBwrlrfB0t2ppvAH
 b0O0k5RrglifiW81hDbcQbVUXrf3bekMkOjis8kiFMw12B7tyT4vUqeRkGlIG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.10.20 23:40, Ed W wrote:

> But why are users "in the field" 

"field" here means litterlly field. Far away from any human being.

> updating a kernel willy nilly without also updating the userland
> software that talks to it? 

Of course, we're always testing. Obviously, in the lab, not in the
field. And we don't wanna have to adapt existing, well tested, embedded
applications for dozens of BIOS versions, which might or might not
have certain functionality (it's not just for LEDs, but all the other
gpio-attached devices, eg. keys, mpcie reset, simsw, ...), etc.

> Why is the kernel upgrade trivial, but the fw upgrade is not an option?

Because technicians have to fly out to the installations and replace
the whole board (no, certainly no remote updates of the BIOS). The costs
per installation are a factor of the board price.

> Why not also update the app or setup a udev rule?

Again, BIOS version specific. And it's a not just a udev rule, it's
a lot of paper work in the application qualification.

This is an embedded device, not an cheap office pc.

> I would understand if we were talking something fairly major, 
> but it's the case of matching a
> filename that YOU changed from an old name to the current name and it's now changing back to the
> original name?

I did not change anything, I wrote a completely new driver with full
gpio support and attached devices.

pcengine folks ignored it for a long time, suddenly the started adding
incompatible stuff to their newer firmware.

> That's extremely disingenuous!!

No, its correct. The apuv1 board (more precisely its SoC) has a
completely different FCH. The old driver had some rudimentary support
just for the front leds, which actually worked properly on none of my
testing boards. I've did several surveys in the apu community -
everybody was using some userland program doing raw iomem access
(/dev/mem). Haven't found a single Distro that ever shipped that old
driver.

> It USED to work for the APU2-4 except that YOU removed support for APU2-4 from that module!!

Yes, I've proposed removing it, because I could not find a single person
who actually used it on apu2/3/4 boards. This might have to with the
fact that folks were happy that they now could use other gpio-connected
devices, too.

And, BTW, it did conflict with the new driver.

Note: the old driver is *only* for LEDs, not gpios as such, nor other
gpio-attached devices.

<skipping stuff that already had been answered>

> - Your LED based SIM toggle HAS already gone. So you have another example of userspace being broken
> right there. (Seems that this rule isn't so concrete?). 

Without my knowledge and ackknowledge as the maintainer !

> So you already need to (significantly?)
> adjust your userspace code - I'm not seeing how/why the LED change is such a blocker?

simsw isn't actively used in the field, the other gpio-consumers (leds,
keys, reset, ...) are used in the field. litterally field.

simsw was a quick shot on purpose, planned to be replaced by rfkill or
portmux. Both still experimental and nothing ready for mainline yet.


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
