Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF482C6107
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgK0Ijs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgK0Ijr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:39:47 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01BC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:39:46 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id j205so5937420lfj.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq0pZQK9Mol8DOtCUpYSsXSaOdIRPPSzZ/jWHRVV+rU=;
        b=CA94T8+XM8TcvvUoQEakxsqYSlXPEIxc3/PhGxdQniz14i/PI65DrKnFAy6LvetjDb
         Vq3ph7kiW6rrK/v3hjv0spHBZmvzAFti8XC6CJhfcVkmDtDzZ/n5VuMkwoTlLh1gEOG8
         T1YbnzDZLFjeFzNEmRGqQqL812VSsp9pSKwWZ7c+dVOr2Hob3J9H4s/9c9NiX52v8Cen
         zImTjkRnUVOYV728GV6iYTseZMS1I+oS2Ph/0SiznRG0pMT3O/ZB1NDHvi8pfnwdgFF2
         M1m0gD6ONVshc3LFG7aj/RpegEeCRyEU7/Zft9hiArRVs/u3K7ogISp8fEhAKaRUYbTM
         fQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq0pZQK9Mol8DOtCUpYSsXSaOdIRPPSzZ/jWHRVV+rU=;
        b=tQ0cg07YmY0yEm615Jf79cAELAF5y/oWk2VqZJbQj1DyYV3VBsbZRL6G8HQwYLtI1u
         uQ9yHujWOlgC+krMLcI8115IXZbuqgMkUkuXGpxqjZ8MpzAkfP++2QBOCL6U4EdEMS02
         vr45Dzp5+wb1LbpD/6oTTt/GmNtQOygVBGVXCGuLWTYzoRR8zgeOxFog5QyzqVAkrMVs
         eFOmRhKvT9eUAT9JGwe7TV+fR6xJ1oVJqBLByt8wBY4V7/5V7kzFwvomCptTmA+tk4pV
         XVxWuV0Y/5DVMVLkdmj5WOles4R/4lXrFMlx+j/XoLN022m0t3/6z1wy5gIWDu4fSsK2
         8TBA==
X-Gm-Message-State: AOAM530XxS2lB7C9sRC2HahsuC00laAgfSeBc1bYCBaRjNagcpdymzoQ
        CEl5U+dLj6WXgu1rz47Or2XKgw==
X-Google-Smtp-Source: ABdhPJwI0C55bHm/cCa6XfqnxtgJ9+clt+MrNFZJxc3oe39zAsc0UkN+fUEQL3t22cpQrVejyC2FtA==
X-Received: by 2002:a19:7c9:: with SMTP id 192mr2695383lfh.424.1606466385391;
        Fri, 27 Nov 2020 00:39:45 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id x11sm603745lfe.96.2020.11.27.00.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 00:39:44 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tsbogend@alpha.franken.de, natechancellor@gmail.com,
        ndesaulniers@google.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] mips: fix Section mismatch in reference
Date:   Fri, 27 Nov 2020 09:39:43 +0100
Message-Id: <20201127083943.2666864-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building mips tinyconfig with clang the following error show up:

WARNING: modpost: vmlinux.o(.text+0x1940c): Section mismatch in reference from the function r4k_cache_init() to the function .init.text:loongson3_sc_init()
The function r4k_cache_init() references
the function __init loongson3_sc_init().
This is often because r4k_cache_init lacks a __init
annotation or the annotation of loongson3_sc_init is wrong.

Remove marked __init from function loongson3_sc_init(),
mips_sc_probe_cm3(), and mips_sc_probe().

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/mips/mm/c-r4k.c   | 2 +-
 arch/mips/mm/sc-mips.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 99521764c75b..4f976d687ab0 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1609,7 +1609,7 @@ static void __init loongson2_sc_init(void)
 	c->options |= MIPS_CPU_INCLUSIVE_CACHES;
 }
 
-static void __init loongson3_sc_init(void)
+static void loongson3_sc_init(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config2, lsize;
diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index dd0a5becaabd..06ec304ad4d1 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -146,7 +146,7 @@ static inline int mips_sc_is_activated(struct cpuinfo_mips *c)
 	return 1;
 }
 
-static int __init mips_sc_probe_cm3(void)
+static int mips_sc_probe_cm3(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned long cfg = read_gcr_l2_config();
@@ -180,7 +180,7 @@ static int __init mips_sc_probe_cm3(void)
 	return 0;
 }
 
-static inline int __init mips_sc_probe(void)
+static inline int mips_sc_probe(void)
 {
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int config1, config2;
-- 
2.29.2

