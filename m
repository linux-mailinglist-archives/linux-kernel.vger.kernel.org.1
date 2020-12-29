Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2992F2E711D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgL2Nwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:52:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9943 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgL2Nwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:52:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D4wkG0rzdzhys4;
        Tue, 29 Dec 2020 21:48:54 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 21:49:24 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <rmfrfs@gmail.com>, <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] staging: greybus: light: Use kzalloc for allocating only one thing
Date:   Tue, 29 Dec 2020 21:50:03 +0800
Message-ID: <20201229135003.23416-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc rather than kcalloc(1,...)

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
@@

- kcalloc(1,
+ kzalloc(
          ...)
// </smpl>

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/staging/greybus/light.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index d2672b65c3f4..d227382fca20 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -290,7 +290,7 @@ static int channel_attr_groups_set(struct gb_channel *channel,
 	channel->attrs = kcalloc(size + 1, sizeof(*channel->attrs), GFP_KERNEL);
 	if (!channel->attrs)
 		return -ENOMEM;
-	channel->attr_group = kcalloc(1, sizeof(*channel->attr_group),
+	channel->attr_group = kzalloc(sizeof(*channel->attr_group),
 				      GFP_KERNEL);
 	if (!channel->attr_group)
 		return -ENOMEM;
-- 
2.22.0

