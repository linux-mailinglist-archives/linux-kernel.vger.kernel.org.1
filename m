Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8A301BF3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhAXM7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbhAXM65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 07:58:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 710FB22D2C;
        Sun, 24 Jan 2021 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611493086;
        bh=5eDnF12i/gn9txUcrRfZFG6pDa2J2ggsQkJpqfZwI8c=;
        h=Date:From:To:Cc:Subject:From;
        b=up10i3UtUcHONEE1qCRR6JrR0nDyGfu1+VfM+G3rIUGu9VZstd2DqFpayw9DP9BRV
         beNZuWKbAuHHk8gw4fdxzsIgsZKZ5DBbSytJNU1polOI9QAk8/hkQVz0nEY43UustA
         hdRVkNPAloJnza8pRmgDnxwi706oV71hUTAfR5/M=
Date:   Sun, 24 Jan 2021 13:58:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.11-rc5
Message-ID: <YA1u24kUPB+B7gKY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.11-rc5

for you to fetch changes up to a1bfb0ccf94dc79223d0db0d50237d3b3898f0b2:

  Merge tag 'iio-fixes-for-5.11a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2021-01-15 08:16:35 +0100)

----------------------------------------------------------------
Staging/IIO fixes for 5.11-rc5

Here are some IIO driver fixes for 5.11-rc5 to resolve some reported
problems.

Nothing major, just a few small fixes, all of these have been in
linux-next for a while and full details are in the shortlog.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandru Ardelean (1):
      iio: adc: ti_am335x_adc: remove omitted iio_kfifo_free()

Dan Carpenter (1):
      iio: sx9310: Off by one in sx9310_read_thresh()

David Lechner (1):
      counter:ti-eqep: remove floor

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.11a' of https://git.kernel.org/.../jic23/iio into staging-linus

Lars-Peter Clausen (1):
      iio: ad5504: Fix setting power-down state

Lorenzo Bianconi (1):
      iio: common: st_sensors: fix possible infinite loop in st_sensors_irq_thread

Slaveyko Slaveykov (1):
      drivers: iio: temperature: Add delay after the addressed reset command in mlx90632.c

Stephan Gerhold (1):
      dt-bindings: iio: accel: bma255: Fix bmc150/bmi055 compatible

Stephen Boyd (1):
      iio: sx9310: Fix semtech,avg-pos-strength setting when > 16

 .../bindings/iio/accel/bosch,bma255.yaml           |  4 +--
 drivers/counter/ti-eqep.c                          | 35 ----------------------
 drivers/iio/adc/ti_am335x_adc.c                    |  6 +---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 31 ++++++++++---------
 drivers/iio/dac/ad5504.c                           |  4 +--
 drivers/iio/proximity/sx9310.c                     |  5 ++--
 drivers/iio/temperature/mlx90632.c                 |  6 ++++
 7 files changed, 31 insertions(+), 60 deletions(-)
