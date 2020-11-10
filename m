Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97D02AE32C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgKJWUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgKJWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:20:43 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CDC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:42 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 194so70631lfm.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iclGPRxOEu/Y72cezYx1VmP9mDKpdmhcr9SlAN2oUkA=;
        b=anCq4EdnMSfYibAYpKrbP8hc679KEJvqPcdaN5/ex3VCos1k3cAadzjksNjGffBqyb
         9lgrUg03iHa8hf4SaVEeE+mhD1mCHcljJ1Z7Ec/ZghnpiPfwDV4+tZOz03wyyuzCkWN9
         T4v3wHx6wv0e4wpOUdjnOJR7SC5EgpvpDGy+L1000n3KvhEK62jVSzkseAUDrGlOW3r0
         g8ZvAhT1g1U4eFHzE8Pxdb2eONP3u7u7CYSfsjuF0yjCdSWIeOtzbawwk3RpvEMvyPf3
         Z/XsxkAcX/vePoc584Itp3epvSDKWY3tEZhC9BFnXQ7YFDQwHJPCHiGaCKIKNknphdDi
         D6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iclGPRxOEu/Y72cezYx1VmP9mDKpdmhcr9SlAN2oUkA=;
        b=qRf5xy6RKkoEFEcMXt4hXoNADrPi7ZVNekj4FHDcJDEfHgnDCbyAQ8sg7ElJIsAPXl
         hwoSd/wlHs/wKQJnZQRyjjUiaVALXtPWMuEbp86Pym+jBGQVTkxfsdaBkF4c8euPSOi4
         gy6V9Me07ZkWjmGtHPExMEIViWyRttbHZmMTeKMYXDUagy9Sw3JFeWIWtfKFCEp3gnP5
         75ILL4n3enLxMLnwoM4kCmB5pB6RW+Go+hd3QYQUDvc8ZHP2SahBVU0TFfAI4fewootV
         U1KD07oCY6qEZfaAQgKtDcbMZpn+l1HcipgvSDzTZGjVoc+4mbx6l0BkOVRq3Re5YuUD
         KlOg==
X-Gm-Message-State: AOAM530YYQn7zjc61dELNDmdn6u9tPY5K6h6CZWRxPvNoJAUhbn3/URy
        jZKE6dWunblQND8u2cgKJKWZVrclUHb1eLRA
X-Google-Smtp-Source: ABdhPJz/vW2PmB5nvPRSNdQS5v8e1QIaJCbChgmywQIwIw3qCBt2wYADSNx1GYS36rwbNkkvrKv/2+gFZwdZs5i0
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a2e:320c:: with SMTP id
 y12mr9612197ljy.362.1605046840773; Tue, 10 Nov 2020 14:20:40 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:09 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <3443e106c40799e5dc3981dec2011379f3cbbb0c.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 05/20] kasan: allow VMAP_STACK for HW_TAGS mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though hardware tag-based mode currently doesn't support checking
vmalloc allocations, it doesn't use shadow memory and works with
VMAP_STACK as is. Change VMAP_STACK definition accordingly.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
---
 arch/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc0e32d..7e7d14fae568 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -914,16 +914,16 @@ config VMAP_STACK
 	default y
 	bool "Use a virtually-mapped stack"
 	depends on HAVE_ARCH_VMAP_STACK
-	depends on !KASAN || KASAN_VMALLOC
+	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
 	help
 	  Enable this if you want the use virtually-mapped kernel stacks
 	  with guard pages.  This causes kernel stack overflows to be
 	  caught immediately rather than causing difficult-to-diagnose
 	  corruption.
 
-	  To use this with KASAN, the architecture must support backing
-	  virtual mappings with real shadow memory, and KASAN_VMALLOC must
-	  be enabled.
+	  To use this with software KASAN modes, the architecture must support
+	  backing virtual mappings with real shadow memory, and KASAN_VMALLOC
+	  must be enabled.
 
 config ARCH_OPTIONAL_KERNEL_RWX
 	def_bool n
-- 
2.29.2.222.g5d2a92d10f8-goog

