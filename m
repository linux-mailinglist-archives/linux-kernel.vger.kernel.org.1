Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09706295DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897572AbgJVLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:48:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40211 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897563AbgJVLsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:48:46 -0400
Received: from [192.168.1.155] ([95.115.71.8]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQ8OG-1kig7X2eum-00M6c7; Thu, 22 Oct 2020 13:48:27 +0200
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
 <65efe44a-bbef-f982-462a-385fffe493a0@wildgooses.com>
 <0de126c4-f2aa-a817-0a38-32bf3ede84d1@redhat.com>
 <e953f3ee-2db1-1523-cd84-6acb26751a15@wildgooses.com>
 <d0d91191-cad2-94a1-6373-0f3ff4e38376@redhat.com>
 <795ae78b-26cf-f58d-6981-f68d7599ccdf@wildgooses.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <6a603bd6-63ff-52e8-8fa2-4442b06e493b@metux.net>
Date:   Thu, 22 Oct 2020 13:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <795ae78b-26cf-f58d-6981-f68d7599ccdf@wildgooses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ik2mwT4vTjJhbImH6K5zZxmJuoZridiM+KMlKxixea6lFsHA7cP
 mEhvnxcol0tTxZ0JrLe9bkrSSdkcB2O5lQ26MjO+QTPhc4Br98BsOJbGOZ41WPRii+uxPnG
 /ueEEPnbMiYRdcxqy4bNv2uWQwgFidgQS9GNHl2w5NYLtZhn/2USfizwLUF1qHpmwisI+Iu
 K2+zMiSvmiFr0Da8/V9DQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BkG2CnxvP0w=:bFlD3SHo+yMcRbgKds2U0u
 1xYBLzlH6sScnlyaPGqRqoudMa5QRYKvOFw0MxZrDVyDTuBPNkY1hfmyNJ4HrBexlcyaXVDsl
 UzYoq5GlHHAd1Il6LCXwvc0MOsxBYUekjb0zRTa1zhBasNIN82Uln1vjiwtuSHFg5CCuJEtsJ
 j5+ZAobhQhKiGhaMsax3zun5qF/VIqcVnu6eZaSW2xbNdZ7GmSuICUrhnNXnqH9bjvXhu7n1w
 iuh4V9Qnelz1V/VbXedLw8HQBJTaatpD/cIfOT+ErKRvrSxuUIJPS7t+j9sWQhBBF1pwHvqZp
 0S9EWLV/gQsaOWmOSSN+8FCWho8XtE8qpuJzAPdc4iloQTvlZ+qoSP043KKbQWcTekD+RqiCj
 ntccu28mXOfOinwYABADZJHRSv7gT3kVe5wKn9bx9kq5C1CKsU3cm4yD7/tvt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.20 23:54, Ed W wrote:

Hi,

> OK, I've just sent a new patch which conditionally configures GPIOs for boards with older firmware's
> (older than 4.10.0).

as mentioned in my reply to it: still breaks existing userlands as
device names and keycodes change. userland would need to become
dependent on bios version. Exactly one of those kind of instability
we do NOT want.

Remember: these boards are used for embedded applications - an area
where we do not have any operator and need a very high level of
stability (sending a technician costs 10x the price of the board).

> This is followed up by the patch I really want to try and get in, which is to add support for APU5
> and APU6. Particularly APU5 is quite interesting to me and significantly different to previous
> boards in that it has a lot more mpcie slots that can be used for LTE modules or wifi cards.

Okay, why not just treating them differently ?

Personally, I don't have an apu5, so can't tell much of them yet. But if
they're so different, I can live with those having different names /
keycode, assuming all this stuff is already supported by the lowest BIOS
version they've ever been shipped with (remember: requirement of BIOS
upgrade in the field is also not an option). Can you please check
whether that's the case ?

In that case we don't need any per bios-version special magic, just
another entry in the DMI match table and separate board structs.

For the mpcie reset lines we really should consider using the reset
controller framework or add it to pci core (so pci_bus drivers also
expose it to sysfs, in order to let userland trigger it). Tricky part
is letting the board driver attach the reset functionality to the
generic pci_bus driver. (grmpf, it wasn't ugly acpi, but dt instead,
this would be pretty trivial via dt-overlay :o).

> This
> creates the realisation that the reset and sim-swap lines are always wired to the LTE slots, not to
> the mpcie slots (although often they overlap in functionality), so naming is corrected here. 

