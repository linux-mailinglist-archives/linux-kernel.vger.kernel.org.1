Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A0A2F3222
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbhALNrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbhALNrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:47:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7D3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:46:19 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u25so3463961lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUIKCpUKReMr/JYvFfQwd9aS5HK3jnQQOYSmK2imVXg=;
        b=HEUPQs/jNT58qii4W8Ufq9ftt6Al3GZ8JkfCttYzOsxA0Xb2jcxoHWXn55Amxs6kJo
         JnPHAgAD/g+flPi5esI6tM6IwPXxHOrxvCssMfYuKmI0icdqaQY5MlD6BLCe1NNFztRz
         W5giyROBrpdsajI0NkRLazqUE+9b3UZy/qf8/uXwn2zN3ZEGnqTuYHHP1hy+DY1wW3VN
         6jtINof/PjBCLQPS09pCdo8eFi/9QQn807JAPNVTL6G9WJAMzJ2tsuviDsX9h3pHu38P
         eT7Nqu/QuC7qJ50/CdMq4ICVqWJcXvWSyfZBAxcPUDWwbFMMPd08QqPnwtg6SFXB2DeI
         PcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUIKCpUKReMr/JYvFfQwd9aS5HK3jnQQOYSmK2imVXg=;
        b=lY8JQF1ArjcGESWPKJORYFHLFoF6SjxAbd1e09U+4eISOCYaBjf+7aG8qcAmuNPE3V
         2wIScHsN/vciHUlBFnhIR3DPAOOCJ3/PByJ7JiAI/59Vxb3876ZMpLmVpa3xGwhMhRAJ
         I9e7wkeXONNeNCTY3syrgkLguzLUVyQlLuwfZ8dYKObWLBm1eMSwL6ubbDR0rVlytNCc
         I+10R1t+5AcaUeytXZm9Km6ENShqQLiQPgh8jW9PYr+Nn5vBCqwftEbfLGhb7IHD7QXb
         oJIwMqWzJjs7ap3oUvoS7lN8Hira4U0F2cr8yO6WDn814osGrN1958h6zR5dZfpTi+sK
         a4aw==
X-Gm-Message-State: AOAM532sq4H+QDl5cG7oypbiWnmJ9sI3ZoSRV58HDrWm2oZBb5/4dHuZ
        MhsGeIRRF+M9RVGRKLwE0CagbnZQHIVrRf85uLbrLg==
X-Google-Smtp-Source: ABdhPJwSMYEL8ooY0JTbtpPBq5NfVURin6bnlITzB59QS6rwLGxAHy60AZkJQ1m9gL03ugqI0Fj6pCIaqVN/oEVlTQo=
X-Received: by 2002:a19:2d0a:: with SMTP id k10mr2398585lfj.286.1610459178017;
 Tue, 12 Jan 2021 05:46:18 -0800 (PST)
MIME-Version: 1.0
References: <5ffbe3de.1c69fb81.ea87c.a145@mx.google.com> <85cdd7c0-d01a-ec8a-cb83-54953cb78789@collabora.com>
In-Reply-To: <85cdd7c0-d01a-ec8a-cb83-54953cb78789@collabora.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Jan 2021 14:46:06 +0100
Message-ID: <CAKfTPtA9Z+dCskqSh3atgOxMRdJi-nzQD_MrUpL8yuRw_UrCCw@mail.gmail.com>
Subject: Re: pmwg/integ bisection: baseline.login on rk3328-rock64
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Anson Huang <Anson.Huang@nxp.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume

On Tue, 12 Jan 2021 at 12:25, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Hi Vincent,
>
> Please see the bisection report below about a boot failure on
> rk3328-rock64 with the pwmg/integ branch.
>
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.

Thanks for the report. I'm going to have a deeper look.

The culprit patch is there to set defconfig for running some of our
tests on hikey and hikey960 boards and doesn't aim to be merged
upstream.
It sets some scheduler features: disable auto group because I run
tests related to cgroups and scheduler. But those are generics
It enables default trace events which are generic too
And It enables some hikey specific config.
TBH I don't see any straightforward relation with rockchip.
As a 1st guess I would say that it is related to trace events.

