Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF6B301BF6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 14:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhAXNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 08:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbhAXNAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 08:00:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A44422D2C;
        Sun, 24 Jan 2021 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611493157;
        bh=VJq6DS9HOMRcWbJkqv+fTJT6/bGrPO0XZ3yGDheWP4s=;
        h=Date:From:To:Cc:Subject:From;
        b=ZARwKB4T1M0vdNmnSS90a/3TRP+huQ9kIsVKHQfI3AVwG4e5Z8hcJvOWdoaqRifhE
         FhVKiSr44qUgFU82ln6IstFykuEir09EMjc6A81sa8rFhfDoMii56Gl0siwV/7uPxk
         548XJqGa0fB+pkgdSHL0kuB77EXHGxJQ+Z62pw8k=
Date:   Sun, 24 Jan 2021 13:59:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.11-rc5
Message-ID: <YA1vIhUuD4wEYzSj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc5

for you to fetch changes up to 31b081066e9c8f4a931a3d20dc0c6ca63c595c44:

  misc: rtsx: init value of aspm_enabled (2021-01-22 11:04:53 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.11-rc5

Here are some small char/misc driver fixes for 5.11-rc5.  Included in
here are:
	- habanalabs driver fixes
	- phy driver fixes
	- hwtracing driver fixes
	- rtsx cardreader driver fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Lobakin (1):
      PHY: Ingenic: fix unconditional build of phy-ingenic-usb

Alexander Shishkin (1):
      intel_th: pci: Add Alder Lake-P support

Arnd Bergmann (1):
      phy: mediatek: allow compile-testing the dsi phy

Greg Kroah-Hartman (3):
      Merge tag 'phy-fixes-5.11' of git://git.kernel.org/.../phy/linux-phy into char-misc-next
      Merge tag 'misc-habanalabs-fixes-2021-01-13' of https://git.kernel.org/.../ogabbay/linux into char-misc-linus
      Merge tag 'misc-habanalabs-fixes-2021-01-21' of https://git.kernel.org/.../ogabbay/linux into char-misc-linus

Oded Gabbay (5):
      habanalabs: fix dma_addr passed to dma_mmap_coherent
      habanalabs: fix reset process in case of failures
      habanalabs: prevent soft lockup during unmap
      habanalabs: fix backward compatibility of idle check
      habanalabs: disable FW events on device removal

Ofir Bitton (1):
      habanalabs: zero pci counters packet before submit to FW

Ricky Wu (1):
      misc: rtsx: init value of aspm_enabled

Tony Lindgren (1):
      phy: cpcap-usb: Fix warning for missing regulator_disable

Wang Hui (1):
      stm class: Fix module init return on allocation failure

 drivers/hwtracing/intel_th/pci.c                  |  5 +++++
 drivers/hwtracing/stm/heartbeat.c                 |  6 ++++--
 drivers/misc/cardreader/rtsx_pcr.c                |  7 ++++++-
 drivers/misc/habanalabs/common/device.c           | 11 ++++++++++-
 drivers/misc/habanalabs/common/firmware_if.c      |  5 +++++
 drivers/misc/habanalabs/common/habanalabs.h       |  1 +
 drivers/misc/habanalabs/common/habanalabs_ioctl.c |  2 ++
 drivers/misc/habanalabs/common/memory.c           | 10 ++++++++--
 drivers/misc/habanalabs/common/mmu.c              |  6 +++---
 drivers/misc/habanalabs/common/mmu_v1.c           | 12 ++++++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c             |  3 ++-
 drivers/misc/habanalabs/goya/goya.c               |  3 ++-
 drivers/phy/ingenic/Makefile                      |  2 +-
 drivers/phy/mediatek/Kconfig                      |  4 +++-
 drivers/phy/motorola/phy-cpcap-usb.c              | 19 +++++++++++++------
 15 files changed, 75 insertions(+), 21 deletions(-)
