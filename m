Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC652DAABF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgLOKUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgLOKUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:20:04 -0500
Date:   Tue, 15 Dec 2020 11:20:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608027562;
        bh=mfJg3RdvN9tVzCK8U4xGmZeudibHtglHHRYbpsfLm8g=;
        h=From:To:Cc:Subject:From;
        b=v8+AHyCjdO9f4UbZSGlG5ypA54n2GUoaTM8kURUFI+wdw3hxmr98QxKcHldeMS7Pf
         AEPVkR4Kw03cIaCLjQanhFBHZWYnsbAdeMnYSpYlTHCZTkhyerE59uNJHpscmS8aY7
         6MsMB8iluCsG2XNWeDO7iHprkpv7rdB+cOsB/ces=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core changes for 5.11-rc1
Message-ID: <X9iN6g0YmMt5pQ+F@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.11-rc1

for you to fetch changes up to 46e85af0cc53f35584e00bb5db7db6893d0e16e5:

  driver core: platform: don't oops in platform_shutdown() on unbound devices (2020-12-13 16:03:42 +0100)

----------------------------------------------------------------
Driver core updates for 5.11-rc1

Here is the big driver core updates for 5.11-rc1

This time there was a lot of different work happening here for some
reason:
	- redo of the fwnode link logic, speeding it up greatly
	- auxiliary bus added (this was a tag that will be pulled in
	  from other trees/maintainers this merge window as well, as
	  driver subsystems started to rely on it)
	- platform driver core cleanups on the way to fixing some
	  long-time api updates in future releases
	- minor fixes and tweaks.

All have been in linux-next with no (finally) reported issues.  Testing
there did helped in shaking issues out a lot :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (5):
      driver core: platform: Introduce platform_get_mem_or_io()
      vfio: platform: Switch to use platform_get_mem_or_io()
      usb: host: sl811: Switch to use platform_get_mem_or_io()
      misc: pvpanic: Combine ACPI and platform drivers
      misc: pvpanic: Replace OF headers by mod_devicetable.h

Dave Ertman (1):
      Add auxiliary bus support

Dave Jiang (1):
      driver core: auxiliary bus: Fix auxiliary bus shutdown null auxdrv ptr

Dmitry Baryshkov (1):
      driver core: platform: don't oops in platform_shutdown() on unbound devices

Greg Kroah-Hartman (4):
      driver core: auxiliary bus: move slab.h from include file
      driver core: auxiliary bus: make remove function return void
      driver core: auxiliary bus: minor coding style tweaks
      Merge tag 'auxbus-5.11-rc1' of git://git.kernel.org/.../gregkh/driver-core into driver-core-next

Hui Su (1):
      fs/kernfs: remove the double check of dentry->inode

Jim Cromie (1):
      dyndbg: fix use before null check

Johan Hovold (1):
      of: fix linker-section match-table corruption

Julian Wiedmann (1):
      driver core: make driver_probe_device() static

Krzysztof Kozlowski (1):
      soc: fix comment for freeing soc_dev_attr

Mauro Carvalho Chehab (1):
      drivers: base: fix some kernel-doc markups

Saravana Kannan (19):
      driver core: Fix lockdep warning on wfs_lock
      Revert "driver core: Avoid deferred probe due to fw_devlink_pause/resume()"
      Revert "driver core: Rename dev_links_info.defer_sync to defer_hook"
      Revert "driver core: Don't do deferred probe in parallel with kernel_init thread"
      Revert "driver core: Remove check in driver_deferred_probe_force_trigger()"
      Revert "of: platform: Batch fwnode parsing when adding all top level devices"
      Revert "driver core: fw_devlink: Add support for batching fwnode parsing"
      driver core: Add fwnode_init()
      driver core: Add fwnode link support
      driver core: Allow only unprobed consumers for SYNC_STATE_ONLY device links
      device property: Add fwnode_is_ancestor_of() and fwnode_get_next_parent_dev()
      driver core: Redefine the meaning of fwnode_operations.add_links()
      driver core: Add fw_devlink_parse_fwtree()
      driver core: Use device's fwnode to check if it is waiting for suppliers
      of: property: Update implementation of add_links() to create fwnode links
      efi: Update implementation of add_links() to create fwnode links
      driver core: Refactor fw_devlink feature
      driver core: Delete pointless parameter in fwnode_operations.add_links
      ACPI: Use fwnode_init() to set up fwnode

Takashi Iwai (1):
      driver: core: Fix list corruption after device_del()

Thierry Reding (2):
      driver core: Reorder devices on successful probe
      driver core: Fix a couple of typos

Uwe Kleine-König (3):
      driver core: platform: reorder functions
      driver core: platform: change logic implementing platform_driver_probe
      driver core: platform: use bus_type functions

Willem de Bruijn (1):
      kernfs: bring names in comments in line with code

 Documentation/driver-api/auxiliary_bus.rst | 234 ++++++++++++
 Documentation/driver-api/index.rst         |   1 +
 drivers/acpi/property.c                    |   2 +-
 drivers/acpi/scan.c                        |   2 +-
 drivers/base/Kconfig                       |   3 +
 drivers/base/Makefile                      |   1 +
 drivers/base/auxiliary.c                   | 279 ++++++++++++++
 drivers/base/base.h                        |   1 -
 drivers/base/class.c                       |   2 +-
 drivers/base/core.c                        | 559 ++++++++++++++++++-----------
 drivers/base/dd.c                          |   9 +-
 drivers/base/devres.c                      |   2 +-
 drivers/base/firmware_loader/fallback.c    |   2 +-
 drivers/base/platform.c                    | 474 ++++++++++++------------
 drivers/base/property.c                    |  52 +++
 drivers/base/soc.c                         |   2 +-
 drivers/base/swnode.c                      |   2 +-
 drivers/firmware/efi/efi-init.c            |  32 +-
 drivers/misc/pvpanic.c                     | 134 +------
 drivers/of/dynamic.c                       |   1 +
 drivers/of/platform.c                      |   2 -
 drivers/of/property.c                      | 149 +++-----
 drivers/usb/host/sl811-hcd.c               |  20 +-
 drivers/vfio/platform/vfio_platform.c      |  13 +-
 fs/kernfs/dir.c                            |   5 +-
 include/linux/acpi.h                       |   2 +-
 include/linux/auxiliary_bus.h              |  77 ++++
 include/linux/device.h                     |  10 +-
 include/linux/device/class.h               |  14 +
 include/linux/fwnode.h                     |  73 ++--
 include/linux/kernfs.h                     |   2 +-
 include/linux/mod_devicetable.h            |   8 +
 include/linux/of.h                         |   3 +-
 include/linux/platform_device.h            |   3 +
 include/linux/property.h                   |   3 +
 kernel/irq/irqdomain.c                     |   2 +-
 lib/dynamic_debug.c                        |   9 +-
 scripts/mod/devicetable-offsets.c          |   3 +
 scripts/mod/file2alias.c                   |   8 +
 39 files changed, 1433 insertions(+), 767 deletions(-)
 create mode 100644 Documentation/driver-api/auxiliary_bus.rst
 create mode 100644 drivers/base/auxiliary.c
 create mode 100644 include/linux/auxiliary_bus.h
