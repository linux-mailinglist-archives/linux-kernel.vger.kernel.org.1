Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52A51A9607
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635764AbgDOIRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:17:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635729AbgDOIQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:16:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 728E89E13340D9F954CC;
        Wed, 15 Apr 2020 16:16:55 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 16:16:44 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <michal.simek@xilinx.com>, <yanaijie@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] firmware: xilinx: make firmware_debugfs_root static
Date:   Wed, 15 Apr 2020 16:43:11 +0800
Message-ID: <20200415084311.24857-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

drivers/firmware/xilinx/zynqmp-debug.c:38:15: warning: symbol
'firmware_debugfs_root' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index c6d0724da4db..43bc6cfdab45 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -35,7 +35,7 @@ static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_QUERY_DATA),
 };
 
-struct dentry *firmware_debugfs_root;
+static struct dentry *firmware_debugfs_root;
 
 /**
  * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
-- 
2.21.1