>
> There's nothing in the serial console log, probably because it's
> crashing too early during boot.
>
> Some details can be found here:
>
>   https://kernelci.org/test/case/id/5ffb978de38e717501c94cd8/
>
> The bisection was run with CONFIG_RANDOMIZE_BASE=y enabled, but
> the same issue occurs with a plain defconfig from that branch.
> Results with other configs and platforms can be compared here:
>
>   https://kernelci.org/test/job/pmwg/branch/integ/kernel/v5.11-rc3-13-gcea05edf93998/plan/baseline/
>
> Please let us know if you need some help to test a fix or debug
> the issue.

I don't have any rockchip board on which I can run tests but I can
push an updated version of the patch without trace events if this can
then be then tested on kernelci rockchip board.

Regards,
Vincent

>
> Thanks,
> Guillaume
>
>
> On 11/01/2021 05:36, KernelCI bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > pmwg/integ bisection: baseline.login on rk3328-rock64
> >
> > Summary:
> >   Start:      cea05edf9399 Merge remote-tracking branch 'georgi.db845c/db845c-fixes' into integ
> >   Plain log:  https://storage.kernelci.org/pmwg/integ/v5.11-rc3-13-gcea05edf93998/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-rk3328-rock64.txt
> >   HTML log:   https://storage.kernelci.org/pmwg/integ/v5.11-rc3-13-gcea05edf93998/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-rk3328-rock64.html
> >   Result:     31379ec3d17b arm64/hikey: update defconfig
> >
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >
> > Parameters:
> >   Tree:       pmwg
> >   URL:        https://git.linaro.org/power/linux.git
> >   Branch:     integ
> >   Target:     rk3328-rock64
> >   CPU arch:   arm64
> >   Lab:        lab-baylibre
> >   Compiler:   gcc-8
> >   Config:     defconfig+CONFIG_RANDOMIZE_BASE=y
> >   Test case:  baseline.login
> >
> > Breaking commit found:
> >
> > -------------------------------------------------------------------------------
> > commit 31379ec3d17bf215585f1bac15eff77351830d37
> > Author: Vincent Guittot <vincent.guittot@linaro.org>
> > Date:   Tue Nov 17 10:02:58 2020 +0100
> >
> >     arm64/hikey: update defconfig
> >
> >     Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 5cfe3cf6f2ac..4d2e85c7f96b 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -12,9 +12,11 @@ CONFIG_TASK_IO_ACCOUNTING=y
> >  CONFIG_IKCONFIG=y
> >  CONFIG_IKCONFIG_PROC=y
> >  CONFIG_NUMA_BALANCING=y
> > +CONFIG_CGROUPS=y
> >  CONFIG_MEMCG=y
> >  CONFIG_MEMCG_SWAP=y
> >  CONFIG_BLK_CGROUP=y
> > +CONFIG_CGROUP_SCHED=y
> >  CONFIG_CGROUP_PIDS=y
> >  CONFIG_CGROUP_HUGETLB=y
> >  CONFIG_CPUSETS=y
> > @@ -22,7 +24,6 @@ CONFIG_CGROUP_DEVICE=y
> >  CONFIG_CGROUP_CPUACCT=y
> >  CONFIG_CGROUP_PERF=y
> >  CONFIG_USER_NS=y
> > -CONFIG_SCHED_AUTOGROUP=y
> >  CONFIG_BLK_DEV_INITRD=y
> >  CONFIG_KALLSYMS_ALL=y
> >  # CONFIG_COMPAT_BRK is not set
> > @@ -83,7 +84,6 @@ CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> >  CONFIG_CPU_FREQ_GOV_USERSPACE=y
> >  CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> >  CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> > -CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> >  CONFIG_CPUFREQ_DT=y
> >  CONFIG_ACPI_CPPC_CPUFREQ=m
> >  CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM=m
> > @@ -264,6 +264,7 @@ CONFIG_VIRTIO_BLK=y
> >  CONFIG_BLK_DEV_NVME=m
> >  CONFIG_SRAM=y
> >  CONFIG_PCI_ENDPOINT_TEST=m
> > +CONFIG_HISI_HIKEY_USB=m
> >  CONFIG_EEPROM_AT24=m
> >  CONFIG_EEPROM_AT25=m
> >  CONFIG_UACCE=m
> > @@ -768,9 +769,13 @@ CONFIG_USB_CONFIGFS_RNDIS=y
> >  CONFIG_USB_CONFIGFS_EEM=y
> >  CONFIG_USB_CONFIGFS_MASS_STORAGE=y
> >  CONFIG_USB_CONFIGFS_F_FS=y
> > +CONFIG_USB_ETH=m
> >  CONFIG_TYPEC=m
> >  CONFIG_TYPEC_TCPM=m
> > +CONFIG_TYPEC_TCPCI=m
> > +CONFIG_TYPEC_RT1711H=m
> >  CONFIG_TYPEC_FUSB302=m
> > +CONFIG_TYPEC_UCSI=m
> >  CONFIG_TYPEC_HD3SS3220=m
> >  CONFIG_MMC=y
> >  CONFIG_MMC_BLOCK_MINORS=32
> > @@ -997,6 +1002,7 @@ CONFIG_PHY_XGENE=y
> >  CONFIG_PHY_SUN4I_USB=y
> >  CONFIG_PHY_MIXEL_MIPI_DPHY=m
> >  CONFIG_PHY_HI6220_USB=y
> > +CONFIG_PHY_HI3660_USB=m
> >  CONFIG_PHY_HISTB_COMBPHY=y
> >  CONFIG_PHY_HISI_INNO_USB2=y
> >  CONFIG_PHY_MVEBU_CP110_COMPHY=y
> > @@ -1059,7 +1065,6 @@ CONFIG_CUSE=m
> >  CONFIG_OVERLAY_FS=m
> >  CONFIG_VFAT_FS=y
> >  CONFIG_HUGETLBFS=y
> > -CONFIG_CONFIGFS_FS=y
> >  CONFIG_EFIVAR_FS=y
> >  CONFIG_SQUASHFS=y
> >  CONFIG_NFS_FS=y
> > @@ -1088,7 +1093,6 @@ CONFIG_DEBUG_INFO=y
> >  CONFIG_MAGIC_SYSRQ=y
> >  CONFIG_DEBUG_FS=y
> >  CONFIG_DEBUG_KERNEL=y
> > -# CONFIG_SCHED_DEBUG is not set
> >  # CONFIG_DEBUG_PREEMPT is not set
> > -# CONFIG_FTRACE is not set
> > +CONFIG_ENABLE_DEFAULT_TRACERS=y
> >  CONFIG_MEMTEST=y
> > -------------------------------------------------------------------------------
> >
> >
> > Git bisection log:
> >
> > -------------------------------------------------------------------------------
> > git bisect start
> > # good: [7c53f6b671f4aba70ff15e1b05148b10d58c2837] Linux 5.11-rc3
> > git bisect good 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> > # bad: [cea05edf939988c7b305d54041dfb471e0ab7765] Merge remote-tracking branch 'georgi.db845c/db845c-fixes' into integ
> > git bisect bad cea05edf939988c7b305d54041dfb471e0ab7765
> > # bad: [3c4d0637f972ca8bf05255916c12c93603887c2d] Merge remote-tracking branch 'vincent.hikey/test/hikey' into integ
> > git bisect bad 3c4d0637f972ca8bf05255916c12c93603887c2d
> > # good: [e593d63655e8104e5eb84b76730f904161e03460] Merge remote-tracking branch 'vincent.guittot/test/scheduler' into integ
> > git bisect good e593d63655e8104e5eb84b76730f904161e03460
> > # bad: [31379ec3d17bf215585f1bac15eff77351830d37] arm64/hikey: update defconfig
> > git bisect bad 31379ec3d17bf215585f1bac15eff77351830d37
> > # good: [782ed9d18ed9c1aee357a327ac6bfdd50a86d6eb] amr64/hikey: disable hearthbeat led
> > git bisect good 782ed9d18ed9c1aee357a327ac6bfdd50a86d6eb
> > # first bad commit: [31379ec3d17bf215585f1bac15eff77351830d37] arm64/hikey: update defconfig
> > -------------------------------------------------------------------------------
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Groups.io Links: You receive all messages sent to this group.
> > View/Reply Online (#5316): https://groups.io/g/kernelci-results/message/5316
> > Mute This Topic: https://groups.io/mt/79590195/924702
> > Group Owner: kernelci-results+owner@groups.io
> > Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >
>
