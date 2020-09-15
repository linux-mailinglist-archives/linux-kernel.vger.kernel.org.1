Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A8626A64A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgION1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgIONXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:23:43 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39231C061222
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:17 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id p20so1173864wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=A4TgnPIs4KlOFwMVz2jZ7oTmV4CFA6JHdIybpn/o/fA=;
        b=oYmwUA55tcvUaLXjfS/MZrSItzoh7D6nc9NF+TniY3ZoIx24Ls8Q/UZyvcRB/q/Tad
         aCO/x2/UGHmC8tlOnbemPKF8Fz9QA6KXlPgcUFvuoWXJjhdLNUiERkK0AzVZtW4gc78I
         r3yZX58ua7derhVDvSUCiyP7P8dm372cj6OuHlfBrxf4Df7lXMGOHh1g3PSnwuNFTP+Z
         YnQPVErJVrlKvqOcU4kPbDBSx1gNCL07qGR9NTqDwNLaAk/mg2XSaRfIJ/yFwh6geFZD
         Mv189/jYStN4uSdfpvMjRCvsRILDaR83YRXOsHZHQYKtWbsGtVSpJV9evgpFF0v17Dhr
         JUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A4TgnPIs4KlOFwMVz2jZ7oTmV4CFA6JHdIybpn/o/fA=;
        b=iYc4dU2scZ14K/EiWOGsBzN8lvaCUa/9SgbTM+/zhmKViOIlqU16XVHL0tVw1CBimX
         pTQxIkAx6T+mIO8HXzKBJI7ODEQpbNhWjslEtaIaeLDS4DSwGWLprdwubG6XupK1XHnK
         joxpmBB6b+gyRFPZEekXhHYpfCR+mjJPTSHVjV3urr7VhlHSW8YHjv6TS0sAOpAvMDj2
         Xa4XfXjFj6NgL4CNrs/KOYQMa0qOmywwNFFltvAVo/wsgCqG0Akn1sT4VNQ/7p1gwygt
         iinC/owZFWnNeZ8Jtw3QU6xygQ/rSEQWAAi0BUFLVx0fOyq6JwXhVZalx6uqpFsEIRCK
         kmvQ==
X-Gm-Message-State: AOAM532zVE4283Fq+idpyLx1ZF2tS/NPpT/oqpjYLxvxUjOJ/NYdIclx
        T9df3M5RZev9wWFABdAiX+d78jR+Wg==
X-Google-Smtp-Source: ABdhPJwJ9IZxHT97cXa5uoGFBvjbuWBl7DGE0CrhPkVSiotm4bBDWmiGegcVd7G5e99XRLCFU6KLs1co6Q==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:80cd:: with SMTP id b196mr4760527wmd.104.1600176075555;
 Tue, 15 Sep 2020 06:21:15 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:20:43 +0200
In-Reply-To: <20200915132046.3332537-1-elver@google.com>
Message-Id: <20200915132046.3332537-8-elver@google.com>
Mime-Version: 1.0
References: <20200915132046.3332537-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v2 07/10] kfence, kmemleak: make KFENCE compatible with KMEMLEAK
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org, glider@google.com
Cc:     hpa@zytor.com, paulmck@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com,
        rientjes@google.com, dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, mingo@redhat.com, jannh@google.com,
        Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, keescook@chromium.org,
        mark.rutland@arm.com, penberg@kernel.org, peterz@infradead.org,
        cai@lca.pw, tglx@linutronix.de, vbabka@suse.cz, will@kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

Add compatibility with KMEMLEAK, by making KMEMLEAK aware of the KFENCE
memory pool. This allows building debug kernels with both enabled, which
also helped in debugging KFENCE.

Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2:
* Rework using delete_object_part() [suggested by Catalin Marinas].
---
 mm/kmemleak.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 5e252d91eb14..feff16068e8e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -97,6 +97,7 @@
 #include <linux/atomic.h>
 
 #include <linux/kasan.h>
+#include <linux/kfence.h>
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
 
@@ -1948,6 +1949,11 @@ void __init kmemleak_init(void)
 		      KMEMLEAK_GREY, GFP_ATOMIC);
 	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
 		      KMEMLEAK_GREY, GFP_ATOMIC);
+#if defined(CONFIG_KFENCE) && defined(CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL)
+	/* KFENCE objects are located in .bss, which may confuse kmemleak. Skip them. */
+	delete_object_part((unsigned long)__kfence_pool, KFENCE_POOL_SIZE);
+#endif
+
 	/* only register .data..ro_after_init if not within .data */
 	if (&__start_ro_after_init < &_sdata || &__end_ro_after_init > &_edata)
 		create_object((unsigned long)__start_ro_after_init,
-- 
2.28.0.618.gf4bc123cb7-goog

