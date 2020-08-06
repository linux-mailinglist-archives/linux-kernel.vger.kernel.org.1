Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658E323E211
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 21:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgHFTZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 15:25:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:35473 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFTZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:25:03 -0400
IronPort-SDR: +X/sFRIIiqa4fROpFfNeHDxaYVm/AtAHwlOuKEn8buZEzpglfFPgU0dt98RggZd4VZ7518BOQP
 ee6Be0lxaSxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="132461178"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="132461178"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:25:02 -0700
IronPort-SDR: IhZ+OmZJvoHu0nRl894FD1fpUugxCkPCwBxfLQI7HR2oL7YK69RhEB67/hDZvmTIx2Hs+PQpi1
 N1PyiQEWmoqg==
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="293409049"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.166.190])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:25:00 -0700
Message-ID: <df539dc3a4791d0f873aec9b303f49b64237a6e8.camel@linux.intel.com>
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com
Date:   Thu, 06 Aug 2020 12:24:58 -0700
In-Reply-To: <20200806153258.GB2131635@gmail.com>
References: <20200717170008.5949-1-kristen@linux.intel.com>
         <20200806153258.GB2131635@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingo, thanks for taking a look, I am glad you like the idea. Some
replies below:

On Thu, 2020-08-06 at 17:32 +0200, Ingo Molnar wrote:
> * Kristen Carlson Accardi <kristen@linux.intel.com> wrote:
> 
> > Function Granular Kernel Address Space Layout Randomization
> > (fgkaslr)
> > -----------------------------------------------------------------
> > ----
> > 
> > This patch set is an implementation of finer grained kernel address
> > space
> > randomization. It rearranges your kernel code at load time 
> > on a per-function level granularity, with only around a second
> > added to
> > boot time.
> 
> This is a very nice feature IMO, and it should be far more effective 
> at randomizing the kernel, due to the sheer number of randomization 
> bits that kernel function granular randomization presents.
> 
> If this is a good approximation of fg-kaslr randomization depth:
> 
>   thule:~/tip> grep ' [tT] ' /proc/kallsyms  | wc -l
>   88488
> 
> ... then that's 80K bits of randomization instead of the mere
> handful 
> of kaslr bits we have today. Very nice!
> 
> > In order to hide our new layout, symbols reported through 
> > /proc/kallsyms will be displayed in a random order.
> 
> Neat. :-)
> 
> > Performance Impact
> > ------------------
> > * Run time
> > The performance impact at run-time of function reordering varies by
> > workload.
> > Using kcbench, a kernel compilation benchmark, the performance of a
> > kernel
> > build with finer grained KASLR was about 1% slower than a kernel
> > with standard
> > KASLR. Analysis with perf showed a slightly higher percentage of 
> > L1-icache-load-misses. Other workloads were examined as well, with
> > varied
> > results. Some workloads performed significantly worse under
> > FGKASLR, while
> > others stayed the same or were mysteriously better. In general, it
> > will
> > depend on the code flow whether or not finer grained KASLR will
> > impact
> > your workload, and how the underlying code was designed. Because
> > the layout
> > changes per boot, each time a system is rebooted the performance of
> > a workload
> > may change.
> 
> I'd guess that the biggest performance impact comes from tearing
> apart 
> 'groups' of functions that particular workloads are using.
> 
> In that sense it might be worthwile to add a '__kaslr_group'
> function 
> tag to key functions, which would keep certain performance critical 
> functions next to each other.
> 
> This shouldn't really be a problem, as even with generous amount of 
> grouping the number of randomization bits is incredibly large.

So my strategy so far was to try to get a very basic non-performance
optimized fgkaslr mode merged first, then add performance optimized
options as a next step. For example, a user might pass in
fgkaslr="group" to the fgkaslr kernel parameter to select a layout
which groups some things by whatever criteria we want to mitigate some
of the performance impact of full randomization, or they might chose
fgkaslr="full", which just randomizes everything (the current
implementation). If people think it's worth adding the performance
optimizations for the initial merge, I can certainly work on those, but
i thought it might be better to keep it super simple at first.

