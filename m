Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3598B27D5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgI2SgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:36:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37314 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgI2SgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:36:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id z4so6575279wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G75o1vtwJEJqsn4jLLLjWPJ87JkHTslNJiSKbRH/W+U=;
        b=bUj1+avKaSFc1eXz+D+DAri2xiUkIrYaziGBi1iUF0IQdHCiTSENwugzXzzMT1fnit
         pX8f7MnwAs+CHwyfLbkL4ZEfzMjkLouR+QET7yc0nRwwOJfwK4EypIVsfz7fWuV0Dsj7
         bjnFzC7Bx+A3ZwtdStHi55tYuUIyhcOE3LgmNtLjXp+M+VpYEnpgoLiVulLHQA4W/vPz
         h9woMQkHQvdTern8AwUU89dQjDpgSg/FmnX3Ln9nfZJCIRNwm4/jrEHEl/bMpS6iY4Z7
         EuCcwlus399wxFPCVjJ31sISfb6QZC2w0e8ljzt0iDZgYh3Wnwir71gZpfGmVhLjrpdH
         5wcg==
X-Gm-Message-State: AOAM533hnNABMBORZ+7GRuTSteLl3k7D8WViwnsEnmUT9wUokNY3fwRw
        +4oBuptrwrASF23zRKw3J4A=
X-Google-Smtp-Source: ABdhPJyRrT8VZbkuyR+uMlXl+IuwMfrgvg3OVh2K+Av6eKUGJ45KzkGbAM6AJojvO9e0oZN+t9TWiw==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr6203909wrm.210.1601404565480;
        Tue, 29 Sep 2020 11:36:05 -0700 (PDT)
Received: from localhost.localdomain ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id b188sm12151271wmb.2.2020.09.29.11.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:36:04 -0700 (PDT)
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
Subject: [PATCH RFC v2 6/6] mm: Add heap quarantine verbose debugging (not for merge)
Date:   Tue, 29 Sep 2020 21:35:13 +0300
Message-Id: <20200929183513.380760-7-alex.popov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929183513.380760-1-alex.popov@linux.com>
References: <20200929183513.380760-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add verbose debugging for deeper understanding of the heap quarantine
inner workings (this patch is not for merge).

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 mm/kasan/quarantine.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 4ce100605086..98cd6e963755 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -203,6 +203,12 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
 		qlist_move_all(q, &temp);
 
 		raw_spin_lock(&quarantine_lock);
+
+		pr_info("quarantine: PUT %zu to tail batch %d, whole sz %zu, batch sz %lu\n",
+				temp.bytes, quarantine_tail,
+				READ_ONCE(quarantine_size),
+				READ_ONCE(quarantine_batch_size));
+
 		WRITE_ONCE(quarantine_size, quarantine_size + temp.bytes);
 		qlist_move_all(&temp, &global_quarantine[quarantine_tail]);
 		if (global_quarantine[quarantine_tail].bytes >=
@@ -313,7 +319,22 @@ void quarantine_reduce(void)
 			quarantine_head = get_random_int() % QUARANTINE_BATCHES;
 		} while (quarantine_head == quarantine_tail);
 		qlist_move_random(&global_quarantine[quarantine_head], &to_free);
+		pr_info("quarantine: whole sz exceed max by %lu, REDUCE head batch %d by %zu, leave %zu\n",
+				quarantine_size - quarantine_max_size,
+				quarantine_head, to_free.bytes,
+				global_quarantine[quarantine_head].bytes);
 		WRITE_ONCE(quarantine_size, quarantine_size - to_free.bytes);
+
+		if (quarantine_head == 0) {
+			unsigned long i;
+
+			pr_info("quarantine: data level in batches:");
+			for (i = 0; i < QUARANTINE_BATCHES; i++) {
+				pr_info("  %lu - %lu%%\n",
+					i, global_quarantine[i].bytes *
+						100 / quarantine_batch_size);
+			}
+		}
 	}
 #endif
 
-- 
2.26.2

