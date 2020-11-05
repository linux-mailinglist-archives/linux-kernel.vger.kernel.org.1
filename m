Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A1C2A738A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgKEADU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbgKEADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:03:17 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6EC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:03:16 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id u3so36357qvb.19
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Z3EYeS+tIqBFVXo6hPJUkFm8u6eCOLhA7qycqAqlcHg=;
        b=iKpb0OkOxyAj1vbZYd8fEFbo90igQaXc+iJXc+9v0Cnyse6LjyC8e1nDAbQ8npvTyB
         6c0yKUJnxJfUXo6LthJnmi4BtVKlRc9st0yW+p5e437FSeJIy1JNB38//QnbDQi8yvJD
         8poDc5IXP7uVlrIMc6PADLpsNjP4ntVvu4fD/ArtGI0BcsxYTalDT3LKcCaYLS0/tX40
         DF6PcU4VsSj6fVtsORvXz3B/FT4bbLunxCJUqQnKWVUgPSC2J9VcbTnOHmRPGpXy5buS
         1wPU09WC6/4kv6Pr/Z2vNysZ9hOswfuOdo+FZprVcJtIH6brNop3j6rOpq169/0ReoIb
         q8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z3EYeS+tIqBFVXo6hPJUkFm8u6eCOLhA7qycqAqlcHg=;
        b=FHBZ4cNeGP8cS7QpGs6X47/4P6qck9do+V+faOFNCGXLH1mb6lVh8VyQ8H5bKGGib7
         Yw0SHCyoAquJDQHe2NYJEieGJGGcPbxE7CLDslu5tWvUnTg0/0VnTIqj0Fe+dv3vdkZ2
         wSjvxg88wG9wF2bVtKdZogvWvVKTStJUiTt0ZkS0Gzi5/xwoii70Auv9LB7FNd+tTQ0r
         Ptu57+Be0Y8UDViuz8ZNDa3RSNcOVEgbQXPkyYpA7z88mxElL1VUiOHMa04S+qaAcEk0
         rfAzXooOWiZpvAAv+6Ci57n9gHcClTZkTpcTVildYzJMePjKU7JNVHyomOTNS7jG4J0l
         7fyQ==
X-Gm-Message-State: AOAM531wrCU8HGZ+H9K3RsayNveLHhPytWmf3ZPCxLW0XZo4xz95C9Sy
        wbv3R6XPP2TVCWifS0EvGzgZpISpEgGZA85/
X-Google-Smtp-Source: ABdhPJzWMcXzK46NzTRvzzutnp1BqgiDGWeQpHI4uE0DQoI/1yGhlrV8gjgvofQbANK7f7lDyvWyDo2WjxVJIhjI
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f7cb:: with SMTP id
 f11mr315849qvo.34.1604534595295; Wed, 04 Nov 2020 16:03:15 -0800 (PST)
Date:   Thu,  5 Nov 2020 01:02:27 +0100
In-Reply-To: <cover.1604534322.git.andreyknvl@google.com>
Message-Id: <1f2309b6c4aa9554b298e82bd830aca7dc6877c3.1604534322.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604534322.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 17/20] kasan: clarify comment in __kasan_kfree_large
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

Currently it says that the memory gets poisoned by page_alloc code.
Clarify this by mentioning the specific callback that poisons the
memory.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://linux-review.googlesource.com/id/I1334dffb69b87d7986fab88a1a039cc3ea764725
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 40ff3ce07a76..4360292ad7f3 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -436,5 +436,5 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
-	/* The object will be poisoned by page_alloc. */
+	/* The object will be poisoned by kasan_free_pages(). */
 }
-- 
2.29.1.341.ge80a0c044ae-goog

