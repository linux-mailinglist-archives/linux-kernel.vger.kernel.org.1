Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADBF28B585
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgJLNJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbgJLNJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:09:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B63C32076C;
        Mon, 12 Oct 2020 13:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602508145;
        bh=DNIrDGvP1vNMajKpATobTUkVEEWgeHkJyR1I0NlZ3OI=;
        h=From:To:Cc:Subject:Date:From;
        b=TC4ixvx6BKOIbyutamEfgBiwVb6yUYkfd+GBqlm4KCy1qgT12NO6juQI5u7scHxXg
         clpCOQo0H+h8Kzs6Nk9JCLf73175KvwDwzZlbMrU/m/ne+jnNtaW2wdyxH2pdX0CRs
         Dns5j69mh1ZtKowU5UVh2g/GMOa2RtiOLdHoOuUk=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.10
Date:   Mon, 12 Oct 2020 14:08:49 +0100
Message-Id: <20201012130904.B63C32076C@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 549738f15da0e5a00275977623be199fbbf7df50:

  Linux 5.9-rc8 (2020-10-04 16:04:34 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.10

for you to fetch changes up to 6e0545c4f08368e67496111778a726f9a2031f26:

  Merge remote-tracking branch 'regmap/for-5.10' into regmap-next (2020-10-05 18:53:24 +0100)

----------------------------------------------------------------
regmap: Updates for v5.10

Quite a busy release for regmap, mostly support for new features useful
on fairly small subsets of devices.  The user visible features are:

 - A new API for registering large numbers of regmap fields at once.
 - Support for Intel AVMM buses connected via SPI.
 - Support for 12/20 address/value layouts.
 - Support for yet another scheme for acknowledging interrupts used on
   some Qualcomm devices.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      regmap: destroy mutex (if used) in regmap_exit()

Charles Keepax (1):
      regmap: debugfs: Fix more error path regressions

Dmitry Osipenko (2):
      regmap: Use flexible sleep
      regmap: Add can_sleep configuration option

Julia Lawall (1):
      regmap: debugfs: use semicolons rather than commas to separate statements

Laxminath Kasam (1):
      regmap: irq: Add support to clear ack registers

Mark Brown (6):
      Merge existing fixes from asoc/for-5.9
      Merge series "Introduce Embedded Controller driver for Acer A500" from Dmitry Osipenko <digetx@gmail.com>:
      Merge series "regmap: add support to regmap_field_bulk_alloc/free" from Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
      Merge series "use semicolons rather than commas to separate statements" from Julia Lawall <Julia.Lawall@inria.fr>:
      Merge tag 'regmap-field-bulk-api' into regmap-5.10
      Merge remote-tracking branch 'regmap/for-5.10' into regmap-next

Ricardo Ribalda (1):
      regmap: Add support for 12/20 register formatting

Srinivas Kandagatla (1):
      regmap: add support to regmap_field_bulk_alloc/free apis

Vinod Koul (1):
      regmap: soundwire: remove unused header mod_devicetable.h

Xu Yilun (1):
      regmap: add Intel SPI Slave to AVMM Bus Bridge support

 drivers/base/regmap/Kconfig           |   6 +-
 drivers/base/regmap/Makefile          |   1 +
 drivers/base/regmap/internal.h        |   3 +
 drivers/base/regmap/regmap-debugfs.c  |   2 +-
 drivers/base/regmap/regmap-irq.c      |  33 +-
 drivers/base/regmap/regmap-sdw.c      |   1 -
 drivers/base/regmap/regmap-spi-avmm.c | 719 ++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap.c          | 145 ++++++-
 include/linux/regmap.h                |  52 +++
 9 files changed, 954 insertions(+), 8 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-spi-avmm.c
