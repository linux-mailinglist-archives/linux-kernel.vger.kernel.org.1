Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B1E292F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgJSUez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbgJSUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:34:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F71C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t4so385639plq.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7omPkC3IVm9RLj2hLgBC2EysNqyrbpwA0iTXHlrGwM=;
        b=yhZHuq/YaILRJqafilWBWtB6B87Tivj6Mg6IydEYpIFZT+dzYbytAlvtNA4PrW1vs4
         k1O5B9yzVRUpgST7zHXYw3cUH8ZAPyQLCu3JHrQmMsb94nGOiN+AiYE62IYqV3gPvZOj
         JWif3dcKWddumUDvExuZCt69ks2011I243OWK+7w+AGROJLuDe14cCfld4rWWkUKKWkb
         fRKipyqs5qNBi9t/Nl4oNvcbWE/EA3x8W5tUaB29Z6jPi1QSQg0cOgmmwfPZRIBafdJV
         ry53yKirmUMVF5jRDIsKOzFn2vtHWUm7PQOAjR8k5lzP9ev+25Iu2Z2IBTdHM3o8hm2t
         U6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7omPkC3IVm9RLj2hLgBC2EysNqyrbpwA0iTXHlrGwM=;
        b=GZNHk8otLB1gmSqMXSodTUGp3dQ+KYle+S39QwrLKBHifR2/HC/sjjdNVjo4wWdPi5
         Zt2VIcaPKTSgohM/tcOwpBp2DRjEbulZkB875Dhxk6Zisd0HhNx9RmX7OCK85vT37PbA
         bBGz9zPM/ZeK7QcBdsuw3uDJHRUgWQzCKTGx7l9X3l+8FCK97xhYMRdJqopmynzFdEBM
         mHL997EHxuQVCcAEZ8Bg9E9j04fnDdJqI6csIED1Ll7mzL+KoD10LQ/J1YOKPVSGeFuX
         kS5myFOtcTqFI9Q/41fGMiiJnzH1HHdblWeOZvo83SsVPfGvSqHA4O7M81lIejs+jFHz
         i6vQ==
X-Gm-Message-State: AOAM532jDaVP0m9MsBMJ3VxOTjFlwGOCHbgAJI94qKf4QNaa7mgy2sqr
        z+da+vfKkvISB6SrpbS5JUzhZI0Q41u9ww==
X-Google-Smtp-Source: ABdhPJxQzuETx3GnHxGMuU/p+/kyoXByNJxqfjQrRWaeUfwUo5UFCwSSiYTjYgKNtltk+cCIPAB8Pw==
X-Received: by 2002:a17:902:7b91:b029:d4:da66:ef6e with SMTP id w17-20020a1709027b91b02900d4da66ef6emr1667423pll.10.1603139684283;
        Mon, 19 Oct 2020 13:34:44 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q123sm631847pfq.56.2020.10.19.13.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:34:43 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     guennadi.liakhovetski@linux.intel.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] rpmsg: Move structure rpmsg_ns_msg to header file
Date:   Mon, 19 Oct 2020 14:34:33 -0600
Message-Id: <20201019203438.501174-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019203438.501174-1-mathieu.poirier@linaro.org>
References: <20201019203438.501174-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move structure rpmsg_ns_msg to its own header file so that
it can be used by other entities.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 32 +-----------------------
 include/linux/rpmsg_ns.h         | 42 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 31 deletions(-)
 create mode 100644 include/linux/rpmsg_ns.h

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 8927bcad56fd..1f8154ee1e90 100644
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
  * @vrp: the remote processor this channel belongs to
@@ -162,9 +135,6 @@ struct virtio_rpmsg_channel {
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

