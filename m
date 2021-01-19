Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07D2FAF24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 04:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbhASDcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 22:32:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11033 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbhASDb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 22:31:58 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DKZ0c28kFzj9VZ;
        Tue, 19 Jan 2021 11:30:08 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.151.207) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 19 Jan 2021 11:31:05 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <longpeng2@huawei.com>, <arei.gonglei@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] nitro_enclaves: set master in the procedure of NE probe
Date:   Tue, 19 Jan 2021 11:30:59 +0800
Message-ID: <20210119033059.1467-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.207]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the PCI spec:
  Bus Master Enable – Controls the ability of a PCI Express
  Endpoint to issue Memory and I/O Read/Write Requests, and
  the ability of a Root or Switch Port to forward Memory and
  I/O Read/Write Requests in the Upstream direction

Set BusMaster to make the driver to be PCI conformant.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/virt/nitro_enclaves/ne_pci_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virt/nitro_enclaves/ne_pci_dev.c b/drivers/virt/nitro_enclaves/ne_pci_dev.c
index b9c1de4..143207e 100644
--- a/drivers/virt/nitro_enclaves/ne_pci_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_pci_dev.c
@@ -480,6 +480,8 @@ static int ne_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto free_ne_pci_dev;
 	}
 
+	pci_set_master(pdev);
+
 	rc = pci_request_regions_exclusive(pdev, "nitro_enclaves");
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Error in pci request regions [rc=%d]\n", rc);
-- 
1.8.3.1

