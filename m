Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8772FE2F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAUGgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbhAUGfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:35:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58E8B23877;
        Thu, 21 Jan 2021 06:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611210827;
        bh=vNGgsCI7zczqFpYu62xY9dECe4uIHd42I4++YfliMGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lYPstG6yWvcqvw1L89t8VLSnNfPErBePn0/+oaJeYs2MP2aBXLIAwVHy94YzOVraY
         l1IM1Ggn8xz81CcOd626yhT39Qdz7hzW3kdWATV61MAmCP6C6eQrpE1NXWi/hOoIBf
         OafSm/rXboaDvv+pmh10LIqhBplbbaY41We7SgQGDFjsmozptEKu9/zAFv0B+R2gTC
         31KY9ioYC7bvuLgCt4Hxi1u2sCh79dG27qpdcQcUIbnqClC+7cFJPeagSKra+VebmW
         RxbbOdyF8I4g+0rrSRidmVO1Zg5DYbxZXQVsefGEHvyIF45iWc4ivSHwpr1PJ6w6kZ
         GpaHJbNAwq6cw==
From:   guoren@kernel.org
To:     palmerdabbelt@google.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: Fixup pfn_valid error with wrong max_mapnr
Date:   Thu, 21 Jan 2021 14:31:17 +0800
Message-Id: <20210121063117.3164494-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The max_mapnr is the number of PFNs, not absolute PFN offset.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bf5379135e39..1576ee9e5e94 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -184,7 +184,7 @@ void __init setup_bootmem(void)
 	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 	max_low_pfn = max_pfn;
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
-	set_max_mapnr(max_low_pfn);
+	set_max_mapnr(max_low_pfn - ARCH_PFN_OFFSET);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	setup_initrd();
-- 
2.17.1

