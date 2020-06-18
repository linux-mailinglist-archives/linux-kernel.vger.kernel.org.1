Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7371FF3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 15:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgFRNxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbgFRNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:52:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB30AC0613F0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so7357182lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTAYZZTmRUPhjm2Zktv8murX5zdFB+l+KQiazCdn7co=;
        b=KaMa74dwDinwhBmsHz34f+PvvenfxHXkPYrjwjAG5L6wNwI0YoOr1N189JlFxQ1Ivw
         7vyEcGZstlUg9MZPp+HM/zipbw53OIis3s1RIHcySqx4I8/bCuJvHgR01G0JTQw5p27y
         ecJNfvmpTyWrusu1VaxuQePfH9+2NvbmUvrQrRwQKkPL2ozUDLrGelzCqqWDk3tJYQL6
         KH9pc5kRmwFdSsu1deOm7Ti+oIHMx01Jr/BuNx/a1LkY63TDWdpV7mura54p1lL5VbUi
         r3lx75WIbTTL6H7LUzszyV97+/iLIcKN8FeZ/lqGXbXgTPj40Ir0pfGoQPM/TNVUxZ75
         AUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTAYZZTmRUPhjm2Zktv8murX5zdFB+l+KQiazCdn7co=;
        b=aJ12VVJR0esKyhuPGCQCUIccIPEzKlx2WNubFQH9h7+NVvCYTGZF69GhOlt26XKpIw
         umH/N0MphpHhETM6E+7jtTQzaLiwIyDIF9lq5r45NDcpQa7RADsafsfDOwDh4CJS/Jbs
         gzmJg8TL/O1TwNnvp0bvC4uAwXigDXXm2tNfjSXuys8Gc1e82Z8DuPuX49v+/IQC33Zh
         JMB/SUc86f0C/zmT4DVF9z/X8t63xHKalABBgGr2UrAEif4I5nECNoa/1/BZnK5ObqkN
         Ueh2dz6arOWr35UYpc7FAO3vfYC4zrvx5DzD0hCvUFXBV73+1b+QLXRtwUM83VJbeSp4
         eBfg==
X-Gm-Message-State: AOAM533E5IJd3i4rGSP7L1CG8DtOLSL55y7CkNAgnRqk5UxSgc0tZRTr
        lk7ugr2Yd8b8L1HK8RRnFrHRDwpgLwU=
X-Google-Smtp-Source: ABdhPJxysRgqmymx9cuSK/ZQ9CFeaPaBbfep2/+ep31vgSAV36AAZHUcZyiSNaZnVjUTELPACtxNQw==
X-Received: by 2002:a2e:7107:: with SMTP id m7mr2296233ljc.342.1592488376891;
        Thu, 18 Jun 2020 06:52:56 -0700 (PDT)
Received: from maximlap.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id f2sm768324lfc.11.2020.06.18.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:52:56 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 2/3] optee: enable support for multi-stage bus enumeration
Date:   Thu, 18 Jun 2020 16:52:50 +0300
Message-Id: <20200618135251.5761-3-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618135251.5761-1-maxim.uvarov@linaro.org>
References: <20200618135251.5761-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers (like ftpm) can operate only after tee-supplicant
runs because of tee-supplicant provides things like storage
services (rpmb, shm).  This patch splits probe of non tee-supplicant
dependable drivers to the early stage, and after tee-supplicant run
probe other drivers.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Suggested-by: Sumit Garg <sumit.garg@linaro.org>
Suggested-by: Arnd Bergmann <arnd@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/core.c          | 27 ++++++++++++++++++++++++---
 drivers/tee/optee/device.c        | 29 +++++++++++------------------
 drivers/tee/optee/optee_private.h | 10 +++++++++-
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 99698b8a3a74..b373b1b08b6d 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -17,6 +17,7 @@
 #include <linux/tee_drv.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/workqueue.h>
 #include "optee_private.h"
 #include "optee_smc.h"
 #include "shm_pool.h"
@@ -218,6 +219,11 @@ static void optee_get_version(struct tee_device *teedev,
 	*vers = v;
 }
 
+static void optee_bus_scan(struct work_struct *work)
+{
+	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
+}
+
 static int optee_open(struct tee_context *ctx)
 {
 	struct optee_context_data *ctxdata;
@@ -241,8 +247,18 @@ static int optee_open(struct tee_context *ctx)
 			kfree(ctxdata);
 			return -EBUSY;
 		}
-	}
 
