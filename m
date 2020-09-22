Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E968274293
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIVNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgIVNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XxM7MKaJ1BALXcudF9CtnaYMkyANiLbV3yHmtLh8dWE=;
        b=VS9u8WxYpJkYQhYGNCDBEemNtAtovmZ8ce2cs7jHQOzOJ+y/5wqX/B0H7m1/X8WTMSBlj/
        leFPtYdL1cjbcnrwUhM7bMf4u3HpTLsGzKhOYevD5CQDu+h1nFNLv6m6H0eS5eYxuQu5s+
        9+HUMLv37FKZ3RUqMaozxbecFdQa/DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-3KDJ0wUmNWe2zWMJkLzUrw-1; Tue, 22 Sep 2020 09:04:46 -0400
X-MC-Unique: 3KDJ0wUmNWe2zWMJkLzUrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 720CD801AE3;
        Tue, 22 Sep 2020 13:04:44 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4399273670;
        Tue, 22 Sep 2020 13:04:42 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 01/13] firmware: arm_sdei: Remove sdei_is_err()
Date:   Tue, 22 Sep 2020 23:04:11 +1000
Message-Id: <20200922130423.10173-2-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdei_is_err() is only called by sdei_to_linux_errno(). The logic of
checking on the error number is common to them. They can be combined
finely.

This removes sdei_is_err() and its logic is combined to the function
sdei_to_linux_errno(). Also, the assignment of @err to zero is also
dropped in invoke_sdei_fn() because it's always overridden afterwards.
This shouldn't cause functional changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/firmware/arm_sdei.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index b4b9ce97f415..2d256b2ed4b4 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -114,26 +114,7 @@ static int sdei_to_linux_errno(unsigned long sdei_err)
 		return -ENOMEM;
 	}
 
-	/* Not an error value ... */
-	return sdei_err;
-}
-
-/*
- * If x0 is any of these values, then the call failed, use sdei_to_linux_errno()
- * to translate.
- */
-static int sdei_is_err(struct arm_smccc_res *res)
-{
-	switch (res->a0) {
-	case SDEI_NOT_SUPPORTED:
-	case SDEI_INVALID_PARAMETERS:
-	case SDEI_DENIED:
-	case SDEI_PENDING:
-	case SDEI_OUT_OF_RESOURCE:
-		return true;
-	}
-
-	return false;
+	return 0;
 }
 
 static int invoke_sdei_fn(unsigned long function_id, unsigned long arg0,
@@ -141,14 +122,13 @@ static int invoke_sdei_fn(unsigned long function_id, unsigned long arg0,
 			  unsigned long arg3, unsigned long arg4,
 			  u64 *result)
 {
-	int err = 0;
+	int err;
 	struct arm_smccc_res res;
 
 	if (sdei_firmware_call) {
 		sdei_firmware_call(function_id, arg0, arg1, arg2, arg3, arg4,
 				   &res);
-		if (sdei_is_err(&res))
-			err = sdei_to_linux_errno(res.a0);
+		err = sdei_to_linux_errno(res.a0);
 	} else {
 		/*
 		 * !sdei_firmware_call means we failed to probe or called
-- 
2.23.0

