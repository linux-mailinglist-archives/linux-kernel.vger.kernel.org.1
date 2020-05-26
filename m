Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07501AF91F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 11:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDSJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgDSJwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:52:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6475C061A0C;
        Sun, 19 Apr 2020 02:52:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o15so2974452pgi.1;
        Sun, 19 Apr 2020 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+11ImWVoVHo1Abgo1KUvhS2FQIppsCfo6UH+T+/qzgs=;
        b=FWRvVsQ1TN0ioGAeP+byZm1uP2+/Un1uA4Yij5mmCFDmuFOEH5LJ0Un71NJml3z2zS
         RwqkhA8ucP14SMtr023/NLsNMRFzQOBlGsJXK6RccSIaGF9cuUsUqNGsCwhQCMZDm5kp
         oPlT8jKmogxlORhe/7Mkirg4kuMV7n0tsmSiMCGWcgXsVxM72lnYMevctrLQ/PlyX4sR
         NUBOqXht8yFnrc8C6Ng82pnF18qCTS7vFHYkwqDkJT61ZL2v1aYxm/F9hWPl5qOXCZma
         Ikxgie+/qJyHPvrqviIVO5lfrbMLvejysrt61YFI7IJRsZJMgigQb9zUphubNm3Yw99N
         ymnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+11ImWVoVHo1Abgo1KUvhS2FQIppsCfo6UH+T+/qzgs=;
        b=GHu+z26RdfTdvCM9VeP5bqbdK7jrlVJf+VYEMaQq1Sx+Dm7p61Zp/DGuxXnlb0cK4Z
         DgZ0h4oMoVRjYWt83Md6HEYMYAaGLR4kvodwmirjrnb52DR4BEcLqFtIuSiHvFZrJ3oz
         Gx5A5cNG+irKdgDYdfdbSNSMemEQ3pzncBG3J0BZOCFuMXFnya6bqA4ZX97s7fn5RAVv
         HxCpsTv8giA0kN5VTNFe7I+KrtoO/fegq879WAVwIO+E+yUXPLN17HzSbH/1VkKpAu68
         kNpdi9JSBrvpM+KiOxd8XvO1eQE3+0Oy59DUQVAAlhOSynXvGbMpmEsdRuU6Yaw/Deyn
         XOeg==
X-Gm-Message-State: AGi0PubJhaDQ9gGiZixeTXSFAya8ztzu+fjk+JkFBcnOSgrYNDStjc4d
        eqxXi1Rn6OkSlvU55eHZn8c=
X-Google-Smtp-Source: APiQypIV0Hhn3WvBrjTXwFhP/7vuLOvB5fDLVw64BVXPX8cdraufg3tgoyuc1aqBd6agwvtez4MFPg==
X-Received: by 2002:aa7:8d52:: with SMTP id s18mr9868901pfe.72.1587289937219;
        Sun, 19 Apr 2020 02:52:17 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.130.218])
        by smtp.gmail.com with ESMTPSA id h193sm18745431pfe.30.2020.04.19.02.52.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 02:52:16 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     hadar.gat@arm.com, mpm@selenic.com, herbert@gondor.apana.org.au,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] drivers/char/hw_random/cctrng.c: Compilation fix.
Date:   Sun, 19 Apr 2020 15:21:18 +0530
Message-Id: <1587289878-121900-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Adding the needed header <linux/fips.h> to fix following compilation error.

	CC      drivers/char/hw_random/cctrng.o
	drivers/char/hw_random/cctrng.c: In function ‘cc_trng_compwork_handler’:
	drivers/char/hw_random/cctrng.c:334:49: error: ‘fips_enabled’ undeclared (first use in this function)
	  if (CC_REG_FLD_GET(RNG_ISR, CRNGT_ERR, isr) && fips_enabled) {
							 ^
	drivers/char/hw_random/cctrng.c:334:49: note: each undeclared identifier is reported only once for each function it appears in
	drivers/char/hw_random/cctrng.c:335:3: error: implicit declaration of function ‘fips_fail_notify’ [-Werror=implicit-function-declaration]
	   fips_fail_notify();
	   ^
	cc1: some warnings being treated as errors
	make[4]: *** [drivers/char/hw_random/cctrng.o] Error 1

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 drivers/char/hw_random/cctrng.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index bdcd562..3124269 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -18,6 +18,10 @@
 
 #include "cctrng.h"
 
+#ifdef CONFIG_CRYPTO_FIPS
+#include <linux/fips.h>
+#endif
+
 #define CC_REG_LOW(name)  (name ## _BIT_SHIFT)
 #define CC_REG_HIGH(name) (CC_REG_LOW(name) + name ## _BIT_SIZE - 1)
 #define CC_GENMASK(name)  GENMASK(CC_REG_HIGH(name), CC_REG_LOW(name))
-- 
1.8.3.1

