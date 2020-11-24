Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1852C27F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbgKXNb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388313AbgKXNby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:31:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A729BC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:31:54 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khYQ8-0001Gj-1O; Tue, 24 Nov 2020 14:31:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khYQ6-0008GV-TN; Tue, 24 Nov 2020 14:31:46 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 0/5] amba: minor fix and various cleanups
Date:   Tue, 24 Nov 2020 14:31:34 +0100
Message-Id: <20201124133139.3072124-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Hello,

Changes since (implicit) v1 sent with Message-Id:
20201124103242.2971199-1-u.kleine-koenig@pengutronix.de:

 - Fix prototype of dynamic_replicator_remove to make the driver compile
   again. Thanks Ulf for catching that.
 - Reorder patches to have the fix first in case it should be
   backported.
 - New patch to cleanup the vfio driver which simplifies the "Make the
   remove callback return void" patch; found by Arnd.
 - Add a guard in "Make use of bus_type functions" that is necessary as
   the bus's shutdown function might be called for unbound devices.
   Thanks to Marek Szyprowski for reporting this problem for a similar
   series I created for spi.
 - Added Reviewed-by: for Arnd and Ulf. (Please speak up if the changes
   I did invalidate your tags.)

@rmk: I assume you are the one who will pick this up and I will have to
send this series to your patch tracker?

Uwe Kleine-König (5):
  amba: Fix resource leak for drivers without .remove
  amba: reorder functions
  vfio: platform: simplify device removal
  amba: Make the remove callback return void
  amba: Make use of bus_type functions

 drivers/amba/bus.c                            | 234 +++++++++---------
 drivers/char/hw_random/nomadik-rng.c          |   3 +-
 drivers/dma/pl330.c                           |   3 +-
 drivers/gpu/drm/pl111/pl111_drv.c             |   4 +-
 drivers/hwtracing/coresight/coresight-catu.c  |   3 +-
 .../hwtracing/coresight/coresight-cpu-debug.c |   4 +-
 .../hwtracing/coresight/coresight-cti-core.c  |   4 +-
 drivers/hwtracing/coresight/coresight-etb10.c |   4 +-
 .../coresight/coresight-etm3x-core.c          |   4 +-
 .../coresight/coresight-etm4x-core.c          |   4 +-
 .../hwtracing/coresight/coresight-funnel.c    |   4 +-
 .../coresight/coresight-replicator.c          |   4 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   4 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |   4 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |   4 +-
 drivers/i2c/busses/i2c-nomadik.c              |   4 +-
 drivers/input/serio/ambakmi.c                 |   3 +-
 drivers/memory/pl172.c                        |   4 +-
 drivers/memory/pl353-smc.c                    |   4 +-
 drivers/mmc/host/mmci.c                       |   4 +-
 drivers/rtc/rtc-pl030.c                       |   4 +-
 drivers/rtc/rtc-pl031.c                       |   4 +-
 drivers/spi/spi-pl022.c                       |   5 +-
 drivers/tty/serial/amba-pl010.c               |   4 +-
 drivers/tty/serial/amba-pl011.c               |   3 +-
 drivers/vfio/platform/vfio_amba.c             |  15 +-
 drivers/video/fbdev/amba-clcd.c               |   4 +-
 drivers/watchdog/sp805_wdt.c                  |   4 +-
 include/linux/amba/bus.h                      |   2 +-
 sound/arm/aaci.c                              |   4 +-
 30 files changed, 157 insertions(+), 198 deletions(-)


base-commit: 95065cb54210eba86bed10cb2118041524d54573
-- 
2.29.2

