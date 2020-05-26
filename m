Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA81C9EA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEGWqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 18:46:08 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:33597 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEGWqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:46:07 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 50c3cd25;
        Thu, 7 May 2020 22:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=Y28RivJhmM6MWjyY0gj84oLdWLQ=; b=EMkPBPwaICbxaPVNifu4
        q3vOcEPh1st206ZYU4wMRszU8E03NYrwDtsQag8ZV2cGoaI1itp016gf8EIAz5dZ
        NhL9MlLsvFI2dnE8kV8ELBHIGxsFasECHkQGu9HukIhZR5NraqdArsCL5TknDdNK
        0UMCxycoLDx9swoh2dlWxZ5uTeyYj3HC3XM0k0Ksb3Fnl3jqnozCYiUUF5tk4i62
        9c3wqlhRH2i2F3FGF4BnIuXVO6RRpbaYQ7bnPl9gdRplAmcCs+cY2hk9JunyMV3W
        88jSI5G9RLZXGZ00Mbq3SEw4S/iaeUr95vpSYPVtmFb+KW5TjilTe+kqtmhE7GLk
        gA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a66014fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 May 2020 22:33:14 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for gcc >= 10
Date:   Thu,  7 May 2020 16:45:30 -0600
Message-Id: <20200507224530.2993316-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 10 appears to have changed -O2 in order to make compilation time
faster when using -flto, seemingly at the expense of performance, in
particular with regards to how the inliner works. Since -O3 these days
shouldn't have the same set of bugs as 10 years ago, this commit
defaults new kernel compiles to -O3 when using gcc >= 10.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 init/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..fab3f810a68d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1245,7 +1245,8 @@ config BOOT_CONFIG
 
 choice
 	prompt "Compiler optimization level"
-	default CC_OPTIMIZE_FOR_PERFORMANCE
+	default CC_OPTIMIZE_FOR_PERFORMANCE_O3 if GCC_VERSION >= 100000
+	default CC_OPTIMIZE_FOR_PERFORMANCE if (GCC_VERSION < 100000 || CC_IS_CLANG)
 
 config CC_OPTIMIZE_FOR_PERFORMANCE
 	bool "Optimize for performance (-O2)"
-- 
2.26.2

