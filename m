Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6382AF936
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgKKTlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKKTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:41:46 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2184FC0613D1;
        Wed, 11 Nov 2020 11:41:46 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id cw8so4346836ejb.8;
        Wed, 11 Nov 2020 11:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EASD0693KjJDiR768N0y2/nnOqHUP/KVeiMD8uj/xHs=;
        b=EYtO2m6qwLaNhdZcTBIZubv5E0Jycfd2Ig/TOJID8j1jL7YEvdYZIjcAsmui591kXm
         Z2FVALKNsDB0rB5FJHdYbRx6R+fU3gFjV2qnSV3JxMmkp8vPao59dh83Pgbm4/w/3q9/
         afXjbc9O2zQ3Qi1btd/6cZphv//K6sWgtIAOqqaOSdSr3iBZPEhvoTVOnzIftmoEqVtP
         0ABjonTTORwu30wfh0y92m38o9o+24wdqhbJgG+SQGMmzVK0GJjrZTncJoyHgnyCLq75
         1YEyII5t3NOuwMIZBpCE9vMIwJcJqwXwM4/9wza968leLjmtUoArBhTGxAT9ovLJpZJm
         gy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EASD0693KjJDiR768N0y2/nnOqHUP/KVeiMD8uj/xHs=;
        b=P1+TYulCR6fQL5pBRG8J9iQ3ecQRVS7wCXn6V350XFIxne4iL2C9CeEL4sFtG1p293
         jU9uontrJ62pqgYfg8GFmO/E+VkBpTOmGzq1gV6atFQ27YWaGgsYg6V4v1TRjKF/yDXQ
         vG+1FnI6gzndCcN4p7FI4w73bbnURMy4g629QtMU+M9XhmVZwukY5qPRowwcUN8L2Taa
         xHtlukYS19AMbY+t1xvLwNox4JDhNvx/Q294j0oGnU/BOszGMYtlc4Ry1j64BOUcyEfP
         UpVGKk997j07Qbn9aiHJBYNXv1fqhBwOPV5Le1nK4YgobYKkn+DinqeL5xe5EozLmZLc
         vC3g==
X-Gm-Message-State: AOAM533phTonweHck4732NKvoWcWhu0mmY2dcejzYgloydZROyZFRjTQ
        ++FhrMc20Or6RxA1aLvsEiYyAb+Iwpq90MIsj5A=
X-Google-Smtp-Source: ABdhPJyRmR9rUdslGE3DuYug8PK8EFxCwcPWYN1KX066goJwiA6/E/eM0Nh0M5pOqUiSE99r+kV3uFS6bxUZ5iE7EJ8=
X-Received: by 2002:a17:906:f8c5:: with SMTP id lh5mr18267633ejb.77.1605123704716;
 Wed, 11 Nov 2020 11:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201111030136.GD8486@MiWiFi-R3L-srv> <04a893e6-1412-5fa8-8dbd-8ec278879965@huawei.com>
In-Reply-To: <04a893e6-1412-5fa8-8dbd-8ec278879965@huawei.com>
From:   Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date:   Thu, 12 Nov 2020 01:11:33 +0530
Message-ID: <CAFTCetTOwgVXryN9n22NSp91wbFqCiykx9Z7hs65AYSdSNmeVg@mail.gmail.com>
Subject: Re: [PATCH v13 0/8] support reserving crashkernel above 4G on arm64 kdump
To:     chenzhou <chenzhou10@huawei.com>
Cc:     Baoquan He <bhe@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>,
        Simon Horman <horms@verge.net.au>, John.P.donnelly@oracle.com,
        guohanjun@huawei.com, xiexiuqi@huawei.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        wangkefeng.wang@huawei.com, mingo@redhat.com,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, huawei.libin@huawei.com,
        prabhakar.pkin@gmail.com, tglx@linutronix.de,
        Dave Young <dyoung@redhat.com>, nsaenzjulienne@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On Wed, Nov 11, 2020 at 7:05 PM chenzhou <chenzhou10@huawei.com> wrote:
