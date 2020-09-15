Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4A269C46
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIODE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:04:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbgIODEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:04:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 04C4FDE06A4004652D42;
        Tue, 15 Sep 2020 11:04:03 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 11:03:52 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>
CC:     <greybus-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] staging: greybus: simplify the return expression of gb_svc_add()
Date:   Tue, 15 Sep 2020 11:26:30 +0800
Message-ID: <20200915032630.1772621-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/greybus/svc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index ce7740ef449b..dca251172cd2 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -1345,18 +1345,12 @@ struct gb_svc *gb_svc_create(struct gb_host_device *hd)
 
 int gb_svc_add(struct gb_svc *svc)
 {
-	int ret;
-
 	/*
 	 * The SVC protocol is currently driven by the SVC, so the SVC device
 	 * is added from the connection request handler when enough
 	 * information has been received.
 	 */
-	ret = gb_connection_enable(svc->connection);
-	if (ret)
-		return ret;
-
-	return 0;
+	return gb_connection_enable(svc->connection);
 }
 
 static void gb_svc_remove_modules(struct gb_svc *svc)
-- 
2.25.1

