Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9817024072D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 16:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgHJOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 10:06:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33154 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgHJOGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:06:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k58RL-0006k2-Lv; Mon, 10 Aug 2020 14:06:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of/address: check for invalid range.cpu_addr
Date:   Mon, 10 Aug 2020 15:06:15 +0100
Message-Id: <20200810140615.6113-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently invalid CPU addresses are not being sanity checked resulting in
SATA setup failure on a SynQuacer SC2A11 development machine. The original
check was removed by and earlier commit, so add a sanity check back in
to avoid this regression.

Fixes: 7a8b64d17e35 ("of/address: use range parser for of_dma_get_range")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/of/address.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 590493e04b01..764c8b94ec35 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -985,6 +985,11 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 			/* Don't error out as we'd break some existing DTs */
 			continue;
 		}
+		if (range.cpu_addr == OF_BAD_ADDR) {
+			pr_warn("Translation of DMA address (%llx) to CPU address failed on node (%pOF)\n",
+				range.cpu_addr, node);
+			continue;
+		}
 		dma_offset = range.cpu_addr - range.bus_addr;
 
 		/* Take lower and upper limits */
-- 
2.25.1