>
> Hi Baoquan, Bhupesh,
>
>
> On 2020/11/11 11:01, Baoquan He wrote:
> > Hi Zhou, Bhupesh
> >
> > On 10/31/20 at 03:44pm, Chen Zhou wrote:
> >> There are following issues in arm64 kdump:
> >> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> >> will fail when there is no enough low memory.
> >> 2. If reserving crashkernel above 4G, in this case, crash dump
> >> kernel will boot failure because there is no low memory available
> >> for allocation.
> >> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
> >> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
> >> the devices in crash dump kernel need to use ZONE_DMA will alloc
> >> fail.
> > I went through this patchset, mainly the x86 related and generic
> > changes, the changes look great and no risk. And I know Bhupesh is
> > following up this and helping review, thanks, both.
> >
> > So you have also tested crashkernel reservation on x86_64, with the
> > normal reservation, and high/low reservation, it is working well,
> > right? Asking this because I didn't see the test result description, and
> > just note it.
>
> Yeah, i also tested on x86_64 and work well. I did these basic tests before sending every
> new version.
> But Bhupesh may have some review comments(Bhupesh referred one month ago).

Sorry for the late response. I was caught up in some other urgent
issues. I have just started reviewing
this series and will have more updates in a day or two. I am also
testing the same on x86_64 and arm64 machines and will share the test
observations soon as well.

Thanks for your patience.
Regards,
Bhupesh

