Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452C32A88E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgKEVWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:22:32 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732286AbgKEVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:22:20 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ECA5940066;
        Thu,  5 Nov 2020 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604611339; bh=mNfE+zkMa68VxwrMuN4ESnNP3XrXt4EiRox8Wp8ljDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeRhFH/7jsEvdoyqmRjC2VyNhaRJN59VCn8iw8pdGe4irOsQLyVz420H19M5wjhJv
         XsA2r3A5rVIpc94I4DzXke33eW2jGfLuzIHH5UGci5R2frYIlET5Vkq5X9L0oBftTO
         ZBTI8r4JUREHPO3YK6/eH0q7/nxP4Gl9GB+Y15NJVZIquUdEaVgOWCAWWiNhk++jKP
         wUBGOrELltwwjJ3ZR4jbzevq28fIvdzWdJn3XYXj6sTwcm+ojmeSZZ54NbNQNax2+c
         gEanMzaBtHQHTzpzmCNs6SkupnzxY/qqnu53wfHjMNgr4ByIlnDwFydhYRLWqDPX7i
         5BUTyWlTUMmpA==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 17282A022B;
        Thu,  5 Nov 2020 21:22:18 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 3/3] include/soc: remove headers for EZChip NPS
Date:   Thu,  5 Nov 2020 13:22:10 -0800
Message-Id: <20201105212210.1891598-4-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105212210.1891598-1-vgupta@synopsys.com>
References: <20201105212210.1891598-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPS platform has been removed from ARC port and there are no in-tree
user of it now . So RIP !

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/soc/nps/common.h | 172 ---------------------------------------
 include/soc/nps/mtm.h    |  59 --------------
 2 files changed, 231 deletions(-)
 delete mode 100644 include/soc/nps/common.h
 delete mode 100644 include/soc/nps/mtm.h

