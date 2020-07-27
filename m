Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E690822F5EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgG0RBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 13:01:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbgG0RBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:01:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30A38974B87AF2C0C6FF;
        Tue, 28 Jul 2020 01:01:32 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 01:01:21 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] powerpc/powernv/sriov: Remove unused but set variable 'phb'
Date:   Tue, 28 Jul 2020 01:11:12 +0800
Message-ID: <20200727171112.2781-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc report warning as follows:

arch/powerpc/platforms/powernv/pci-sriov.c:602:25: warning:
 variable 'phb' set but not used [-Wunused-but-set-variable]
  602 |  struct pnv_phb        *phb;
      |                         ^~~

This variable is not used, so this commit removing it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/powerpc/platforms/powernv/pci-sriov.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 8404d8c3901d..7894745fd4f8 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -599,10 +599,8 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 static void pnv_pci_sriov_disable(struct pci_dev *pdev)
 {
 	u16                    num_vfs, base_pe;
-	struct pnv_phb        *phb;
 	struct pnv_iov_data   *iov;
 
-	phb = pci_bus_to_pnvhb(pdev->bus);
 	iov = pnv_iov_get(pdev);
 	num_vfs = iov->num_vfs;
 	base_pe = iov->vf_pe_arr[0].pe_number;

