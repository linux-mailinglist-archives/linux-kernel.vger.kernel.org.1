Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556F72D71A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436945AbgLKIY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:24:59 -0500
Received: from mout01.posteo.de ([185.67.36.65]:39517 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436879AbgLKIYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:24:21 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 12253160063
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:23:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607675000; bh=zmFUMMH6d/UrVwTnxwekchr/5Inhbi+gBZ8MpkCM2nQ=;
        h=Date:From:To:Cc:Subject:From;
        b=cg7GbcfIyscg42arM2talvWcVKL9b/XxwIGQaj1cIPze/UmzKgfDE8MAOPuJj0o5I
         P8J6sPAs3UkU9LsVltpSfPFX5JCVndr19gjDSn5lqtnFMbT1JUYW5hFGUMOPw+pV4y
         NsX5oDm8wsGpZ2F9wDq8lL9YQ08sfp9++EaFcVdKYkRK5SkZEFQ9+SGjLvFydRMPPO
         U6LXsfGgkrhWD1/cs/ujmHeaCv8HpCq1slWSaSrxCr1oQzaBvkcStEtvGwPLJ2i80w
         T3csQPGlIVStCh1V8YMW06m9WS97h2z7LPEkpUGbTPJWm4B41T9e5h4yERvhL7lPmB
         MndURXN5MHUsA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CskLt3QKWz9rxR;
        Fri, 11 Dec 2020 09:23:18 +0100 (CET)
Date:   Fri, 11 Dec 2020 09:23:17 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v4 0/2] hwspinlock: add sun8i hardware spinlock support
Message-ID: <cover.1607674518.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner sun8i compatible devices contain a spinlock unit
which can be used to sync access to devices shared between the ARM cores
and the embedded OpenRisc AR100 core. According to the datasheets at
least 32 spinlocks are supported. The implementation supports 32, 64,
128 and 256 spinlock setups, but there is no known SoC yet, which
implements more than 32 spinlocks.

This driver adds support for this hardware spinlock unit to Linux
including all 4 possible setups. The driver reports the found setup via
debugfs. It can be build as a builtin and normal module by using the
HWSPINLOCK_SUN8I symbol.

This driver is the first step to enable hwspinlock support in Linux, but
also requires support in the firmware of the OpenRisc core. This patch
provides the driver and binding documentation but is not yet included
into the sun8i and sun50i dtsi files. Also not every sun8i or sun50i SoC
seem to have support for this hardware. For example the H616 is missing
the whole spinlock section in the datasheets.

The spinlock hardware has two ways to figure out if a lock is taken. The
lock can simply be read or bits of a 32bit wide status register can be
checked. The status register only supports the first 32 locks and may
not cover bigger spinlock setups. Therefore reading/writing a specific
spinlock for checking is used in the driver.

The status register is now free for debugging/testing purposes and can
completely bypass the Linux hwspinlock ABI. This status register will be
used in some additional kernel modules to test the hwspinlock driver.



Testing the driver.

To run all tests it is necessary to take locks on the OpenRisc core and
show on the Linux side that the locks were taken by an external event.
This can be achived by using the crust firmware. For this the crust
firmware needs to be changed to take and release spinlocks (a simple
MMIO operation on the hwlock registers), which is currently not
supported by the current crust firmware. The necessary crust fork can
be found here https://github.com/wgottwalt/crust (hwspinlock branch).
It is also necessary to build u-boot with support for this crust/SCP
firmware. This u-boot fork can be found here
https://github.com/crust-firmware/u-boot (crust branch).

For testing this driver it is also necessary to pick a device that is
fully supported by the crust firmware. For this the H5 based Friendlyarm
NanoPi NEO2 was used, which is fully supported by u-boot (and the fork),
the curst firmware (via H5 target) and current Linux kernels. In the
crust fork it is necessary to go into debug menu of "make nconfig" and
select the hwspinlock test loop. This debug option enables a loop that
goes through the first 32 spinlocks. It takes/releases a lock one after
another using the timeout functions (and hw timers) of the crust
firmware. A timeout can be set in the debug menu.

Test 1:

