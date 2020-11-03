Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A52A4CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgKCRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:32:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:34096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgKCRcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:32:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58B18AD85;
        Tue,  3 Nov 2020 17:32:12 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: [PATCH v6 7/7] mm: Remove examples from enum zone_type comment
Date:   Tue,  3 Nov 2020 18:31:58 +0100
Message-Id: <20201103173159.27570-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201103173159.27570-1-nsaenzjulienne@suse.de>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't really list every setup in common code. On top of that they are
unlikely to stay true for long as things change in the arch trees
independently of this comment.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mmzone.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf696c05e..9d0c454d23cd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -354,26 +354,6 @@ enum zone_type {
 	 * DMA mask is assumed when ZONE_DMA32 is defined. Some 64-bit
 	 * platforms may need both zones as they support peripherals with
 	 * different DMA addressing limitations.
-	 *
-	 * Some examples:
-	 *
-	 *  - i386 and x86_64 have a fixed 16M ZONE_DMA and ZONE_DMA32 for the
-	 *    rest of the lower 4G.
-	 *
-	 *  - arm only uses ZONE_DMA, the size, up to 4G, may vary depending on
-	 *    the specific device.
-	 *
-	 *  - arm64 has a fixed 1G ZONE_DMA and ZONE_DMA32 for the rest of the
-	 *    lower 4G.
-	 *
-	 *  - powerpc only uses ZONE_DMA, the size, up to 2G, may vary
-	 *    depending on the specific device.
-	 *
-	 *  - s390 uses ZONE_DMA fixed to the lower 2G.
-	 *
-	 *  - ia64 and riscv only use ZONE_DMA32.
-	 *
-	 *  - parisc uses neither.
 	 */
 #ifdef CONFIG_ZONE_DMA
 	ZONE_DMA,
-- 
2.29.1

