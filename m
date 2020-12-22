Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00082E0E16
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 19:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgLVSBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 13:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgLVSBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 13:01:37 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3CEC061285
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:00:20 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y5so12754188iow.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KARs1QZcnC/nptat3ZvE0oGL0cJbgcKd2gJzkqzYJPg=;
        b=HryWO/h3lBSjvEGFPksqzPRaaiEVaNcnYrATbUSIHTPogwutQWP4VKY18XesCk+0aW
         JrFVSOsUX3YSp++IP7Be7aQgvRj5sIc5jDmZnP6PZGWmoIbfO/UDHMYOpxcD9VYq5cyb
         AQmY7i88slMOfdypv9sy/8g691sRe5lfWUhJS95jrqOD+ix/Kk5slwQPZuidHUu73lyb
         AODGnQN2YDlozbr6lZz98ZNnHECY9ySysKSVtUfJuqrQNqKVwgbZWPY3boEDL3vgoz/h
         uzumNfy3VcLZ3A42qdlvbh9PorIs3tiUKAmyV0IYHmMtH99ah/7gWKxJeKgGHQ/JAg2z
         I7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KARs1QZcnC/nptat3ZvE0oGL0cJbgcKd2gJzkqzYJPg=;
        b=W1/LoPhsA81DxDnWD8ta28mGj8rDUmt+lnIbmSQt0DTp2KtTds1WcTzFmVEU30SVkX
         widzoTq0vpRWurtk5bykiXjvO1ncU1n5cs+KEnaCI2VE9ySjgRlMUTL4oW4xXfp4LHCx
         v69UruwpC3PYE1Qy/1l4vxT1Fpfk6FNSMBbazzplwqfDU13MQILP1YJMl1OgNTHBK9DT
         OqHuSnVzzReaCb1KastkvyNeFhmwIvKbsXmL3wsdF5GzTp/xTlz1mIyp+UYOnZQha68a
         GIiXxieIo1iUrcDHSI4cUbSP0Jp5nOyy1PoPFcWEp/gVrjO1DrDzrKzgProd0jnEH4dw
         VzDw==
X-Gm-Message-State: AOAM5321+Wz+ICna3CvzcGBcl80GQ455ni0LinTsXpNFEHSbwMFHNiB8
        Ki6+YxAGPZD1t/LJiyxMIk7zCA==
X-Google-Smtp-Source: ABdhPJyQ357Y3xPqXimBFJFDFbaVlAcAnY8iVRH+s7ZgLg3ouQO5D/VGobWOTN02czlHblboUfmG7A==
X-Received: by 2002:a6b:8e92:: with SMTP id q140mr18931070iod.182.1608660019481;
        Tue, 22 Dec 2020 10:00:19 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f29sm16328385ilg.3.2020.12.22.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:00:18 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: ipa: use state to determine event ring command success
Date:   Tue, 22 Dec 2020 12:00:12 -0600
Message-Id: <20201222180012.22489-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201222180012.22489-1-elder@linaro.org>
References: <20201222180012.22489-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the same basic fix for event rings as the
previous one does for channels.

The result of issuing an event ring control command should be that
the event ring changes state.  If enabled, a completion interrupt
signals that the event ring state has changed.  This interrupt is
enabled by gsi_evt_ring_command() and disabled again after the
command has completed (or we time out).

There is a window of time during which the command could complete
successfully without interrupting.  This would cause the event ring
to transition to the desired new state.

So whether a event ring command ends via completion interrupt or
timeout, we can consider the command successful if the event ring
has entered the desired state (and a failure if it has not,
regardless of the cause).

Fixes: b4175f8731f78 ("net: ipa: only enable GSI event control IRQs when needed")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 4f0e791764237..579cc3e516775 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -384,13 +384,15 @@ static int gsi_evt_ring_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 	}
 
 	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_ALLOCATE);
-	if (!ret && evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED) {
-		dev_err(gsi->dev, "event ring %u bad state %u after alloc\n",
-			evt_ring_id, evt_ring->state);
-		ret = -EIO;
-	}
 
-	return ret;
+	/* If successful the event ring state will have changed */
+	if (evt_ring->state == GSI_EVT_RING_STATE_ALLOCATED)
+		return 0;
+
+	dev_err(gsi->dev, "event ring %u bad state %u after alloc\n",
+		evt_ring_id, evt_ring->state);
+
+	return -EIO;
 }
 
 /* Reset a GSI event ring in ALLOCATED or ERROR state. */
@@ -408,9 +410,13 @@ static void gsi_evt_ring_reset_command(struct gsi *gsi, u32 evt_ring_id)
 	}
 
 	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_RESET);
-	if (!ret && evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED)
-		dev_err(gsi->dev, "event ring %u bad state %u after reset\n",
-			evt_ring_id, evt_ring->state);
+
+	/* If successful the event ring state will have changed */
+	if (evt_ring->state == GSI_EVT_RING_STATE_ALLOCATED)
+		return;
+
+	dev_err(gsi->dev, "event ring %u bad state %u after reset\n",
+		evt_ring_id, evt_ring->state);
 }
 
 /* Issue a hardware de-allocation request for an allocated event ring */
@@ -426,9 +432,13 @@ static void gsi_evt_ring_de_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 	}
 
 	ret = evt_ring_command(gsi, evt_ring_id, GSI_EVT_DE_ALLOC);
-	if (!ret && evt_ring->state != GSI_EVT_RING_STATE_NOT_ALLOCATED)
-		dev_err(gsi->dev, "event ring %u bad state %u after dealloc\n",
-			evt_ring_id, evt_ring->state);
+
+	/* If successful the event ring state will have changed */
+	if (evt_ring->state == GSI_EVT_RING_STATE_NOT_ALLOCATED)
+		return;
+
+	dev_err(gsi->dev, "event ring %u bad state %u after dealloc\n",
+		evt_ring_id, evt_ring->state);
 }
 
 /* Fetch the current state of a channel from hardware */
-- 
2.20.1

