Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB64C2E2F1B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 21:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgLZUzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 15:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgLZUzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 15:55:46 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3FFC061757;
        Sat, 26 Dec 2020 12:55:06 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 9so1480490ooy.7;
        Sat, 26 Dec 2020 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yo+rI+xV9fbwD4IcjY7RrOaFOn/0rDQdu5Q5Hur4+BI=;
        b=gMtNXCnL1BR7DaHRAdED3vrLhbMhDaVGujHTgScABzPMv7r2CdjIFECefK8LkIkSFO
         kCOaandzqNwhblwiX0kvGXbS1MzZk2qNnshFp/+ZCdNJ9pXEb16NluogkSoH/J3TStHk
         o8/4NaY4zw0a+EKEMzebmZbuhZegUvuee4GiXZB82x1r7TlyrruUk6WALYWOD22QISxD
         8R5aUV6MOH7LufNI6AXecrn9tBSJYrahwzxO/RPQUIEqDNXbQHCX4/rbjRbxxU5gVwK6
         uzboa+ylImYetyf4yVIPlz2gxMqPXgD66g95nwniFbxOJKUPGRnrKRs6IC29+Wc6ixaX
         3NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yo+rI+xV9fbwD4IcjY7RrOaFOn/0rDQdu5Q5Hur4+BI=;
        b=MVTMqIUvpqfyUbL5887lXniRcxmOJFOAQeElNI75s8mzBAazvcBB2lUCzD446f50dj
         b4AvsOM6SEdmp54V2iwh2MQ4tNmOdtAO4auxWqyvQHYG7TyhIjHFV7wHvehD0YdCdCxo
         pnbpBxqG5OBQVesfunVMtKLju+15i0+eYEPP/46xXCEL9K0WKAp32VZYz9X3TZtqnoPw
         rpxBEnqUBww/HuHkGPhY68aOGkToyvzLuNvT7DYXXXRHkNbPwmDp8nuGJMbTmiP+TDOS
         9PWnzNQjlua+Tbyie8pEibfEH8lAZKAmdOoradGs5yxDfAVpWqjeZtVF1oULss2ujFwS
         YobQ==
X-Gm-Message-State: AOAM5305n0pUPaGglenlO4WS3x9MRPm0oypKz0t3Mp0hQVcDFi39Gr1i
        zSNo5awQcqf2/bnwEkvcWlU=
X-Google-Smtp-Source: ABdhPJzwKliUGwW+xUgTsKBdUIVNz3yeyECJM+tlFqEypStQTga95vofnFnnv6d5xg5OPJL1NFVV1g==
X-Received: by 2002:a4a:8c73:: with SMTP id v48mr27191779ooj.53.1609016105311;
        Sat, 26 Dec 2020 12:55:05 -0800 (PST)
Received: from localhost.localdomain ([198.98.48.60])
        by smtp.gmail.com with ESMTPSA id z3sm8287878ooj.26.2020.12.26.12.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 12:55:04 -0800 (PST)
From:   Arnold Gozum <arngozum@gmail.com>
Cc:     Arnold Gozum <arngozum@gmail.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel-vbtn: Support for tablet mode on Dell Inspiron 7352
Date:   Sat, 26 Dec 2020 15:53:06 -0500
Message-Id: <20201226205307.249659-1-arngozum@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell Inspiron 7352 is a 2-in-1 model that has chassis-type "Notebook".
Add this model to the dmi_switches_allow_list.

Signed-off-by: Arnold Gozum <arngozum@gmail.com>
---
 drivers/platform/x86/intel-vbtn.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 3b49a1f4061b..9bbdb26d4305 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -222,6 +222,12 @@ static const struct dmi_system_id dmi_switches_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Switch SA5-271"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7352"),
+		},
+	},
 	{} /* Array terminator */
 };
 
-- 
2.25.1

