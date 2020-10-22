Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAA296179
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901245AbgJVPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 11:10:33 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:41278 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508416AbgJVPKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 11:10:31 -0400
Received: from macbookpro-ed.wildgooses.lan (unknown [212.69.38.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256))
        (No client certificate requested)
        (Authenticated sender: ed@wildgooses.com)
        by mail1.nippynetworks.com (Postfix) with ESMTPSA id 4CH9lj5RJjzTgZX;
        Thu, 22 Oct 2020 16:10:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1603379429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoZnghyL86LjuRh48xnNLuc12RaEl9wnNvCJlJnX08s=;
        b=h05nHdK+uEAWSpj4PnguxcAM10C3YrjKYkthf3XBhEYs4nDouvc4ywlnSg4LGPCtBdrlMZ
        YKq/R35vuW25T1d+Qmn2+uMlSMfOX1HqMuuq//k9ONAnH8FEPmYYE8QtD4kJQ/J748kY7I
        ZkjAfYuc1dLB7Bt0iSH5YT7E+6Gk+8U=
Subject: Re: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform
 driver
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Hans de Goede <hdegoede@redhat.com>,
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
 <6a603bd6-63ff-52e8-8fa2-4442b06e493b@metux.net>
From:   Ed W <lists@wildgooses.com>
Message-ID: <cb7a0dcd-7b4f-9baa-788d-c42db72afeb2@wildgooses.com>
Date:   Thu, 22 Oct 2020 16:10:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <6a603bd6-63ff-52e8-8fa2-4442b06e493b@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


>> This is followed up by the patch I really want to try and get in, whic=
h is to add support for APU5
>> and APU6. Particularly APU5 is quite interesting to me and significant=
ly different to previous
>> boards in that it has a lot more mpcie slots that can be used for LTE =
modules or wifi cards.
> Okay, why not just treating them differently ?
>
> Personally, I don't have an apu5, so can't tell much of them yet. But i=
f
> they're so different, I can live with those having different names /
> keycode, assuming all this stuff is already supported by the lowest BIO=
S
> version they've ever been shipped with (remember: requirement of BIOS
> upgrade in the field is also not an option). Can you please check
> whether that's the case ?
>
> In that case we don't need any per bios-version special magic, just
> another entry in the DMI match table and separate board structs.


You are reaching the wrong conclusion I feel?

a) your proposal doesn't address that ACPI and the upstream board configu=
re all this stuff already.
We are creating duplicate devices right now. Patch 1 removes the duplicat=
e device. I don't see that
your proposal addresses the duplicate devices?

b) there is no reason for naming to be different between APU2-4 and 5. Le=
ts standardise. I use the
boards somewhat interchangeably

c) If you check my patch, there is already a DMI match for APU5, so this =
can do whatever you want it
to, however, since it's green fields, I've set it up to match the way APU=
2-4 is working (in my patch)

