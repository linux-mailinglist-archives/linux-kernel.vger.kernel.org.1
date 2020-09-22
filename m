Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4527429A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIVNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgIVNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCazxR82tIjJ7CXuFLgKuutUERgYiVj/OOCuAnVnNZM=;
        b=gzat75StrYGcke67GEr/PwIzEHD8ST8jFp2BMGimby7d/P6x4LyHmGU+uJbowpNi9RF+Xg
        KXdGDqg0Zhk0RV83DwLNXUw+M4fqSQrX7go+Nl9Nd7lrxnL/S4F4HCsmhf4x7+ecudoRuG
        EN7zuo7U2elMT2bHaS6ZdmmQSlefkws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-ekLOwJ-ZOUmFj7gP2au11g-1; Tue, 22 Sep 2020 09:05:03 -0400
X-MC-Unique: ekLOwJ-ZOUmFj7gP2au11g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A5561891E88;
        Tue, 22 Sep 2020 13:05:02 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 187CD73670;
        Tue, 22 Sep 2020 13:04:59 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 08/13] firmware: arm_sdei: Remove while loop in sdei_event_register()
Date:   Tue, 22 Sep 2020 23:04:18 +1000
Message-Id: <20200922130423.10173-9-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the unnecessary while loop in sdei_event_register()
because of the following two reasons. This shouldn't cause any
functional changes.

   * The while loop is executed for once, meaning it's not needed
     in theory.
   * With the while loop removed, the nested statements can be
     avoid to make the code a bit cleaner.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/firmware/arm_sdei.c | 52 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 4caeef3e1e0b..6595bd66aa73 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -590,36 +590,34 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 	WARN_ON(in_nmi());
 
 	mutex_lock(&sdei_events_lock);
-	do {
-		if (sdei_event_find(event_num)) {
-			pr_warn("Event %u already registered\n", event_num);
-			err = -EBUSY;
-			break;
-		}
+	if (sdei_event_find(event_num)) {
+		pr_warn("Event %u already registered\n", event_num);
+		err = -EBUSY;
+		goto unlock;
+	}
 
-		event = sdei_event_create(event_num, cb, arg);
-		if (IS_ERR(event)) {
-			err = PTR_ERR(event);
-			pr_warn("Failed to create event %u: %d\n", event_num,
-				err);
-			break;
-		}
+	event = sdei_event_create(event_num, cb, arg);
+	if (IS_ERR(event)) {
+		err = PTR_ERR(event);
+		pr_warn("Failed to create event %u: %d\n", event_num, err);
+		goto unlock;
+	}
 
-		cpus_read_lock();
-		err = _sdei_event_register(event);
-		if (err) {
-			sdei_event_destroy(event);
-			pr_warn("Failed to register event %u: %d\n", event_num,
-				err);
-		} else {
-			spin_lock(&sdei_list_lock);
-			event->reregister = true;
-			spin_unlock(&sdei_list_lock);
-		}
-		cpus_read_unlock();
-	} while (0);
-	mutex_unlock(&sdei_events_lock);
+	cpus_read_lock();
+	err = _sdei_event_register(event);
+	if (err) {
+		sdei_event_destroy(event);
+		pr_warn("Failed to register event %u: %d\n", event_num, err);
+		goto cpu_unlock;
+	}
 
+	spin_lock(&sdei_list_lock);
+	event->reregister = true;
+	spin_unlock(&sdei_list_lock);
+cpu_unlock:
+	cpus_read_unlock();
+unlock:
+	mutex_unlock(&sdei_events_lock);
 	return err;
 }
 
-- 
2.23.0

