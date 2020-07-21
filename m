Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8D22832D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgGUPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 11:07:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51474 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729685AbgGUPHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:07:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CBF8F844C56D6A57C27;
        Tue, 21 Jul 2020 23:07:11 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 23:07:01 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mtd: rawnand: pasemi: Make pasemi_device_ready() static
Date:   Tue, 21 Jul 2020 23:16:57 +0800
Message-ID: <20200721151657.41027-1-weiyongjun1@huawei.com>
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

The sparse tool complains as follows:

drivers/mtd/nand/raw/pasemi_nand.c:71:5: warning:
 symbol 'pasemi_device_ready' was not declared. Should it be static?

This function is not used outside of pasemi_nand.c, so this commit
marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mtd/nand/raw/pasemi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
index d8eca8c3fdcd..81e2e667037e 100644
--- a/drivers/mtd/nand/raw/pasemi_nand.c
+++ b/drivers/mtd/nand/raw/pasemi_nand.c
@@ -68,7 +68,7 @@ static void pasemi_hwcontrol(struct nand_chip *chip, int cmd,
 	inl(lpcctl);
 }
 
-int pasemi_device_ready(struct nand_chip *chip)
+static int pasemi_device_ready(struct nand_chip *chip)
 {
 	return !!(inl(lpcctl) & LBICTRL_LPCCTL_NR);
 }

