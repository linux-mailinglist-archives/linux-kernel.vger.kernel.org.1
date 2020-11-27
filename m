Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259C32C640C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgK0Lpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgK0Lpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:45:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1427206D8;
        Fri, 27 Nov 2020 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606477534;
        bh=pCuERobJCCzVNGQt0FGsvx61B+OhUF8qKzhnI5TXBWQ=;
        h=Date:From:To:Cc:Subject:From;
        b=VeSQBB20rTF2W/n/gWl929dklnJle/FUbDJ1O2K0KHwpQtRGlRTJVzfC9gvfmGKc4
         D67wwdCGhZV0ekFOWD4qRcZyGX+f/8PaUOq7m+UK1Gw+iPOI3fiWAKYFAJhDsDCO6F
         TVpQbmagZ2Agd3GCtBiTfTcpdAIJtIIcAdDcEUi0=
Date:   Fri, 27 Nov 2020 11:45:29 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, tglx@linutronix.de,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [GIT PULL] IOMMU fixes for -rc6
Message-ID: <20201127114529.GB20418@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Linus,

Here's another round of IOMMU fixes for -rc6 consisting mainly of a
bunch of independent driver fixes. Thomas agreed for me to take the
x86 'tboot' fix here, as it fixes a regression introduced by a vt-d
change.

Please pull,

Will

--->8

The following changes since commit 91c2c28d8de34815ea9bb4d16e9db7308ad33d3e:

  MAINTAINERS: Temporarily add myself to the IOMMU entry (2020-11-19 11:12:17 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/iommu-fixes

for you to fetch changes up to d76b42e92780c3587c1a998a3a943b501c137553:

  iommu/vt-d: Don't read VCCAP register unless it exists (2020-11-26 14:50:24 +0000)

----------------------------------------------------------------
iommu fixes for -rc6

- Fix intel iommu driver when running on devices without VCCAP_REG

- Fix swiotlb and "iommu=pt" interaction under TXT (tboot)

- Fix missing return value check during device probe()

- Fix probe ordering for Qualcomm SMMU implementation

- Ensure page-sized mappings are used for AMD IOMMU buffers with SNP RMP

----------------------------------------------------------------
David Woodhouse (1):
      iommu/vt-d: Don't read VCCAP register unless it exists

John Stultz (1):
      arm-smmu-qcom: Ensure the qcom_scm driver has finished probing

Lu Baolu (1):
      x86/tboot: Don't disable swiotlb when iommu is forced on

Shameer Kolothum (1):
      iommu: Check return of __iommu_attach_device()

Suravee Suthikulpanit (1):
      iommu/amd: Enforce 4k mapping for certain IOMMU data structures

 arch/x86/kernel/tboot.c                    |  5 +----
 drivers/iommu/amd/init.c                   | 27 ++++++++++++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c |  4 ++++
 drivers/iommu/intel/dmar.c                 |  3 ++-
 drivers/iommu/intel/iommu.c                |  4 ++--
 drivers/iommu/iommu.c                      | 10 ++++++----
 6 files changed, 37 insertions(+), 16 deletions(-)
