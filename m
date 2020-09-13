Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1D267ECD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgIMIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIMIjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:39:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81EB207C3;
        Sun, 13 Sep 2020 08:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599986356;
        bh=M2WOsoWi9lK3ja3pk4dr6bjTBhnL84e7E4DMFTl31ao=;
        h=Date:From:To:Cc:Subject:From;
        b=wYwVFpUR0DntPazRfWOkSMXhD6+ppZ9pNovOFyF4K6sccLbFDnkDUFTL6OkYFD3r2
         8K5tmNzMcY5uVpJFA2kvTA1L5XbUlAWGD8upNw/GC8vJjAz+sPXxIq+JbKTS+n6oL0
         uQiap2tCFIHIFIV2QcUF6yLoua5t8kDdSub+XkQ4=
Date:   Sun, 13 Sep 2020 10:39:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.9-rc5
Message-ID: <20200913083918.GA906881@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.9-rc5

for you to fetch changes up to a139ffa40f0c24b753838b8ef3dcf6ad10eb7854:

  iio: adc: mcp3422: fix locking on error path (2020-09-01 16:08:07 +0200)

----------------------------------------------------------------
Staging / IIO driver fixes for 5.9-rc5

Here are a number of Staging and IIO driver fixes for 5.9-rc5.

The majority of these are IIO driver fixes, to resolve a timestamp issue
that was recently found to affect a bunch of IIO drivers.

The other fixes in here are:
	- small IIO driver fixes
	- greybus driver fix
	- counter driver fix (came in through the IIO fixes tree)

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Angelo Compagnucci (2):
      iio: adc: mcp3422: fix locking scope
      iio: adc: mcp3422: fix locking on error path

Dan Carpenter (2):
      staging: greybus: audio: Uninitialized variable in gbaudio_remove_controls()
      counter: microchip-tcb-capture: check the correct variable

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.9a' of https://git.kernel.org/.../jic23/iio into staging-linus

Gwendal Grignou (1):
      iio: cros_ec: Set Gyroscope default frequency to 25Hz

Jonathan Cameron (13):
      iio: accel: kxsd9: Fix alignment of local buffer.
      iio:accel:mma8452: Fix timestamp alignment and prevent data leak.
      iio:accel:bmc150-accel: Fix timestamp alignment and prevent data leak.
      iio:accel:mma7455: Fix timestamp alignment and prevent data leak.
      iio:proximity:mb1232: Fix timestamp alignment and prevent data leak.
      iio:chemical:ccs811: Fix timestamp alignment and prevent data leak.
      iio:light:max44000 Fix timestamp alignment and prevent data leak.
      iio:light:ltr501 Fix timestamp alignment issue.
      iio:magnetometer:ak8975 Fix alignment and data leak issues.
      iio:adc:ti-adc081c Fix alignment and data leak issues
      iio:adc:ti-adc084s021 Fix alignment and data leak issues.
      iio:adc:ina2xx Fix timestamp alignment issue.
      iio:adc:max1118 Fix alignment of timestamp and data leak issues

Martin Blumenstingl (1):
      iio: adc: meson-saradc: Use the parent device to look up the calib data

Maxim Kochetkov (1):
      iio: adc: ti-ads1015: fix conversion when CONFIG_PM is not set

Michael Walle (1):
      iio: adc: rockchip_saradc: select IIO_TRIGGERED_BUFFER

Rustam Kovhaev (1):
      staging: wlan-ng: fix out of bounds read in prism2sta_probe_usb()

Vaibhav Agarwal (1):
      staging: greybus: audio: fix uninitialized value issue

 drivers/counter/microchip-tcb-capture.c            |  4 +--
 drivers/iio/accel/bmc150-accel-core.c              | 15 ++++++++---
 drivers/iio/accel/kxsd9.c                          | 16 ++++++++----
 drivers/iio/accel/mma7455_core.c                   | 16 +++++++++---
 drivers/iio/accel/mma8452.c                        | 11 +++++---
 drivers/iio/adc/Kconfig                            |  2 ++
 drivers/iio/adc/ina2xx-adc.c                       | 11 +++++---
 drivers/iio/adc/max1118.c                          | 10 +++++---
 drivers/iio/adc/mcp3422.c                          | 16 +++++++-----
 drivers/iio/adc/meson_saradc.c                     |  2 +-
 drivers/iio/adc/ti-adc081c.c                       | 11 +++++---
 drivers/iio/adc/ti-adc084s021.c                    | 10 +++++---
 drivers/iio/adc/ti-ads1015.c                       | 10 ++++++++
 drivers/iio/chemical/ccs811.c                      | 13 +++++++---
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  5 +++-
 drivers/iio/light/ltr501.c                         | 15 ++++++-----
 drivers/iio/light/max44000.c                       | 12 ++++++---
 drivers/iio/magnetometer/ak8975.c                  | 16 ++++++++----
 drivers/iio/proximity/mb1232.c                     | 17 +++++++------
 drivers/staging/greybus/audio_helper.c             |  3 +--
 drivers/staging/greybus/audio_topology.c           | 29 +++++++++++-----------
 drivers/staging/wlan-ng/hfa384x_usb.c              |  5 ----
 drivers/staging/wlan-ng/prism2usb.c                | 19 +++++---------
 23 files changed, 169 insertions(+), 99 deletions(-)
