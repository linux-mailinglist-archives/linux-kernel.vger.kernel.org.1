Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991362CEDF2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 13:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgLDMSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 07:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgLDMSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:18:54 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C0DC061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 04:18:08 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so7324798lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 04:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKh+BEm0Z2hwqewzzroWyDAofQUgJdQkZ+JXiUwPDEU=;
        b=pZu9FxSWb0qhpn2tILJ8QNQAAOVd2yuPkNWwm+pqgkEFt6pc6Vz6Acf4UYrGpIxlT+
         1HTAp/sNwh8RoKTuJXWF+rSQowE3O1oxfWUVXFiJc1tC2QM37A4arFOkX4K4zS1y3UrA
         7Hpwue75hh07cIOm1PTeTQNHv/Qu3Nc6t5EDMwptN2K2CvcWMnuXU1h92VPRm1GgdpQ0
         dJ+qkkLDT7tf8SiXZOdlDr5tqcleQbDbjt+O3bPSDo6gPsMhheZaYSanoKvt1dWZ6WDE
         uyVKDw2ErECXAUMimdLiAVD/4uqVDvQZinJHWbfwkQ87PBaK3Pxjsj/6nB3EmQQyZ2X/
         qpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QKh+BEm0Z2hwqewzzroWyDAofQUgJdQkZ+JXiUwPDEU=;
        b=AQUpPk/Yo8jLNJsb6aV9cPtIdrYm+sSlyZgZZgVUY8uQSNDadL3hBSDvCNC/J8FZPm
         aqI/5th4M4jEz0quxOvvOnXn8N+Ddhpx2aFOjU5aot5pZ0IHR4wfzxk9gOm6gEV1yP8k
         2exwrHMTncf3fMzrklJWf2JEpvHnQdwHP1FbzbjH4WBloSeszIHOn7rrX0RtzpjYEIkj
         YpIy+bX+M577/GSlfk0Cq42KKRt/WYhsje3dDtYICW1dBNUWUk98zF24PnW+pse8UXT9
         Def3hwIli4wN+7qTGamRwvgYUKKJrVCoC2aumBXj2DZJCplHAb+XP0ZJHNT0r889zTlU
         qhPA==
X-Gm-Message-State: AOAM533UCOGcvMh3isQvMAhK+c8v1Ytt203LMOM6OIwpNhVytvsh4loN
        hRT7GnsOnnoQ4CLl2fYMh+ks+Q==
X-Google-Smtp-Source: ABdhPJz2Cdt4Tpl9onypmtkivvmNIEWmBoOLOR8tvaRInPMfFukDEjGAivVIF1q6f0kGhoFFtOEh7Q==
X-Received: by 2002:ac2:41ca:: with SMTP id d10mr3218682lfi.419.1607084286559;
        Fri, 04 Dec 2020 04:18:06 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id c8sm597731lja.103.2020.12.04.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:18:06 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     akpm@linux-foundation.org, glider@google.com, elver@google.com,
        dvyukov@google.com, catalin.marinas@arm.com, will@kernel.org
Cc:     kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] kfence: fix implicit function declaration
Date:   Fri,  4 Dec 2020 13:18:04 +0100
Message-Id: <20201204121804.1532849-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kfence the following error shows up:

In file included from mm/kfence/report.c:13:
arch/arm64/include/asm/kfence.h: In function ‘kfence_protect_page’:
arch/arm64/include/asm/kfence.h:12:2: error: implicit declaration of function ‘set_memory_valid’ [-Werror=implicit-function-declaration]
   12 |  set_memory_valid(addr, 1, !protect);
      |  ^~~~~~~~~~~~~~~~

Use the correct include both
f2b7c491916d ("set_memory: allow querying whether set_direct_map_*() is actually enabled")
and 4c4c75881536 ("arm64, kfence: enable KFENCE for ARM64") went in the
same day via different trees.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

I got this build error in todays next-20201204.
Andrew, since both patches are in your -mm tree, I think this can be
folded into 4c4c75881536 ("arm64, kfence: enable KFENCE for ARM64")

 arch/arm64/include/asm/kfence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index 6c0afeeab635..c44bb368a810 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_KFENCE_H
 #define __ASM_KFENCE_H
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 static inline bool arch_kfence_init_pool(void) { return true; }
 
-- 
2.29.2

