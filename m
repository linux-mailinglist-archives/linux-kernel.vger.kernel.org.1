Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B128E5B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgJNRsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgJNRsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:48:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA49421D7F;
        Wed, 14 Oct 2020 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602697697;
        bh=EW5sWPAlr/20i9MiLaqAZtk2Oe9mv9yP4a2UBCA6LJ0=;
        h=Date:From:To:Cc:Subject:From;
        b=wEdW9HasWwGhAoA4rsQHtUOBNj2cWdwmutdfrh98qOqHeHoJu63XN3xIGvmlzsun3
         Cd40r/O0oWt8Y/OWugereqmyPI+oJ/ROU5eWXLvGoYLbMOHwNCovq+SmuYuKHItqFV
         2XNWxudkUW0b/UqjMrUfxwRDQ6yJP1zq6AGJw+2U=
Date:   Wed, 14 Oct 2020 19:48:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core patches for 5.10-rc1
Message-ID: <20201014174851.GA3786562@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.10-rc1

for you to fetch changes up to ee4906770ee931394179bcd42cabb196bc952276:

  regmap: debugfs: use semicolons rather than commas to separate statements (2020-10-02 15:48:52 +0200)

----------------------------------------------------------------
Driver Core patches for 5.10-rc1

Here is the "big" set of driver core patches for 5.10-rc1

They include a lot of different things, all related to the driver core
and/or some driver logic:
	- sysfs common write functions to make it easier to audit sysfs
	  attributes
	- device connection cleanups and fixes
	- devm helpers for a few functions
	- NOIO allocations for when devices are being removed
	- minor cleanups and fixes

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      driver core: Annotate dev_err_probe() with __must_check

Bartosz Golaszewski (4):
      devres: provide devm_krealloc()
      hwmon: pmbus: use more devres helpers
      iio: adc: xilinx-xadc: use devm_krealloc()
      platform_device: switch to simpler IDA interface

Greg Kroah-Hartman (4):
      Revert "test_firmware: Test platform fw loading on non-EFI systems"
      Revert "driver core: Annotate dev_err_probe() with __must_check"
      Merge 5.9-rc5 into driver-core-next
      platform/x86: intel_pmc_core: do not create a static struct device

Heikki Krogerus (5):
      device connection: Remove device_connection_find()
      device connection: Remove device_connection_add()
      device connection: Remove struct device_connection
      device property: Move fwnode_connection_find_match() under drivers/base/property.c
      Documentation: Remove device connection documentation

Jim Cromie (1):
      dyndbg: use keyword, arg varnames for query term pairs

Joe Perches (8):
      sysfs: Add sysfs_emit and sysfs_emit_at to format sysfs output
      drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions
      drivers core: Remove strcat uses around sysfs_emit and neaten
      drivers core: Reindent a couple uses around sysfs_emit
      drivers core: Miscellaneous changes for sysfs_emit
      mm: and drivers core: Convert hugetlb_report_node_meminfo to sysfs_emit
      drivers core: Use sysfs_emit for shared_cpu_map_show and shared_cpu_list_show
      drivers core: node: Use a more typical macro definition style for ACCESS_ATTR

Jonathan Neuschäfer (1):
      docs: driver-api: firmware: fallback-mechanisms: Fix rendering of bullet point

Julia Lawall (1):
      regmap: debugfs: use semicolons rather than commas to separate statements

Kees Cook (1):
      test_firmware: Test platform fw loading on non-EFI systems

Oliver Neukum (1):
      driver core: force NOIO allocations during unplug

Randy Dunlap (1):
      lib: devres: delete duplicated words

Saravana Kannan (1):
      scripts/dev-needs: Add script to list device dependencies

Stephen Boyd (2):
      syscore: Use pm_pr_dbg() for syscore_{suspend,resume}()
      driver core: platform: Document return type of more functions

Zenghui Yu (1):
      driver core: Use the ktime_us_delta() helper

 Documentation/driver-api/device_connection.rst     |  43 ---
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 .../driver-api/firmware/fallback-mechanisms.rst    |   1 +
 Documentation/driver-api/index.rst                 |   1 -
 Documentation/filesystems/sysfs.rst                |   8 +-
 MAINTAINERS                                        |   6 +
 drivers/base/Makefile                              |   2 +-
 drivers/base/arch_topology.c                       |   2 +-
 drivers/base/bus.c                                 |   2 +-
 drivers/base/cacheinfo.c                           |  49 ++--
 drivers/base/class.c                               |   2 +-
 drivers/base/core.c                                |  63 +++--
 drivers/base/cpu.c                                 |  84 +++---
 drivers/base/dd.c                                  |   8 +-
 drivers/base/devcon.c                              | 231 ---------------
 drivers/base/devcoredump.c                         |   2 +-
 drivers/base/devres.c                              | 105 +++++++
 drivers/base/firmware_loader/fallback.c            |   4 +-
 drivers/base/memory.c                              |  62 ++--
 drivers/base/node.c                                | 306 ++++++++++----------
 drivers/base/platform.c                            |  37 ++-
 drivers/base/power/sysfs.c                         | 160 +++++++----
 drivers/base/power/wakeup_stats.c                  |  17 +-
 drivers/base/property.c                            |  73 +++++
 drivers/base/regmap/regmap-debugfs.c               |   2 +-
 drivers/base/soc.c                                 |  64 ++---
 drivers/base/syscore.c                             |   8 +-
 drivers/base/topology.c                            |  10 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |  28 +-
 drivers/iio/adc/xilinx-xadc-core.c                 |  16 +-
 drivers/platform/x86/intel_pmc_core_pltdrv.c       |  26 +-
 drivers/usb/roles/class.c                          |  12 +-
 drivers/usb/typec/mux.c                            |  19 +-
 fs/sysfs/file.c                                    |  55 ++++
 include/linux/device.h                             |  58 +---
 include/linux/hugetlb.h                            |   4 +-
 include/linux/property.h                           |  14 +
 include/linux/sysfs.h                              |  15 +
 lib/devres.c                                       |  20 +-
 lib/dynamic_debug.c                                |  27 +-
 mm/hugetlb.c                                       |  18 +-
 scripts/dev-needs.sh                               | 315 +++++++++++++++++++++
 42 files changed, 1153 insertions(+), 827 deletions(-)
 delete mode 100644 Documentation/driver-api/device_connection.rst
 delete mode 100644 drivers/base/devcon.c
 create mode 100755 scripts/dev-needs.sh
