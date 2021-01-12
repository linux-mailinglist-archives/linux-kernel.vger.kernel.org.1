Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006B92F2E74
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbhALLyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:54:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39564 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbhALLyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:54:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 91B291F452F6
Subject: Re: next/master bisection: baseline.bootrr.clk-mt8173-mm-probed on
 mt8173-elm-hana
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <5ffc97ef.1c69fb81.447c7.037e@mx.google.com>
Cc:     "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-clk@vger.kernel.org
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <429f3c2c-4dbe-39b7-dd93-d73f22425a0f@collabora.com>
Date:   Tue, 12 Jan 2021 11:53:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <5ffc97ef.1c69fb81.447c7.037e@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

Please see the bisection report below about the clk-mt8173-mm and
mtk-mmsys drivers failing to probe on mt8173-elm-hana with
next-20210111.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

Some details can be found here:

  https://kernelci.org/test/plan/id/5ffbeef7f97770d9ccc94cf0/

The bisection was run with CONFIG_ARM64_64K_PAGES=y and only
against the clk-mt8173-mm test case, but it can be reproduced
with a plain arm64 defconfig and the mtk-mmsys driver is also
confirmed to be failing to probe with this patch.

Your commit message acknowledges the fact that it might "break"
some drivers, or rather that some drivers might need to be fixed:

>     If this patch prevents some devices from probing, it's very likely due
>     to the system having one or more device drivers that "probe"/set up a
>     device (DT node with compatible property) without creating a struct
>     device for it. [...]

It sounds like this is what needs to be done here, so I've also
put some MediaTek maintainers on CC.

Thanks,
Guillaume

On 11/01/2021 18:24, KernelCI bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.bootrr.clk-mt8173-mm-probed on mt8173-elm-hana
> 
> Summary:
>   Start:      ef8b014ee4a1 Add linux-next specific files for 20210111
>   Plain log:  https://storage.kernelci.org/next/master/next-20210111/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/clang-11/lab-collabora/baseline-mt8173-elm-hana.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20210111/arm64/defconfig+CONFIG_ARM64_64K_PAGES=y/clang-11/lab-collabora/baseline-mt8173-elm-hana.html
>   Result:     e590474768f1 driver core: Set fw_devlink=on by default
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     mt8173-elm-hana
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   clang-11
>   Config:     defconfig+CONFIG_ARM64_64K_PAGES=y
>   Test case:  baseline.bootrr.clk-mt8173-mm-probed
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit e590474768f1cc04852190b61dec692411b22e2a
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Thu Dec 17 19:17:03 2020 -0800
> 
>     driver core: Set fw_devlink=on by default
>     
>     Cyclic dependencies in some firmware was one of the last remaining
>     reasons fw_devlink=on couldn't be set by default. Now that cyclic
>     dependencies don't block probing, set fw_devlink=on by default.
>     
>     Setting fw_devlink=on by default brings a bunch of benefits (currently,
>     only for systems with device tree firmware):
>     * Significantly cuts down deferred probes.
>     * Device probe is effectively attempted in graph order.
>     * Makes it much easier to load drivers as modules without having to
>       worry about functional dependencies between modules (depmod is still
>       needed for symbol dependencies).
>     
>     If this patch prevents some devices from probing, it's very likely due
>     to the system having one or more device drivers that "probe"/set up a
>     device (DT node with compatible property) without creating a struct
>     device for it.  If we hit such cases, the device drivers need to be
>     fixed so that they populate struct devices and probe them like normal
>     device drivers so that the driver core is aware of the devices and their
>     status. See [1] for an example of such a case.
>     
>     [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
>     Signed-off-by: Saravana Kannan <saravanak@google.com>
>     Link: https://lore.kernel.org/r/20201218031703.3053753-6-saravanak@google.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4e15193aafad..e61e62b624ce 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1457,7 +1457,7 @@ static void device_links_purge(struct device *dev)
>  #define FW_DEVLINK_FLAGS_RPM		(FW_DEVLINK_FLAGS_ON | \
>  					 DL_FLAG_PM_RUNTIME)
>  
> -static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_PERMISSIVE;
> +static u32 fw_devlink_flags = FW_DEVLINK_FLAGS_ON;
>  static int __init fw_devlink_setup(char *arg)
>  {
>  	if (!arg)
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [5625dcfbbcf892e40e8d60abbb5f56701a1d031c] Documentation: kbuild: Fix section reference
> git bisect good 5625dcfbbcf892e40e8d60abbb5f56701a1d031c
> # bad: [ef8b014ee4a1ccd9e751732690a8c7cdeed945e7] Add linux-next specific files for 20210111
> git bisect bad ef8b014ee4a1ccd9e751732690a8c7cdeed945e7
> # good: [2233cdbefdf4ba65cd69c80708ee7e6b1c8ab3e5] Merge remote-tracking branch 'v4l-dvb/master'
> git bisect good 2233cdbefdf4ba65cd69c80708ee7e6b1c8ab3e5
> # good: [c337ba6fa02b1f2984ab6f97f3a17843313bdb25] Merge remote-tracking branch 'keys/keys-next'
> git bisect good c337ba6fa02b1f2984ab6f97f3a17843313bdb25
> # bad: [967973bebd34bffe1426ae93e886cdce1aacfcc2] Merge remote-tracking branch 'tty/tty-next'
> git bisect bad 967973bebd34bffe1426ae93e886cdce1aacfcc2
> # good: [ad596f5fbfab93493f928003b297c5e766cf54a2] sched/idle: Fix missing need_resched() check after rcu_idle_enter()
> git bisect good ad596f5fbfab93493f928003b297c5e766cf54a2
> # good: [fdf6c4ae933617fc7bbc7db73db297f5f74849f9] Merge remote-tracking branch 'leds/for-next'
> git bisect good fdf6c4ae933617fc7bbc7db73db297f5f74849f9
> # bad: [95d0b5d0ceb2e915c22ed4a9b513827309d09b0f] Merge remote-tracking branch 'usb/usb-next'
> git bisect bad 95d0b5d0ceb2e915c22ed4a9b513827309d09b0f
> # good: [77adb8bdf4227257e26b7ff67272678e66a0b250] usb: dwc3: gadget: Allow runtime suspend if UDC unbinded
> git bisect good 77adb8bdf4227257e26b7ff67272678e66a0b250
> # good: [c13b827927112ba6170bea31c638a8573c127461] driver core: fw_devlink_relax_cycle() can be static
> git bisect good c13b827927112ba6170bea31c638a8573c127461
> # good: [841081d89d5adf96759f2df50185de950f5d8694] usb: usbip: Use DEFINE_SPINLOCK() for spinlock
> git bisect good 841081d89d5adf96759f2df50185de950f5d8694
> # bad: [0fab972eef49ef8d30eb91d6bd98861122d083d1] drivers: core: Detach device from power domain on shutdown
> git bisect bad 0fab972eef49ef8d30eb91d6bd98861122d083d1
> # bad: [e590474768f1cc04852190b61dec692411b22e2a] driver core: Set fw_devlink=on by default
> git bisect bad e590474768f1cc04852190b61dec692411b22e2a
> # first bad commit: [e590474768f1cc04852190b61dec692411b22e2a] driver core: Set fw_devlink=on by default
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#5341): https://groups.io/g/kernelci-results/message/5341
> Mute This Topic: https://groups.io/mt/79603430/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

