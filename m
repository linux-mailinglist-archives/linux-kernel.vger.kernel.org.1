Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4212A9303
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKFJnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:43:39 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:5525 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgKFJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:43:39 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id D5413665B17;
        Fri,  6 Nov 2020 17:43:36 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] ntb: idt: fix error check in ntb_hw_idt.c
Date:   Fri,  6 Nov 2020 17:43:31 +0800
Message-Id: <1604655811-31933-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGR5NTBoYSh9KTh5CVkpNS09NTk5DSkxJT0hVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NyI6Hgw4Mj8jQhw4AxEvMw1K
        FhIaFCNVSlVKTUtPTU5OQ0pMTE9LVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKQk9DNwY+
X-HM-Tid: 0a759cf0a1a49373kuwsd5413665b17
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idt_create_dev never return NULL and fix smatch warning.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index d54261f..e7a4c2a
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2511,7 +2511,7 @@ static int idt_init_dbgfs(struct idt_ntb_dev *ndev)
 	/* If the top directory is not created then do nothing */
 	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
 		dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
-		return PTR_ERR(dbgfs_topdir);
+		return PTR_ERR_OR_ZERO(dbgfs_topdir);
 	}
 
 	/* Create the info file node */
@@ -2756,7 +2756,7 @@ static int idt_pci_probe(struct pci_dev *pdev,
 
 	/* Allocate the memory for IDT NTB device data */
 	ndev = idt_create_dev(pdev, id);
-	if (IS_ERR_OR_NULL(ndev))
+	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
 	/* Initialize the basic PCI subsystem of the device */
-- 
2.7.4

