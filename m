Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1D28A852
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgJKRF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 13:05:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34064 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbgJKRF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 13:05:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 660481F44357
Subject: Re: [PATCH] x86/x86_64_defconfig: Enable the serial console
To:     Borislav Petkov <bp@alien8.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Collabora Kernel ML <kernel@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?Q?Diego_Elio_Petten=c3=b2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Willy Tarreau <w@1wt.eu>
References: <20201008162206.862203-1-enric.balletbo@collabora.com>
 <20201008164044.GE5505@zn.tnic>
 <4162cfa4-7bf2-3e6e-1b8c-e19187e6fa10@infradead.org>
 <2538da14-0f4b-5d4a-c7bf-6fdb46ba2796@collabora.com>
 <20201011122020.GA15925@zn.tnic>
 <107a6fb0-a667-2f30-d1f4-640e3fee193a@collabora.com>
 <20201011155754.GC15925@zn.tnic>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1dfdf163-9b54-ceae-b178-c566e6109263@collabora.com>
Date:   Sun, 11 Oct 2020 19:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201011155754.GC15925@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 11/10/20 17:57, Borislav Petkov wrote:
> On Sun, Oct 11, 2020 at 05:40:27PM +0200, Enric Balletbo i Serra wrote:
>> How do you quantify those things are NOT common enough? Do you have a number?
> 
> I don't want to change the defconfig - you do. So quantifying is in your
> court - not mine.
> 
>> I don't have a number, the only I can tell is that both symbols enable support
>> for I2C, SPI an HS-UART. The AMD one, is found on AMD Carrizo and later
>> chipsets, the Intel one, is found on Intel Skylake and later. I.e Lots of
>> laptops need these to have support for the touchpad.
> 
> That sounds like a step in the right direction.
> 
>> KernelCI is focused on upstream kernel development. KernelCI builds lots of
>> different versions of the kernel, including stable kernels, and maintainers
>> trees. It does tests on real hardware, so having a config supporting as much as
>> possible the x86 hardware that we have in the KernelCI labs will help us to
>> increase the test coverage and catch more issues.
> 
> So those issues - where do you guys report them? Because I've never seen
> one reported by kernelCI, AFAIR. I see 0day bot and syzbot doing such
> reports on a regular basis but none from kernelCI AFAIK. Do you send
> your bug reports to lkml and Cc the relevant parties?
> 

Yes, although probably there is only a chance that you saw for ARM platforms, we
just started to attach x86 hardware to the KernelCI labs (apart from some qemu
instances).

They all can be found here:
https://groups.io/g/kernelci-results/messages?start=10:2020:-120


>> Yes, it can. As I said, is a matter of maintenance, if we do this we
>> will have a different workflow for x86 hardware.
> 
> Lemme get this straight - your workflow would do:
> 
> $ make defconfig
> 
> and now here you'd have to add a single command:
> 
> $ .scripts/kconfig/merge_config.sh -m .config .kernelci.config.snippet
> 
> in order to get the symbols you want, enabled.
> 
> I've shown this one because this is how those other configs like
> kvm_guest.config and xen.config work - they're config snippets and they
> get merged with a preexisting config, see scripts/kconfig/Makefile.
> 
> Now, is that additional single command worth "hours of maintenance time"
> or is it something you can do easily? As in:
> 
> 	if (x86)
> 		<command>
> 
> ?
>

Sorry if I didn't explain well, but I am not talking about this workflow, which
of course, is very trivial and actually even implemented in kernelCI. It
actually allows to merge fragments. Let me try explain again.

I'm going to use the arm64 / x86 naming just because for clarity, but basically
is a fragment in the kernel repository vs a fragment on another repository.

So imagine your hardware is attached to a KernelCI lab and want to run
v4l2-compliance tests on that hardware.

For arm64 (i.e : arm64_defconfig)
   1. You send a patch to the list enabling the CONFIG_YOUR_V4L2_DEVICE=m
   2. The patch is accepted and merged in linux-next.
   3. KernelCI builds linux-next, boots the kernel on the hardware, detects a
new v4l2 device, and runs the v4l2-compliance tests.


For x86:
   1. You send a patch to list enabling the CONFIG_YOUR_V4L2_DEVICE=m
   2. The patch is rejected because doesn't fit the requirements (is not common
enough)
   3. If you're lucky someone will tell you to send the patch, to the specific
KernelCI x86 fragment project.
   4. You send a patch to the separate KernelCI x86 project.
   5. The patch is accepted and merged.
   6. KernelCI builds linux-next, boots the kernel on the hardware, detects a
new v4l2 device, and runs the v4l2-compliance tests.


Of course you can skip 1-3 if you know already that. Another example:


For arm64 (i.e : arm64_defconfig):
    1. Someone renames CONFIG_A to CONFIG_AB, sends a patch, and as he did a
grep, the patch modifies all the defconfigs.
    2. The patch is accepted and merged in linux-next.
    3. KernelCI builds linux-next, boots the kernel on the hardware and all the
tests continue passing.


For x86:
    1. Someone renames CONFIG_A to CONFIG_AB, sends a patch and as he did a grep
the patches modifies all the defconfigs.
    2. The patch is accepted and merged in linux-next.
    3. KernelCI builds linux-next, boots the kernel on the hardware, and some
tests start to fail or are skipped.
    4. The maintainer is noticed about the behavior change, so he will need to
look at the problem, and find it.
    5. The maintainer sends a patch.
    6. The patch is accepted, but he needs to tag the release as per kernel <
x.y.z version it should use CONFIG_A and for kernel > x.y.z it should pick
CONFIG_AB.
    7. KernelCI builds linux-next, boots the kernel on the hardware and all the
tests pass again.

Thanks,
 Enric


> Thx.
> 