d) Your driver already broke my userspace a year back when you changed th=
ese names. I've just
supported all/both versions of the LED naming conventions since then (it =
isn't hard). I do believe
we are overthinking this? It's really trivial to incorporate?



> For the mpcie reset lines we really should consider using the reset
> controller framework or add it to pci core (so pci_bus drivers also
> expose it to sysfs, in order to let userland trigger it). Tricky part
> is letting the board driver attach the reset functionality to the
> generic pci_bus driver. (grmpf, it wasn't ugly acpi, but dt instead,
> this would be pretty trivial via dt-overlay :o).


Knock yourself out. However, make sure that you read Pascal's email to yo=
u where he states that
these lines aren't actually wired up on many of the board revisions?


>> This
>> creates the realisation that the reset and sim-swap lines are always w=
ired to the LTE slots, not to
>> the mpcie slots (although often they overlap in functionality), so nam=
ing is corrected here.=20
> Sorry, but i'm confused. What's the actual difference between mpcie and=

> LTE slots ? What is an LTE slot anyways ? Are you talking about the USB=

> lanes on the M2 slot ?


The APU2-4 have

- 3x mpcie *shaped* slots

- On some boards there are two of these wired with the pcie signals

- On some boards there are two or three of these wired with USB signals

- On some boards there are mSATA signals to one of these slots

- On some boards there are either 1x or 2x SIM cards wired to some of the=
 slots


What is common is that the reset lines (and rfkill) go to the same slots =
as the SIM lines.

So my suggestion is to name these lines based on "purpose", ie modem1 and=
 modem2, which is 100%
consistent, rather than slot number, since that varies based on which boa=
rd you pickup off the pile


The schematics are all publicly available. Although I think you may have =
to ask Pascal for the
APU5/6 ones. The rest are on the website


I'm confused about what you mean by M2 slot? There are no m.2 slots on th=
e board? only mpcie, some
with USB signals, some with SIM?


> According to the pinouts i've found, the reset line is dedicated to
> PCIE, but perhaps we should treat it as "card reset" - IOW the whole
> card resets, no matter which channels (sata, pcie, usb, ...) it is
> actually using.


Please read Pascal's email to you. He disconnected these lines on many bo=
ard revisions.


>> I don't know if it's useful, but I uploaded a couple of scripts for be=
eping and flashing the leds.
>> Here I just used globs to handle the different naming on the different=
 boards (since I need to
>> handle the older Alix boards as well). Enrico, is this useful to you?
>>
>> =C2=A0=C2=A0=C2=A0 https://github.com/nippynetworks/gpio-utils
> The swap_sim script illustrates a good point, that I resisted to think
> about: sim swapping needs extra, baseband specific logic, to make it
> actually work :(


We just need the GPIOs exposing in some way. Nothing else. Everything els=
e is done in userspace


> So, I'm still unsure whether this stuff should go into a separate
> portmux subsystem or an extended rfkill (where the basebands have to
> be put into) ... both options still a lot of work to do.


Lets please focus on things we can achieve in the near future in this thr=
ead


>> As an aside, these boards are super easy to flash as they support flas=
hrom.=20
> Easy in the lab. But not in the field - if *anything* goes wrong,
> technician needs to fly out - several k$ plus days of downtime,
> until the technician reaches the place.


Not disagreeing, but it seems about as reliable as doing a software upgra=
de. If you do those then
you are likely safe doing this



>> The generic bios is quite slow to startup and I would like to prepare =

>> a customised version with shorter timeouts. Happy to work with
>> you on something separately if this is interesting?
> Actually, I already planned an actual factory setup for these boxes,
> which includes the whole process, hw testing, bios deployment,
> OS/application deployment, etc, etc. Unfortunately, this is lots of
> work to do (has to be someting that arbitrary field technicians,
> who aren't sw engineers, can actually do on their own).


I've already got one

Hint: use netboot for simplest setup


> Tried to get some sponsoring from pcengines, but they don't even seems
> to be interested in an arranging simple things like LED names.
> Damn, I'm really unhappy with these folks - we could have prevented muc=
h
> of this whole mess if they would talked to me (they know that I'm the
> apu-board kernel maintainer) :(


I'm hiring. Contact me offlist if you want to talk further?



> Let's try summarize the current state of knowledge:
>
> * apu2..4:
>   * BIOS support highly depends on BIOS version, we need to
>     support older versions.
>   * Field depends on on driver's naming, keycodes, ...


Realistically that's only partially true:

- older kernels and older bios has "old names"

- kernels from a year back with your driver have a mix of "new" or "new +=
 old" names depending on
whether the bios is newer than 4.10.

- After the patch I proposed: newer bios and newer kernel use ACPI, older=
 bios match your driver,
people upgrading from kernels more than about a year old don't notice sin=
ce they move from "old"
names to "acpi names" which are identical.



> * simsw:
>   * similar to mpcie-reset (still experimental, ...) ...
>   * seems to be really bound to M2 ports


Not experimental. Works reliably. Just don't toggle them during bootup (a=
s your driver was doing in
the past - current driver doesn't do this anymore - problem resolved)

The GPIO lines are wired to a SIM swap chip which does all the work. The =
LTE cards don't know or see
what is happening


Regards

Ed W


