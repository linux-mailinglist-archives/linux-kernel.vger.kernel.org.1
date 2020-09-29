Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2619027D5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgI2Sfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:35:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53648 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgI2Sfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:35:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id x23so5637822wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MskjPp6ZpujaNwi4yQltgMjSnkxLjmoI3z/cZXeO2Hw=;
        b=luY1GfD1B31Y+NiHMHZ+CiVUnjosmRwAZky2ubvWrZL0KrKpYYawDsNFW4JhE2o724
         e6MbFYFGkKKFAwvmuTDbKMzHfh5yjdSueB1PWNi13dRWFlnhiKbNlemtYjT00CKbnoxk
         JpwG8cH65lU+kPesaZwnqsLV8xZ3lCwZ/vrz6cnCRwu970OTZbKbMwo7uIhtQ6PGJ2/e
         29cEjz2yr8neZGcQgHxoA8yDm6x1A8ggigrZcx9bZnYDXEpqK07tDMKYG+y6lIFvlosi
         duv5DoztVd3k0lBwdL7Qf59ejfSdOERa4VjCzHFuEIOvY7QJ6Z2m27nCR0EQ4bFtPt5R
         9DZQ==
X-Gm-Message-State: AOAM530gPQuo87QMwqNNys07Q/QLBNSkTbB2rg+Ii5EwyJBqm3Yhflf9
        NV1iL1c4xLS5Sn8E7E2+MRw=
X-Google-Smtp-Source: ABdhPJwrwd83g7bnSyKaLf5bfDcLBH7k0W2piOgi8XJXLrVdkpCHESSboWm1QucjXR4ih++3BiFn+w==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr6092766wmj.107.1601404547746;
        Tue, 29 Sep 2020 11:35:47 -0700 (PDT)
Received: from localhost.localdomain ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id b188sm12151271wmb.2.2020.09.29.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:35:47 -0700 (PDT)
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
Subject: [PATCH RFC v2 2/6] mm/slab: Perform init_on_free earlier
Date:   Tue, 29 Sep 2020 21:35:09 +0300
Message-Id: <20200929183513.380760-3-alex.popov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929183513.380760-1-alex.popov@linux.com>
References: <20200929183513.380760-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in CONFIG_SLAB init_on_free happens too late, and heap
objects go to the heap quarantine being dirty. Lets move memory
clearing before calling kasan_slab_free() to fix that.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 mm/slab.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 3160dff6fd76..5140203c5b76 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3414,6 +3414,9 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 					 unsigned long caller)
 {
+	if (unlikely(slab_want_init_on_free(cachep)))
+		memset(objp, 0, cachep->object_size);
+
 	/* Put the object into the quarantine, don't touch it for now. */
 	if (kasan_slab_free(cachep, objp, _RET_IP_))
 		return;
@@ -3432,8 +3435,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
-	if (unlikely(slab_want_init_on_free(cachep)))
-		memset(objp, 0, cachep->object_size);
 	kmemleak_free_recursive(objp, cachep->flags);
 	objp = cache_free_debugcheck(cachep, objp, caller);
 	memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
-- 
2.26.2

