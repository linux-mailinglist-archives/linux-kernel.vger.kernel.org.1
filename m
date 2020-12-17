Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2892DD624
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgLQR2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:28:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60772 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgLQR2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:28:00 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kpx3e-0000tk-18; Thu, 17 Dec 2020 17:27:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Fix spelling mistake in Kconfig "whats" -> "what's"
Date:   Thu, 17 Dec 2020 17:27:17 +0000
Message-Id: <20201217172717.58203-1-colin.king@canonical.com>
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
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 7af1a55b708e..585d440a554a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -713,7 +713,7 @@ config ZSMALLOC_STAT
 	select DEBUG_FS
 	help
 	  This option enables code in the zsmalloc to collect various
-	  statistics about whats happening in zsmalloc and exports that
+	  statistics about what's happening in zsmalloc and exports that
 	  information to userspace via debugfs.
 	  If unsure, say N.
 
-- 
2.29.2

