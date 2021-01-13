Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB462F4595
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbhAMHxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbhAMHxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:53:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA1CF2311F;
        Wed, 13 Jan 2021 07:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610524376;
        bh=kmLYoQgqDbVzoR0gMbQNR/IarUrDRDrvXFYtch82kxs=;
        h=Date:From:To:Cc:Subject:From;
        b=gRiohowvrX8pqMH3GPCLpsFhnKysOiN0w2RhV4RgweVoLwtlPsVqz+H/AX0Jvv1gU
         H5HGWbIhVvb7xA/vXmoYJlQ5s0ukH6Rt99TBfJi6+iuayJAcE/INLoLdB2MPo3+lI3
         JrOQuURO/6y+iAVfWS0+I/8ldr01gYG9CUfDiM1ycZ6YOiXIKZH0PCWSDz+CrVaZlF
         pT+ar1lIQszLUjfn+sxmDA7argDwhWZSuzfBKx9s8+NkoA2q8XVbs1c3XMDbKzTG0T
         ptPhGbvhIGkZ3rms4fjMhDaVH16YbzOhB3dpU0JF2rkyVMvBwxksK/N4tH649zq817
         jPLmqupVLghIA==
Date:   Wed, 13 Jan 2021 09:52:53 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.11-rc4
Message-ID: <20210113075253.GA27799@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This pull request contains three important bug fixes for 5.11-rc4.
Basically the driver won't work without the dma address fix, and 
IMO the two other fixes are also improtant enough to be included 
at this stage.

Thanks,
Oded

The following changes since commit f970d1d01af8606233f47901c1cf39f3ae21fd74:

  Merge tag 'phy-fixes-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-misc-next (2021-01-11 15:37:40 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-01-13

for you to fetch changes up to 9488307a5559255f2fc9a3ab61e1c31e243ca7c6:

  habanalabs: prevent soft lockup during unmap (2021-01-12 15:00:10 +0200)

----------------------------------------------------------------
This tag contains the following bug fixes:

- Fix the dma address that is passed to dma_mmap_coherent. We passed
  an address that includes an offset that is needed by our device and
  that caused dma_mmap_coherent to do an errounous mapping.

- Fix the reset process in case failures happen during the reset process.
  Without this fix, if the user would have asked to perform reset after
  the previous reset failed he would get a kernel panic

- WA to prevent soft lockup BUG during unmap of host memory. In case of
  tens of thousands of mappings, the unmapping can take a long time that
  exceeds the soft lockup timeout. This WA adds a small sleep every 32K
  page unmappings to prevent that.

----------------------------------------------------------------
Oded Gabbay (3):
      habanalabs: fix dma_addr passed to dma_mmap_coherent
      habanalabs: fix reset process in case of failures
      habanalabs: prevent soft lockup during unmap

 drivers/misc/habanalabs/common/device.c     |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h |  1 +
 drivers/misc/habanalabs/common/memory.c     | 10 ++++++++--
 drivers/misc/habanalabs/common/mmu.c        |  6 +++---
 drivers/misc/habanalabs/common/mmu_v1.c     | 12 ++++++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c       |  3 ++-
 drivers/misc/habanalabs/goya/goya.c         |  3 ++-
 7 files changed, 27 insertions(+), 10 deletions(-)