> 
> > Future work could identify hot areas that may not be randomized and
> > either
> > leave them in the .text section or group them together into a
> > single section
> > that may be randomized. If grouping things together helps, one
> > other thing to
> > consider is that if we could identify text blobs that should be
> > grouped together
> > to benefit a particular code flow, it could be interesting to
> > explore
> > whether this security feature could be also be used as a
> > performance
> > feature if you are interested in optimizing your kernel layout for
> > a
> > particular workload at boot time. Optimizing function layout for a
> > particular
> > workload has been researched and proven effective - for more
> > information
> > read the Facebook paper "Optimizing Function Placement for Large-
> > Scale
> > Data-Center Applications" (see references section below).
> 
> I'm pretty sure the 'grouping' solution would address any real 
> slowdowns.
> 
> I'd also suggest allowing the passing in of a boot-time pseudo-
> random 
> generator seed number, which would allow the creation of a 
> pseudo-randomized but repeatable layout across reboots.

We talked during the RFC stage of porting the chacha20 code to this
early boot stage to use as a prand generator. Ultimately, this means
you now have a secret you have to protect (the seed), and so I've
dropped this for now. I could see maybe having this as a debug option?
I certainly use a prand myself even now when I'm still debugging
functional issues (although the one I use for my own debugging isn't
suitable for merging).

> 
> > Image Size
> > ----------
> > Adding additional section headers as a result of compiling with
> > -ffunction-sections will increase the size of the vmlinux ELF file.
> > With a standard distro config, the resulting vmlinux was increased
> > by
> > about 3%. The compressed image is also increased due to the header
> > files,
> > as well as the extra relocations that must be added. You can expect
> > fgkaslr
> > to increase the size of the compressed image by about 15%.
> 
> What is the increase of the resulting raw kernel image? Additional 
> relocations might increase its size (unless I'm missing something) - 
> it would be nice to measure this effect. I'd expect this to be
> really 
> low.

By raw kernel image, do you mean just what eventually gets copied into
memory after decompression minus the relocation table? If so, this is
almost no difference - the only difference is that there is a little
bit of change in the padding between sections vs what the non-
randomized kernel is because of alignment differences with the new
layout. so you wind up with a few extra bytes give or take.

> 
> vmlinux or compressed kernel size doesn't really matter on x86-64, 
> it's a boot time only expense well within typical system resource 
> limits.
> 
> > Disabling
> > ---------
> > Disabling normal KASLR using the nokaslr command line option also
> > disables
> > fgkaslr. It is also possible to disable fgkaslr separately by
> > booting with
> > fgkaslr=off on the commandline.
> 
> I'd suggest to also add a 'nofgkaslr' boot option if it doesn't yet 
> exist, to keep usage symmetric with kaslr.
> 
> Likewise, there should probably be a 'kaslr=off' option as well.
> 
> The less random our user interfaces are, the better ...
> 
> >  arch/x86/boot/compressed/Makefile             |   9 +-
> >  arch/x86/boot/compressed/fgkaslr.c            | 811
> > ++++++++++++++++++
> >  arch/x86/boot/compressed/kaslr.c              |   4 -
> >  arch/x86/boot/compressed/misc.c               | 157 +++-
> >  arch/x86/boot/compressed/misc.h               |  30 +
> >  arch/x86/boot/compressed/utils.c              |  11 +
> >  arch/x86/boot/compressed/vmlinux.symbols      |  17 +
> >  arch/x86/include/asm/boot.h                   |  15 +-
> >  arch/x86/kernel/vmlinux.lds.S                 |  17 +-
> >  arch/x86/lib/kaslr.c                          |  18 +-
> >  arch/x86/tools/relocs.c                       | 143 ++-
> >  arch/x86/tools/relocs.h                       |   4 +-
> >  arch/x86/tools/relocs_common.c                |  15 +-
> >  include/asm-generic/vmlinux.lds.h             |  18 +-
> >  include/linux/decompress/mm.h                 |  12 +-
> >  include/uapi/linux/elf.h                      |   1 +
> >  init/Kconfig                                  |  26 +
> >  kernel/kallsyms.c                             | 163 +++-
> >  kernel/module.c                               |  81 ++
> >  tools/objtool/elf.c                           |   8 +-
> >  26 files changed, 1670 insertions(+), 85 deletions(-)
> >  create mode 100644 Documentation/security/fgkaslr.rst
> >  create mode 100644 arch/x86/boot/compressed/fgkaslr.c
> >  create mode 100644 arch/x86/boot/compressed/utils.c
> >  create mode 100644 arch/x86/boot/compressed/vmlinux.symbols
> 
> This looks surprisingly lean overall.

Most of the changes outside of fgkaslr.c, module.c, and kallsyms.c were
little tweaks here and there to accommodate using -ffunction-sections
and handling >64K elf sections, otherwise yes, I tried to keep it very
self contained and non-invasive.


