Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC442D990C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbgLNNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:39:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9200 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407981AbgLNNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:39:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CvjBD1L16zkq4x;
        Mon, 14 Dec 2020 21:37:40 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:38:19 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tty: moxa: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:38:49 +0800
Message-ID: <20201214133849.4052-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/tty/moxa.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 9f13f7d49dd7..a9b5bfb613d1 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -2036,10 +2036,10 @@ static int moxa_get_serial_info(struct tty_struct *tty,
 	if (!info)
 		return -ENODEV;
 	mutex_lock(&info->port.mutex);
-	ss->type = info->type,
-	ss->line = info->port.tty->index,
-	ss->flags = info->port.flags,
-	ss->baud_base = 921600,
+	ss->type = info->type;
+	ss->line = info->port.tty->index;
+	ss->flags = info->port.flags;
+	ss->baud_base = 921600;
 	ss->close_delay = info->port.close_delay;
 	mutex_unlock(&info->port.mutex);
 	return 0;
-- 
2.22.0

