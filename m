Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86629C41A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822835AbgJ0Rw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:52:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35014 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1822757AbgJ0RwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:52:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so1358684pfo.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2RF5KZ6D5NXkOtLEZgeVFNMVDzLukO3tGuEfFyz0uKo=;
        b=HOi7o3j/C5yMctib6W5NjKoEIEHQSOgFn6MZA0Qr0BRTPw2jPplGwqLm4/wNfrp2ty
         Y5zslQdOnat1NrFopGTcLkKDqVt3gFC3Tvb3kxjMTn9LgBsVphN9t/IciJHYsw95L/ML
         kyIsgcHDFWy2gZMcUuOoznfRXcuVmX5iXnSxjrn0HDJd0VgcI0LjMg4I0PCx+JWrB0Yo
         HSd61RdaGYwsrgFXNhCm+oJ9XZjdjhYhj6PqByTj1zV5cwhPhguSbNfdoXOMd4LF7wRK
         l6UOY/knmXygH7lIxqGWgX/pGI11DCDckVQ2PNTPysFDx5iOlfFkzqn6Z7PsoWrZlF6j
         O9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2RF5KZ6D5NXkOtLEZgeVFNMVDzLukO3tGuEfFyz0uKo=;
        b=uE9E8jwSrj9P0AZTn3JiZr2ewSsA3WMuQucxqKglO31axhHryMKoTL0Z79ewTUGeqJ
         mgNMVRRWKwuWdX1vXN0JRkRPrsZqlY6wiv2zEVyNHacItL3PSZjHDv56RY0Wj+uS+sr1
         IzFIZ54jY66cHDpzRU+gk6mn0NguMBMebqVKs2RLghCtCHKpqC+C8i2ptTLdVXIBMwvj
         788d5FLOw9c8SDx4hrev8NfS50o8zeSJTZvipmXUF86JjEIjfVTWJ3ZkXV/cVOgOS5As
         vxHBB3hvzbmBYxA18fQx0Mo7sFT2XM6953hbwnIyLoTrh084Tau/O1oLuV+jcjvAk1O4
         fjBw==
X-Gm-Message-State: AOAM530a9D7ZaG5lwlaUWr0+Pz09Aza4JxkBosZt9/ZblXdraf+rqCRA
        UdGuSWIQT4tXMhVHMURzL1ujXQ==
X-Google-Smtp-Source: ABdhPJyYSFWZwj1Yw1uKdoddHFWr3ALsUQGasix6mHU4+fPWFFZmZH6XGxcewwhE206/uqhuJJUBzA==
X-Received: by 2002:a63:af4c:: with SMTP id s12mr2801714pgo.395.1603821144507;
        Tue, 27 Oct 2020 10:52:24 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r8sm2761225pgl.57.2020.10.27.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:52:23 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] rpmsg: Move structure rpmsg_ns_msg to header file
Date:   Tue, 27 Oct 2020 11:52:13 -0600
Message-Id: <20201027175218.1033609-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027175218.1033609-1-mathieu.poirier@linaro.org>
References: <20201027175218.1033609-1-mathieu.poirier@linaro.org>
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
 include/linux/rpmsg_ns.h         | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/rpmsg_ns.h

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 22f57d14904e..064a5ddcf7c0 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/rpmsg.h>
 #include <linux/rpmsg_byteorder.h>
+#include <linux/rpmsg_ns.h>
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
diff --git a/include/linux/rpmsg_ns.h b/include/linux/rpmsg_ns.h
new file mode 100644
index 000000000000..bb479f430080
--- /dev/null
+++ b/include/linux/rpmsg_ns.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_RPMSG_NS_H
+#define _LINUX_RPMSG_NS_H
+
+#include <linux/mod_devicetable.h>
+#include <linux/types.h>
+#include <linux/rpmsg_byteorder.h>
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