+		if (!optee->scan_bus_done) {
+			INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
+			optee->scan_bus_wq = create_workqueue("optee_bus_scan");
+			if (!optee->scan_bus_wq) {
+				kfree(ctxdata);
+				return -ECHILD;
+			}
+			queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
+			optee->scan_bus_done = true;
+		}
+	}
 	mutex_init(&ctxdata->mutex);
 	INIT_LIST_HEAD(&ctxdata->sess_list);
 
@@ -296,8 +312,13 @@ static void optee_release(struct tee_context *ctx)
 
 	ctx->data = NULL;
 
-	if (teedev == optee->supp_teedev)
+	if (teedev == optee->supp_teedev) {
+		if (optee->scan_bus_wq) {
+			destroy_workqueue(optee->scan_bus_wq);
+			optee->scan_bus_wq = NULL;
+		}
 		optee_supp_release(&optee->supp);
+	}
 }
 
 static const struct tee_driver_ops optee_ops = {
@@ -675,7 +696,7 @@ static int optee_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, optee);
 
-	rc = optee_enumerate_devices();
+	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
 	if (rc) {
 		optee_remove(pdev);
 		return rc;
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index e91b7db5f49e..7a897d51969f 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -11,18 +11,6 @@
 #include <linux/uuid.h>
 #include "optee_private.h"
 
-/*
- * Get device UUIDs
- *
- * [out]     memref[0]        Array of device UUIDs
- *
- * Return codes:
- * TEE_SUCCESS - Invoke command success
- * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
- * TEE_ERROR_SHORT_BUFFER - Output buffer size less than required
- */
-#define PTA_CMD_GET_DEVICES		0x0
-
 static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 {
 	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
@@ -32,7 +20,8 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 }
 
 static int get_devices(struct tee_context *ctx, u32 session,
-		       struct tee_shm *device_shm, u32 *shm_size)
+		       struct tee_shm *device_shm, u32 *shm_size,
+		       u32 func)
 {
 	int ret = 0;
 	struct tee_ioctl_invoke_arg inv_arg;
@@ -41,8 +30,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
-	/* Invoke PTA_CMD_GET_DEVICES function */
-	inv_arg.func = PTA_CMD_GET_DEVICES;
+	inv_arg.func = func;
 	inv_arg.session = session;
 	inv_arg.num_params = 4;
 
@@ -90,7 +78,7 @@ static int optee_register_device(const uuid_t *device_uuid)
 	return rc;
 }
 
-int optee_enumerate_devices(void)
+static int __optee_enumerate_devices(u32 func)
 {
 	const uuid_t pta_uuid =
 		UUID_INIT(0x7011a688, 0xddde, 0x4053,
@@ -121,7 +109,7 @@ int optee_enumerate_devices(void)
 		goto out_ctx;
 	}
 
-	rc = get_devices(ctx, sess_arg.session, NULL, &shm_size);
+	rc = get_devices(ctx, sess_arg.session, NULL, &shm_size, func);
 	if (rc < 0 || !shm_size)
 		goto out_sess;
 
@@ -133,7 +121,7 @@ int optee_enumerate_devices(void)
 		goto out_sess;
 	}
 
-	rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size);
+	rc = get_devices(ctx, sess_arg.session, device_shm, &shm_size, func);
 	if (rc < 0)
 		goto out_shm;
 
@@ -161,3 +149,8 @@ int optee_enumerate_devices(void)
 
 	return rc;
 }
+
+int optee_enumerate_devices(u32 func)
+{
+	return  __optee_enumerate_devices(func);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index d9c5037b4e03..8b71839a357e 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -78,6 +78,9 @@ struct optee_supp {
  * @memremaped_shm	virtual address of memory in shared memory pool
  * @sec_caps:		secure world capabilities defined by
  *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
+ * @scan_bus_done	flag if device registation was already done.
+ * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
+ * @scan_bus_work	workq to scan optee bus and register optee drivers
  */
 struct optee {
 	struct tee_device *supp_teedev;
@@ -89,6 +92,9 @@ struct optee {
 	struct tee_shm_pool *pool;
 	void *memremaped_shm;
 	u32 sec_caps;
+	bool   scan_bus_done;
+	struct workqueue_struct *scan_bus_wq;
+	struct work_struct scan_bus_work;
 };
 
 struct optee_session {
@@ -173,7 +179,9 @@ void optee_free_pages_list(void *array, size_t num_entries);
 void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
 			   size_t page_offset);
 
-int optee_enumerate_devices(void);
+#define PTA_CMD_GET_DEVICES		0x0
+#define PTA_CMD_GET_DEVICES_SUPP	0x1
+int optee_enumerate_devices(u32 func);
 
 /*
  * Small helpers
-- 
2.17.1

