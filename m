Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9FB267ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIMIj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgIMIiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:38:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 350E3207C3;
        Sun, 13 Sep 2020 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599986331;
        bh=oGhCHOncTAh7inOE6AoEj8ydHuCHuPosuFwPAl4WicY=;
        h=Date:From:To:Cc:Subject:From;
        b=bO6Jl9zDay12YfncOCCNyCNDabisejxn/x2EfVdbNe2Vx4g3WOZhaBEMpnsejsmX4
         z43LlAgV8ednrK5N+PytuOZt+5dpm/zUVQ7rwNG9p4KC6g0dlyucJdV+lW58oWKVD8
         ARY6zzQMlIKpfTyPJJOGBEDu//tnyyJpqpclrPWI=
Date:   Sun, 13 Sep 2020 10:38:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Driver core fixes for 5.9-rc5
Message-ID: <20200913083853.GA906777@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.9-rc5

for you to fetch changes up to baaabecfc80fad255f866563b53b8c7a3eec176e:

  test_firmware: Test platform fw loading on non-EFI systems (2020-09-10 18:19:16 +0200)

----------------------------------------------------------------
Driver core fixes for 5.9-rc5

Here are some small driver core and debugfs fixes for 5.9-rc5

Included in here are:
	- firmware loader memory leak fix
	- firmware loader testing fixes for non-EFI systems
	- device link locking fixes found by lockdep
	- kobject_del() bugfix that has been affecting some callers
	- debugfs minor fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      kobject: Restore old behaviour of kobject_del(NULL)
      kobject: Drop unneeded conditional in __kobject_del()

Kees Cook (1):
      test_firmware: Test platform fw loading on non-EFI systems

Krzysztof Kozlowski (1):
      MAINTAINERS: Add the security document to SECURITY CONTACT

Michał Mirosław (1):
      driver code: print symbolic error code

Prateek Sood (1):
      firmware_loader: fix memory leak for paged buffer

Randy Dunlap (1):
      PM: <linux/device.h>: fix @em_pd kernel-doc warning

Saravana Kannan (1):
      driver core: Fix device_pm_lock() locking for device links

Vladis Dronov (1):
      debugfs: Fix module state check condition

 MAINTAINERS                              |  1 +
 drivers/base/core.c                      |  8 ++------
 drivers/base/firmware_loader/firmware.h  |  2 ++
 drivers/base/firmware_loader/main.c      | 17 +++++++++++------
 drivers/firmware/efi/embedded-firmware.c | 10 +++++-----
 fs/debugfs/file.c                        |  4 ++--
 include/linux/device.h                   |  1 +
 include/linux/efi_embedded_fw.h          |  6 ++----
 lib/kobject.c                            |  9 +++++----
 lib/test_firmware.c                      |  9 +++++++++
 10 files changed, 40 insertions(+), 27 deletions(-)
