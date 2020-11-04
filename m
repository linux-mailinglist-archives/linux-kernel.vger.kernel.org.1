Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055E82A7127
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgKDXTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732667AbgKDXTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:19:37 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D089C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:19:36 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id s9so11204123qvt.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=n8TE6VLWWv4zp+ZnErvJoE/L5oOe+Pde/aeeJYIsZf4=;
        b=VzWDrHAu8PcZDpVqfwqHHsr0grdBxINSFib8aaW6NKowRtNq8XtPgqCJ3wZRd6Kh5o
         DO4OeACbYe+qGI0qx5hBcDkHyonu+e76XoqWrb8O1DUIpLvq6DzQk+9FEtE/I5w1h7n0
         AsTtUAhNQphVlieXp5Wh/bJwER/NjeGHzsNslo8Mq/+ges76CcYlXreJH+5tA+6+vTx5
         POSR5YoJa7lHs/OOUZJ2Zx26KoBySgb3Vlj3A4NnblyOFWWyasJY1yEyj2onrUBjXPp/
         5DpxEuXn81Le0VqDzzzVenVdsr7gBjcrSG0mV7F/85Og6C+fBSxjdR7vN1KenILx4GCQ
         hZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n8TE6VLWWv4zp+ZnErvJoE/L5oOe+Pde/aeeJYIsZf4=;
        b=ODkT92SYHHav5I97uMnhPV9b0TSIHgkJK9QVpYY+NlJv9HFdAk4RKfh0Vo3ED6I+1E
         DWgZpQmfDLhfMQihLKvkc87E1/qVj8CJqybf7f9IgRr2zqq9hS9lp5Rx5P/STmlelMSN
         FlQwggdsJ2ppv1JQqyF65fgqUXZ1feb0Nn4BvyOgQRZxskI/hCPSkCwAB7SAkd6bSpKm
         tBexrIxhkGhClyVFDcx/o50EyVRqVB0FiAjXa7biw5ugSNAge8DOvLdAZ7ew3RyKWULP
         Fb/Z9yvzTgN1HXylyfb9ns7c1TewwVdNrg/77Gb4O/hUAGP8NkQQhnAcbepYUUSJtKrS
         O41w==
X-Gm-Message-State: AOAM530loP39Ok1L9QbuZw6PQir4sOLg7fLljXQWnFB2xlGGp7iu/2L1
        AInnUIAovXJgfEIRqV9RHjYG993lV3HmW8Eh
X-Google-Smtp-Source: ABdhPJyWE83nSB/5cwbEd4BXNUcn6UEVGVrwqQr7OlMpHVeaEJXPYKrKILj5zgwt3f29RpGPROwrke/5Ez6Y2GlM
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:1586:: with SMTP id
 m6mr249436qvw.15.1604531975177; Wed, 04 Nov 2020 15:19:35 -0800 (PST)
Date:   Thu,  5 Nov 2020 00:18:27 +0100
In-Reply-To: <cover.1604531793.git.andreyknvl@google.com>
Message-Id: <6320e83ab93e0ae574426e5ad36ee3e52dcadf35.1604531793.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604531793.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v8 12/43] kasan: don't duplicate config dependencies
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
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

Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
those to KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
---
 lib/Kconfig.kasan | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 8f0742a0f23e..ec59a0e26d09 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -24,6 +24,8 @@ menuconfig KASAN
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	select CONSTRUCTORS
+	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
@@ -46,10 +48,7 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
 
@@ -70,10 +69,7 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.29.1.341.ge80a0c044ae-goog

