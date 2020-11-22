Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1992BC56F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 12:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgKVLmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 06:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgKVLmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 06:42:38 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDEE208D5;
        Sun, 22 Nov 2020 11:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606045356;
        bh=u9wt6zWQXqhPbLe88eGaTAtgK4qyg1Qlp00FPr9i2ZM=;
        h=Date:From:To:Cc:Subject:From;
        b=nK+mQGu0EYSPkK5eEbE7KgkFxchQJDFI9j74vY7HjR2B8EA0b8vtN5kQidc7Jrk+n
         sRhmpb90J18mh2jJuZgMszn2sPDGlCl+4dyFCx6xPnXO4fgRE+g3CQ+8aoi5K0kVpJ
         DSYMQYxJm7fLByieuEt8wAtoX5EwjbBYDOnlwkY4=
Date:   Sun, 22 Nov 2020 12:43:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.10-rc5
Message-ID: <X7pO0mtUNsMsE9F7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.10-rc5

for you to fetch changes up to 2dde2821b57f12fa8601d35d438b5e300fcbbe1d:

  Merge tag 'iio-fixes-for-5.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2020-11-17 10:53:00 +0100)

----------------------------------------------------------------
Staging/IIO fixes for 5.10-rc5

Here are some small Staging and IIO driver fixes for 5.10-rc5.  They
include:
	- IIO fixes for reported regressions and problems
	- new device ids for IIO drivers
	- new device id for rtl8723bs driver
	- staging ralink driver Kconfig dependency fix
	- staging mt7621-pci bus resource fix

All of these have been in linux-next all week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Brian O'Keefe (1):
      staging: rtl8723bs: Add 024c:0627 to the list of SDIO device-ids

David Lechner (1):
      counter/ti-eqep: Fix regmap max_register

Fabien Parent (1):
      iio: adc: mediatek: fix unset field

Fabrice Gasnier (1):
      docs: ABI: testing: iio: stm32: remove re-introduced unsupported ABI

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.10a' of https://git.kernel.org/.../jic23/iio into staging-linus

Gwendal Grignou (1):
      iio: cros_ec: Use default frequencies when EC returns invalid information

Hans de Goede (2):
      iio: accel: kxcjk1013: Replace is_smo8500_device with an acpi_type enum
      iio: accel: kxcjk1013: Add support for KIOX010A ACPI DSM for setting tablet-mode

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: set 10ms as min shub slave timeout

Necip Fazil Yildiran (2):
      staging: ralink-gdma: fix kconfig dependency bug for DMA_RALINK
      iio: light: fix kconfig dependency bug for VCNL4035

Olivier Moysan (1):
      iio: adc: stm32-adc: fix a regression when using dma and irq

Paul Cercueil (2):
      iio/adc: ingenic: Fix battery VREF for JZ4770 SoC
      iio/adc: ingenic: Fix AUX/VBAT readings when touchscreen is used

Sergio Paracuellos (1):
      staging: mt7621-pci: avoid to request pci bus resources

 .../ABI/testing/sysfs-bus-iio-timer-stm32          | 24 ----------
 drivers/counter/ti-eqep.c                          |  4 +-
 drivers/iio/accel/kxcjk-1013.c                     | 51 +++++++++++++++++++---
 drivers/iio/adc/ingenic-adc.c                      | 34 ++++++++++++---
 drivers/iio/adc/mt6577_auxadc.c                    |  6 ++-
 drivers/iio/adc/stm32-adc-core.c                   | 41 ++++++++---------
 drivers/iio/adc/stm32-adc.c                        | 50 ++++++++++++++++++++-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 16 ++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  6 ++-
 drivers/iio/light/Kconfig                          |  1 +
 drivers/staging/mt7621-pci/pci-mt7621.c            | 15 ++-----
 drivers/staging/ralink-gdma/Kconfig                |  1 +
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c       |  1 +
 13 files changed, 165 insertions(+), 85 deletions(-)
