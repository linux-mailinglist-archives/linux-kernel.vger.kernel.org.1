Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75322DABAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgLOLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:11:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:49714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbgLOLLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:11:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608030658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Yx7SevcBUttZRGBUgn4zpJi1UCc9qXZWWCyxJCQZZZI=;
        b=NV7BwIrwiGRFQaAQ96DIiW1UlD6Hby+vHIu/rM2INcEJ1fag87Bf4iwtbi51xV/LVwhL4h
        8vQ2G9q4P3cv2r+JkeedQ6A/lETc6SGYmEbelS/G9TIUSq5fWDNBu0M8Hiqz3azUYnoYa2
        yLUH8ytqC/GKmzvACYDQwY9AVnV1Yxw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF0FAAC7F;
        Tue, 15 Dec 2020 11:10:58 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2] xen/xenbus: make xs_talkv() interruptible
Date:   Tue, 15 Dec 2020 12:10:55 +0100
Message-Id: <20201215111055.3810-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a process waits for any Xenstore action in the xenbus driver
it should be interruptible by signals.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- don't special case SIGKILL as libxenstore is handling -EINTR fine
---
 drivers/xen/xenbus/xenbus_xs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3a06eb699f33..17c8f8a155fd 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -205,8 +205,15 @@ static bool test_reply(struct xb_req_data *req)
 
 static void *read_reply(struct xb_req_data *req)
 {
+	int ret;
+
 	do {
-		wait_event(req->wq, test_reply(req));
+		ret = wait_event_interruptible(req->wq, test_reply(req));
+
+		if (ret == -ERESTARTSYS && signal_pending(current)) {
+			req->msg.type = XS_ERROR;
+			return ERR_PTR(-EINTR);
+		}
 
 		if (!xenbus_ok())
 			/*
-- 
2.26.2

