Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2927D2CF2BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgLDRI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:08:27 -0500
Received: from mout01.posteo.de ([185.67.36.65]:37680 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgLDRI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:08:26 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9EAFE16005C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 18:07:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607101648; bh=vOF7YijQDGoXFoCAEY7Jtz2xeXsFata2nmuA6EvDRiI=;
        h=Date:From:To:Cc:Subject:From;
        b=q62EwsZ5BRD/XQ/ofk5gft+3hWujguO55UHLPtDOWJZmsL7e6i72rfgI3QqUgAbBA
         nU9Diu70vGuzHk7V4UfHmAIr7l6ml2nNw6QvifOOiwyeextebrcjRqaRUFtXIsccxz
         5MstC+yqb6pqOKJr2YCxDAlwB2k5oHp7Q3/zYg+zRJDS0az+XjID7HmtNI0ge3ovzq
         A96gGjI/P2jFZ/W5ne7NE+HrjovNHsb1MhU88KatDCFGQz3G7oAj4oQnzI4bhwk4sG
         dEcpVgy9zhrD5/bh1gfu6pKGC2x31YhJuzwpcItefMm+YDVHes/9Ff9iPHUTjYinlT
         WCB3+9pnUWCrw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CnfJv5SfXz9rxT;
        Fri,  4 Dec 2020 18:07:27 +0100 (CET)
Date:   Fri, 4 Dec 2020 18:07:25 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v2 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201204180725.62698c50@monster.powergraphx.local>
In-Reply-To: <20201204162117.u7fevtxkktuiqncv@gilmour>
References: <cover.1607094989.git.wilken.gottwalt@posteo.net>
        <c03d114477b887048ea0348dbfd1adb53c139e9f.1607094989.git.wilken.gottwalt@posteo.net>
        <20201204162117.u7fevtxkktuiqncv@gilmour>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 17:21:17 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> On Fri, Dec 04, 2020 at 04:35:12PM +0100, Wilken Gottwalt wrote:
> > Adds the sunxi_hwspinlock driver for the hardware spinlock unit found in
> > most of the sun8i and sun50i based SoCs.
> > 
> > This unit provides at least 32 spinlocks in hardware. The implementation
> > supports 32, 64, 128 or 256 32bit registers, where one lock can be taken
> > by reading a register and released by writing a 0 to it. This driver
> > supports all 4 spinlock setups, but for now only the first setup (32
> > locks) seem to exist in available devices. This spinlock unit is shared
> > between all ARM cores and the embedded OpenRisc AR100 core, all of them
> > can take/release a lock with a single cycle operation. It can be used to
> > sync access to devices shared by the ARM cores and the OpenRisc core.
> > 
> > There are two ways to check if a lock is taken. The first way is to read
> > a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> > is returned, the caller has to try again, which means the lock is
> > currently taken. The second way is to read a 32bit wide status register
> > where every bit represents one of the 32 first locks. According to the
> > datasheets this status register supports the 32 first locks only. For
> > this reason the lock read/write approach is used in this driver which
> > can cover all 256 locks in the biggest setup.
> > 
> > Being able to use the status register to get knowledge about the locks
> > makes it suitable to extended testing. It also can be used to bypass
> > the Linux hwspinlock ABI completely and is not able to set locks. This
> > is used in one of the tests to show that the driver works correctly.
> > 
> > To run all tests it is necessary to take locks on the OpenRisc core and
> > show on the Linux side that the locks were taken by an external event.
> > This can be achived by using the crust firmware. For this the crust
> > firmware needs to be changed to take and release spinlocks (a simple
> > MMIO operation on the hwlock registers), which is currently not
> > supported by the current crust firmware. The necessary crust fork can
> > be found here https://github.com/wgottwalt/crust (hwspinlock branch).
> > It is also necessary to build u-boot with support for this crust/SCP
> > firmware. This u-boot fork can be found here
> > https://github.com/crust-firmware/u-boot (crust branch). For testing
> > this driver it is also necessary to pick a device that is fully
> > supported by crust. In this case a H5 based device works very well. In
> > this test a Friendlyarm NanoPi NEO2 was used, which is fully supported
> > by u-boot (also the fork) and current Linux kernels. In the crust fork
> > it is necessary to go into debug menu of "make nconfig" and select the
> > hwspinlock test loop, which uses the timeout functions of the crust
> > firmware. It loops through the first 32 spinlocks and takes/releases a
> > lock one after another using a timeout which can be set in the debug
> > menu.
> > 
> > Test 1:
> > This test was done with a mainline u-boot and a crust enabled u-boot.
> > For this a simple second kernel module was used, found here
> > https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/test_module.
> > 
> > If run with mainline u-boot it shows that the Linux side correctly
> > takes a lock, tries to recursively take a lock again (which does not
> > happen) and releases a lock. Done for all 32 locks several times.
> > 
> > [  122.518435] [init]--- SUNXI HWSPINLOCK DRIVER TEST ---
> > [  122.523810] [run ]--- testing locks 0 to 31 ---
> > [  122.528370] [test] testing lock 0
> > [  122.531686] [test]+++ attempt #0 succeded
> > [  122.535709] [test]+++ attempt #1 succeded
> > [  122.539729] [test]+++ attempt #2 succeded
> > [  122.543752] [test] testing lock 1
> > [  122.547072] [test]+++ attempt #0 succeded
> > [  122.551093] [test]+++ attempt #1 succeded
> > [  122.555113] [test]+++ attempt #2 succeded
> > [  122.559129] [test] testing lock 2
> > ...
> > [  123.004812] [test] testing lock 31
> > [  123.008208] [test]+++ attempt #0 succeded
> > [  123.012228] [test]+++ attempt #1 succeded
> > [  123.016250] [test]+++ attempt #2 succeded
> > 
> > Same test run with the hwspinlock test loop enabled in crust. Here the
> > test module hits two locks exactly in the moment crust switches from
> > lock 7 to 8. The test module code path is slower because of more code
> > that needs to be executed which makes this rare scenario possible.
> > 
> > [  122.620656] [test] testing lock 6
> > [  122.623966] [test]+++ attempt #0 succeded
> > [  122.627988] [test]+++ attempt #1 succeded
> > [  122.632008] [test]+++ attempt #2 succeded
> > [  122.636044] [test] testing lock 7
> > [  122.639364] [test] taking lock attempt #0 failed (-16)
> > [  122.644507] [run ]--- testing specific lock 7 failed (-14) ---
> > [  122.650345] [test] testing lock 8
> > [  122.653671] [test] taking lock attempt #0 failed (-16)
> > [  122.658818] [run ]--- testing specific lock 8 failed (-14) ---
> > [  122.664658] [test] testing lock 9
> > [  122.667971] [test]+++ attempt #0 succeded
> > [  122.671989] [test]+++ attempt #1 succeded
> > 
> > Test 2:
> > This is a more complex test that uses the status register to bypass the
> > Linux hwspinlock ABI. For this to work a slightly modified driver is
> > used and can be found here
> > https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/
> > modified_sunxi_hwspinlock
> > This modified driver splits the 4K memory range into two and leaves the
> > status register untouched, so that it can be used by another test kernel
> > module which can be found here
> > https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/test2_module
> > It is also necessary to change the device tree entries to get both
> > kernel modules working in parallel.
> > 
> > hwspinlock-mod@1c18000 {
> >         compatible = "allwinner,sun50i-hwspinlock-mod";
> >         reg = <0x01c18000 0x4 0x01c18100 0x400>;
> >         clocks = <&ccu CLK_BUS_SPINLOCK>;
> >         clock-names = "ahb";
> >         resets = <&ccu RST_BUS_SPINLOCK>;
> >         reset-names = "ahb";
> >         status = "okay";
> > };
> > 
> > hwspinlock-stat@1c18010 {
> >         compatible = "allwinner,sun50i-hwspinlock-stat";
> >         reg = <0x01c18010 0x4>;
> >         status = "okay";
> > };
> > 
> > The extended test kernel module supports 4 different modes of the test,
> > 2 of them are sufficient to show the spinlock mechanism working.
> > 
> > Mode 1:
> > This one reads and prints the status register continuously. The crust
> > firmware and the test are set to a hwlock timeout of 1 second. The test
> > kernel module code runs a bit slower because of more code executed and
> > you can see how one lock is missed between entry 2 and 3.
> > 
> > > modprobe sunxi_hwspinlock_test2 mode=1 loops=10
> > [  187.167074] [init]--- SUNXI HWSPINLOCK DRIVER TEST ---
> > [  187.172636] [sreg] 00000000_00010000_00000000_00000000
> > [  188.196287] [sreg] 00000000_00001000_00000000_00000000
> > [  189.220285] [sreg] 00000000_00000010_00000000_00000000
> > [  190.244286] [sreg] 00000000_00000001_00000000_00000000
> > [  191.268285] [sreg] 00000000_00000000_10000000_00000000
> > [  192.292294] [sreg] 00000000_00000000_01000000_00000000
> > [  193.316302] [sreg] 00000000_00000000_00100000_00000000
> > [  194.340285] [sreg] 00000000_00000000_00010000_00000000
> > [  195.364285] [sreg] 00000000_00000000_00001000_00000000
> > [  196.388284] [sreg] 00000000_00000000_00000100_00000000
> > 
> > Mode 3:
> > This mode combines the Linux hwspinlock ABI approach from test 1 and the
> > status register access. The "after" reads show the locks taken by the
> > Linux driver and the crust firmware.
> > 
> > [  439.138476] [test] testing lock 13
> > [  439.141894] [sreg] before take 00000000_00000100_00000000_00000000
> > [  439.148083] [sreg] after take 00000000_00000110_00000000_00000000
> > [  439.154189] [sreg] after recursive take 00000000_00000110_00000000_00000000
> > [  439.161162] [sreg] after untake 00000000_00000010_00000000_00000000
> > [  439.167435] [test]+++ attempt #0 succeded
> > [  439.171458] [sreg] before take 00000000_00000010_00000000_00000000
> > [  439.177649] [sreg] after take 00000000_00000110_00000000_00000000
> > [  439.183751] [sreg] after recursive take 00000000_00000110_00000000_00000000
> > [  439.190725] [sreg] after untake 00000000_00000010_00000000_00000000
> > [  439.196992] [test]+++ attempt #1 succeded
> > [  439.201018] [sreg] before take 00000000_00000010_00000000_00000000
> > [  439.207212] [sreg] after take 00000000_00000110_00000000_00000000
> > [  439.213322] [sreg] after recursive take 00000000_00000110_00000000_00000000
> > [  439.220290] [sreg] after untake 00000000_00000010_00000000_00000000
> > [  439.226559] [test]+++ attempt #2 succeded
> > [  439.230576] [test] testing lock 14
> > [  439.233996] [sreg] before take 00000000_00000010_00000000_00000000
> > [  439.240177] [test] taking lock attempt #0 failed (-16)
> > [  439.245322] [run ]--- testing specific lock 14 failed (-14) ---
> > [  439.251252] [test] testing lock 15
> > [  439.254677] [sreg] before take 00000000_00000010_00000000_00000000
> > [  439.260865] [sreg] after take 00000000_00000011_00000000_00000000
> > [  439.266975] [sreg] after recursive take 00000000_00000011_00000000_00000000
> > [  439.273943] [sreg] after untake 00000000_00000010_00000000_00000000
> > [  439.280212] [test]+++ attempt #0 succeded
> > [  439.284235] [sreg] before take 00000000_00000010_00000000_00000000
> > [  439.290428] [sreg] after take 00000000_00000011_00000000_00000000
> > [  439.296534] [sreg] after recursive take 00000000_00000011_00000000_00000000
> > [  439.303502] [sreg] after untake 00000000_00000010_00000000_00000000
> > [  439.309774] [test]+++ attempt #1 succeded
> 
> Most of this should be in the cover letter (the details on how to make the tests mostly).
> 
> However, I mentioned in your first version that some comments on the
> previous drivers posted still applied to you, and you missed those
> comments apparently. See here for more details:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20200210170143.20007-2-nborisov@suse.com/#23148161
> 
> Most importantly, the driver name and compatible need to be changed.

Hmm, so I basically could use sun8i or sun50i. But picking sun8i would be
the logical one, because there it appeared first and sun50i is backwards
compatible... What do you think?

> Maxime

