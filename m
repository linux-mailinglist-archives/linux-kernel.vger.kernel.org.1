Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F55A2C71BD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbgK1VvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8215 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbgK1SeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:34:08 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CjnSD3CVZzkWdf;
        Sat, 28 Nov 2020 18:15:24 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Nov 2020 18:15:46 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, <dm-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH 1/3] dm ioctl: fix error return code in target_message
Date:   Sat, 28 Nov 2020 18:19:59 +0800
Message-ID: <20201128101959.95277-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 2ca4c92f58f9 ("dm ioctl: prevent empty message")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/md/dm-ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index cd0478d44..5e306bba4 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1600,6 +1600,7 @@ static int target_message(struct file *filp, struct dm_ioctl *param, size_t para
 
 	if (!argc) {
 		DMWARN("Empty message received.");
+		r = -EINVAL;
 		goto out_argv;
 	}
 
-- 
2.23.0

