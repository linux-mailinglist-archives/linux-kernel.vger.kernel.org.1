Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8332A2BB886
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgKTVmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 16:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgKTVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 16:42:51 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3A4C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:50 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id q28so8454911pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnwwhkWQ3GeoAyW3l6kwgfA23oecuiB8HGCIRs5X5Aw=;
        b=VzUNQrAE4wFp3JCqzBDRItQY7d3iKu/bjxiETUpjz7KFyDIseKrdmQP2XNTMg0xkiI
         OQw3Zga7phPQJBVmwriflTkHTQuYUhkOif16K6MAzXfQutfYp8ugJDs14wQqpT11mRz3
         VDS0qldQ1OH7vb3YnJveqwnJfdb3S7ytdIFVUXoXb6nFDTLitAMzXWvKoKunysc00Z9F
         VheyIho7s1GwBwGe6zW/1ymYAlQj/qhHQGqbHiB4Pmz4sv/ePpiFu4Uidpf047clRP8o
         ERcfzJviiftPSrcPSpcANhL8nVILqf6OWyAHhxA925gphG6gBcokQ78CCslA3dHTcQkf
         i4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnwwhkWQ3GeoAyW3l6kwgfA23oecuiB8HGCIRs5X5Aw=;
        b=SY5XC64t2mQc077d8pfx0aXvnd4crY0ev7/wmerVapPrUYwVZ3UchPVvTNTxlvxDj+
         hH2WV711DPQmut7LISFBzvYTg0ytfUWKNUkqiKoLRlG8JCyYyfrM+qZ436Vy3cfnLvRq
         /oFKhqQl/ejO9Syok2CP87t+Ew23ddKIgOmGiFnPK/c/k7Se4Rm03WgLMRBjnBjyaySx
         WAqHPUjkrYIHrc9NBpEwHP4ZVEEmt+U93uQ15gaNPARQZsKUnE6jgTvzfEQ6sO4E6WTK
         xcW5gYI2tuaZxn3XIiuSjXqktl021AJIfklRGuhnfbFfrIFdm17xTWSj2QMCk28gzY1t
         dyvw==
X-Gm-Message-State: AOAM530cpUoL+GCafOrqGRUXn6gRlyAbklTbouS6Vz4n4JOjuLTtwhwZ
        6CJ5XntACyRz4iO4HQFVSWinBlDoaCGpIQ==
X-Google-Smtp-Source: ABdhPJxOTtuYstDLKctepxBS7KkotAln4vgrKRWz/Ij9cHcCnk2ExRqDEA1CI505Q5s/1Zcy21Dnaw==
X-Received: by 2002:a17:90b:4a4b:: with SMTP id lb11mr6323001pjb.131.1605908569804;
        Fri, 20 Nov 2020 13:42:49 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm4713197pfj.157.2020.11.20.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:42:49 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/8] rpmsg: Move structure rpmsg_ns_msg to header file
Date:   Fri, 20 Nov 2020 14:42:40 -0700
Message-Id: <20201120214245.172963-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120214245.172963-1-mathieu.poirier@linaro.org>
References: <20201120214245.172963-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move structure rpmsg_ns_msg to its own header file so that
it can be used by other entities.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 32 +-----------------------
 include/linux/rpmsg/ns.h         | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/rpmsg/ns.h

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 5259fbbc8e68..20d0cf909bea 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/rpmsg.h>
 #include <linux/rpmsg/byteorder.h>
+#include <linux/rpmsg/ns.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -93,34 +94,6 @@ struct rpmsg_hdr {
 	u8 data[];
 } __packed;
 
-/**
- * struct rpmsg_ns_msg - dynamic name service announcement message
- * @name: name of remote service that is published
- * @addr: address of remote service that is published
- * @flags: indicates whether service is created or destroyed
- *
- * This message is sent across to publish a new service, or announce
- * about its removal. When we receive these messages, an appropriate
- * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
- * or ->remove() handler of the appropriate rpmsg driver will be invoked
- * (if/as-soon-as one is registered).
- */
-struct rpmsg_ns_msg {
-	char name[RPMSG_NAME_SIZE];
-	__rpmsg32 addr;
-	__rpmsg32 flags;
-} __packed;
-
-/**
- * enum rpmsg_ns_flags - dynamic name service announcement flags
- *
- * @RPMSG_NS_CREATE: a new remote service was just created
- * @RPMSG_NS_DESTROY: a known remote service was just destroyed
- */
-enum rpmsg_ns_flags {
-	RPMSG_NS_CREATE		= 0,
-	RPMSG_NS_DESTROY	= 1,
-};
 
 /**
  * struct virtio_rpmsg_channel - rpmsg channel descriptor
@@ -167,9 +140,6 @@ struct virtio_rpmsg_channel {
  */
 #define RPMSG_RESERVED_ADDRESSES	(1024)
 
-/* Address 53 is reserved for advertising remote services */
-#define RPMSG_NS_ADDR			(53)
-
 static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept);
 static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
 static int virtio_rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len,
diff --git a/include/linux/rpmsg/ns.h b/include/linux/rpmsg/ns.h
new file mode 100644
index 000000000000..73ecc91dc26f
--- /dev/null
+++ b/include/linux/rpmsg/ns.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_RPMSG_NS_H
+#define _LINUX_RPMSG_NS_H
+
+#include <linux/mod_devicetable.h>
+#include <linux/rpmsg/byteorder.h>
+#include <linux/types.h>
+
+/**
+ * struct rpmsg_ns_msg - dynamic name service announcement message
+ * @name: name of remote service that is published
+ * @addr: address of remote service that is published
+ * @flags: indicates whether service is created or destroyed
+ *
+ * This message is sent across to publish a new service, or announce
+ * about its removal. When we receive these messages, an appropriate
+ * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
+ * or ->remove() handler of the appropriate rpmsg driver will be invoked
+ * (if/as-soon-as one is registered).
+ */
+struct rpmsg_ns_msg {
+	char name[RPMSG_NAME_SIZE];
+	__rpmsg32 addr;
+	__rpmsg32 flags;
+} __packed;
+
+/**
+ * enum rpmsg_ns_flags - dynamic name service announcement flags
+ *
+ * @RPMSG_NS_CREATE: a new remote service was just created
+ * @RPMSG_NS_DESTROY: a known remote service was just destroyed
+ */
+enum rpmsg_ns_flags {
+	RPMSG_NS_CREATE		= 0,
+	RPMSG_NS_DESTROY	= 1,
+};
+
+/* Address 53 is reserved for advertising remote services */
+#define RPMSG_NS_ADDR			(53)
+
+#endif
-- 
2.25.1