> >> To solve these issues, change the behavior of crashkernel=X.
> >> crashkernel=X tries low allocation in DMA zone (or the DMA32 zone if
> >> CONFIG_ZONE_DMA is disabled), and fall back to high allocation if it fails.
> >>
> >> We can also use "crashkernel=X,high" to select a high region above
> >> DMA zone, which also tries to allocate at least 256M low memory in
> >> DMA zone automatically (or the DMA32 zone if CONFIG_ZONE_DMA is disabled).
> >> "crashkernel=Y,low" can be used to allocate specified size low memory.
> >>
> >> When reserving crashkernel in high memory, some low memory is reserved
> >> for crash dump kernel devices. So there may be two regions reserved for
> >> crash dump kernel.
> >> In order to distinct from the high region and make no effect to the use
> >> of existing kexec-tools, rename the low region as "Crash kernel (low)",
> >> and pass the low region by reusing DT property
> >> "linux,usable-memory-range". We made the low memory region as the last
> >> range of "linux,usable-memory-range" to keep compatibility with existing
> >> user-space and older kdump kernels.
> >>
> >> Besides, we need to modify kexec-tools:
> >> arm64: support more than one crash kernel regions(see [1])
> >>
> >> Another update is document about DT property 'linux,usable-memory-range':
> >> schemas: update 'linux,usable-memory-range' node schema(see [2])
> >>
> >> This patchset contains the following eight patches:
> >> 0001-x86-kdump-replace-the-hard-coded-alignment-with-macr.patch
> >> 0002-x86-kdump-make-the-lower-bound-of-crash-kernel-reser.patch
> >> 0003-x86-kdump-use-macro-CRASH_ADDR_LOW_MAX-in-functions-.patch
> >> 0004-x86-kdump-move-reserve_crashkernel-_low-into-crash_c.patch
> >> 0005-arm64-kdump-introduce-some-macroes-for-crash-kernel-.patch
> >> 0006-arm64-kdump-reimplement-crashkernel-X.patch
> >> 0007-arm64-kdump-add-memory-for-devices-by-DT-property-li.patch
> >> 0008-kdump-update-Documentation-about-crashkernel.patch
> >>
> >> 0001-0003 are some x86 cleanups which prepares for making
> >> functionsreserve_crashkernel[_low]() generic.
> >> 0004 makes functions reserve_crashkernel[_low]() generic.
> >> 0005-0006 reimplements arm64 crashkernel=X.
> >> 0007 adds memory for devices by DT property linux,usable-memory-range.
> >> 0008 updates the doc.
> >>
> >> Changes since [v12]
> >> - Rebased on top of 5.10-rc1.
> >> - Keep CRASH_ALIGN as 16M suggested by Dave.
> >> - Drop patch "kdump: add threshold for the required memory".
> >> - Add Tested-by from John.
> >>
> >> Changes since [v11]
> >> - Rebased on top of 5.9-rc4.
> >> - Make the function reserve_crashkernel() of x86 generic.
> >> Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
> >> and arm64 use the generic version to reimplement crashkernel=X.
> >>
> >> Changes since [v10]
> >> - Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.
> >>
> >> Changes since [v9]
> >> - Patch 1 add Acked-by from Dave.
> >> - Update patch 5 according to Dave's comments.
> >> - Update chosen schema.
> >>
> >> Changes since [v8]
> >> - Reuse DT property "linux,usable-memory-range".
> >> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
> >> memory region.
> >> - Fix kdump broken with ZONE_DMA reintroduced.
> >> - Update chosen schema.
> >>
> >> Changes since [v7]
> >> - Move x86 CRASH_ALIGN to 2M
> >> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> >> - Update Documentation/devicetree/bindings/chosen.txt.
> >> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
> >> suggested by Arnd.
> >> - Add Tested-by from Jhon and pk.
> >>
> >> Changes since [v6]
> >> - Fix build errors reported by kbuild test robot.
> >>
> >> Changes since [v5]
> >> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> >> - Delete crashkernel=X,high.
> >> - Modify crashkernel=X,low.
> >> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> >> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> >> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> >> pass to crash dump kernel by DT property "linux,low-memory-range".
> >> - Update Documentation/admin-guide/kdump/kdump.rst.
> >>
> >> Changes since [v4]
> >> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> >>
> >> Changes since [v3]
> >> - Add memblock_cap_memory_ranges back for multiple ranges.
> >> - Fix some compiling warnings.
> >>
> >> Changes since [v2]
> >> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> >> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> >> patch.
> >>
> >> Changes since [v1]:
> >> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> >> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> >> in fdt_enforce_memory_region().
> >> There are at most two crash kernel regions, for two crash kernel regions
> >> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> >> and then remove the memory range in the middle.
> >>
> >> [1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
> >> [2]: https://github.com/robherring/dt-schema/pull/19
> >> [v1]: https://lkml.org/lkml/2019/4/2/1174
> >> [v2]: https://lkml.org/lkml/2019/4/9/86
> >> [v3]: https://lkml.org/lkml/2019/4/9/306
> >> [v4]: https://lkml.org/lkml/2019/4/15/273
> >> [v5]: https://lkml.org/lkml/2019/5/6/1360
> >> [v6]: https://lkml.org/lkml/2019/8/30/142
> >> [v7]: https://lkml.org/lkml/2019/12/23/411
> >> [v8]: https://lkml.org/lkml/2020/5/21/213
> >> [v9]: https://lkml.org/lkml/2020/6/28/73
> >> [v10]: https://lkml.org/lkml/2020/7/2/1443
> >> [v11]: https://lkml.org/lkml/2020/8/1/150
> >> [v12]: https://lkml.org/lkml/2020/9/7/1037
> >>
> >> Chen Zhou (8):
> >>   x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
> >>   x86: kdump: make the lower bound of crash kernel reservation
> >>     consistent
> >>   x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
> >>     reserve_crashkernel()
> >>   x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
> >>   arm64: kdump: introduce some macroes for crash kernel reservation
> >>   arm64: kdump: reimplement crashkernel=X
> >>   arm64: kdump: add memory for devices by DT property
> >>     linux,usable-memory-range
> >>   kdump: update Documentation about crashkernel
> >>
> >>  Documentation/admin-guide/kdump/kdump.rst     |  23 ++-
> >>  .../admin-guide/kernel-parameters.txt         |  12 +-
> >>  arch/arm64/include/asm/kexec.h                |  15 ++
> >>  arch/arm64/include/asm/processor.h            |   1 +
> >>  arch/arm64/kernel/setup.c                     |  13 +-
> >>  arch/arm64/mm/init.c                          | 105 ++++-------
> >>  arch/arm64/mm/mmu.c                           |   4 +
> >>  arch/x86/include/asm/kexec.h                  |  28 +++
> >>  arch/x86/kernel/setup.c                       | 153 +---------------
> >>  include/linux/crash_core.h                    |   4 +
> >>  include/linux/kexec.h                         |   2 -
> >>  kernel/crash_core.c                           | 168 ++++++++++++++++++
> >>  kernel/kexec_core.c                           |  17 --
> >>  13 files changed, 301 insertions(+), 244 deletions(-)
> >>
> >> --
> >> 2.20.1
> >>
> > .
> >
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
