Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BBF274294
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVNEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbgIVNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXXHQcFb7gymmjp65ADoyP/L0SPyAaT1S5TkZkbvSPM=;
        b=TVwf0h1Wtexyy46tLt0HsqdEOIBV6PhlFezfDSkEuFNzNwO8UVqrYpe5/8oAJWYvqfeAUd
        Tk0AEl4rzdIBGV0aycIz0PjjJA/LHcsipI2+Zyu1RRvZRNvfpiccHSmK3wL2g8qXKEemRp
        ncCx3BhjG0/nl/P4qiVGXTY3OVhWURo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-2lYE5RBaM_-wtTFhn3YD-Q-1; Tue, 22 Sep 2020 09:04:48 -0400
X-MC-Unique: 2lYE5RBaM_-wtTFhn3YD-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA43ADC04;
        Tue, 22 Sep 2020 13:04:47 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7A6A73670;
        Tue, 22 Sep 2020 13:04:44 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 02/13] firmware: arm_sdei: Common block for failing path in sdei_event_create()
Date:   Tue, 22 Sep 2020 23:04:12 +1000
Message-Id: <20200922130423.10173-3-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple calls of kfree(event) in the failing path of
sdei_event_create() to free the SDEI event. It means we need to
call it again when adding more code in the failing path. It's
prone to miss doing that and introduce memory leakage.

This introduces common block for failing path in sdei_event_create()
to resolve the issue. This shouldn't cause functional changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 2d256b2ed4b4..a126ab7e3490 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -190,33 +190,31 @@ static struct sdei_event *sdei_event_create(u32 event_num,
 	lockdep_assert_held(&sdei_events_lock);
 
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
-	if (!event)
-		return ERR_PTR(-ENOMEM);
+	if (!event) {
+		err = -ENOMEM;
+		goto fail;
+	}
 
 	INIT_LIST_HEAD(&event->list);
 	event->event_num = event_num;
 
 	err = sdei_api_event_get_info(event_num, SDEI_EVENT_INFO_EV_PRIORITY,
 				      &result);
-	if (err) {
-		kfree(event);
-		return ERR_PTR(err);
-	}
+	if (err)
+		goto fail;
 	event->priority = result;
 
 	err = sdei_api_event_get_info(event_num, SDEI_EVENT_INFO_EV_TYPE,
 				      &result);
-	if (err) {
-		kfree(event);
-		return ERR_PTR(err);
-	}
+	if (err)
+		goto fail;
 	event->type = result;
 
 	if (event->type == SDEI_EVENT_TYPE_SHARED) {
 		reg = kzalloc(sizeof(*reg), GFP_KERNEL);
 		if (!reg) {
-			kfree(event);
-			return ERR_PTR(-ENOMEM);
+			err = -ENOMEM;
+			goto fail;
 		}
 
 		reg->event_num = event_num;
@@ -231,8 +229,8 @@ static struct sdei_event *sdei_event_create(u32 event_num,
 
 		regs = alloc_percpu(struct sdei_registered_event);
 		if (!regs) {
-			kfree(event);
-			return ERR_PTR(-ENOMEM);
+			err = -ENOMEM;
+			goto fail;
 		}
 
 		for_each_possible_cpu(cpu) {
@@ -252,6 +250,10 @@ static struct sdei_event *sdei_event_create(u32 event_num,
 	spin_unlock(&sdei_list_lock);
 
 	return event;
+
+fail:
+	kfree(event);
+	return ERR_PTR(err);
 }
 
 static void sdei_event_destroy_llocked(struct sdei_event *event)
-- 
2.23.0

