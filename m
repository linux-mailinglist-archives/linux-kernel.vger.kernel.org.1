Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C71E51A476C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDJOav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 10:30:51 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:51552 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJOav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:30:51 -0400
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id R2Wp2200M5USYZQ062Wp8i; Fri, 10 Apr 2020 16:30:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jMugD-0004re-5L; Fri, 10 Apr 2020 16:30:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jMugD-00058K-3B; Fri, 10 Apr 2020 16:30:49 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] iommu: Fix MTK_IOMMU dependencies
Date:   Fri, 10 Apr 2020 16:30:47 +0200
Message-Id: <20200410143047.19691-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If NO_DMA=y (e.g. Sun-3 all{mod,yes}-config):

    drivers/iommu/dma-iommu.o: In function `iommu_dma_mmap':
    dma-iommu.c:(.text+0x836): undefined reference to `dma_pgprot'

IOMMU_DMA must not be selected, unless HAS_DMA=y.

Hence fix this by making MTK_IOMMU depend on HAS_DMA.
While at it, remove the dependency on ARM || ARM64, as that is already
implied by the dependency on ARCH_MEDIATEK.

Fixes: e93a1695d7fb5513 ("iommu: Enable compile testing for some of drivers")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 58b4a4dbfc78b9a5..bead9aaea8429447 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -457,7 +457,7 @@ config S390_AP_IOMMU
 
 config MTK_IOMMU
 	bool "MTK IOMMU Support"
-	depends on ARM || ARM64 || COMPILE_TEST
+	depends on HAS_DMA
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select ARM_DMA_USE_IOMMU
 	select IOMMU_API
-- 
2.17.1

