Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFBA26B913
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIOLW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIOLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:18:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71CEC061222
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:07:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so1584731pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=IPDhGgu0otyR0D5FWAzn2/lQZFvFhrDOh5IObqsojaY=;
        b=iWHncBdtzB2UH5J2cOkmy6ubgv4Ns2WCFis1qs6YjEpUbVkClCrL9i5ROlhMEO6J2l
         i29LHAGefXZD91vifwuXqdI3SQOUpobmGTtqaYiL4j7FcONW6aJ7sVozrdI4YhPhGrpN
         2ib9FIogd7Q/iTm4BEICibWPbnK8M1ulTibDqSYIcMtPeiuAK/EPyUEVYPY2deNdosDg
         QbKO7oBMEFZKAuufCmpM6qJafjxJvCHRr/tWGpPgrnP5x2DI6cVn+VvBmBCmPbyJfIVO
         KYLe4IqeiNb4mWiHagholFCEsdjl4lY8gDLbO+5fRDolDGDykARl7lL7dq7DkKZekeJi
         5j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IPDhGgu0otyR0D5FWAzn2/lQZFvFhrDOh5IObqsojaY=;
        b=VzLsdEdOut9sYaB8yZdg70gfMJ0Sm8vVMtvY9W8GLY2Gtwdg5hhGtVI4qEB8s2/qyL
         IOrJIJmeDUGsIJKYYVYCHAbtHCl/0GHa/ciweoYqkWfrWcfot6vAUiwe4iN7OBx4NNxW
         MnIpL49V4aerekjzmIMY0OwSKtUVXMfhO7pKse5TVJvOLGCa/ZEUcXE5y/2XbuwZijCA
         tmiXXLzd1hPFrRxPmbirBkCypJIuuPu1Cp5Tn15aoFsAcmZ4Ci8lGnmWvsVhHuj4IF+1
         Di1iYAUNtZMpjOPs/vcKjX+pP4utzKx5jkwygyTaN4dMO/uVQbD1UjhMqiJKOh3jcKAf
         W1WQ==
X-Gm-Message-State: AOAM532ecsNJQz0PhK2gwzEVeqSrCZ6XAlAlE1tr/db9UHh/zyS98fw5
        957WL8mDPeE/V4fnd1qL3E7zbw==
X-Google-Smtp-Source: ABdhPJyA9HwpWVL0uXGhfpvfPM8oY97KnK+Zvd/q1ERwk2QiM36t2cfcuyq/L3nFYWKcRJz0A7dkbw==
X-Received: by 2002:a17:902:ba8c:b029:d1:e5e7:be11 with SMTP id k12-20020a170902ba8cb02900d1e5e7be11mr1215635pls.68.1600168024250;
        Tue, 15 Sep 2020 04:07:04 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([223.235.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm13368523pfi.169.2020.09.15.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:07:03 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ran Wang <ran.wang_1@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        tanveer <tanveer.alam@puresoftware.com>
Subject: [PATCH v1] soc: fsl: rcpm: Add ACPI support
Date:   Tue, 15 Sep 2020 16:36:47 +0530
Message-Id: <20200915110647.846-1-kuldip.dwivedi@puresoftware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support in fsl RCPM driver. This is required
to support ACPI S3 state. S3 is the ACPI sleep state
that is known as "sleep" or "suspend to RAM".
It essentially turns off most power of the system but
keeps memory powered.

Signed-off-by: tanveer <tanveer.alam@puresoftware.com>
Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
---

Notes:
    1. Add ACPI match table
    2. NXP team members are added for confirming HID changes
    3. There is only one node in ACPI so no need to check for
       current device explicitly
    4. These changes are tested on LX2160A and LS1046A platforms

 drivers/soc/fsl/rcpm.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index a093dbe6d2cb..e75a436fb159 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -2,10 +2,12 @@
 //
 // rcpm.c - Freescale QorIQ RCPM driver
 //
-// Copyright 2019 NXP
+// Copyright 2019-2020 NXP
+// Copyright 2020 Puresoftware Ltd.
 //
 // Author: Ran Wang <ran.wang_1@nxp.com>
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -57,8 +59,13 @@ static int rcpm_pm_prepare(struct device *dev)
 				rcpm->wakeup_cells + 1);
 
 		/*  Wakeup source should refer to current rcpm device */
-		if (ret || (np->phandle != value[0]))
-			continue;
+		if (is_acpi_node(dev->fwnode)) {
+			if (ret)
+				continue;
+		} else {
+			if (ret || (np->phandle != value[0]))
+				continue;
+		}
 
 		/* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
 		 * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
@@ -139,10 +146,19 @@ static const struct of_device_id rcpm_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rcpm_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rcpm_acpi_match[] = {
+	{ "NXP0015", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rcpm_acpi_match);
+#endif
+
 static struct platform_driver rcpm_driver = {
 	.driver = {
 		.name = "rcpm",
 		.of_match_table = rcpm_of_match,
+		.acpi_match_table = ACPI_PTR(rcpm_acpi_match),
 		.pm	= &rcpm_pm_ops,
 	},
 	.probe = rcpm_probe,
-- 
2.17.1

