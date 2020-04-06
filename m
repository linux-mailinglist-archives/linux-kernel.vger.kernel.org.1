Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB94E19F3B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 12:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgDFKmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 06:42:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38401 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726883AbgDFKmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbIlbCAOndT/p1zcHoZ374KLh6U88poeeD1HrBvG9E4=;
        b=LPWwbOXfrollBY3avjTdFWYFC33DZRK2QkPfDWUYpXTElO+3sfLDvB6Qpjgu5VWYaWoHbD
        ahpFBQa+7qd0ZI74yADNLdXOvtzKTBcBidXOnovcdxd7xXs3uOQ4Wl2uloU40dAb51NZXh
        es+5q/BjUURvG9atF0yTx6Ist6H1Mig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-Rf8kApVBPk-ga5P8dMT1Gw-1; Mon, 06 Apr 2020 06:42:00 -0400
X-MC-Unique: Rf8kApVBPk-ga5P8dMT1Gw-1
Received: by mail-wr1-f71.google.com with SMTP id h95so8112293wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IbIlbCAOndT/p1zcHoZ374KLh6U88poeeD1HrBvG9E4=;
        b=DFEfGyghwSKMABIWDuSpbgrsuZe2XB6z0wie+Htwi1QHqzeYdynyU5uxXPJrLgYDoV
         N1yBIsmsBChEgelAoGHumE85xLJE1dcB4LZG5TuZ0ZG6caIsL4U84+lmhztFfH2C+xCs
         VMpAaK+y7KC1/e+0J6dUnlh16rVoPo9bmUJrnJdLPs2rxUBU7eJ/8PO3uriIlhoUtfxR
         dJykTLcyIitbsVdjbGvfbdFPiuH0fs3yaaMVw6KxjmKkF4pvMJYKQvycH2e3XC4Q9/TD
         oT8QwR/QX4yeavlDoTZ22YMxN+CA9k3DNtbmRcT/ogecmsPwXnIYYLKA7eCjFLe3l3Zd
         XwHw==
X-Gm-Message-State: AGi0PuanQAjdMmBXKJWndsmr+dbbyuQjdloXITyvgXUfnexHAkzixfFo
        tXXMhe4XfNYpdKRZQ7vQ5RZiFx+JeJHU6E4/9l/U8+SnKspRBrrrBWlN5jmTIr/GaVlLdcjBjhd
        lTBch8vftI9DytN7X4FyUpbqk
X-Received: by 2002:adf:df8a:: with SMTP id z10mr22265707wrl.278.1586169718867;
        Mon, 06 Apr 2020 03:41:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8Kwp2LMDv2jWv5I1+owW1KhVa8HnP1k5r/OndJsHc/EXWEVpdq3UeZBeqhWQrXxT9poQ/CA==
X-Received: by 2002:adf:df8a:: with SMTP id z10mr22265687wrl.278.1586169718558;
        Mon, 06 Apr 2020 03:41:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a2sm17305337wra.71.2020.04.06.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:41:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 1/5] Drivers: hv: copy from message page only what's needed
Date:   Mon,  6 Apr 2020 12:41:50 +0200
Message-Id: <20200406104154.45010-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
References: <20200406104154.45010-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
messages. Each message comes with a header (16 bytes) which specifies the
payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
look at the real message length and copies the whole slot to a temporary
buffer before passing it to message handlers. This is potentially dangerous
as hypervisor doesn't have to clean the whole slot when putting a new
message there and a message handler can get access to some data which
belongs to a previous message.

Note, this is not currently a problem because all message handlers are
in-kernel but eventually we may e.g. get this exported to userspace.

Note also, that this is not a performance critical path: messages (unlike
events) represent rare events so it doesn't really matter (from performance
point of view) if we copy too much.

Fix the issue by taking into account the real message length. The temporary
buffer allocated by vmbus_on_msg_dpc() remains fixed size for now. Also,
check that the supplied payload length is valid (<= 240 bytes).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378c27421..943b23beb992 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1032,6 +1032,12 @@ void vmbus_on_msg_dpc(unsigned long data)
 		goto msg_handled;
 	}
 
+	if (msg->header.payload_size > HV_MESSAGE_PAYLOAD_BYTE_COUNT) {
+		WARN_ONCE(1, "payload size is too large (%d)\n",
+			  msg->header.payload_size);
+		goto msg_handled;
+	}
+
 	entry = &channel_message_table[hdr->msgtype];
 
 	if (!entry->message_handler)
@@ -1043,7 +1049,8 @@ void vmbus_on_msg_dpc(unsigned long data)
 			return;
 
 		INIT_WORK(&ctx->work, vmbus_onmessage_work);
-		memcpy(&ctx->msg, msg, sizeof(*msg));
+		memcpy(&ctx->msg, msg, sizeof(msg->header) +
+		       msg->header.payload_size);
 
 		/*
 		 * The host can generate a rescind message while we
-- 
2.25.1

