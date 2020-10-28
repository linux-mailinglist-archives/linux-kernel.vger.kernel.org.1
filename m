Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3204629E0C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbgJ2Be0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:34:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34791 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgJ2BeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 21:34:25 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kaichuan.hsieh@canonical.com>)
        id 1kXcpv-0004Tb-UB; Wed, 28 Oct 2020 04:13:24 +0000
From:   Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] firmware/dmi: Include product_sku info to modalias
Date:   Wed, 28 Oct 2020 12:13:20 +0800
Message-Id: <20201028041320.9521-1-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <[PATCH] firmware/dmi: Include product_sku info to modalias>
References: <[PATCH] firmware/dmi: Include product_sku info to modalias>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Dell platforms rely on modalias to customize configuration,
the product sku can be more specific for the hardware.

Add product_sku to modalias for better utilization.

Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
---
 drivers/firmware/dmi-id.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 86d71b0212b1..4d5421d14a41 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -85,6 +85,7 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
 		{ "svn", DMI_SYS_VENDOR },
 		{ "pn",  DMI_PRODUCT_NAME },
 		{ "pvr", DMI_PRODUCT_VERSION },
+		{ "sku", DMI_PRODUCT_SKU },
 		{ "rvn", DMI_BOARD_VENDOR },
 		{ "rn",  DMI_BOARD_NAME },
 		{ "rvr", DMI_BOARD_VERSION },
-- 
2.25.1

