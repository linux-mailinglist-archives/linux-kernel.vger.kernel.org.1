Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5DC2D3F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgLIKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:12:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:54144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbgLIKMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:12:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607508676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lp/BX/zYvTTJSC9VfCvCXfJRULVfbr1TBpetvpV+Cfo=;
        b=CDXncT75s8PkuuzKBjWJ+/rdiXZ+WdhzCg1/7T/SWjXNpddihYd5xSJe/k16ukZGzghXAm
        oQ5wTadzIhPc0MvnfNb9/0We/IXiQU3HkCllxc5/dTlKxjXA97f89OJGtaIHvVw/Sf4Cfm
        cO4sAMeS2KWjwBa/YpnQ4QkFWy+NO7Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC6CFAC94;
        Wed,  9 Dec 2020 10:11:16 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH] xen/xenbus: make xs_talkv() interruptible for SIGKILL
Date:   Wed,  9 Dec 2020 11:11:14 +0100
Message-Id: <20201209101114.31522-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a process waits for any Xenstore action in the xenbus driver
it should be interruptible via SIGKILL.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xenbus/xenbus_xs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 3a06eb699f33..1f4d3593e89e 100644
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
+		if (ret == -ERESTARTSYS && fatal_signal_pending(current)) {
+			req->msg.type = XS_ERROR;
+			return ERR_PTR(-EINTR);
+		}
 
 		if (!xenbus_ok())
 			/*
-- 
2.26.2

