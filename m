Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3B209F25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 15:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404878AbgFYNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404650AbgFYNIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:08:42 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A7C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 06:08:42 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F104136D; Thu, 25 Jun 2020 15:08:37 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 00/13] iommu: Remove usage of dev->archdata.iommu
Date:   Thu, 25 Jun 2020 15:08:23 +0200
Message-Id: <20200625130836.1916-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

here is a patch-set to remove the usage of dev->archdata.iommu from
the IOMMU code in the kernel and replace its uses by the iommu per-device
private data field. The changes also remove the field entirely from
the architectures which no longer need it.

On PowerPC the field is called dev->archdata.iommu_domain and was only
used by the PAMU IOMMU driver. It gets removed as well.

The patches have been runtime tested on Intel VT-d and compile tested
with allyesconfig for:

	* x86 (32 and 64 bit)
	* arm and arm64
	* ia64 (only drivers/ because build failed for me in
	        arch/ia64)
	* PPC64

Besides that the changes also survived my IOMMU tree compile tests.

Please review.

Regards,

	Joerg

Joerg Roedel (13):
  iommu/exynos: Use dev_iommu_priv_get/set()
  iommu/vt-d: Use dev_iommu_priv_get/set()
  iommu/msm: Use dev_iommu_priv_get/set()
  iommu/omap: Use dev_iommu_priv_get/set()
  iommu/rockchip: Use dev_iommu_priv_get/set()
  iommu/tegra: Use dev_iommu_priv_get/set()
  iommu/pamu: Use dev_iommu_priv_get/set()
  iommu/mediatek: Do no use dev->archdata.iommu
  x86: Remove dev->archdata.iommu pointer
  ia64: Remove dev->archdata.iommu pointer
  arm: Remove dev->archdata.iommu pointer
  arm64: Remove dev->archdata.iommu pointer
  powerpc/dma: Remove dev->archdata.iommu_domain

 arch/arm/include/asm/device.h                 |  3 ---
 arch/arm64/include/asm/device.h               |  3 ---
 arch/ia64/include/asm/device.h                |  3 ---
 arch/powerpc/include/asm/device.h             |  3 ---
 arch/x86/include/asm/device.h                 |  3 ---
 .../gpu/drm/i915/selftests/mock_gem_device.c  | 10 ++++++++--
 drivers/iommu/exynos-iommu.c                  | 20 +++++++++----------
 drivers/iommu/fsl_pamu_domain.c               |  8 ++++----
 drivers/iommu/intel/iommu.c                   | 18 ++++++++---------
 drivers/iommu/msm_iommu.c                     |  4 ++--
 drivers/iommu/mtk_iommu.h                     |  2 ++
 drivers/iommu/mtk_iommu_v1.c                  | 10 ++++------
 drivers/iommu/omap-iommu.c                    | 20 +++++++++----------
 drivers/iommu/rockchip-iommu.c                |  8 ++++----
 drivers/iommu/tegra-gart.c                    |  8 ++++----
 drivers/iommu/tegra-smmu.c                    |  8 ++++----
 .../media/platform/s5p-mfc/s5p_mfc_iommu.h    |  4 +++-
 17 files changed, 64 insertions(+), 71 deletions(-)

-- 
2.27.0

