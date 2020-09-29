Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF527D5DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgI2Sf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:35:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56216 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgI2Sfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:35:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id d4so5628111wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bxuhq/r6r8osy7pzVzO/JXpG1ASc+MUIPI5gsA7kxI=;
        b=ShXo7s6FrF+lqlmyCH1LeCFXoBs2gXd8lylPKvQeEHlePfju5RUP6bklCxnSallnbg
         LDTAbFtJNUzpNasX+Gb3DE4dGNe+U00kUU+vPH/3eqam95CE7LvXNjp46FXY28wJXTBg
         v30iZb1cSk+yoUXNW/eAgjvSgFsP7BQwtt6/hkgLHSE04tag/Zq9kiO1r4/bved6lQ2n
         LcXTT+oM2LuURSI5KIPLu6UcXhYabuiqfCuhPT6wpvA9nzSkcQVhvpYW1+unqVsS7YwB
         i+SmGZWl9D9uKwhQFM9Aif4Y5GqXXeezArl0vIWzVKKCbJdRqXUYdm3l2cigB6icnJRw
         pupw==
X-Gm-Message-State: AOAM533Uw6ARyJAO5PuDZzOol39o8SxY7tKqWQ80cr99iDBCI7Gggj3O
        axkP5h2ieYE41agPgPelIjE=
X-Google-Smtp-Source: ABdhPJy9A5JEn21mEASXT5hiuePaz0JL4sNUqlLTquEiKyft5GG7jNH5pWMw/hXwHiK/QazBvkyuwg==
X-Received: by 2002:a1c:5685:: with SMTP id k127mr6197810wmb.135.1601404551593;
        Tue, 29 Sep 2020 11:35:51 -0700 (PDT)
Received: from localhost.localdomain ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id b188sm12151271wmb.2.2020.09.29.11.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:35:50 -0700 (PDT)
From:   Alexander Popov <alex.popov@linux.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Cc:     notify@kernel.org
Subject: [PATCH RFC v2 3/6] mm: Integrate SLAB_QUARANTINE with init_on_free
Date:   Tue, 29 Sep 2020 21:35:10 +0300
Message-Id: <20200929183513.380760-4-alex.popov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929183513.380760-1-alex.popov@linux.com>
References: <20200929183513.380760-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having slab quarantine without memory erasing is harmful.
If the quarantined objects are not cleaned and contain data, then:
  1. they will be useful for use-after-free exploitation,
  2. there is no chance to detect use-after-free access.
So we want the quarantined objects to be erased.
Enable init_on_free that cleans objects before placing them into
the quarantine. CONFIG_PAGE_POISONING should be disabled since it
cuts off init_on_free.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 init/Kconfig    |  3 ++-
 mm/page_alloc.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 358c8ce818f4..cd4cee71fd4e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1933,7 +1933,8 @@ config SLAB_FREELIST_HARDENED
 
 config SLAB_QUARANTINE
 	bool "Enable slab freelist quarantine"
-	depends on !KASAN && (SLAB || SLUB)
+	depends on !KASAN && (SLAB || SLUB) && !PAGE_POISONING
+	select INIT_ON_FREE_DEFAULT_ON
 	help
 	  Enable slab freelist quarantine to delay reusing of freed slab
 	  objects. If this feature is enabled, freed objects are stored
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..f67118e88500 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -168,6 +168,27 @@ static int __init early_init_on_alloc(char *buf)
 }
 early_param("init_on_alloc", early_init_on_alloc);
 
+#ifdef CONFIG_SLAB_QUARANTINE
+static int __init early_init_on_free(char *buf)
+{
+	/*
+	 * Having slab quarantine without memory erasing is harmful.
+	 * If the quarantined objects are not cleaned and contain data, then:
+	 *  1. they will be useful for use-after-free exploitation,
+	 *  2. use-after-free access may not be detected.
+	 * So we want the quarantined objects to be erased.
+	 *
+	 * Enable init_on_free that cleans objects before placing them into
+	 * the quarantine. CONFIG_PAGE_POISONING should be disabled since it
+	 * cuts off init_on_free.
+	 */
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_INIT_ON_FREE_DEFAULT_ON));
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_PAGE_POISONING));
+	pr_info("mem auto-init: init_on_free is on for CONFIG_SLAB_QUARANTINE\n");
+
+	return 0;
+}
+#else /* CONFIG_SLAB_QUARANTINE */
 static int __init early_init_on_free(char *buf)
 {
 	int ret;
@@ -184,6 +205,7 @@ static int __init early_init_on_free(char *buf)
 		static_branch_disable(&init_on_free);
 	return ret;
 }
+#endif /* CONFIG_SLAB_QUARANTINE */
 early_param("init_on_free", early_init_on_free);
 
 /*
-- 
2.26.2

