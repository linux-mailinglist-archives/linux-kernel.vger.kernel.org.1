Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0531FF3F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 15:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgFRNxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 09:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgFRNxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:53:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60DC061794
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:59 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c11so3510701lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCKO4KAmC6t1/xjLg97oW5MQyzYYn4C2HI5vulCaWjo=;
        b=LIKoIHVL7/dtxgL0YTVqziTRKr2IXVBLtuDnmJaaBuLg2qWuVZF81JrDdMjTOZsWe8
         R/g7Hobi0QVRaqpcrmwA3ipwTTw9pZT/E5DFI0/WNEvcnATbo+/ZrlQc9b4qyu1kvLgo
         Jw85cH2uo36G9mls7riTrpDIcYeCViKhbtp3faiIprtev1+J+ABv2ADt+mttZLytEMiL
         Ox8QZL6wOuEAVsQErLV9pz1oDZpNzALTFPf5UO80LUBu+/ofr+q9jh/91MsUQBq8Iqji
         MLpo7cOYWHy27B8fBxT4u3+WlpDx7a+PAB0vCmZYTDxqGPObz5F3/7FE7BjHcFU9gm2x
         eDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCKO4KAmC6t1/xjLg97oW5MQyzYYn4C2HI5vulCaWjo=;
        b=kdzo5vTA/erytQNbvrvvN4jFo6Oxhj3G2xQ6N3AFrk0F1jZMDt6b0DV5upiKATSZyG
         yjR+8QtWdgtn2xvmRY/oAHuMcIlZsVbaOX5PxP5sZeOg0rEaSiaWZMEe6i4y4CH0udjO
         GhxRBhJ7Sj7AJWUENijEF6hO3+P2wTRW9vlAtskpqXsW1BzpX+dJk0paNMSQzSYtYKxC
         fxxZnuuUV0jIg7H5G/0GiVXl8Qls+YKZqjd8BAjD9KcPucKqMZRjhDZnLhFhI6X1rnOT
         VYRTjI7mOn+FyyklBFZB9amoKu1ujz1Mq7aF0CyLFRhJfkSmvOP/CBfo3fMTNf6LcNbC
         0LuQ==
X-Gm-Message-State: AOAM533UnCImZJ8raqkVJJQEYhXBUrIX095mRe4Hofp6IV+T8OWyOptW
        rntmmaPffLZ+0Dp875szZ48dHHUIVhs=
X-Google-Smtp-Source: ABdhPJyRe9YpUDbeCkQv53AEEx+b/DzoZviTu3xdCnINh3Ga4OlAzUDrYDSg8hO9aQ1Us/9bWPoAkg==
X-Received: by 2002:ac2:4886:: with SMTP id x6mr2512328lfc.198.1592488377963;
        Thu, 18 Jun 2020 06:52:57 -0700 (PDT)
Received: from maximlap.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id f2sm768324lfc.11.2020.06.18.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:52:57 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 3/3] tpm_ftpm_tee: register driver on TEE bus
Date:   Thu, 18 Jun 2020 16:52:51 +0300
Message-Id: <20200618135251.5761-4-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618135251.5761-1-maxim.uvarov@linaro.org>
References: <20200618135251.5761-1-maxim.uvarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OP-TEE based fTPM Trusted Application depends on tee-supplicant to
provide NV RAM implementation based on RPMB secure storage. So this
dependency can be resolved via TEE bus where we only invoke fTPM
driver probe once fTPM device is registered on the bus which is only
true after the tee-supplicant is up and running. Additionally, TEE bus
provides auto device enumeration.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Suggested-by: Sumit Garg <sumit.garg@linaro.org>
Suggested-by: Arnd Bergmann <arnd@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 70 ++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 2491a2cb54a2..2ccdf8ac6994 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -214,11 +214,10 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
  * Return:
  *	On success, 0. On failure, -errno.
  */
-static int ftpm_tee_probe(struct platform_device *pdev)
+static int ftpm_tee_probe(struct device *dev)
 {
 	int rc;
 	struct tpm_chip *chip;
-	struct device *dev = &pdev->dev;
 	struct ftpm_tee_private *pvt_data = NULL;
 	struct tee_ioctl_open_session_arg sess_arg;
 
@@ -297,6 +296,13 @@ static int ftpm_tee_probe(struct platform_device *pdev)
 	return rc;
 }
 
+static int ftpm_plat_tee_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return ftpm_tee_probe(dev);
+}
+
 /**
  * ftpm_tee_remove() - remove the TPM device
  * @pdev: the platform_device description.
@@ -304,9 +310,9 @@ static int ftpm_tee_probe(struct platform_device *pdev)
  * Return:
  *	0 always.
  */
-static int ftpm_tee_remove(struct platform_device *pdev)
+static int ftpm_tee_remove(struct device *dev)
 {
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(dev);
 
 	/* Release the chip */
 	tpm_chip_unregister(pvt_data->chip);
@@ -328,11 +334,18 @@ static int ftpm_tee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int ftpm_plat_tee_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return ftpm_tee_remove(dev);
+}
+
 /**
  * ftpm_tee_shutdown() - shutdown the TPM device
  * @pdev: the platform_device description.
  */
-static void ftpm_tee_shutdown(struct platform_device *pdev)
+static void ftpm_plat_tee_shutdown(struct platform_device *pdev)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
 
@@ -347,17 +360,54 @@ static const struct of_device_id of_ftpm_tee_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, of_ftpm_tee_ids);
 
-static struct platform_driver ftpm_tee_driver = {
+static struct platform_driver ftpm_tee_plat_driver = {
 	.driver = {
 		.name = "ftpm-tee",
 		.of_match_table = of_match_ptr(of_ftpm_tee_ids),
 	},
-	.probe = ftpm_tee_probe,
-	.remove = ftpm_tee_remove,
-	.shutdown = ftpm_tee_shutdown,
+	.shutdown = ftpm_plat_tee_shutdown,
+	.probe = ftpm_plat_tee_probe,
+	.remove = ftpm_plat_tee_remove,
+};
+
+/* UUID of the fTPM TA */
+static const struct tee_client_device_id optee_ftpm_id_table[] = {
+	{UUID_INIT(0xbc50d971, 0xd4c9, 0x42c4,
+		   0x82, 0xcb, 0x34, 0x3f, 0xb7, 0xf3, 0x78, 0x96)},
+	{}
 };
 
-module_platform_driver(ftpm_tee_driver);
+MODULE_DEVICE_TABLE(tee, optee_ftpm_id_table);
+
+static struct tee_client_driver ftpm_tee_driver = {
+	.id_table	= optee_ftpm_id_table,
+	.driver		= {
+		.name		= "optee-ftpm",
+		.bus		= &tee_bus_type,
+		.probe		= ftpm_tee_probe,
+		.remove		= ftpm_tee_remove,
+	},
+};
+
+static int __init ftpm_mod_init(void)
+{
+	int rc;
+
+	rc = platform_driver_register(&ftpm_tee_plat_driver);
+	if (rc)
+		return rc;
+
+	return driver_register(&ftpm_tee_driver.driver);
+}
+
+static void __exit ftpm_mod_exit(void)
+{
+	platform_driver_unregister(&ftpm_tee_plat_driver);
+	driver_unregister(&ftpm_tee_driver.driver);
+}
+
+module_init(ftpm_mod_init);
+module_exit(ftpm_mod_exit);
 
 MODULE_AUTHOR("Thirupathaiah Annapureddy <thiruan@microsoft.com>");
 MODULE_DESCRIPTION("TPM Driver for fTPM TA in TEE");
-- 
2.17.1

