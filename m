Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D522D419
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 05:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGYDFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 23:05:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbgGYDFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:05:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B1F0FFCE756F0518781A;
        Sat, 25 Jul 2020 11:05:20 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Jul 2020
 11:05:07 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <viresh.kumar@linaro.org>, <greybus-dev@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] svc: add missed destroy_workqueue when gb_svc_create fails
Date:   Sat, 25 Jul 2020 11:06:37 +0800
Message-ID: <1595646397-53868-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

destroy_workqueue() should be called to destroy svc->wq
when gb_svc_create() init resources fails.

Fixes: 8465def499c7 ("staging: greybus: move the greybus core to drivers/greybus")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/greybus/svc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index ce7740e..38f858f 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -1340,6 +1340,7 @@ struct gb_svc *gb_svc_create(struct gb_host_device *hd)
 
 err_put_device:
 	put_device(&svc->dev);
+	destroy_workqueue(svc->wq);
 	return NULL;
 }
 
-- 
2.7.4

