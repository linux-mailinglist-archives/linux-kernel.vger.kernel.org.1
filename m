Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7235F301BF4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbhAXM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbhAXM71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 07:59:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E89CC22ADC;
        Sun, 24 Jan 2021 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611493115;
        bh=Trep1rSLWw10LxiNaywrkRM2pBHxMEKg6GaN7eAzBOc=;
        h=Date:From:To:Cc:Subject:From;
        b=nzfrXLkYXxN5II7AKZomlQHQhHlRFrHDma3GvE8Sn9t9+Gs0a0p4+4JeQdiNQvwwg
         8O53JiBLKkyJIt4CaBTZ4YoZeQAgSojmsNoh7mIFbOsHhKz1KK5hnlDuo7fhw+PqAz
         ctJzKrzLRGcgxE9NqBtQEFocSajUbI/mmBCdVYfA=
Date:   Sun, 24 Jan 2021 13:58:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.11-rc5
Message-ID: <YA1u+IPixwAx6t7P@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.11-rc5

for you to fetch changes up to e020ff611ba9be54e959e6b548038f8a020da1c9:

  driver core: Fix device link device name collision (2021-01-21 20:12:40 +0100)

----------------------------------------------------------------
Driver core fixes for 5.11-rc5

Here are some small driver core fixes for 5.11-rc5 that resolve some
reported problems:
	- revert of a -rc1 patch that was causing problems with some
	  machines
	- device link device name collision problem fix (busses only
	  have to name devices unique to their bus, not unique to all
	  busses)
	- kernfs splice bugfixes to resolve firmware loading problems
	  for Qualcomm systems.
	- other tiny driver core fixes for minor issues reported.

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christoph Hellwig (3):
      kernfs: implement ->read_iter
      kernfs: implement ->write_iter
      kernfs: wire up ->splice_read and ->splice_write

Greg Kroah-Hartman (1):
      Revert "driver core: Reorder devices on successful probe"

John Garry (1):
      Driver core: platform: Add extra error check in devm_platform_get_irqs_affinity()

Meng Li (1):
      drivers core: Free dma_range_map when driver probe failed

Rafael J. Wysocki (1):
      driver core: Extend device_is_dependent()

Saravana Kannan (1):
      driver core: Fix device link device name collision

 Documentation/ABI/testing/sysfs-class-devlink    |  4 +-
 Documentation/ABI/testing/sysfs-devices-consumer |  5 +-
 Documentation/ABI/testing/sysfs-devices-supplier |  5 +-
 drivers/base/core.c                              | 44 +++++++++++-----
 drivers/base/dd.c                                |  9 +---
 drivers/base/platform.c                          |  2 +
 fs/kernfs/file.c                                 | 65 +++++++++---------------
 include/linux/device.h                           | 12 +++++
 8 files changed, 79 insertions(+), 67 deletions(-)
