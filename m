Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9381E2B86DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgKRVhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgKRVhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:37:07 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF93C061A48
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:05 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id q28so2218038pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JnwwhkWQ3GeoAyW3l6kwgfA23oecuiB8HGCIRs5X5Aw=;
        b=UVxx0X4ffkJCsE72epSJzR4TY1Xiblhjo3GK7Hr0AXwSUItF10yfXOg2xQ6/3zwTuF
         ptWujPQdLS+RmshGhMwkZAXh0bP8ZGDLRLRkZoiW48WTzthdjkY5obPF2EqbSinie6Ey
         HfmMd9loEG7OYSvqY/16vR0Sgv3VMCrEra9gl8r+vkfNgBIkFL2VPNwJTte69O6jfN5i
         b0BTiiE9+MqClh19y3XK1hzmWJoAAj/eLGmw6g2KLKccGH3gPOfvo/VsVbqy0dNbEYa7
         LN8xr2zaV8wgvHjwB3ZFp0R8rUngS28c49DiiSwIlf+lcNWpu4qdzRY8tlPkcg3fmmEF
         J6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JnwwhkWQ3GeoAyW3l6kwgfA23oecuiB8HGCIRs5X5Aw=;
        b=bhXC8guA55SZ9sOccrRCMUvIweMlncPj75NHpUEwgwcY09wpwcmEkDVITTaF3Fmep0
         02S/cewBAMNBpii3W1/6PuZHH4RNEUFU2cvL1mfKbfaQoGojOTZivoPyzWFGOfsHSyjO
         NPwQqNdBxh3WcUagRoiIPcmnc0++FTaEw0TNEIyug3MK9eAWbmkwHRPxuwJz97Hv5Ly2
         6fFtFLucUn3XfL4xaUBAVm0R4s4lk9PFz1Lw3dBY7lB9chg7vFcqnR0s7Pbm/7PD7pDS
         uLxQ+M3YhgE3IXvY41KN53YAjLMbik8JZHuXB5bvLHf0P9bOUfyCjp+tF+RloSlEgv02
         zZWQ==
X-Gm-Message-State: AOAM533QLRaZnUNZjp0NQqtoK6uEdb5fouYRbEa/8nFyJ1MJDF9Y4Uxd
        4JPZEhrxRlQa8/tRYro9VVdM3A==
X-Google-Smtp-Source: ABdhPJzuARGK6O4ViGB4NkqtpYWeWIcnqrClZO2KrNEuBjTdyZ7HHr4kxS0KBLGRxR1zW8FvfDxOcQ==
X-Received: by 2002:a63:1845:: with SMTP id 5mr9895754pgy.393.1605735425560;
        Wed, 18 Nov 2020 13:37:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e6sm26575694pfn.190.2020.11.18.13.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:37:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] rpmsg: Move structure rpmsg_ns_msg to header file
Date:   Wed, 18 Nov 2020 14:36:55 -0700
Message-Id: <20201118213700.74106-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118213700.74106-1-mathieu.poirier@linaro.org>
References: <20201118213700.74106-1-mathieu.poirier@linaro.org>
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

