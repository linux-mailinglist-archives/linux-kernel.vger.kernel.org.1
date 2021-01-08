Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF06B2EF413
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbhAHOkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbhAHOkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:40:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E22C023A03;
        Fri,  8 Jan 2021 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610116796;
        bh=wu8Z1NndSiclLvgiYArv1I/gUeY9KPNK/Rtzl6oOWao=;
        h=Date:From:To:Cc:Subject:From;
        b=cyKH4bn+4uQ4o5U3IUubRGSPqAbgrbuR2x+uYDfuh70R9qvB5zMPij+kLFUzvTKsr
         DQ9FrP3ZWY9c1TtGaoPQoQbhHDbdIB/+ei7TUVTAiwjqJ3CTWxP4YIXUDGdpnEdLSd
         G1FteR399sqlPngl6qKSNQMzhCxHgGsAw4knlCk/eVlWJKY/kX0dGQYRnuCgrWJK8P
         OheDsDGmMkZ9zDft80iCn2GtzRQjfsCcU/7Qy2MqWhKRCaAfnF5kxADlxJ6sELOmFD
         ze8QOYGwxDr9Cwm6oAKIH1jZQmwXwbbfym38DO+bkl/ShdEw8495dKrj/59oh3c/zE
         IRqWVw3qJno/g==
Date:   Fri, 8 Jan 2021 14:39:51 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [GIT PULL] IOMMU fixes for -rc3
Message-ID: <20210108143951.GA4867@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these IOMMU fixes for -rc3. It's mainly all Intel VT-D stuff,
but there are some fixes for AMD and ARM as well. We've also got the
revert I promised during the merge window, which removes a temporary
hack to accomodate i915 while we transitioned the Intel IOMMU driver
over to the common DMA-IOMMU API.

Finally, there are still a couple of other VT-D fixes floating around, so I
expect to send you another batch of fixes next week.

Cheers,

Will

--->8

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to 7c29ada5e70083805bc3a68daa23441df421fbee:

  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices (2021-01-07 14:38:15 +0000)

----------------------------------------------------------------
iommu fixes for -rc3

- Fix VT-D TLB invalidation for subdevices

- Fix VT-D use-after-free on subdevice detach

- Fix VT-D locking so that IRQs are disabled during SVA bind/unbind

- Fix VT-D address alignment when flushing IOTLB

- Fix memory leak in VT-D IRQ remapping failure path

- Revert temporary i915 sglist hack now that it is no longer required

- Fix sporadic boot failure with Arm SMMU on Qualcomm SM8150

- Fix NULL dereference in AMD IRQ remapping code with remapping disabled

- Fix accidental enabling of irqs on AMD resume-from-suspend path

- Fix some typos in comments

----------------------------------------------------------------
Bjorn Andersson (1):
      iommu/arm-smmu-qcom: Initialize SCTLR of the bypass context

David Woodhouse (2):
      iommu/amd: Set iommu->int_enabled consistently when interrupts are set up
      iommu/amd: Stop irq_remapping_select() matching when remapping is disabled

Dinghao Liu (1):
      iommu/intel: Fix memleak in intel_irq_remapping_alloc

Liu Yi L (3):
      iommu/vt-d: Move intel_iommu info from struct intel_svm to struct intel_svm_dev
      iommu/vt-d: Fix general protection fault in aux_detach_device()
      iommu/vt-d: Fix ineffective devTLB invalidation for subdevices

Lu Baolu (3):
      iommu/vt-d: Fix misuse of ALIGN in qi_flush_piotlb()
      Revert "iommu: Add quirk for Intel graphic devices in map_sg"
      iommu/vt-d: Fix lockdep splat in sva bind()/unbind()

Stefano Garzarella (1):
      iommu/iova: fix 'domain' typos

 drivers/iommu/amd/init.c                   |   3 +-
 drivers/iommu/amd/iommu.c                  |   3 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |   2 +
 drivers/iommu/dma-iommu.c                  |  27 ------
 drivers/iommu/intel/dmar.c                 |   4 +-
 drivers/iommu/intel/iommu.c                | 148 +++++++++++++++++++++--------
 drivers/iommu/intel/irq_remapping.c        |   2 +
 drivers/iommu/intel/svm.c                  |  23 +++--
 drivers/iommu/iova.c                       |   8 +-
 include/linux/intel-iommu.h                |  18 ++--
 10 files changed, 147 insertions(+), 91 deletions(-)
