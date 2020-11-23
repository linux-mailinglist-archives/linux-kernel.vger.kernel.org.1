Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48B2C1647
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbgKWUPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgKWUPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:06 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCBC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:06 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t14so13762046qvc.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=01BW1GkidBPog12oysmILVzISd/+h9nT3tAZwCe3eCQ=;
        b=ftOluYgsoGAOE5Ye/to9lLng+2ouMijOYaYtwma2Ox9E53wFC3jC7Nqa0GnHSc266v
         7venxL4adfRnnuzv07o06M9sPHJt+dDW40FZqv8UC20VDOUHQgD11io/dJVACWzd5Crp
         NyCk5K3h5KXsbQg+rRlQ0KFgtBFOS94A1KVMBNcjTIUeRCkb113dfiZjpB1xcq3rtsuB
         zkGdOifa55a0nfyRYqdixyGXB6OXKvBSZu5bw11Vg4HhJQoZ7veWEiiF3/bcJyIsl+06
         NXpZUiOOOis3fhzxBKjaSCZNXCdhA3reqMwAszBN4vudp7UH4LMtCP4gOnylYl/ep3ys
         oIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=01BW1GkidBPog12oysmILVzISd/+h9nT3tAZwCe3eCQ=;
        b=T5MpnryYbLgCzrYrQDswWjwxt+RnNp6oqED9fnQO6RSiVknHOe1uIwPcLhwMS+DsKj
         LsUHEXnLE1QKb4+3qT3l5E7HAA2h9rUY1hn3SethGpsR7hKalYtwdgznpuTbmGW5mtZP
         XDMT43KnkLABHS88CFmi4GBJuQVzOmFf8TrjR92LI9nCe01H+miNhERf4Mg0JaWj3fce
         54v/DMIz2Drazupqp1wB9p1wgjT3Q1Y/MZhbRoguItmOeD7ltdQUAOVxM9ZxpC7lPqMW
         5OgAcLk77dYDQnlhPXqKeyfw8q3cuoz78gCQ+vtZEPAaNr7uE3IPvbF+gZkGO86Rcmcr
         vTZg==
X-Gm-Message-State: AOAM531l9jMlKZ/aeTKn3aGhXCM4qafBzTwXiTY2bTfmQkVc78t0UZI9
        AVyK8wsH7XqdFvnC2PmTunmz0jTghFlJwUqW
X-Google-Smtp-Source: ABdhPJxJLu3lTiGvBa9uPDvK6XDnw+JLdTht9mXTq7OHyNsPd/2Yeymonl71MNmRULVBzyGWvGUs9Gqp+tGli6N/
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:804a:: with SMTP id
 68mr1169751qva.1.1606162505149; Mon, 23 Nov 2020 12:15:05 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:35 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <ecdb2a1658ebd88eb276dee2493518ac0e82de41.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 05/19] kasan: allow VMAP_STACK for HW_TAGS mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
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
Reviewed-by: Marco Elver <elver@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
---
 arch/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 762096e4ec16..6092102b29e9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -955,16 +955,16 @@ config VMAP_STACK
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
2.29.2.454.gaff20da3a2-goog

