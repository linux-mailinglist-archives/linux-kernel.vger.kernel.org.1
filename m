Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9C2F779E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 12:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbhAOL1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 06:27:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbhAOL1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 06:27:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74B52221F7;
        Fri, 15 Jan 2021 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610709984;
        bh=Ud2aU3k2amrcKUSS+xZ+7kbwFYaKD8iDQJBdhP/vXCU=;
        h=Date:From:To:Cc:Subject:From;
        b=kjFFbT+cftc/qgBpV2O5kcSyfAGq9i70VipVaLTA4N5FvBFUAi3CnAJsdcuvwnsMK
         EG/W0QdAYqsWMNkN5EDMbz+k05nzFRKnLC8FsA2G1+wxquxKT42lKFgPbHL4swHi0I
         Yds6sKl5nmGCrUO5HWkfqg+OpHHDkedAs/I4E+UetBp/qIRtmMkyN25e34KNLmm50j
         efnjTDxK1OQXZVKa/JXGIWT7I6udj+57OoHVNzff/z9Q5FHCw1dgJTU0iZF2RphOsN
         Vx7Y/nSDM5LKEHm13LX3daUWT5zjF//9j8MJ74/HJ7LqLoNERJ5QlAHs2mjsSHcHit
         rdWFDtaL+H/mQ==
Date:   Fri, 15 Jan 2021 11:26:20 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [GIT PULL] IOMMU fixes for -rc4
Message-ID: <20210115112619.GA14253@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these three IOMMU fixes for -rc4. The main one is a change
to the Intel IOMMU driver to fix the handling of unaligned addresses
when invalidating the TLB. The fix itself is a bit ugly (the caller does
a bunch of shifting which is then effectively undone later in the
callchain), but Lu has patches to clean all of this up in 5.12.

Thanks,

Will

--->8

The following changes since commit 7c29ada5e70083805bc3a68daa23441df421fbee:

  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices (2021-01-07 14:38:15 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to 694a1c0adebee9152a9ba0320468f7921aca647d:

  iommu/vt-d: Fix duplicate included linux/dma-map-ops.h (2021-01-12 16:56:20 +0000)

----------------------------------------------------------------
iommu fixes for -rc4

- Fix address alignment handling for VT-D TLB invalidation

- Enable workarounds for buggy Qualcomm firmware on two more SoCs

- Drop duplicate #include

----------------------------------------------------------------
Konrad Dybcio (1):
      iommu: arm-smmu-qcom: Add sdm630/msm8998 compatibles for qcom quirks

Lu Baolu (1):
      iommu/vt-d: Fix unaligned addresses for intel_flush_svm_range_dev()

Tian Tao (1):
      iommu/vt-d: Fix duplicate included linux/dma-map-ops.h

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  2 ++
 drivers/iommu/intel/iommu.c                |  1 -
 drivers/iommu/intel/svm.c                  | 22 ++++++++++++++++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)