diff --git a/include/soc/nps/common.h b/include/soc/nps/common.h
deleted file mode 100644
index 8c18dc6d3fde..000000000000
--- a/include/soc/nps/common.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * Copyright (c) 2016, Mellanox Technologies. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#ifndef SOC_NPS_COMMON_H
-#define SOC_NPS_COMMON_H
-
-#ifdef CONFIG_SMP
-#define NPS_IPI_IRQ					5
-#endif
-
-#define NPS_HOST_REG_BASE			0xF6000000
-
-#define NPS_MSU_BLKID				0x018
-
-#define CTOP_INST_RSPI_GIC_0_R12		0x3C56117E
-#define CTOP_INST_MOV2B_FLIP_R3_B1_B2_INST	0x5B60
-#define CTOP_INST_MOV2B_FLIP_R3_B1_B2_LIMM	0x00010422
-
-#ifndef AUX_IENABLE
-#define AUX_IENABLE				0x40c
-#endif
-
-#define CTOP_AUX_IACK				(0xFFFFF800 + 0x088)
-
-#ifndef __ASSEMBLY__
-
-/* In order to increase compilation test coverage */
-#ifdef CONFIG_ARC
-static inline void nps_ack_gic(void)
-{
-	__asm__ __volatile__ (
-	"       .word %0\n"
-	:
-	: "i"(CTOP_INST_RSPI_GIC_0_R12)
-	: "memory");
-}
-#else
-static inline void nps_ack_gic(void) { }
-#define write_aux_reg(r, v)
-#define read_aux_reg(r) 0
-#endif
-
-/* CPU global ID */
-struct global_id {
-	union {
-		struct {
-#ifdef CONFIG_EZNPS_MTM_EXT
-			u32 __reserved:20, cluster:4, core:4, thread:4;
-#else
-			u32 __reserved:24, cluster:4, core:4;
-#endif
-		};
-		u32 value;
-	};
-};
-
-/*
- * Convert logical to physical CPU IDs
- *
- * The conversion swap bits 1 and 2 of cluster id (out of 4 bits)
- * Now quad of logical clusters id's are adjacent physically,
- * and not like the id's physically came with each cluster.
- * Below table is 4x4 mesh of core clusters as it layout on chip.
- * Cluster ids are in format: logical (physical)
- *
- *    -----------------   ------------------
- * 3 |  5 (3)   7 (7)  | | 13 (11)   15 (15)|
- *
- * 2 |  4 (2)   6 (6)  | | 12 (10)   14 (14)|
- *    -----------------   ------------------
- * 1 |  1 (1)   3 (5)  | |  9  (9)   11 (13)|
- *
- * 0 |  0 (0)   2 (4)  | |  8  (8)   10 (12)|
- *    -----------------   ------------------
- *       0       1            2        3
- */
-static inline int nps_cluster_logic_to_phys(int cluster)
-{
-#ifdef __arc__
-	 __asm__ __volatile__(
-	"       mov r3,%0\n"
-	"       .short %1\n"
-	"       .word %2\n"
-	"       mov %0,r3\n"
-	: "+r"(cluster)
-	: "i"(CTOP_INST_MOV2B_FLIP_R3_B1_B2_INST),
-	  "i"(CTOP_INST_MOV2B_FLIP_R3_B1_B2_LIMM)
-	: "r3");
-#endif
-
-	return cluster;
-}
-
-#define NPS_CPU_TO_CLUSTER_NUM(cpu) \
-	({ struct global_id gid; gid.value = cpu; \
-		nps_cluster_logic_to_phys(gid.cluster); })
-
-struct nps_host_reg_address {
-	union {
-		struct {
-			u32 base:8, cl_x:4, cl_y:4,
-			blkid:6, reg:8, __reserved:2;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_address_non_cl {
-	union {
-		struct {
-			u32 base:7, blkid:11, reg:12, __reserved:2;
-		};
-		u32 value;
-	};
-};
-
-static inline void *nps_host_reg_non_cl(u32 blkid, u32 reg)
-{
-	struct nps_host_reg_address_non_cl reg_address;
-
-	reg_address.value = NPS_HOST_REG_BASE;
-	reg_address.blkid = blkid;
-	reg_address.reg = reg;
-
-	return (void *)reg_address.value;
-}
-
-static inline void *nps_host_reg(u32 cpu, u32 blkid, u32 reg)
-{
-	struct nps_host_reg_address reg_address;
-	u32 cl = NPS_CPU_TO_CLUSTER_NUM(cpu);
-
-	reg_address.value = NPS_HOST_REG_BASE;
-	reg_address.cl_x  = (cl >> 2) & 0x3;
-	reg_address.cl_y  = cl & 0x3;
-	reg_address.blkid = blkid;
-	reg_address.reg   = reg;
-
-	return (void *)reg_address.value;
-}
-#endif /* __ASSEMBLY__ */
-
-#endif /* SOC_NPS_COMMON_H */
diff --git a/include/soc/nps/mtm.h b/include/soc/nps/mtm.h
deleted file mode 100644
index d2f5e7e3703e..000000000000
--- a/include/soc/nps/mtm.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * Copyright (c) 2016, Mellanox Technologies. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#ifndef SOC_NPS_MTM_H
-#define SOC_NPS_MTM_H
-
-#define CTOP_INST_HWSCHD_OFF_R3                 0x3B6F00BF
-#define CTOP_INST_HWSCHD_RESTORE_R3             0x3E6F70C3
-
-static inline void hw_schd_save(unsigned int *flags)
-{
-	__asm__ __volatile__(
-	"       .word %1\n"
-	"       st r3,[%0]\n"
-	:
-	: "r"(flags), "i"(CTOP_INST_HWSCHD_OFF_R3)
-	: "r3", "memory");
-}
-
-static inline void hw_schd_restore(unsigned int flags)
-{
-	__asm__ __volatile__(
-	"       mov r3, %0\n"
-	"       .word %1\n"
-	:
-	: "r"(flags), "i"(CTOP_INST_HWSCHD_RESTORE_R3)
-	: "r3");
-}
-
-#endif /* SOC_NPS_MTM_H */
-- 
2.25.1

