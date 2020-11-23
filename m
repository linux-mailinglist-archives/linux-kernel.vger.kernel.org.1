Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A011D2C15C6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKWUI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgKWUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:27 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807DC061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:25 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id y21so99160wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XfXa1jt+0lTuh6OgRbLfYhhuoSJQhOjqmzv/mbzZDEM=;
        b=tNrLX9o0lFHI6YWmxVuoOlxK7USSwhxsGK9bGXKo9Q/Ey0C48ZL6MTwIPXc2XXj9ir
         RaGv3fnIPrVR7PhO+cvCNTTZblxnQKFdm/+XhHV18otbUWNwrXpQbMrfnPHE5IlMj2J9
         KgoGMxjlxuHbAK3QnGUxRZ8XF67Xp9YJLhIOIXcqDjkGtEKzubh80QyY6mNOMhXGWQ8x
         Bfl7CSzZc2gkbGlMhoikl1gcAeVTqaD91IqXctkdDssT7C6i2wfDElh/1itCFS+YdEpw
         UWxa8LpZeXLKLlCdwB7ydHzYuJt0VWv26483bHnMJ7c9jayQ4WSScWqVPcohcI9QoJgg
         krsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XfXa1jt+0lTuh6OgRbLfYhhuoSJQhOjqmzv/mbzZDEM=;
        b=QlJFMK79irIYIdEKmWPvYlFzIUZ/kdZ4e8RQXzPrlCfens/BRWLqC0aBy/GZGLIIUy
         QqZg0Pj6kYx8BMkG11x2dN5YawGwwfUkqsaX6wmZoXIxjbJNe+bpVxCrVLI4tm2aLY8V
         Z+6SOvJ3102JYWWynNfYJY+IcqwgVCvejY+GaUdtdVcmSAOjTJVreH88A6ZS3DHvh4Z7
         iFk0apuH5dVDMNfcY0bjtSG1MHssh9YD0cqm08qv0oCm7mvf1yPCf8O7I49+6/wj/FyB
         gGtxFkZaAas/EkiydfMuPCpWImMI5sJbqxFDliA/aSGPIxyz1NnK/1dx5MSY9ql7w+gR
         oGnA==
X-Gm-Message-State: AOAM532jq9Bswp/MBTn25gkLc+r13Uu8nGTortwmCnqgv6HW26sA3GvI
        /M9Dsy8E+khu2SXaQgHIEiY3911bTnYjGhIS
X-Google-Smtp-Source: ABdhPJyipEp52As5ABW7qjej49j6iqncktvo99eer3o5hWFS2jWRYIYJpdVzUNciy1GEwE5a7M10sdyRdgGbAsHK
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6000:10cd:: with SMTP id
 b13mr1469712wrx.220.1606162104203; Mon, 23 Nov 2020 12:08:24 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:26 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <0c493d3a065ad95b04313d00244e884a7e2498ff.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 02/42] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
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

Currently only generic KASAN mode supports vmalloc, reflect that
in the config.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I1889e5b3bed28cc5d607802fb6ae43ba461c0dc1
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 8fb097057fec..58dd3b86ef84 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -146,7 +146,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.29.2.454.gaff20da3a2-goog

