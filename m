Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3709821D8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 16:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgGMOsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 10:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgGMOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:48:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:48:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so16860532wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=SqLpNbrWbVZ1ZcHNvqUNkPn7eaBYfUTrAesyLzeaaYk=;
        b=OavEDpb0LRY6G1J+nhTH6zmCvIPkcUpsy7v/Jf+/PjPbGNj+AWgbJCfAFA9N1C+yBK
         n2VxAtw3IajL9I0XEXRaEdsB8FkgEBBX4kEHm06tvJ0ji3FITv1OE8tnNWnPnnBMnUrj
         BUM9O5J5vghrq5zsSmxaqQnTeLnGV04q4+9HxZdMeBZ0+zS9MXnq7ZU8KyY0eJqbRFFE
         W1tfFGTAbPBNPOfa9nFekDi5tjcp0QlJOl4JDXrzFsB5bkaAYJL53HxqQ/tj6jISt4Xf
         6iGUNVAmSwmszzkYjoIDsygaKitJmqnSVJIxXVSOyrQlW22uZaRo/7JbEpVjLZ3/9XVE
         UjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=SqLpNbrWbVZ1ZcHNvqUNkPn7eaBYfUTrAesyLzeaaYk=;
        b=IXxgUO6VvU4T0MZXsn9i0SZI1F8JDKAQmnKmsO9AVek4qxIxEUZlIWPBCtP9a6usCX
         rkYwKH1dReX3p4r9XI9qPlEBW/brZ66ZvDKoRhy8nM8StwJtR/OJVM7v1Kb4zLA3i2+F
         b+1Zn3hw0rbp6r7I2e0Rgxdy3FfdPwVcLGUetXbUq2yVq2l2E5VJtm5/NzkwXzTk6OBb
         DbeWxxOo57qmoKjuHhJ4JFB8xAQS6FlfaVF7YEfiv6ZRz+bshEMjZxVb1XSzppDJjRVx
         mbmc0zLTaixaroY1SO3pQ0/B2U+AiogIPynViK6yEN4S0ltP3E0jVtHsrXi+jWtnoczR
         /RDg==
X-Gm-Message-State: AOAM532ropvkZ5CYLHsMKHiX1zrNDbWHUkFf75bnZqT9l3FH0HH+jbrF
        IXTLpgqp0KnUDJXqissqtNPyv6dR
X-Google-Smtp-Source: ABdhPJz6OYaI9f9AbQQUklXdfTvoboI7v15Jwy6JRK/aFx/FGtqZ4n2oviWBpCFzVE+GFP8PJTCJzg==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr81009818wrp.421.1594651692234;
        Mon, 13 Jul 2020 07:48:12 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id u17sm23369080wrp.70.2020.07.13.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:48:10 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 3/3] habanalabs: update hl_boot_if.h from firmware
Date:   Mon, 13 Jul 2020 18:54:24 +0300
Message-Id: <20200713155424.24721-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713155424.24721-1-oded.gabbay@gmail.com>
References: <20200713155424.24721-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the boot interface file from the latest version from firmware.
Defines for secure boot were added.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/include/common/hl_boot_if.h    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index c22d134e73af..bb67cafc6e00 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -44,6 +44,15 @@
  *					The NIC FW loading and initialization
  *					failed. This means NICs are not usable.
  *
+ * CPU_BOOT_ERR0_SECURITY_NOT_RDY	Chip security initialization has been
+ *					started, but is not ready yet - chip
+ *					cannot be accessed.
+ *
+ * CPU_BOOT_ERR0_SECURITY_FAIL		Security related tasks have failed.
+ *					The tasks are security init (root of
+ *					trust), boot authentication (chain of
+ *					trust), data packets authentication.
+ *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
  *					running FW populates the error
@@ -57,6 +66,8 @@
 #define CPU_BOOT_ERR0_BMC_WAIT_SKIPPED		(1 << 4)
 #define CPU_BOOT_ERR0_NIC_DATA_NOT_RDY		(1 << 5)
 #define CPU_BOOT_ERR0_NIC_FW_FAIL		(1 << 6)
+#define CPU_BOOT_ERR0_SECURITY_NOT_RDY		(1 << 7)
+#define CPU_BOOT_ERR0_SECURITY_FAIL		(1 << 8)
 #define CPU_BOOT_ERR0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
@@ -79,7 +90,10 @@ enum cpu_boot_status {
 	CPU_BOOT_STATUS_BMC_WAITING_SKIPPED, /* deprecated - will be removed */
 	/* Last boot loader progress status, ready to receive commands */
 	CPU_BOOT_STATUS_READY_TO_BOOT = 15,
+	/* Internal Boot finished, ready for boot-fit */
 	CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT = 16,
+	/* Internal Security has been initialized, device can be accessed */
+	CPU_BOOT_STATUS_SECURITY_READY = 17,
 };
 
 enum kmd_msg {
-- 
2.17.1

