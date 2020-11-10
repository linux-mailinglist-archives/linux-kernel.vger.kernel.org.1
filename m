Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB342AE2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgKJWLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732399AbgKJWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:11:36 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD494C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:35 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id j5so8472161qtj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UUYs3/IPjbrn0Fy6AEi8q/1m6cYKglUE4ldVZ9aX59U=;
        b=QydEmdA1Gp7eDtmYL2akJJN4XP/XDdS7K0035eTRBqfwpOiTsI8qckQMz67w5NLOu9
         /2ZH8t1mD1hbruAMJrD/JJb+mmmO87gx+ODjoX5iPANTPnzJveL5vHGbNNSJYp3Ez8Vz
         pMt3WkTfTLW37HVWft91uPgK5UJORgic0Ob9XpK+f/Lw4aErxSlMVWqiQxCbxJI1MJUZ
         i5ooDewzPIra+kCFLauGA//Elk03zfQXErM4ncvUGDnCFCcqTjgh3HOVPc6QXQEaf6vn
         //VO5+/j5fAyJlvVgQ8QCUnmcxWYQuwma0bK5WJJ7hXCMT/9+lGD+kb5wBY0fVW+LGLg
         CyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UUYs3/IPjbrn0Fy6AEi8q/1m6cYKglUE4ldVZ9aX59U=;
        b=LV407tEp/tbo5dRwFZpsBoyNk59qJgMwMPhRbHbo52+R1J+YYz57q/Ywbu17wBFA37
         2Wc5Nt/pgK/QSireZiEEt1HpGcQbVS0vJZxvs6GideRu3zWbGClDLaW++Eh9j649qVX3
         Ty30YX9tpsKrv041MOzqU6uweqhPIYuJXiBq/rlWIlLFM9v081k7JPWMqcYkXGwHihm6
         5WRCIFiwlhoXtuY8ent1XvWfO56Nq1tyiWVlsRjoG7BctzHPd+muveMgKT9rbV4GDRui
         P2KdD16lb2ap1gmyCQsV1d3nsdpNJX0sFmJPUN3/Iqq/7fqiJIEGNljdQhjZCB34xGKD
         lXYQ==
X-Gm-Message-State: AOAM532zswasFyR2ZmPaYLNvh+CA4ZVbHl95oi3a7pShyUB9Da2ZkEio
        bsHQR4ZmDyFUMpPf+ipLFUVNP5f2lXOU00KJ
X-Google-Smtp-Source: ABdhPJxBGmgnkdqlgcqU0fxuPE0cGKNTmRvZZzDmGb5C/wSdyzJI0RXRE/HBsl7sZ1hYsisb1ALC2svdh6jJeS74
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:524b:: with SMTP id
 s11mr16651952qvq.3.1605046294997; Tue, 10 Nov 2020 14:11:34 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:09 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <fc3f94183e4229363d0a891abc791af5b85d20f7.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 12/44] kasan: don't duplicate config dependencies
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
2.29.2.222.g5d2a92d10f8-goog

