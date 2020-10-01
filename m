Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137922803B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbgJAQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:18:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732741AbgJAQR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:17:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB25BAFCB;
        Thu,  1 Oct 2020 16:17:57 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        robin.murphy@arm.com, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 4/4] mm: Update DMA zones description
Date:   Thu,  1 Oct 2020 18:17:40 +0200
Message-Id: <20201001161740.29064-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001161740.29064-1-nsaenzjulienne@suse.de>
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default behavior for arm64 changed, so reflect that.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 include/linux/mmzone.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf696c05e..d28ce77ccc2a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -363,8 +363,9 @@ enum zone_type {
 	 *  - arm only uses ZONE_DMA, the size, up to 4G, may vary depending on
 	 *    the specific device.
 	 *
-	 *  - arm64 has a fixed 1G ZONE_DMA and ZONE_DMA32 for the rest of the
-	 *    lower 4G.
+	 *  - arm64 uses a single 4GB ZONE_DMA, except on the Raspberry Pi 4,
+	 *    in which ZONE_DMA covers the first GB and ZONE_DMA32 the rest of
+	 *    the lower 4GB.
 	 *
 	 *  - powerpc only uses ZONE_DMA, the size, up to 2G, may vary
 	 *    depending on the specific device.
-- 
2.28.0

