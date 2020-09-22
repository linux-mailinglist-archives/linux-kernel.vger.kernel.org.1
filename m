Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB627429C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIVNFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726733AbgIVNFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vucNpfuwz7wsHWP7lIOEnbwwpZRvCD9WhkDs3cYmEX0=;
        b=NsMYc0GELln0+mkjGUQQxhQMUBsgYDG9HNVrsYeZeFBs8+UkM1M2sppN4lUT9hYjkrYvL4
        5s1XzbnrkDJk27oWYzpJMA1FLdzzbBVyOJHC0bh3Z6ItluzcMWdKUwWNHCENKYYjaXI0sc
        /BdGK4iYU5TKZwCS4NEfk7wh1vV9aQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-95cWHzoSM1S4vQpbsj_7oA-1; Tue, 22 Sep 2020 09:05:14 -0400
X-MC-Unique: 95cWHzoSM1S4vQpbsj_7oA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E22841017DC8;
        Tue, 22 Sep 2020 13:05:12 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B765573682;
        Tue, 22 Sep 2020 13:05:10 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 12/13] firmware: arm_sdei: Remove _sdei_event_register()
Date:   Tue, 22 Sep 2020 23:04:22 +1000
Message-Id: <20200922130423.10173-13-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function _sdei_event_register() is called by sdei_event_register()
and sdei_device_thaw() as the following functional call chain shows.
_sdei_event_register() covers the shared and private events, but
sdei_device_thaw() only covers the shared events. So the logic to
cover the private events in _sdei_event_register() isn't needed by
sdei_device_thaw().

Similarly, sdei_reregister_event_llocked() covers the shared and
private events in the regard of reenablement. The logic to cover
the private events isn't needed by sdei_device_thaw() either.

   sdei_event_register          sdei_device_thaw
      _sdei_event_register         sdei_reregister_shared
                                      sdei_reregister_event_llocked
                                         _sdei_event_register

This removes _sdei_event_register() and sdei_reregister_event_llocked().
Their logic is moved to sdei_event_register() and sdei_reregister_shared().
This shouldn't cause any logical changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 77 ++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 49 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index cf1a37b40e24..361d142ad2a8 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -577,25 +577,6 @@ static void _local_event_register(void *data)
 	sdei_cross_call_return(arg, err);
 }
 
-static int _sdei_event_register(struct sdei_event *event)
-{
-	int err;
-
-	lockdep_assert_held(&sdei_events_lock);
-
-	if (event->type == SDEI_EVENT_TYPE_SHARED)
-		return sdei_api_event_register(event->event_num,
-					       sdei_entry_point,
-					       event->registered,
-					       SDEI_EVENT_REGISTER_RM_ANY, 0);
-
-	err = sdei_do_cross_call(_local_event_register, event);
-	if (err)
-		sdei_do_cross_call(_local_event_unregister, event);
-
-	return err;
-}
-
 int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 {
 	int err;
@@ -618,7 +599,17 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 	}
 
 	cpus_read_lock();
-	err = _sdei_event_register(event);
+	if (event->type == SDEI_EVENT_TYPE_SHARED) {
+		err = sdei_api_event_register(event->event_num,
+					      sdei_entry_point,
+					      event->registered,
+					      SDEI_EVENT_REGISTER_RM_ANY, 0);
+	} else {
+		err = sdei_do_cross_call(_local_event_register, event);
+		if (err)
+			sdei_do_cross_call(_local_event_unregister, event);
+	}
+
 	if (err) {
 		sdei_event_destroy(event);
 		pr_warn("Failed to register event %u: %d\n", event_num, err);
@@ -635,33 +626,6 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 	return err;
 }
 
-static int sdei_reregister_event_llocked(struct sdei_event *event)
-{
-	int err;
-
-	lockdep_assert_held(&sdei_events_lock);
-	lockdep_assert_held(&sdei_list_lock);
-
-	err = _sdei_event_register(event);
-	if (err) {
-		pr_err("Failed to re-register event %u\n", event->event_num);
-		sdei_event_destroy_llocked(event);
-		return err;
-	}
-
-	if (event->reenable) {
-		if (event->type == SDEI_EVENT_TYPE_SHARED)
-			err = sdei_api_event_enable(event->event_num);
-		else
-			err = sdei_do_cross_call(_local_event_enable, event);
-	}
-
-	if (err)
-		pr_err("Failed to re-enable event %u\n", event->event_num);
-
-	return err;
-}
-
 static int sdei_reregister_shared(void)
 {
 	int err = 0;
@@ -674,9 +638,24 @@ static int sdei_reregister_shared(void)
 			continue;
 
 		if (event->reregister) {
-			err = sdei_reregister_event_llocked(event);
-			if (err)
+			err = sdei_api_event_register(event->event_num,
+					sdei_entry_point, event->registered,
+					SDEI_EVENT_REGISTER_RM_ANY, 0);
+			if (err) {
+				pr_err("Failed to re-register event %u\n",
+				       event->event_num);
+				sdei_event_destroy_llocked(event);
 				break;
+			}
+		}
+
+		if (event->reenable) {
+			err = sdei_api_event_enable(event->event_num);
+			if (err) {
+				pr_err("Failed to re-enable event %u\n",
+				       event->event_num);
+				break;
+			}
 		}
 	}
 	spin_unlock(&sdei_list_lock);
-- 
2.23.0

