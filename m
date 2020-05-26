Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F261E1C9E35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 00:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgEGWGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 18:06:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44227 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgEGWGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:06:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jWodU-000300-A9; Thu, 07 May 2020 22:04:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: asus_wmi: remove redundant initialization of variable status
Date:   Thu,  7 May 2020 23:04:55 +0100
Message-Id: <20200507220455.66681-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable status is being initialized with a value that is never read
and it is being updated later with a new value. The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index bb7c529d7d16..1909d728a536 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -309,7 +309,7 @@ static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
 	struct acpi_buffer input;
 	u64 phys_addr;
 	u32 retval;
-	u32 status = -1;
+	u32 status;
 
 	/*
 	 * Copy to dma capable address otherwise memory corruption occurs as
-- 
2.25.1

