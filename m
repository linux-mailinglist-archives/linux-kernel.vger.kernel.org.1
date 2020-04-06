Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D762D19F3B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgDFKmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 06:42:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48015 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726996AbgDFKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNCEzp8Xf9G/EJkWE4iVp8b4/dzBkQfiZaLwTbSfMe4=;
        b=MjSvco5b97iB5ZS1/6kdnUcuSMmbdgf54HkXK0jtG59GCsxoGpaP/uJn4UncVt1fuk3VDn
        RJe4e7XRjJGYlODDsM4SXCr+qQvsTk9IQ3h75gG9eVjBIIl7BOJ1dtfvTBnrMTAvwMF+Jq
        O31d4toEbS1IFBolQhUkCgquQraGoL4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-583k9PYANPC7zFoAjbnRVQ-1; Mon, 06 Apr 2020 06:42:02 -0400
X-MC-Unique: 583k9PYANPC7zFoAjbnRVQ-1
Received: by mail-wr1-f69.google.com with SMTP id c8so8142161wru.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNCEzp8Xf9G/EJkWE4iVp8b4/dzBkQfiZaLwTbSfMe4=;
        b=pXk6M8+dT0h2UH4ya2vc4sGjM5rZyTZVi8NZdGnIormNoJnsM7BnGc6uQfyFalTQRD
         kRbQ0fxihisuy5kanfj9++RZYFX1g5xTKDvHdFoPxOMwLBC5TQ0E1qbeSdg16UAyYKvq
         fvWh7icfiwmSimnlCNIt8HQ8afUztabHRBUa+5b4/s98pKrr1kJI0Qhnwa9N9qM/CK1E
         EMf5jvhVgbk9pha/JOzylbbvNZf2eGO0HyXgs1PNQuy7SduFCcUfzt2X7j0uObBNO8oE
         U6/vNp2uJV59jJ7vWvFoQlJO+cirxOGT/7/pxDGOB/EbtmSs/7ep0cbFCzicv52MZmWY
         m4gQ==
X-Gm-Message-State: AGi0PuZd6l/1/RCcUYUgOFI0TZKlJ+wCxnIaqGi0oy087nusOsejuXeu
        xJ3FqARWLwMnkrPV2CCzJfIUlF5zZ9z5K4UFDGd3fThxVLaskzw/WOYvIp41cziNgjBaennYmwY
        buRlkkrETEFVXZ14XFYKWnbMH
X-Received: by 2002:a1c:98c2:: with SMTP id a185mr9801248wme.85.1586169720308;
        Mon, 06 Apr 2020 03:42:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypIVoZ4LLrlXceBRrGrczs27RRHIwL8V1sWT18u9g9ujFzu+ivzbGQ5OvFlPEr0gXDR0iFB7nA==
X-Received: by 2002:a1c:98c2:: with SMTP id a185mr9801222wme.85.1586169720021;
        Mon, 06 Apr 2020 03:42:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a2sm17305337wra.71.2020.04.06.03.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:41:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 2/5] Drivers: hv: allocate the exact needed memory for messages
Date:   Mon,  6 Apr 2020 12:41:51 +0200
Message-Id: <20200406104154.45010-3-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
References: <20200406104154.45010-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we need to pass a buffer with Hyper-V message we don't need to always
allocate 256 bytes for the message: the real message length is known from
the header. Change 'struct onmessage_work_context' to make it possible to
not over-allocate.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 943b23beb992..b114bb411d7e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -991,7 +991,10 @@ static struct bus_type  hv_bus = {
 
 struct onmessage_work_context {
 	struct work_struct work;
-	struct hv_message msg;
+	struct {
+		struct hv_message_header header;
+		u8 payload[];
+	} msg;
 };
 
 static void vmbus_onmessage_work(struct work_struct *work)
@@ -1044,7 +1047,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 
 	if (entry->handler_type	== VMHT_BLOCKING) {
-		ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+		ctx = kmalloc(sizeof(*ctx) + msg->header.payload_size,
+			      GFP_ATOMIC);
 		if (ctx == NULL)
 			return;
 
@@ -1098,10 +1102,11 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 	WARN_ON(!is_hvsock_channel(channel));
 
 	/*
-	 * sizeof(*ctx) is small and the allocation should really not fail,
+	 * Allocation size is small and the allocation should really not fail,
 	 * otherwise the state of the hv_sock connections ends up in limbo.
 	 */
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
+	ctx = kzalloc(sizeof(*ctx) + sizeof(*rescind),
+		      GFP_KERNEL | __GFP_NOFAIL);
 
 	/*
 	 * So far, these are not really used by Linux. Just set them to the
@@ -1111,7 +1116,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 	ctx->msg.header.payload_size = sizeof(*rescind);
 
 	/* These values are actually used by Linux. */
-	rescind = (struct vmbus_channel_rescind_offer *)ctx->msg.u.payload;
+	rescind = (struct vmbus_channel_rescind_offer *)ctx->msg.payload;
 	rescind->header.msgtype = CHANNELMSG_RESCIND_CHANNELOFFER;
 	rescind->child_relid = channel->offermsg.child_relid;
 
-- 
2.25.1

