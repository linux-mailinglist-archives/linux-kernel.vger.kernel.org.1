Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F5265DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgIKKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 06:23:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36715 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgIKKX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:23:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kGgDC-0003Vv-7r; Fri, 11 Sep 2020 10:23:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: remove redundant assignment to pointer eb
Date:   Fri, 11 Sep 2020 11:23:21 +0100
Message-Id: <20200911102321.22515-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer eb is being assigned a value that is never read, the assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/mtdswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index 58eefa43af14..795dec4483c2 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -1053,7 +1053,6 @@ static int mtdswap_writesect(struct mtd_blktrans_dev *dev,
 	if (ret < 0)
 		return ret;
 
-	eb = d->eb_data + (newblock / d->pages_per_eblk);
 	d->page_data[page] = newblock;
 
 	return 0;
-- 
2.27.0

