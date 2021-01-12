Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A052F2DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbhALLbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:31:41 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53430 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbhALLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:31:40 -0500
Received: by mail-wm1-f49.google.com with SMTP id k10so1604510wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oCzTEVCcpHeTixYYulm8kuJjhoqZkFV/jPq3t9iFZAs=;
        b=Ym8jlobj1n1wD99e84JdiFz068b3YjN2iLutM6j6vXYcxGaI6YqdFcADM2o78ZH30B
         h/qbvoQ/8Re186dav+ZfL9cMcdPLQa3UgYGag1phaS2pqYpwwslzz//bQ74MSYNCMOyN
         ynHWl0Tn7S16sx+cZiAYV2cG+ylRxmw3BMCae6FuRoZY7qzjbw7R/+UrjHe12EmUzV1h
         DhmJWis7Rrl7VElcvcDRnL80wBIp9Z4AeHpiA+vxsJYJBF2kVXqVvf5fTLe7RgXRDde1
         py/8mJI2iioycXASq4GBiGbZxSQQtVg+u8Jiyim7Ti7dJytqtL4XSyg6gVIYelQj3lFj
         YqXw==
X-Gm-Message-State: AOAM531XXXNAHNNAm8sdbkaaslndOZUrbNoa9RstoWEoDwzb0JqMGpDB
        eFNDB6Bz3WZqegwuD3Z1cRg=
X-Google-Smtp-Source: ABdhPJxPWHz46y0LJ399R5L88o2bJ91vGKb1xzhkc6zqGsTMiIoe2qG7NFqhY9OKPNO2PtXETtiF2g==
X-Received: by 2002:a1c:2605:: with SMTP id m5mr3163791wmm.111.1610451057501;
        Tue, 12 Jan 2021 03:30:57 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id w13sm4326931wrt.52.2021.01.12.03.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 03:30:56 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:30:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Anson Huang <Anson.Huang@nxp.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: pmwg/integ bisection: baseline.login on rk3328-rock64
Message-ID: <20210112113055.GA19845@kozik-lap>
References: <5ffbe3de.1c69fb81.ea87c.a145@mx.google.com>
 <85cdd7c0-d01a-ec8a-cb83-54953cb78789@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85cdd7c0-d01a-ec8a-cb83-54953cb78789@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:25:25AM +0000, Guillaume Tucker wrote:
> Hi Vincent,
> 
> Please see the bisection report below about a boot failure on
> rk3328-rock64 with the pwmg/integ branch.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
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

Hi all,

Regardless of this bisected issue, such commit and its description is
not good.  Multiple entries are added and removed - no clue why. Was it
savedefconfig? Maybe yes, maybe no, who knows... If yes, it should be
reverted because savedefconfig is known to remove important features
*later* (vide DEBUG_FS in the past).

Instead, commit should explicitly explain for each item why this is
added or removed.

Best regards,
Krzysztof


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
