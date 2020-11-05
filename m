Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66F72A7375
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbgKEACu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgKEACt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:02:49 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B8BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:02:48 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id b68so322wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=z6j3WUTg8MpmEPLYdtLimxVBLIkxxjwsBk3bJk+FZ/c=;
        b=o1BHF1EVbMTrooct4IuVuzwUadRydSkmLut5zGwLfIW86KeTj+T7+3qQd8RFCYYVk1
         ZMQRhpeEUB0u7Y/NHq7fRwnmcx3ssRcGQXKNVGsCHvT9J0ec5Uo0HSkVZwIlNtxDiWBV
         1AYf95vBSDu2mEJnYgYDgiUD2HOPIlRa801YsQlyBFlE4oaIsvs/R1fU90M1/78nGH31
         rSpbf1mVkKGWUcgjBXgG/dZMJz3TUYg1+KwIJX3sm4kRmuAVkTFAYArvZdBWFDmDFy5c
         75+gVsds4JozQ2HcmfCmLiO0RpdOJkKQTUuAkL7OUg7yjQY0LQHEif8Q02Q9qTWV0+Hq
         AH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z6j3WUTg8MpmEPLYdtLimxVBLIkxxjwsBk3bJk+FZ/c=;
        b=HejN5VPBmiyQlauzAJ96rJ0/05vFnByIKOQf1Ya3ZQo86nrNlfKEVCr5X2VF4jq88x
         ES17bnl6Q1wxii0tmvom4FNs0F7GahHO7nWYY/ybPG766GvggQ4ZUTtOSL4eVz14wgWn
         OVZ2wZiFGg587ryaCg03GKDfRHX7YwwqBtkqZISkhLUgMTnDGmtaqOzYxlarxvoJAR7w
         1zWhB8NQhd8kBIU+23lRN1Wih894YCkWtKQJP8P35Z/J+tMMGuzW6JHR4MQgKIH4TB+Q
         YMX7pDUpc2nNLf1aPzS2ogsgL/bJEDR9xrE+3uxX854QgkZs92v6pAB54TdZH95z1tsB
         z4nA==
X-Gm-Message-State: AOAM531moc65sBlvOFOhWyQ01Gu1JYVyz6rBdqLwNt/IteFpvXjQXvQc
        hM/OiV+hv6fV6ikQBA1OFXeeeXqOm19o2Cw7
X-Google-Smtp-Source: ABdhPJyW9CVHpcZlYLIGEMvyGyz16yUK8Wds51tx5Sii32bcO3BS7futrB9CgRdyZWCAoRPp5flAxMpdXR2/WiKH
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:a315:: with SMTP id
 c21mr514082wrb.272.1604534567466; Wed, 04 Nov 2020 16:02:47 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:15 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <dbd82cbb24bf5875b465e0d75568916edb8b92ea.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 05/20] kasan: allow VMAP_STACK for HW_TAGS mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
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
2.29.1.341.ge80a0c044ae-goog

