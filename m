Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0E2DD608
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgLQRZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:25:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60677 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQRZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:25:09 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpx0t-0000eB-Hz; Thu, 17 Dec 2020 17:24:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: fix spelling mistake in Kconfig "wont" -> "won't"
Date:   Thu, 17 Dec 2020 17:24:27 +0000
Message-Id: <20201217172427.58009-1-colin.king@canonical.com>
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
 arch/xtensa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 37ce1489364e..97beddc9d645 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -467,7 +467,7 @@ config INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX
 	  then enter your normal kernel breakpoints once the MMU was mapped
 	  to the kernel mappings (0XC0000000).
 
-	  This unfortunately won't work for U-Boot and likely also wont
+	  This unfortunately won't work for U-Boot and likely also won't
 	  work for using KEXEC to have a hot kernel ready for doing a
 	  KDUMP.
 
-- 
2.29.2

