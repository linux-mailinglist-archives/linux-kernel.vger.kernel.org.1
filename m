Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1689F29587C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504245AbgJVGkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:40:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48877 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504237AbgJVGkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:40:52 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kaichuan.hsieh@canonical.com>)
        id 1kVUHK-0003qB-Ft; Thu, 22 Oct 2020 06:40:51 +0000
From:   kaichuan.hsieh@canonical.com
To:     jdelvare@suse.com, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware/dmi: Include product_sku info to modalias
Date:   Thu, 22 Oct 2020 14:40:47 +0800
Message-Id: <20201022064047.9827-1-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>

Some Dell platforms rely on modalias to customize configuration,
the product sku can be more specific for the hardware.

Add product_sku to modalias for better utilization.

Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
---
 drivers/firmware/dmi-id.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 86d71b0212b1..26eb01da5392 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -77,21 +77,22 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
 		const char *prefix;
 		int field;
 	} fields[] = {
-		{ "bvn", DMI_BIOS_VENDOR },
-		{ "bvr", DMI_BIOS_VERSION },
-		{ "bd",  DMI_BIOS_DATE },
-		{ "br",  DMI_BIOS_RELEASE },
-		{ "efr", DMI_EC_FIRMWARE_RELEASE },
-		{ "svn", DMI_SYS_VENDOR },
-		{ "pn",  DMI_PRODUCT_NAME },
-		{ "pvr", DMI_PRODUCT_VERSION },
-		{ "rvn", DMI_BOARD_VENDOR },
-		{ "rn",  DMI_BOARD_NAME },
-		{ "rvr", DMI_BOARD_VERSION },
-		{ "cvn", DMI_CHASSIS_VENDOR },
-		{ "ct",  DMI_CHASSIS_TYPE },
-		{ "cvr", DMI_CHASSIS_VERSION },
-		{ NULL,  DMI_NONE }
+		{ "bvn",  DMI_BIOS_VENDOR },
+		{ "bvr",  DMI_BIOS_VERSION },
+		{ "bd",   DMI_BIOS_DATE },
+		{ "br",   DMI_BIOS_RELEASE },
+		{ "efr",  DMI_EC_FIRMWARE_RELEASE },
+		{ "svn",  DMI_SYS_VENDOR },
+		{ "pn",   DMI_PRODUCT_NAME },
+		{ "pvr",  DMI_PRODUCT_VERSION },
+		{ "psku", DMI_PRODUCT_SKU },
+		{ "rvn",  DMI_BOARD_VENDOR },
+		{ "rn",   DMI_BOARD_NAME },
+		{ "rvr",  DMI_BOARD_VERSION },
+		{ "cvn",  DMI_CHASSIS_VENDOR },
+		{ "ct",   DMI_CHASSIS_TYPE },
+		{ "cvr",  DMI_CHASSIS_VERSION },
+		{ NULL,   DMI_NONE }
 	};
 
 	ssize_t l, left;
-- 
2.25.1

