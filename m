Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2612F66FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhANRJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhANRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:09:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB8BC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id d17so9231860ejy.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6V6QqtKy7QTWrKapPBu+ZYpP/RWiVAOJ6BtvVV2mls=;
        b=B4YXhIQYl0t10KBG05mXejTQqNYBbYVzi5sCwh7aOdTfH9xQDxMCVPnjcZ/D8hGuKu
         +8fdk71v6RDFAUVPQtheGVxLuVH55oUbMu8a4zM0RRFtvo9A2wORjFVMW4g3AJKMIXRT
         h3Ig1WAnPaYxCTk+qTe0SksipIJvLyda/ieuAmAMJ4/K8rvHWi6EcSBbrL968P8lToRE
         tP14bmwYDBblfo1rof1EJc8BdrZz9pGECo9SjO5uec9D4OW18gF58cvTCIXl5SUMKwIX
         w7P9PQQhn3xbpKHz6FFCKJP3+bxcrmQYK1wdrLv/ZoEQn1BHzhf3/76PsvGK81hzXpnE
         oYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6V6QqtKy7QTWrKapPBu+ZYpP/RWiVAOJ6BtvVV2mls=;
        b=crosEMU0oU25I8OGwBFSNCzklERoj9KW1Io5tuFpoAfv6L9+loMvxmhS0XbPKdQ2sl
         l9+j9nioZQQu3IuVB+4ybBV54L15ZaphWxQaELPtmbX4twPj5qvTBS/nPF2Q4FgOtOfe
         VsN+JbbLvkZ9OHZ+mELrwlaphh3ylEQU6w12w9oAshlvkphdhl2k78+ksiIIcyTjMFN2
         HTrQUss+kwnyssA+rYRN9fd7LStIPxFBlf+ffPYlMVhJ5LnvLxbInt6oYdHsrBfbEZYk
         R/n6OnWycSwLOKLxSGA02/pB/MRyZGi0YscPcfYCRm1UPKuQJRs7H464WFFlacgUw9ne
         0D4Q==
X-Gm-Message-State: AOAM532I2iDbfzNSeMm1qPN0bwB+e2aQgxynaq9EC+J9OniMx8emCECd
        vHUOdt8F1ccp+EPgTy2WOR6je4mZtwLMJQ==
X-Google-Smtp-Source: ABdhPJzlEkX6y7TYYW4cKlFVcX4qc0zGMOXoe4qHIV6Ftr+hmqtFoXVuZJ1PohxU5AX0oIOEcpMofg==
X-Received: by 2002:a17:906:d98:: with SMTP id m24mr2212219eji.428.1610644113205;
        Thu, 14 Jan 2021 09:08:33 -0800 (PST)
Received: from yoga-910.localhost (5-12-227-87.residential.rdsnet.ro. [5.12.227.87])
        by smtp.gmail.com with ESMTPSA id be6sm2397644edb.29.2021.01.14.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:08:32 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/5] bus: fsl-mc: move fsl_mc_command struct in a uapi header
Date:   Thu, 14 Jan 2021 19:07:48 +0200
Message-Id: <20210114170752.2927915-2-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114170752.2927915-1-ciorneiioana@gmail.com>
References: <20210114170752.2927915-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Define "struct fsl_mc_command" as a structure that can cross the
user/kernel boundary.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 MAINTAINERS                 |  1 +
 include/linux/fsl/mc.h      |  8 +-------
 include/uapi/linux/fsl_mc.h | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)
 create mode 100644 include/uapi/linux/fsl_mc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c2cb79198288..13b589396b61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14654,6 +14654,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
+F:	include/uapi/linux/fsl_mc.h
 
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index db244874e834..63b56aba925a 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
+#include <uapi/linux/fsl_mc.h>
 
 #define FSL_MC_VENDOR_FREESCALE	0x1957
 
@@ -209,8 +210,6 @@ struct fsl_mc_device {
 #define to_fsl_mc_device(_dev) \
 	container_of(_dev, struct fsl_mc_device, dev)
 
-#define MC_CMD_NUM_OF_PARAMS	7
-
 struct mc_cmd_header {
 	u8 src_id;
 	u8 flags_hw;
@@ -220,11 +219,6 @@ struct mc_cmd_header {
 	__le16 cmd_id;
 };
 
-struct fsl_mc_command {
-	__le64 header;
-	__le64 params[MC_CMD_NUM_OF_PARAMS];
-};
-
 enum mc_cmd_status {
 	MC_CMD_STATUS_OK = 0x0, /* Completed successfully */
 	MC_CMD_STATUS_READY = 0x1, /* Ready to be processed */
diff --git a/include/uapi/linux/fsl_mc.h b/include/uapi/linux/fsl_mc.h
new file mode 100644
index 000000000000..cf56d46f052e
--- /dev/null
+++ b/include/uapi/linux/fsl_mc.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Management Complex (MC) userspace public interface
+ *
+ * Copyright 2021 NXP
+ *
+ */
+#ifndef _UAPI_FSL_MC_H_
+#define _UAPI_FSL_MC_H_
+
+#include <linux/types.h>
+
+#define MC_CMD_NUM_OF_PARAMS	7
+
+/**
+ * struct fsl_mc_command - Management Complex (MC) command structure
+ * @header: MC command header
+ * @params: MC command parameters
+ */
+struct fsl_mc_command {
+	__le64 header;
+	__le64 params[MC_CMD_NUM_OF_PARAMS];
+};
+
+#endif /* _UAPI_FSL_MC_H_ */
-- 
2.29.2

