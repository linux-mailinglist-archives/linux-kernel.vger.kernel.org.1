Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30D1C816E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 07:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgEGFSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 01:18:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3831 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgEGFSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:18:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 41BE2419C58FC7F755E5;
        Thu,  7 May 2020 13:18:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 13:18:08 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     David Kershner <david.kershner@unisys.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <sparmaintainer@unisys.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] visorbus: fix error return code in visorchipset_init()
Date:   Thu, 7 May 2020 05:22:11 +0000
Message-ID: <20200507052211.103018-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return negative error code -ENODEV from the visor_check_channel()
error handling case instead of 0. Also change the error code to -ENOMEM
in kzalloc() error case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/visorbus/visorchipset.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/visorbus/visorchipset.c b/drivers/visorbus/visorchipset.c
index cb1eb7e05f87..5668cad86e37 100644
--- a/drivers/visorbus/visorchipset.c
+++ b/drivers/visorbus/visorchipset.c
@@ -1561,7 +1561,7 @@ static void controlvm_periodic_work(struct work_struct *work)
 
 static int visorchipset_init(struct acpi_device *acpi_device)
 {
-	int err = -ENODEV;
+	int err = -ENOMEM;
 	struct visorchannel *controlvm_channel;
 
 	chipset_dev = kzalloc(sizeof(*chipset_dev), GFP_KERNEL);
@@ -1584,8 +1584,10 @@ static int visorchipset_init(struct acpi_device *acpi_device)
 				 "controlvm",
 				 sizeof(struct visor_controlvm_channel),
 				 VISOR_CONTROLVM_CHANNEL_VERSIONID,
-				 VISOR_CHANNEL_SIGNATURE))
+				 VISOR_CHANNEL_SIGNATURE)) {
+		err = -ENODEV;
 		goto error_delete_groups;
+	}
 	/* if booting in a crash kernel */
 	if (is_kdump_kernel())
 		INIT_DELAYED_WORK(&chipset_dev->periodic_controlvm_work,



