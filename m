Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4837426AFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgIOVc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgIOVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:16:47 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166BCC061354
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:46 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id d9so1700298wrv.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BdONTOcHhT5ryTedju+DUoHznOnFqEEPqO/13OyviNc=;
        b=X1oFaYJ3ruHAFYTNWhnNVd4ydUZPygtts9K7sLHGb4tL8soibh0M5VHrDRf8er6czC
         S3Bn9yMJmOywdqnJEpdb/8BnHtS6pKui5SvEFZs9pUnNbq5PwhYVkyTXXEQ/d5l88eo+
         IjKYNtfww1UIZzqXqee6/vjaJdvWRoJD69TBXYgKT0WwZgX7TC3GJw+w4FmxT2lg+BLz
         J8Nkv3KOemu1M29hF5q6jkkaBkAGczwP4Fet7xpF+UoTNV4F978v/Vq/F+zUMGsIWY3E
         sdHEwpmqPkFbbulvvEhZssP09nuxFYuRdXW4rz/ERIQGqOpA6OK8rysgnJvDzj8sxUos
         o/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BdONTOcHhT5ryTedju+DUoHznOnFqEEPqO/13OyviNc=;
        b=hAIF9KO4wtYBlkPEF1Myl1KcbjdWL6xK+lvMusFX8gtSmxSu0vmvYp3jsKMM8+h5gn
         avc7DXzRqIGMbyfVFDsE6smXEDTMqpQPl1YVvWgbTDXWX3PII5XpKsFlJQZzhhjvaRZp
         kheMo4ufGJvIXriYNbUJlYU2CGgVgg4VGp8go1csAV2YYz0SxrRwzl6cySVPB08hxQJl
         c60H1GOmgJ8DPfkKRZlOHl/a+3BbBPFikMUrj3eL1Z1fP/re+DuV67KNgxBKjYauOqhS
         mlJ1076ElkWEMOemJoU2BoxHjoAjnJ21nPA+osrslp3iG8774WSf6NK87Mjif6E3EsKY
         8c2Q==
X-Gm-Message-State: AOAM530s+MxuaJPm0y3q+msCv21rL2HIIcXL7/FgApxeSkJ0U9OAAtOs
        jWzFpcFuLSIoE26+lNr3GuOUYbnreOUMVOJz
X-Google-Smtp-Source: ABdhPJyRaB4++4piH+N0WrxzDm3lIXLWNtbPvrqZh7r0LOgztg6BdoQfKl+Xjg2AISEKwNb86A0SmdpEYhDETYjx
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:4709:: with SMTP id
 y9mr23509475wrq.59.1600204604330; Tue, 15 Sep 2020 14:16:44 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:15:51 +0200
In-Reply-To: <cover.1600204505.git.andreyknvl@google.com>
Message-Id: <af8284f93dc3c1a51a2db0d3784bf71bb5f348cd.1600204505.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 09/37] kasan: don't duplicate config dependencies
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
those to KASAN.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
---
 lib/Kconfig.kasan | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index e1d55331b618..b4cf6c519d71 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -24,6 +24,9 @@ menuconfig KASAN
 		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
 	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
+	select SLUB_DEBUG if SLUB
+	select CONSTRUCTORS
+	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
 	  designed to find out-of-bounds accesses and use-after-free bugs.
@@ -46,10 +49,6 @@ choice
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
-	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables generic KASAN mode.
 
@@ -70,10 +69,6 @@ config KASAN_GENERIC
 config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
-	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
-	select SLUB_DEBUG if SLUB
-	select CONSTRUCTORS
-	select STACKDEPOT
 	help
 	  Enables software tag-based KASAN mode.
 
-- 
2.28.0.618.gf4bc123cb7-goog

