Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9446A20B3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgFZOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 10:47:04 -0400
Received: from 8bytes.org ([81.169.241.247]:50292 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgFZOrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:47:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5E1352A7; Fri, 26 Jun 2020 16:47:02 +0200 (CEST)
Date:   Fri, 26 Jun 2020 16:47:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.8-rc2
Message-ID: <20200626144655.GA20234@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.8-rc2

for you to fetch changes up to 48f0bcfb7aad2c6eb4c1e66476b58475aa14393e:

  iommu/vt-d: Fix misuse of iommu_domain_identity_map() (2020-06-23 10:08:32 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.8-rc2:

A couple of Intel VT-d fixes:

	- Make Intel SVM code 64bit only. The code uses pgd_t* and the
	  IOMMU only supports long-mode page-table formats, so its
	  broken on 32bit anyway.

	- Make sure GFX quirks in for Intel VT-d are not applied to
	  untrusted devices. Those devices might gain full memory access
	  otherwise.

	- Identity mapping setup fix.

	- Fix ACS enabling when Intel IOMMU is off and untrusted devices
	  are detected.

	- Two smaller fixes for coherency and IO page-table setup

----------------------------------------------------------------
Lu Baolu (5):
      iommu/vt-d: Make Intel SVM code 64-bit only
      iommu/vt-d: Set U/S bit in first level page table by default
      iommu/vt-d: Enable PCI ACS for platform opt in hint
      iommu/vt-d: Update scalable mode paging structure coherency
      iommu/vt-d: Fix misuse of iommu_domain_identity_map()

Rajat Jain (1):
      iommu/vt-d: Don't apply gfx quirks to untrusted devices

 drivers/iommu/Kconfig       |  2 +-
 drivers/iommu/intel/dmar.c  |  3 ++-
 drivers/iommu/intel/iommu.c | 59 +++++++++++++++++++++++++++++++++++++++------
 include/linux/intel-iommu.h |  1 +
 4 files changed, 56 insertions(+), 9 deletions(-)

Please pull.

Thanks,

	Joerg
