Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472F029D508
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgJ1V43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgJ1V4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:56:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DF8C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:56:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0aab002bb6ddc5d07837c1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ab00:2bb6:ddc5:d078:37c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 390491EC0494;
        Wed, 28 Oct 2020 14:39:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603892358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yVbuVYVOUKsblE/68+tpjrSrUjA614WzS6Qde3GZktc=;
        b=CFx2SWS8+FYLt45SKJ6BjT2UQz0QS83pysRPhR9P5t8pIyaMk2sNel72AzUGWlrNry92rE
        fF1WFZ7fNpWxO9JvTCHOkwuTC+w/e0rUHD/DW4g4O+U+SDcc06c9kooSD2ccdoL4pJdiju
        e1bHJ/fEmg6Kl3baIlNPLgYdmRhoE6k=
Date:   Wed, 28 Oct 2020 14:39:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Fix vmlinux size check on 64-bit
Message-ID: <20201028133909.GA27112@zn.tnic>
References: <20201005151539.2214095-1-nivedita@alum.mit.edu>
 <20201027200803.GL15580@zn.tnic>
 <20201027211422.GC1833548@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027211422.GC1833548@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 05:14:22PM -0400, Arvind Sankar wrote:
> This is indeed just a small correctness fixlet, but I'm not following
> the rest of your comments.

I'm just trying to make sense of that house of cards we have here.

> PHYSICAL_START has an effect independent of the setting of
> RELOCATABLE.

Theoretically you can set PHYSICAL_START to 0x0:

config PHYSICAL_START
        hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
        default "0x1000000"
        help
          This gives the physical address where the kernel is loaded.

          If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
          bzImage will decompress itself to above physical address and
          run from there.
	  ^^^^^^^^^^^^^^

and disable RELOCATABLE:

CONFIG_PHYSICAL_START=0x0
# CONFIG_RELOCATABLE is not set

but then you hit this:

ld: per-CPU data too large - increase CONFIG_PHYSICAL_START

full output at the end of the mail.

> It's where the kernel image starts in virtual address space, as shown
> by the 16MiB difference between __START_KERNEL_map and _text in the
> usual .config situation. In all configs, not just majority, the kernel
> image itself starts at _text.

Of course.

> The 16MiB gap below _text is not actually mapped, but the important
> point is that the way the initial construction of pagetables is
> currently setup, the code cannot map anything above __START_KERNEL_map
> + KERNEL_IMAGE_SIZE, so _end needs to be below that.

Right.

> If KASLR was disabled (either at build-time or run-time), these
> link-time addresses are where the kernel actually lives (in VA space);
> and if it was enabled, it will make sure to place the _end of the kernel
> below KERNEL_IMAGE_SIZE when choosing a random virtual location.

Yes.

> That said, AFAICT, RELOCATABLE and PHYSICAL_START look like historical
> artifacts at this point: RELOCATABLE should be completely irrelevant for
> the 64-bit kernel, and there's really no reason to be able to configure
> the start VA of the kernel, that should just be constant independent of
> PHYSICAL_START.

See the CONFIG_PHYSICAL_START help text. Apparently there has been a
use case where one can set PHYSICAL_START to the region where a kdump
kernel is going to be loaded and that kdump kernel is a vmlinux and not
a bzImage and thus not relocatable.

And I just produced a .config which doesn't work. I guess

	"Don't change this unless you know what you are doing."

is supposed to say that that value can't be just anything but that ain't
good enough.

Lemme try a different offset after reading this:

	  Otherwise if you plan to use vmlinux
          for capturing the crash dump change this value to start of
          the reserved region.  In other words, it can be set based on
          the "X" value as specified in the "crashkernel=YM@XM"

Setting it to 256M works:

$ readelf -a vmlinux | grep -E "\W(_end|_text)"
 95509: ffffffff90000000     0 NOTYPE  GLOBAL DEFAULT    1 _text
 97868: ffffffff9aa26000     0 NOTYPE  GLOBAL DEFAULT   30 _end

Setting to 8M works too, it seems:

