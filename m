Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04626DBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIQMrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:47:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbgIQMjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:39:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E600F45C0DBA7A1F6276;
        Thu, 17 Sep 2020 20:39:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:39:13 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     James Qian Wang <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        "Brian Starkey" <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next v2] drm/komeda: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 17 Sep 2020 20:39:49 +0800
Message-ID: <20200917123949.101925-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
v2: based on linux-next(20200917), and can be applied to
    mainline cleanly now.

 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 1d767473b..4a10e6b9e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -41,18 +41,7 @@ static int komeda_register_show(struct seq_file *sf, void *x)
 	return 0;
 }
 
-static int komeda_register_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, komeda_register_show, inode->i_private);
-}
-
-static const struct file_operations komeda_register_fops = {
-	.owner		= THIS_MODULE,
-	.open		= komeda_register_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(komeda_register);
 
 #ifdef CONFIG_DEBUG_FS
 static void komeda_debugfs_init(struct komeda_dev *mdev)
-- 
2.23.0

