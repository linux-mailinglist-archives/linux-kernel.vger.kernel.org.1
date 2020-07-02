Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE9211F40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 10:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGBIzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 04:55:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36564 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:55:43 -0400
Received: from [222.129.43.254] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1jqv0H-0000UW-GJ; Thu, 02 Jul 2020 08:55:34 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, mapengyu@gmail.com, ibm-acpi@hmh.eng.br,
        dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: not loading brightness_init when _BCL invalid
Date:   Thu,  2 Jul 2020 16:55:20 +0800
Message-Id: <20200702085520.16901-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When _BCL invalid, disable thinkpad_acpi backlight brightness control.

brightness_enable is already checked at the beginning,
Always print notice when enabled brightness control.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ff7f0a4f2475..a52d6d457d6c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6955,10 +6955,13 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 			pr_warn("Cannot enable backlight brightness support, ACPI is already handling it.  Refer to the acpi_backlight kernel parameter.\n");
 			return 1;
 		}
-	} else if (tp_features.bright_acpimode && brightness_enable > 1) {
-		pr_notice("Standard ACPI backlight interface not available, thinkpad_acpi native brightness control enabled\n");
+	} else if (!tp_features.bright_acpimode) {
+		pr_notice("thinkpad_acpi backlight interface not available\n");
+		return 1;
 	}
 
+	pr_notice("thinkpad_acpi native brightness control enabled\n");
+
 	/*
 	 * Check for module parameter bogosity, note that we
 	 * init brightness_mode to TPACPI_BRGHT_MODE_MAX in order to be
-- 
2.26.2

