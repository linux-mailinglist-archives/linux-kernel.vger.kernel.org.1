Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9734227429D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIVNF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbgIVNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KjwhOf+bbyvXDKHKM5B94n61AZZ19Z/R39dbQ40wdkw=;
        b=BE0m4Vj2D7BqmPidWEIQ1JlvsZ5jkTQojB3pg09Oi95GyziRn+2JX+5STekY+lmPlGRh8r
        7OpgOegGhv4aGeaJcrQZrhmhLKkeWvV7gK8G+huSkbISi2XeXdOHFB+ByZEVaW9aX6iAuu
        Gqa56RiPPy232pg4UFuAecpeQeQGVpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-AsJP0a6sP7yJsKZQfqIwHw-1; Tue, 22 Sep 2020 09:05:11 -0400
X-MC-Unique: AsJP0a6sP7yJsKZQfqIwHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59965801F9A;
        Tue, 22 Sep 2020 13:05:10 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4750B73689;
        Tue, 22 Sep 2020 13:05:07 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 11/13] firmware: arm_sdei: Introduce sdei_do_local_call()
Date:   Tue, 22 Sep 2020 23:04:21 +1000
Message-Id: <20200922130423.10173-12-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the CPU hotplug, the private events are registered, enabled
or unregistered on the specific CPU. It repeats the same steps:
initializing cross call argument, make function call on local CPU,
check the returned error.

This introduces sdei_do_local_call() to cover the first steps. The
other benefit is to make CROSSCALL_INIT and struct sdei_crosscall_args
are only visible to sdei_do_{cross, local}_call().

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 41 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 786c1b6d4af3..cf1a37b40e24 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -85,6 +85,17 @@ struct sdei_crosscall_args {
 		atomic_set(&arg.errors, 0);	\
 	} while (0)
 
+static inline int sdei_do_local_call(smp_call_func_t fn,
+				     struct sdei_event *event)
+{
+	struct sdei_crosscall_args arg;
+
+	CROSSCALL_INIT(arg, event);
+	fn(&arg);
+
+	return arg.first_error;
+}
+
 static inline int sdei_do_cross_call(smp_call_func_t fn,
 				     struct sdei_event *event)
 {
@@ -677,7 +688,7 @@ static int sdei_reregister_shared(void)
 static int sdei_cpuhp_down(unsigned int cpu)
 {
 	struct sdei_event *event;
-	struct sdei_crosscall_args arg;
+	int err;
 
 	/* un-register private events */
 	spin_lock(&sdei_list_lock);
@@ -685,12 +696,11 @@ static int sdei_cpuhp_down(unsigned int cpu)
 		if (event->type == SDEI_EVENT_TYPE_SHARED)
 			continue;
 
-		CROSSCALL_INIT(arg, event);
-		/* call the cross-call function locally... */
-		_local_event_unregister(&arg);
-		if (arg.first_error)
+		err = sdei_do_local_call(_local_event_unregister, event);
+		if (err) {
 			pr_err("Failed to unregister event %u: %d\n",
-			       event->event_num, arg.first_error);
+			       event->event_num, err);
+		}
 	}
 	spin_unlock(&sdei_list_lock);
 
@@ -700,7 +710,7 @@ static int sdei_cpuhp_down(unsigned int cpu)
 static int sdei_cpuhp_up(unsigned int cpu)
 {
 	struct sdei_event *event;
-	struct sdei_crosscall_args arg;
+	int err;
 
 	/* re-register/enable private events */
 	spin_lock(&sdei_list_lock);
@@ -709,20 +719,19 @@ static int sdei_cpuhp_up(unsigned int cpu)
 			continue;
 
 		if (event->reregister) {
-			CROSSCALL_INIT(arg, event);
-			/* call the cross-call function locally... */
-			_local_event_register(&arg);
-			if (arg.first_error)
+			err = sdei_do_local_call(_local_event_register, event);
+			if (err) {
 				pr_err("Failed to re-register event %u: %d\n",
-				       event->event_num, arg.first_error);
+				       event->event_num, err);
+			}
 		}
 
 		if (event->reenable) {
-			CROSSCALL_INIT(arg, event);
-			_local_event_enable(&arg);
-			if (arg.first_error)
+			err = sdei_do_local_call(_local_event_enable, event);
+			if (err) {
 				pr_err("Failed to re-enable event %u: %d\n",
-				       event->event_num, arg.first_error);
+				       event->event_num, err);
+			}
 		}
 	}
 	spin_unlock(&sdei_list_lock);
-- 
2.23.0

