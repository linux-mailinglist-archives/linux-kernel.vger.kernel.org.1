Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A904F2E7B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 18:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgL3Rdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 12:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgL3Rdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 12:33:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97E6120782;
        Wed, 30 Dec 2020 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609349592;
        bh=V0QUQ7ZCTsj2mbKSxTRyBeQajsHsL57gjaE6FUo71gQ=;
        h=Date:From:To:Cc:Subject:From;
        b=NA5yyx9c2JVDGNJG+RETVHELF4jqs0PyVStlkTu1/TKm3xCHq7kn2n9sOwT1pFBts
         LXbH28oz1EnWESVLYJqvoRfzIEysFgBINlhzyAQ1Wkqw81iE+RYfJK1o9ei0CpTAPB
         aqAYIdBgJo5NVl/I6mUV6VtgMCCc1E/bOf1UPJdS/w0xW4UfxbqKdl5mKHPVXgcyK3
         PN+CCsde6RoKAd9x6mbLOQJX7qFu4jDkiT2AGVOGAbATvHXNZvwLszxdyrpB3ZU9xX
         K4Xwv9e1k0zkmduf6KJGkolBMdF2fz7lcFCDDkNCJG+vwKlXhAp1sQfeopFq/cXWJ4
         MTn1vwiiYsjAw==
Date:   Wed, 30 Dec 2020 19:33:06 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.11-rc2
Message-ID: <20201230173306.GA12162@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This pull request contains a number of important fixes for 5.11-rc2.
Mainly fixes to support our new F/W with enhanced security features,
but also additional bugs.
See details in the tag message below.

Thanks,
Oded

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2020-12-30

for you to fetch changes up to b000700d6db50c933ce8b661154e26cf4ad06dba:

  habanalabs: Fix memleak in hl_device_reset (2020-12-29 23:23:12 +0200)

----------------------------------------------------------------
This tag contains the following fixes for 5.11-rc2:

- Fixes that are needed for supporting the new F/W with security features:
  - Correctly fetch PLL information in GOYA when security is enabled in F/W
  - Fix hard-reset support when F/W is in its preboot stage
  - Disable clock gating when initializing the H/W
  - Fix hard-reset procedure
  - Fix PCI controller initialization
- Remove setting of Engine-Barrier in collective wait operations. This
  barrier created a drop in performance
- Retry loading the TPC firmware in case of EINTR during loading
- Fix CS counters
- Register to PCI shutdown callback to fix handling of VM shutdown
- Fix order of status check
- Fix memory leak in reset procedure
- Fix and add comments and fix indentations

----------------------------------------------------------------
Alon Mizrahi (5):
      habanalabs: add comment for pll frequency ioctl opcode
      habanalabs: fetch PSOC PLL frequency from F/W in goya
      habanalabs: remove generic gaudi get_pll_freq function
      habanalabs/gaudi: do not set EB in collective slave queues
      habanalabs: add validation cs counter, fix misplaced counters

Dinghao Liu (1):
      habanalabs: Fix memleak in hl_device_reset

Oded Gabbay (7):
      habanalabs/gaudi: disable CGM at HW initialization
      habanalabs/gaudi: enhance reset message
      habanalabs: update comment in hl_boot_if.h
      habanalabs: adjust pci controller init to new firmware
      habanalabs/gaudi: retry loading TPC f/w on -EINTR
      habanalabs: register to pci shutdown callback
      habanalabs: fix order of status check

Ofir Bitton (2):
      habanalabs: preboot hard reset support
      habanalabs: full FW hard reset support

Tomer Tayar (2):
      habanalabs: Fix a missing-braces warning
      habanalabs: Revise comment to align with mirror list name

 .../misc/habanalabs/common/command_submission.c    |  77 +++++++--
 drivers/misc/habanalabs/common/device.c            |   8 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  60 +++++--
 drivers/misc/habanalabs/common/habanalabs.h        |   4 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   1 +
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   7 +-
 drivers/misc/habanalabs/common/hw_queue.c          |   5 +-
 drivers/misc/habanalabs/common/pci.c               |  28 +--
 drivers/misc/habanalabs/gaudi/gaudi.c              | 191 +++++++++------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   7 -
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |   3 +-
 drivers/misc/habanalabs/goya/goya.c                |  75 ++++----
 .../misc/habanalabs/include/common/hl_boot_if.h    |   9 +-
 include/uapi/misc/habanalabs.h                     |   5 +
 14 files changed, 281 insertions(+), 199 deletions(-)