This test was done using a mainline u-boot and a crust enabled u-boot.
For this a simple second kernel module was used, which can be found here
https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/test.

Using mainline u-boot it shows that the Linux side correctly takes a
lock, tries to recursively take a lock again (which does not happen) and
releases a lock. This is done for all 32 locks several times.

[   50.332836] [init]--- SUN8I HWSPINLOCK DRIVER TEST ---
[   50.338155] [run ]--- testing locks 0 to 31 ---
[   50.342725] [test] testing lock 0
[   50.346075] [test]+++ attempt #0 succeded
[   50.350103] [test]+++ attempt #1 succeded
[   50.354127] [test]+++ attempt #2 succeded
[   50.358154] [test] testing lock 1
[   50.361474] [test]+++ attempt #0 succeded
[   50.365496] [test]+++ attempt #1 succeded
[   50.369509] [test]+++ attempt #2 succeded
...
[   50.819369] [test] testing lock 31
[   50.822777] [test]+++ attempt #0 succeded
[   50.826796] [test]+++ attempt #1 succeded
[   50.830816] [test]+++ attempt #2 succeded

If the same test is done with the hwspinlock loop enabled crust firmware
and the crust enabled u-boot fork, the Linux test kernel module hits the
one lock taken by the crust firmware.

[  198.232316] [init]--- SUN8I HWSPINLOCK DRIVER TEST ---
[  198.237616] [run ]--- testing locks 0 to 31 ---
[  198.242170] [test] testing lock 0
[  198.245493] [test]+++ attempt #0 succeded
[  198.249514] [test]+++ attempt #1 succeded
[  198.253528] [test]+++ attempt #2 succeded
...
[  198.550564] [test] testing lock 20
[  198.553972] [test]+++ attempt #0 succeded
[  198.557983] [test]+++ attempt #1 succeded
[  198.561998] [test]+++ attempt #2 succeded
[  198.566018] [test] testing lock 21
[  198.569432] [test] taking lock attempt #0 failed (-16)
[  198.574580] [run ]--- testing specific lock 21 failed (-14) ---
[  198.580505] [test] testing lock 22
[  198.583918] [test]+++ attempt #0 succeded
[  198.587935] [test]+++ attempt #1 succeded
[  198.591954] [test]+++ attempt #2 succeded
...
[  198.719650] [test] testing lock 31
[  198.723065] [test]+++ attempt #0 succeded
[  198.727088] [test]+++ attempt #1 succeded
[  198.731099] [test]+++ attempt #2 succeded



Test 2:

This is a more complex test which uses the status register to bypass the
Linux hwspinlock ABI. For this to work a slightly modified driver is
used, which can be found here
https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/modified.
This modified driver splits the 4K memory range into two and leaves the
status register untouched, so that it can be used by another test kernel
modulei, which can be found here
https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/test2.
It is also necessary to change the device tree entries to get both
kernel modules working in parallel.

hwspinlock-mod@1c18000 {
        compatible = "allwinner,sun8i-hwspinlock-mod";
        reg = <0x01c18000 0x4 0x01c18100 0x400>;
        clocks = <&ccu CLK_BUS_SPINLOCK>;
        clock-names = "ahb";
        resets = <&ccu RST_BUS_SPINLOCK>;
        reset-names = "ahb";
        status = "okay";
};

hwspinlock-stat@1c18010 {
        compatible = "allwinner,sun8i-hwspinlock-stat";
        reg = <0x01c18010 0x4>;
        status = "okay";
};

The extended test kernel module supports four different modes to test
the hwspinlocks. Two of them are sufficient to show the spinlock
mechanism working.

Test 2 Mode 1:

This test reads and prints the status register continuously. The crust
firmware and the test are set to a hwspinlock timeout of one second. The
test kernel module code runs a bit slower because of more code executed
and all the printing. Because of that you can see how one lock is missed
completely between entry 8 and 9.