Sorry, but i'm confused. What's the actual difference between mpcie and
LTE slots ? What is an LTE slot anyways ? Are you talking about the USB
lanes on the M2 slot ?

Does anybody happen to have the FULL M2 spec available ?

According to the pinouts i've found, the reset line is dedicated to
PCIE, but perhaps we should treat it as "card reset" - IOW the whole
card resets, no matter which channels (sata, pcie, usb, ...) it is
actually using.

If that's the case, maybe we should reconsider the whole bus topology,
perhaps introduce an pseudo bus for representing the m2 connector,
which has the corresponding pcie/sata/usb/... ports as childs.
(I'm going to ask the corresponding bus maintainers for their oppinions)

> That
> said, I don't think the reset lines function on most iterations of boards, so possibly supporting
> those lines with GPIOs is redundant anyway...

My observation (on apu2/3/4) is that it seems to dependend on the
cards, eg. one baseband I've testing did the reset (sometimes even
needs on after poweron), another one just seemed to ignore it. Both
were running via USB.

No idea, whether that also depends on BIOS version ...

> I don't know if it's useful, but I uploaded a couple of scripts for beeping and flashing the leds.
> Here I just used globs to handle the different naming on the different boards (since I need to
> handle the older Alix boards as well). Enrico, is this useful to you?
> 
>     https://github.com/nippynetworks/gpio-utils

The swap_sim script illustrates a good point, that I resisted to think
about: sim swapping needs extra, baseband specific logic, to make it
actually work :(

So, I'm still unsure whether this stuff should go into a separate
portmux subsystem or an extended rfkill (where the basebands have to
be put into) ... both options still a lot of work to do.

> As an aside, these boards are super easy to flash as they support flashrom. 

Easy in the lab. But not in the field - if *anything* goes wrong,
technician needs to fly out - several k$ plus days of downtime,
until the technician reaches the place.

Let me rephrase this again: embedded devices, litterally in the field.

For kernel and userland, we already have good ways to handle redundancy
(automatic rescue boot in bootloader, serial console, wdt, ...), but
for the BIOS we don't have that.

> The generic bios is quite slow to startup and I would like to prepare 
> a customised version with shorter timeouts. Happy to work with
> you on something separately if this is interesting?

Actually, I already planned an actual factory setup for these boxes,
which includes the whole process, hw testing, bios deployment,
OS/application deployment, etc, etc. Unfortunately, this is lots of
work to do (has to be someting that arbitrary field technicians,
who aren't sw engineers, can actually do on their own).

Tried to get some sponsoring from pcengines, but they don't even seems
to be interested in an arranging simple things like LED names.
Damn, I'm really unhappy with these folks - we could have prevented much
of this whole mess if they would talked to me (they know that I'm the
apu-board kernel maintainer) :(



Let's try summarize the current state of knowledge:

* apu2..4:
  * BIOS support highly depends on BIOS version, we need to
    support older versions.
  * Field depends on on driver's naming, keycodes, ...
* apu5/6:
  * no known field-users that depend on the driver's naming scheme yet,
    (actually not supported yet) - we possibly could tolerate change
    in naming
  * assuming that all boards in the field already have recent enough
    BIOS that support LEDs and keys
  * suggestion: only implement the missing parts (eg. dont instantiate
    LEDs/Keys for them) - need to make sure there's no conflict with
    acpi-instantiated gpios, or grab these instead
* mpcie-reset:
  * no known field-users that depend on that - only has been used as
    debug tool and mapping to LEDs declared as temporary solution
    (planned to move it to reset controller subsystem or into pci
    subsystem)
  * therefore: userland API changes acceptable
  * open question:
    * do these lines actually belong to pcie or to the whole m2 card
      (which might not even use pcie, instead usb or sata) ?
    * shall we have a separate (pseudo)bus for m2, which controls
      these lines ?
    * do we need per-card special handlings (timing, ...) ?
* simsw:
  * similar to mpcie-reset (still experimental, ...) ...
  * seems to be really bound to M2 ports

Proposal:
  * introduce M2 (pseudo-)bus for modelling M2 ports + functionality
  * per-port reset lines (considered "card reset" instead of just
    pcie reset)
  * sim switch functionality
  * exposes switch/reset functionality via sysfs to userland
  * possibly publishes extra card information (if available)
  * linking to actual bus'es (currently active) on the card,
    which come from different subsystems (pci, usb, ...)


I'm going to write a small proposal for this new m2-port subsystem,
an post it @lkml.


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
