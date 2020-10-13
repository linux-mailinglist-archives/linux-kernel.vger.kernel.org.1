Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC01228DD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgJNJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgJNJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2655C08EA6F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o8so761918pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5+qdsDTVcz4rRfOTbXtw6enq/qmYTbuHet8yphp+jA=;
        b=ebOpZ9QpXR2dftdCCIs74a47xR5rZSQ06O6dFlNcQEAIfeZpi1dAV2ByMOAfNtntVG
         hNMJJzRMwS+AVeeUcm15xkrb5qaC+tehTlB2A9+53Yj0sYaqIi393r/3H1dYPVyJrMWi
         q63Qz8SKpowMpVzVP2f7sjJTTTFeUZ1rrqddSWAMn4ZNHq6UrJU7Ik5hTTl20Nbwvwgn
         zTzvM+tRVE1LKSAlhcshxsdpcQoKyAnDkvLcHZLcEuLN+DHBqSgy+rXHoWFzvVwk2LTV
         L7ia3yKg2iNHy4I3H5JGdmD15NKhg1aqtSCh/Gu4r4FXNNRWSbcsb5Nwxddi5RD4xVAX
         k0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5+qdsDTVcz4rRfOTbXtw6enq/qmYTbuHet8yphp+jA=;
        b=UMti42mwDqKpKY0Q0jKVte0ireS2pkAaoON66NhCLweKMWU6JEZFfGfU0JGwL5Ao51
         zL5zN0em/l61oRST2pu/kUhXdOKmtHI/RmOkFuZhlZ/pUExcIC4lL/cU0IYYW65EKf3B
         6CIe2VRf7v7KmgZ/+CiX2K+tJGozBUsZaSh9jWNGTw3uNOpyq631sO/kbJtURYcsdpZV
         iDRRjyJ1Fi71V45XKUhRl0EC4MvQw9LOkzdk1Hu6B7s9lmwALEMyMePCCDwKw8bmw3NF
         ZFSDylet9Lmsw6QOZByhtHv91oEVO1QqRJugV68hiJFfWOLXbMfPJikAy7ST5/EvA77G
         A+9Q==
X-Gm-Message-State: AOAM532Qqqu+OnSh96nHnCpG0w6CxI56W5USUpriZ4ZbCMFWfZOb3dpy
        0eHBowboZwsyZYTblBl/h3hqDA==
X-Google-Smtp-Source: ABdhPJy1z0AeoVRv+mwnHZD4UbkBuWxHZWZnL+iRxNZht514ZKhwBML20m9YulGZdDvy/KyyR4sSLg==
X-Received: by 2002:a17:90b:383:: with SMTP id ga3mr735456pjb.2.1602631522496;
        Tue, 13 Oct 2020 16:25:22 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b8sm791871pfr.159.2020.10.13.16.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 16:25:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] rpmsg: Move rpmsg_endpoint_ops to rpmsg.h
Date:   Tue, 13 Oct 2020 17:25:11 -0600
Message-Id: <20201013232519.1367542-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
References: <20201013232519.1367542-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move structure rpmsg_endpoint_ops to header rpmsg.h so that it can
be used by other entities.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/rpmsg_internal.h | 19 -------------------
 include/linux/rpmsg.h          | 24 +++++++++++++++++++++---
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3fc83cd50e98..094cf968d2d3 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -18,25 +18,6 @@
 #define to_rpmsg_device(d) container_of(d, struct rpmsg_device, dev)
 #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
 
-/**
- * struct rpmsg_device_ops - indirection table for the rpmsg_device operations
- * @create_ept:		create backend-specific endpoint, required
- * @announce_create:	announce presence of new channel, optional
- * @announce_destroy:	announce destruction of channel, optional
- *
- * Indirection table for the operations that a rpmsg backend should implement.
- * @announce_create and @announce_destroy are optional as the backend might
- * advertise new channels implicitly by creating the endpoints.
- */
-struct rpmsg_device_ops {
-	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
-					    rpmsg_rx_cb_t cb, void *priv,
-					    struct rpmsg_channel_info chinfo);
-
-	int (*announce_create)(struct rpmsg_device *ept);
-	int (*announce_destroy)(struct rpmsg_device *ept);
-};
-
 /**
  * struct rpmsg_endpoint_ops - indirection table for rpmsg_endpoint operations
  * @destroy_ept:	see @rpmsg_destroy_ept(), required
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d1c018..9fe1c54ae995 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -22,7 +22,6 @@
 
 struct rpmsg_device;
 struct rpmsg_endpoint;
-struct rpmsg_device_ops;
 struct rpmsg_endpoint_ops;
 
 /**
@@ -37,6 +36,27 @@ struct rpmsg_channel_info {
 	u32 dst;
 };
 
+typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
+
+/**
+ * struct rpmsg_device_ops - indirection table for the rpmsg_device operations
+ * @create_ept:		create backend-specific endpoint, required
+ * @announce_create:	announce presence of new channel, optional
+ * @announce_destroy:	announce destruction of channel, optional
+ *
+ * Indirection table for the operations that a rpmsg backend should implement.
+ * @announce_create and @announce_destroy are optional as the backend might
+ * advertise new channels implicitly by creating the endpoints.
+ */
+struct rpmsg_device_ops {
+	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
+					    rpmsg_rx_cb_t cb, void *priv,
+					    struct rpmsg_channel_info chinfo);
+
+	int (*announce_create)(struct rpmsg_device *ept);
+	int (*announce_destroy)(struct rpmsg_device *ept);
+};
+
 /**
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
@@ -59,8 +79,6 @@ struct rpmsg_device {
 	const struct rpmsg_device_ops *ops;
 };
 
-typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
-
 /**
  * struct rpmsg_endpoint - binds a local rpmsg address to its user
  * @rpdev: rpmsg channel device
-- 
2.25.1

