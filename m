Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DDD28E705
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbgJNTMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:12:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:52400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389644AbgJNTM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:12:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2C14B1EA;
        Wed, 14 Oct 2020 19:12:24 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-mm@kvack.org
Subject: [PATCH v3 8/8] mm: Update DMA zones description
Date:   Wed, 14 Oct 2020 21:12:10 +0200
Message-Id: <20201014191211.27029-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201014191211.27029-1-nsaenzjulienne@suse.de>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default behavior for arm64 changed, so reflect that.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/linux/mmzone.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf696c05e..4ee2306351b9 100644
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

