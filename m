Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F119BFF4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 13:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbgDBLNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 07:13:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37992 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgDBLNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:13:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jJxn4-0004jB-2I; Thu, 02 Apr 2020 11:13:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: platform: remove redundant assignment to variable ret
Date:   Thu,  2 Apr 2020 12:13:41 +0100
Message-Id: <20200402111341.511801-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read
and it is being updated later with a new value. The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/base/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 5255550b7c34..2e454c18b3a9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -668,7 +668,7 @@ EXPORT_SYMBOL_GPL(platform_device_unregister);
 struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo)
 {
-	int ret = -ENOMEM;
+	int ret;
 	struct platform_device *pdev;
 
 	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
-- 
2.25.1

