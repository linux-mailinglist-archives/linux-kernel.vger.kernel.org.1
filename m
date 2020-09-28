Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1277F27AC38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgI1KtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:49:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14307 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbgI1KtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:49:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7BF8F6792C3B33BAAEFF;
        Mon, 28 Sep 2020 18:49:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 18:49:12 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <gregkh@linuxfoundation.org>, <christian.gromm@microchip.com>,
        <masahiroy@kernel.org>, <tglx@linutronix.de>,
        <keescook@chromium.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] staging: most: don't access hdm_ch before checking it valid
Date:   Mon, 28 Sep 2020 18:48:38 +0800
Message-ID: <20200928104838.189639-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In try_start_dim_transfer(), pointer hdm_ch is accessed before checking.
This may lead to a potential null pointer dereference. Fix this by
dereferencing hdm_ch after calling BUG_ON().

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/staging/most/dim2/dim2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 509c8012d20b..ccd7cc7545e4 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -148,7 +148,7 @@ void dimcb_on_error(u8 error_id, const char *error_message)
 static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
 {
 	u16 buf_size;
-	struct list_head *head = &hdm_ch->pending_list;
+	struct list_head *head;
 	struct mbo *mbo;
 	unsigned long flags;
 	struct dim_ch_state_t st;
@@ -156,6 +156,7 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
 	BUG_ON(!hdm_ch);
 	BUG_ON(!hdm_ch->is_initialized);
 
+	head = &hdm_ch->pending_list;
 	spin_lock_irqsave(&dim_lock, flags);
 	if (list_empty(head)) {
 		spin_unlock_irqrestore(&dim_lock, flags);
-- 
2.17.1

