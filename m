Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0717827429B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgIVNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgIVNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhCqGMhbTPpzuMxFH08XGb+AsIJ09aFNt8j1Zra1m9Q=;
        b=QLXJsFk5+xNpQ3Z9GGKUNzsxVCenPJipEz052zUAwDrpfkF1GV/zUGMwvSHCh6OfRXC07+
        3LO0u7V2OpO0+4SQm1fq/UieP/NDkfwaGclZz8XL3Iq+5IAjxaHZW6txqPbcSfoQzFzU1q
        13YdIBvj7gx9YWdHUnuINaV23hiVZtA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-P8Cq0BK5OZGMTdClNBMHhg-1; Tue, 22 Sep 2020 09:05:06 -0400
X-MC-Unique: P8Cq0BK5OZGMTdClNBMHhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3E0AADC00;
        Tue, 22 Sep 2020 13:05:04 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8632373670;
        Tue, 22 Sep 2020 13:05:02 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 09/13] firmware: arm_sdei: Remove while loop in sdei_event_unregister()
Date:   Tue, 22 Sep 2020 23:04:19 +1000
Message-Id: <20200922130423.10173-10-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the unnecessary while loop in sdei_event_unregister()
because of the following two reasons. This shouldn't cause any
functional changes.

   * The while loop is executed for once, meaning it's not needed
     in theory.
   * With the while loop removed, the nested statements can be
     avoid to make the code a bit cleaner.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/firmware/arm_sdei.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 6595bd66aa73..790bff70d169 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -491,24 +491,23 @@ int sdei_event_unregister(u32 event_num)
 
 	mutex_lock(&sdei_events_lock);
 	event = sdei_event_find(event_num);
-	do {
-		if (!event) {
-			pr_warn("Event %u not registered\n", event_num);
-			err = -ENOENT;
-			break;
-		}
+	if (!event) {
+		pr_warn("Event %u not registered\n", event_num);
+		err = -ENOENT;
+		goto unlock;
+	}
 
-		spin_lock(&sdei_list_lock);
-		event->reregister = false;
-		event->reenable = false;
-		spin_unlock(&sdei_list_lock);
+	spin_lock(&sdei_list_lock);
+	event->reregister = false;
+	event->reenable = false;
+	spin_unlock(&sdei_list_lock);
 
-		err = _sdei_event_unregister(event);
-		if (err)
-			break;
+	err = _sdei_event_unregister(event);
+	if (err)
+		goto unlock;
 
-		sdei_event_destroy(event);
-	} while (0);
+	sdei_event_destroy(event);
+unlock:
 	mutex_unlock(&sdei_events_lock);
 
 	return err;
-- 
2.23.0