$ readelf -a vmlinux | grep -E "\W(_end|_text)"
 95509: ffffffff80800000     0 NOTYPE  GLOBAL DEFAULT    1 _text
 97868: ffffffff8b226000     0 NOTYPE  GLOBAL DEFAULT   30 _end

so I guess this should be a range > 0 specification but I guess not
important.

Going back to the question at hand, if you think about it, the kernel
image *is* between _text or _stext and _end. And KERNEL_IMAGE_SIZE is
exactly what it is - the size of the kernel image.

Now, if you were talking about a kernel *mapping* size, then I'd
understand but this check is for the kernel *image* size.

But reading that commit message again:

    these build-time and link-time checks would have prevented the
    vmlinux size regression.

this *is* talking about vmlinux size and that starts at _text...

Thx.

ld: per-CPU data too large - increase CONFIG_PHYSICAL_START
init/main.o: in function `perf_trace_initcall_level':
/home/boris/kernel/linux/./include/trace/events/initcall.h:10:(.text+0x147): relocation truncated to fit: R_X86_64_PC32 against symbol `this_cpu_off' defined in .data..percpu..read_mostly section in arch/x86/kernel/setup_percpu.o
init/main.o: in function `perf_trace_initcall_start':
/home/boris/kernel/linux/./include/trace/events/initcall.h:27:(.text+0x252): relocation truncated to fit: R_X86_64_PC32 against symbol `this_cpu_off' defined in .data..percpu..read_mostly section in arch/x86/kernel/setup_percpu.o
init/main.o: in function `perf_trace_initcall_finish':
/home/boris/kernel/linux/./include/trace/events/initcall.h:48:(.text+0x319): relocation truncated to fit: R_X86_64_PC32 against symbol `this_cpu_off' defined in .data..percpu..read_mostly section in arch/x86/kernel/setup_percpu.o
init/main.o: in function `preempt_count':
/home/boris/kernel/linux/./arch/x86/include/asm/preempt.h:26:(.text+0x823): relocation truncated to fit: R_X86_64_PC32 against symbol `__preempt_count' defined in .data..percpu section in arch/x86/kernel/cpu/common.o
/home/boris/kernel/linux/./arch/x86/include/asm/preempt.h:26:(.text+0x84f): relocation truncated to fit: R_X86_64_PC32 against symbol `__preempt_count' defined in .data..percpu section in arch/x86/kernel/cpu/common.o
init/main.o: in function `preempt_count_set':
/home/boris/kernel/linux/./arch/x86/include/asm/preempt.h:34:(.text+0x88f): relocation truncated to fit: R_X86_64_PC32 against symbol `__preempt_count' defined in .data..percpu section in arch/x86/kernel/cpu/common.o
/home/boris/kernel/linux/./arch/x86/include/asm/preempt.h:37:(.text+0x8a3): relocation truncated to fit: R_X86_64_PC32 against symbol `__preempt_count' defined in .data..percpu section in arch/x86/kernel/cpu/common.o
init/main.o: in function `trace_initcall_start':
/home/boris/kernel/linux/./include/trace/events/initcall.h:27:(.text+0x8e5): relocation truncated to fit: R_X86_64_PC32 against symbol `cpu_number' defined in .data..percpu..read_mostly section in arch/x86/kernel/setup_percpu.o
init/main.o: in function `__preempt_count_add':
/home/boris/kernel/linux/./arch/x86/include/asm/preempt.h:79:(.text+0x8fc): relocation truncated to fit: R_X86_64_PC32 against symbol `__preempt_count' defined in .data..percpu section in arch/x86/kernel/cpu/common.o
init/main.o: in function `__preempt_count_dec_and_test':
/home/boris/kernel/linux/./arch/x86/include/asm/preempt.h:94:(.text+0x91b): relocation truncated to fit: R_X86_64_PC32 against symbol `__preempt_count' defined in .data..percpu section in arch/x86/kernel/cpu/common.o
init/main.o: in function `trace_initcall_finish':
/home/boris/kernel/linux/./include/trace/events/initcall.h:48:(.text+0x932): additional relocation overflows omitted from the output
make: *** [Makefile:1164: vmlinux] Error 1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
