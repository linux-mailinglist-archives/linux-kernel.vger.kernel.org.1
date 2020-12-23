Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9772A2E1BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgLWLfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:35:05 -0500
Received: from mout02.posteo.de ([185.67.36.66]:51099 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgLWLfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:35:04 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5F8C72400FE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:34:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1608723246; bh=zw4e+htmhPInAC/8ULoYjG/tSsCu5ivmULEhGDZziVs=;
        h=Date:From:To:Cc:Subject:From;
        b=QIRoIDHvUnVRoqYUPvyn/TMHqIVUY9/na6prx4s0KRrO3jLgdjOnz9wSynl0zOWOk
         qMK0hvQGxJkNyMFNkK33KSqa+VULR0IN4h7Elron/pIdTUu8yoy594tAyZVZ8XBR6X
         yU/JcgDeypQRLAml9n/0hYa8U3UF6vsKeAMdTzSc6VsAUiFFe1r8eAbht+W+3FM+xo
         6e3kKU03gFjBX0Hr/u/m1V0puIF7YMEc+9NviCKvB6/7xKqC3+kE27qQDXY9ctHimG
         5YpnxOw9xuJJCDP1UFFw0UQRZCotFPIXNOFOB8DUUPBZnO+qxDNJew2dr/u214ErA7
         shvUSwgFS4O9w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4D1B1S53z9z6tm5;
        Wed, 23 Dec 2020 12:34:04 +0100 (CET)
Date:   Wed, 23 Dec 2020 12:34:03 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v5 0/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <cover.1608721968.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner sun6i compatible devices contain a spinlock unit
which can be used to sync access to devices shared between the ARM cores
and the embedded companion core. According to the datasheets at least 32
spinlocks are supported. The implementation supports 32, 64, 128 and 256
spinlock setups, but there is no known SoC yet, which implements more
than 32 spinlocks.

This driver adds support for this hardware spinlock unit to Linux
including all 4 possible setups. The driver reports the found setup via
debugfs. It can be build as a builtin and normal module by using the
HWSPINLOCK_SUN8I symbol.

This driver is the first step to enable hwspinlock support in Linux, but
also requires support in the firmware of the companion core. This patch
provides the driver and binding documentation but is not yet included
into the sunxi files. Also not every sunxi seem to have support for this
hardware, but it can be found in sun6i, sun8i, sun9i and sun50i devices.

The spinlock hardware has two ways to figure out if a lock is taken. The
lock can simply be readi, or bits of a 32bit wide status register can be
checked. The status register only supports the first 32 locks and may
not cover bigger spinlock setups. Therefore reading/writing a specific
spinlock is used in the driver for checking the status of a lock.

The status register is now free for debugging/testing purposes and can
completely bypass the Linux hwspinlock ABI. This status register will be
used in some additional kernel modules to test the hwspinlock driver.

Testing the driver.

To run all tests it is necessary to take locks on the companion core and
show on the Linux side that the locks were taken by an external event.
This can be achived by using an Allwinner SoC which includes an OpenRisc
companion core and can use the free crust firmware. For this the crust
firmware needs to be changed to take and release spinlocks (a simple
MMIO operation on the hwlock registers), which is currently not
supported by the current crust firmware. The necessary crust fork can
be found here https://github.com/wgottwalt/crust (hwspinlock branch).
It is also necessary to build u-boot with support for this crust/SCP
firmware. This u-boot fork can be found here
https://github.com/crust-firmware/u-boot (crust branch).

To test this driver it is also necessary to pick a device that is fully
supported by the crust firmware. For this the H5 based Friendlyarm
NanoPi NEO2 was used. It is fully supported by u-boot (and the fork),
the crust firmware (via H5 target) and current Linux kernels. In the
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

# modprobe sun6i_hwspinlock_test
[  472.182172] [init]--- SUN6I HWSPINLOCK DRIVER TEST ---
[  472.187491] [run ]--- testing locks 0 to 31 ---
[  472.192058] [test] testing lock 0
[  472.195371] [test]+++ attempt #0 succeded
[  472.199394] [test]+++ attempt #1 succeded
[  472.203411] [test]+++ attempt #2 succeded
[  472.207433] [test] testing lock 1
[  472.210755] [test]+++ attempt #0 succeded
...
[  472.665684] [test]+++ attempt #2 succeded
[  472.669704] [test] testing lock 31
[  472.673117] [test]+++ attempt #0 succeded
[  472.677137] [test]+++ attempt #1 succeded
[  472.681152] [test]+++ attempt #2 succeded

If the same test is done with the hwspinlock loop enabled crust firmware
and the crust enabled u-boot fork, the Linux test kernel module hits the
one lock taken by the crust firmware.

# modprobe sun6i_hwspinlock_test
...
[  945.871840] [test]+++ attempt #1 succeded
[  945.875854] [test]+++ attempt #2 succeded
[  945.879875] [test] testing lock 18
[  945.883273] [test]+++ attempt #0 succeded
[  945.887293] [test]+++ attempt #1 succeded
[  945.891310] [test]+++ attempt #2 succeded
[  945.895329] [test] testing lock 19
[  945.898738] [test] taking lock attempt #0 failed (-16)
[  945.903886] [run ]--- testing specific lock 19 failed (-14) ---
[  945.909811] [test] testing lock 20
[  945.913224] [test]+++ attempt #0 succeded
[  945.917245] [test]+++ attempt #1 succeded
[  945.921265] [test]+++ attempt #2 succeded
[  945.925281] [test] testing lock 21
[  945.928694] [test]+++ attempt #0 succeded
[  945.932709] [test]+++ attempt #1 succeded
...

Test 2:

This is a more complex test which uses the status register to bypass the
Linux hwspinlock ABI. For this to work a slightly modified driver is
used. It can be found here
https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/modified.
This modified driver splits the 4K memory range into two and leaves the
status register untouched. It can now be used by another test kernel
module, which can be found here
https://github.com/wgottwalt/sunxi_hwspinlock/tree/main/test2.
It is also necessary to change the device tree entries to get both
kernel modules working in parallel.

hwspinlock-mod@1c18000 {
        compatible = "allwinner,sun6i-a31-hwspinlock-mod";
        reg = <0x01c18000 0x4 0x01c18100 0x400>;
        clocks = <&ccu CLK_BUS_SPINLOCK>;
        clock-names = "ahb";
        resets = <&ccu RST_BUS_SPINLOCK>;
        reset-names = "ahb";
        status = "okay";
};

hwspinlock-stat@1c18010 {
        compatible = "allwinner,sun6i-a31-hwspinlock-stat";
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

# modprobe sun6i_hwspinlock_test2 mode=1 loops=10
[  179.611838] [init]--- SUN6I HWSPINLOCK DRIVER ENHANCED TEST ---
[  179.618114] [sreg] 10000000_00000000_00000000_00000000
[  180.643989] [sreg] 01000000_00000000_00000000_00000000
[  181.668006] [sreg] 00100000_00000000_00000000_00000000
[  182.691985] [sreg] 00010000_00000000_00000000_00000000
[  183.715985] [sreg] 00001000_00000000_00000000_00000000
[  184.739987] [sreg] 00000100_00000000_00000000_00000000
[  185.763986] [sreg] 00000010_00000000_00000000_00000000
[  186.787985] [sreg] 00000001_00000000_00000000_00000000
[  187.811985] [sreg] 00000000_01000000_00000000_00000000
[  188.835985] [sreg] 00000000_00100000_00000000_00000000

Test 2 Mode 3:

This test combines the Linux hwspinlock ABI approach from the first test
and the status register access. The "after" reads show the locks taken
by both sides until the Linux hwspinlock driver tries to take the lock
taken by the crust firmware.

# modprobe sun6i_hwspinlock_test2 mode=3
[  454.734821] [init]--- SUN6I HWSPINLOCK DRIVER ENHANCED TEST ---
...
[  455.897153] [test]+++ attempt #1 succeded
[  455.901178] [sreg] before take 00000000_00000000_00000000_00100000
[  455.907372] [sreg] after take 00000000_00000000_00000000_01100000
[  455.913478] [sreg] after recursive take 00000000_00000000_00000000_01100000
[  455.920455] [sreg] after untake 00000000_00000000_00000000_00100000
[  455.926721] [test]+++ attempt #2 succeded
[  455.930741] [test] testing lock 26
[  455.934157] [sreg] before take 00000000_00000000_00000000_00100000
[  455.940345] [test] taking lock attempt #0 failed (-16)
[  455.945492] [run ]--- testing specific lock 26 failed (-14) ---
[  455.951419] [test] testing lock 27
[  455.954836] [sreg] before take 00000000_00000000_00000000_00100000
[  455.961034] [sreg] after take 00000000_00000000_00000000_00110000
[  455.967135] [sreg] after recursive take 00000000_00000000_00000000_00110000
[  455.974109] [sreg] after untake 00000000_00000000_00000000_00100000
[  455.980375] [test]+++ attempt #0 succeded
[  455.984400] [sreg] before take 00000000_00000000_00000000_00100000

This patch adds:
- hwspinlock driver sun6i_hwspinlock
- updates makefiles
- hwspinlock dt bindings documentation
- updates MAINTAINERS

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Changes in v5:
  - changed symbols to earliest known supported SoC (A31)
  - simplified dt documentation
  - fixed several types
  - updated test description
  - changed init back to classic probe/remove callbacks

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
  dt-bindings: hwlock: add sun6i_hwspinlock
  hwspinlock: add sun6i hardware spinlock support

 .../bindings/hwlock/sun6i-a31-hwspinlock.yaml |  44 ++++
 MAINTAINERS                                   |   6 +
 drivers/hwspinlock/Kconfig                    |   9 +
 drivers/hwspinlock/Makefile                   |   1 +
 drivers/hwspinlock/sun6i_hwspinlock.c         | 214 ++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
 create mode 100644 drivers/hwspinlock/sun6i_hwspinlock.c

-- 
2.29.2

