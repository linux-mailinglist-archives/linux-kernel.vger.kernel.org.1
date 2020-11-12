Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A4F2AFFD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 07:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgKLGow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 01:44:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8066 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLGov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 01:44:51 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CWsXN6H8HzLx8Y;
        Thu, 12 Nov 2020 14:44:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 14:44:41 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <rspringer@google.com>, <toddpoynor@google.com>,
        <benchan@chromium.org>, <rcy@google.com>,
        <gregkh@linuxfoundation.org>, <sque@chromium.org>,
        <jnjoseph@google.com>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] staging: gasket: interrupt: fix the missed eventfd_ctx_put() in gasket_interrupt.c
Date:   Thu, 12 Nov 2020 14:49:24 +0800
Message-ID: <20201112064924.99680-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gasket_interrupt_set_eventfd() misses to call eventfd_ctx_put() in an
error path. We check interrupt is valid before calling
eventfd_ctx_fdget() to fix it.

There is the same issue in gasket_interrupt_clear_eventfd(), Add the
missed function call to fix it.

Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex driver")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 2d6195f7300e..864342acfd86 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -487,14 +487,16 @@ int gasket_interrupt_system_status(struct gasket_dev *gasket_dev)
 int gasket_interrupt_set_eventfd(struct gasket_interrupt_data *interrupt_data,
 				 int interrupt, int event_fd)
 {
-	struct eventfd_ctx *ctx = eventfd_ctx_fdget(event_fd);
-
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
+	struct eventfd_ctx *ctx;
 
 	if (interrupt < 0 || interrupt >= interrupt_data->num_interrupts)
 		return -EINVAL;
 
+	ctx = eventfd_ctx_fdget(event_fd);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
 	interrupt_data->eventfd_ctxs[interrupt] = ctx;
 	return 0;
 }
@@ -505,6 +507,9 @@ int gasket_interrupt_clear_eventfd(struct gasket_interrupt_data *interrupt_data,
 	if (interrupt < 0 || interrupt >= interrupt_data->num_interrupts)
 		return -EINVAL;
 
-	interrupt_data->eventfd_ctxs[interrupt] = NULL;
+	if (interrupt_data->eventfd_ctxs[interrupt]) {
+		eventfd_ctx_put(interrupt_data->eventfd_ctxs[interrupt]);
+		interrupt_data->eventfd_ctxs[interrupt] = NULL;
+	}
 	return 0;
 }
-- 
2.17.1