# modprobe sun8i_hwspinlock_test2 mode=1 loops=10
[  182.685525] [init]--- SUN8I HWSPINLOCK DRIVER ENHANCED TEST ---
[  182.691882] [sreg] 00000100_00000000_00000000_00000000
[  183.715763] [sreg] 00000010_00000000_00000000_00000000
[  184.739777] [sreg] 00000001_00000000_00000000_00000000
[  185.763761] [sreg] 00000000_10000000_00000000_00000000
[  186.787760] [sreg] 00000000_01000000_00000000_00000000
[  187.811761] [sreg] 00000000_00100000_00000000_00000000
[  188.835763] [sreg] 00000000_00010000_00000000_00000000
[  189.859761] [sreg] 00000000_00001000_00000000_00000000
[  190.883760] [sreg] 00000000_00000010_00000000_00000000
[  191.907760] [sreg] 00000000_00000001_00000000_00000000

Test 2 Mode 3:

This test combines the Linux hwspinlock ABI approach from the first test
and the status register access. The "after" reads show the locks taken
by both sides until the Linux hwspinlock driver tries to take the lock
taken by the crust firmware.

[  315.452080] [test]+++ attempt #0 succeded
[  315.456106] [sreg] before take 00000000_00000100_00000000_00000000
[  315.462292] [sreg] after take 00000000_00001100_00000000_00000000
[  315.468399] [sreg] after recursive take 00000000_00001100_00000000_00000000
[  315.475368] [sreg] after untake 00000000_00000100_00000000_00000000
[  315.481643] [test]+++ attempt #1 succeded
[  315.485664] [sreg] before take 00000000_00000100_00000000_00000000
[  315.491856] [sreg] after take 00000000_00001100_00000000_00000000
[  315.497958] [sreg] after recursive take 00000000_00001100_00000000_00000000
[  315.504938] [sreg] after untake 00000000_00000100_00000000_00000000
[  315.511205] [test]+++ attempt #2 succeded
[  315.515225] [test] testing lock 13
[  315.518642] [sreg] before take 00000000_00000100_00000000_00000000
[  315.524830] [test] taking lock attempt #0 failed (-16)
[  315.529972] [run ]--- testing specific lock 13 failed (-14) ---
[  315.535898] [test] testing lock 14
[  315.539305] [sreg] before take 00000000_00000100_00000000_00000000
[  315.545498] [sreg] after take 00000000_00000110_00000000_00000000
[  315.551599] [sreg] after recursive take 00000000_00000110_00000000_00000000
[  315.558573] [sreg] after untake 00000000_00000100_00000000_00000000
[  315.564844] [test]+++ attempt #0 succeded
[  315.568870] [sreg] before take 00000000_00000100_00000000_00000000
[  315.575058] [sreg] after take 00000000_00000110_00000000_00000000
[  315.581169] [sreg] after recursive take 00000000_00000110_00000000_00000000
[  315.588138] [sreg] after untake 00000000_00000100_00000000_00000000
[  315.594409] [test]+++ attempt #1 succeded



This patch adds:
- hwspinlock driver suni8i_hwspinlock
- updates makefiles
- hwspinlock dt bindings documentation
- updates MAINTAINERS

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Changes in v4:
  - changed binding from sun8i-hwspinlock to sun8i-a33-hwspinlock
  - fixed several issues in the dt documentation
  - further simplified driver
  - fixed an add_action_and_reset_* function issue
  - fixed some typos

Changes in v3:
  - moved test description to cover letter
  - changed name and symbols from sunxi to sun8i
  - improved driver description
  - further simplified driver
  - fully switched to devm_* and devm_add_action_* functions

Changes in v2:
  - redone coverletter
  - fixed ranges in the device tree description
  - added suggestions from Bjorn Andersson and Maxime Ripard to the driver
  - provided better driver and test description

Wilken Gottwalt (2):
  dt-bindings: hwlock: add sun8i_hwspinlock
  hwspinlock: add sun8i hardware spinlock support

 .../bindings/hwlock/sun8i-hwspinlock.yaml     |  56 +++++
 MAINTAINERS                                   |   6 +
 drivers/hwspinlock/Kconfig                    |   9 +
 drivers/hwspinlock/Makefile                   |   1 +
 drivers/hwspinlock/sun8i_hwspinlock.c         | 197 ++++++++++++++++++
 5 files changed, 269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/sun8i_hwspinlock.c

-- 
2.29.2

