Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F592742A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIVNFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgIVNFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600779922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDKWtwkeX6PwhHnYzLP/HsSC6dugF73xZ+cl9YQHuxI=;
        b=XC9CkxedBSs6NsFlR4FWy19mmBt5bXwcshKRTAwb7UEseS/ddxFUPXewkIeiZNm/nqfCXf
        TUp/KtKGrkY2uP+PvePHj0D51W3d16ff38fpyOYSpgTKorb+uWKshuZhiVbnRos+92QN48
        4YZsROgcx5+9ZsZN71fbCvacmh8Uyew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-IlwrXy6-O0Cx7jmVIILn-A-1; Tue, 22 Sep 2020 09:05:18 -0400
X-MC-Unique: IlwrXy6-O0Cx7jmVIILn-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76677801AF0;
        Tue, 22 Sep 2020 13:05:15 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C39A73682;
        Tue, 22 Sep 2020 13:05:13 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 13/13] firmware: arm_sdei: Remove _sdei_event_unregister()
Date:   Tue, 22 Sep 2020 23:04:23 +1000
Message-Id: <20200922130423.10173-14-gshan@redhat.com>
In-Reply-To: <20200922130423.10173-1-gshan@redhat.com>
References: <20200922130423.10173-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_sdei_event_unregister() is called by sdei_event_unregister() and
sdei_device_freeze(). _sdei_event_unregister() covers the shared
and private events, but sdei_device_freeze() only covers the shared
events. So the logic to cover the private events isn't needed by
sdei_device_freeze().

   sdei_event_unregister        sdei_device_freeze
      _sdei_event_unregister       sdei_unregister_shared
                                     _sdei_event_unregister

This removes _sdei_event_unregister(). Its logic is moved to its
callers accordingly. This shouldn't cause any logical changes.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/firmware/arm_sdei.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 361d142ad2a8..840754dcc6ca 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -487,16 +487,6 @@ static void _local_event_unregister(void *data)
 	sdei_cross_call_return(arg, err);
 }
 
-static int _sdei_event_unregister(struct sdei_event *event)
-{
-	lockdep_assert_held(&sdei_events_lock);
-
-	if (event->type == SDEI_EVENT_TYPE_SHARED)
-		return sdei_api_event_unregister(event->event_num);
-
-	return sdei_do_cross_call(_local_event_unregister, event);
-}
-
 int sdei_event_unregister(u32 event_num)
 {
 	int err;
@@ -517,7 +507,11 @@ int sdei_event_unregister(u32 event_num)
 	event->reenable = false;
 	spin_unlock(&sdei_list_lock);
 
-	err = _sdei_event_unregister(event);
+	if (event->type == SDEI_EVENT_TYPE_SHARED)
+		err = sdei_api_event_unregister(event->event_num);
+	else
+		err = sdei_do_cross_call(_local_event_unregister, event);
+
 	if (err)
 		goto unlock;
 
@@ -543,7 +537,7 @@ static int sdei_unregister_shared(void)
 		if (event->type != SDEI_EVENT_TYPE_SHARED)
 			continue;
 
-		err = _sdei_event_unregister(event);
+		err = sdei_api_event_unregister(event->event_num);
 		if (err)
 			break;
 	}
-- 
2.23.0

