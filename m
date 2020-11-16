Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098642B43C3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgKPMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:30:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8092 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgKPMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:30:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZT146fVGzLpLF;
        Mon, 16 Nov 2020 20:30:00 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 20:30:10 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <oohall@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] powerpc/powernv/sriov: Fix unsigned comparison to zero
Date:   Mon, 16 Nov 2020 20:41:55 +0800
Message-ID: <1605530515-69328-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warnings:

./arch/powerpc/platforms/powernv/pci-sriov.c:443:7-10: WARNING: Unsigned expression compared with zero: win < 0
./arch/powerpc/platforms/powernv/pci-sriov.c:462:7-10: WARNING: Unsigned expression compared with zero: win < 0

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 arch/powerpc/platforms/powernv/pci-sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index c4434f2..92fc861 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -422,7 +422,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
 {
 	struct pnv_iov_data   *iov;
 	struct pnv_phb        *phb;
-	unsigned int           win;
+	int		       win;
 	struct resource       *res;
 	int                    i, j;
 	int64_t                rc;
-- 
2.6.2

