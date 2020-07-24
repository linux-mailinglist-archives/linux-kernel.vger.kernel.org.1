Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD42722C2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 12:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGXKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 06:10:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgGXKKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:10:46 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B969143A83EE02C61C15;
        Fri, 24 Jul 2020 18:10:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Jul 2020
 18:10:34 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] io_uring: Semicolon cleanups in io_uring.c
Date:   Fri, 24 Jul 2020 18:10:16 +0800
Message-ID: <20200724101016.48539-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop extra trailing Semicolon.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f81d36d78594..cf71c698e497 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4007,7 +4007,7 @@ static int io_send(struct io_kiocb *req, bool force_nonblock,
 
 	ret = import_single_range(WRITE, sr->buf, sr->len, &iov, &msg.msg_iter);
 	if (unlikely(ret))
-		return ret;;
+		return ret;
 
 	msg.msg_name = NULL;
 	msg.msg_control = NULL;
-- 
2.17.1

