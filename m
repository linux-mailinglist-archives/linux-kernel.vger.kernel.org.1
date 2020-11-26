Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421022C5DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 23:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391838AbgKZWYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 17:24:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57246 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391822AbgKZWYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 17:24:07 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kiPgL-0005GQ-IU; Thu, 26 Nov 2020 22:24:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cramfs: Kconfig: Fix spelling mistake "adresssed" -> "addressed"
Date:   Thu, 26 Nov 2020 22:24:05 +0000
Message-Id: <20201126222405.12772-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig help text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cramfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
index d98cef0dbb6b..a8af8c6ac15d 100644
--- a/fs/cramfs/Kconfig
+++ b/fs/cramfs/Kconfig
@@ -38,7 +38,7 @@ config CRAMFS_MTD
 	default y if !CRAMFS_BLOCKDEV
 	help
 	  This option allows the CramFs driver to load data directly from
-	  a linear adressed memory range (usually non volatile memory
+	  a linear addressed memory range (usually non volatile memory
 	  like flash) instead of going through the block device layer.
 	  This saves some memory since no intermediate buffering is
 	  necessary.
-- 
2.29.2

