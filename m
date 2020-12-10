Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0751B2D6540
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393160AbgLJSic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:38:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46482 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393096AbgLJSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:38:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so6509280wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qevJfY7dsLkmoNjN5cKll/uAr7AEc1whLJC/57i9ulU=;
        b=FysU7itUIBZUXyTSR0h8fgcv8yILKT5bo4xLK5xhlp8+3zN4c1501zmbroWbBe+bKF
         nUizeznaBt3FUkv7NtRR+GTghcocwSw0LejLe2wGfM9cLKes/qsEDWMfIy6pGaEb/MV/
         uVpwVvCqtvNzWTpJcZfxKWvmTCimd6A5M0jxwymE9zwxdJtqmIVDsP8E349NJm7t4SK4
         qow3aMl4zifb2NEj1Z8+iJCJ2VxsRUauY+7w8NuhqS3IPs/6asP2HYbH4nYRjxmUopOP
         m2sk4gRuJoAh+lsi5vqxU0mhQ7OJe3/ctvtzfNH72G6SP6qtfDLFzeXvwjxOwyOepJG0
         Azkg==
X-Gm-Message-State: AOAM532/nu4lRmUMiFAxCBuOkfXD8eMmsBZCarIjiRJlgp5j1wvaXtEl
        kxamntektQ07XkZX39aTFFI=
X-Google-Smtp-Source: ABdhPJxLzWse7Ykv1E/1SYot6r/6FwAHVz/IyRlUCr67SQMp43PAveKBidrqjrvsOUsVSGQ+8YocaA==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr9905265wrt.246.1607625463189;
        Thu, 10 Dec 2020 10:37:43 -0800 (PST)
Received: from localhost.localdomain ([185.248.161.177])
        by smtp.gmail.com with ESMTPSA id z21sm10216699wmk.20.2020.12.10.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:37:40 -0800 (PST)
From:   Alexander Popov <alex.popov@linux.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>
Cc:     notify@kernel.org
Subject: [PATCH] mm/slab: Perform init_on_free earlier
Date:   Thu, 10 Dec 2020 21:37:29 +0300
Message-Id: <20201210183729.1261524-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in CONFIG_SLAB init_on_free happens too late, and heap
objects go to the heap quarantine not being erased.

Lets move init_on_free clearing before calling kasan_slab_free().
In that case heap quarantine will store erased objects, similarly
to CONFIG_SLUB=y behavior.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
 mm/slab.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index b1113561b98b..344a101e37e0 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3416,6 +3416,9 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 static __always_inline void __cache_free(struct kmem_cache *cachep, void *objp,
 					 unsigned long caller)
 {
+	if (unlikely(slab_want_init_on_free(cachep)))
+		memset(objp, 0, cachep->object_size);
+
 	/* Put the object into the quarantine, don't touch it for now. */
 	if (kasan_slab_free(cachep, objp, _RET_IP_))
 		return;
@@ -3434,8 +3437,6 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
 	struct array_cache *ac = cpu_cache_get(cachep);
 
 	check_irq_off();
-	if (unlikely(slab_want_init_on_free(cachep)))
-		memset(objp, 0, cachep->object_size);
 	kmemleak_free_recursive(objp, cachep->flags);
 	objp = cache_free_debugcheck(cachep, objp, caller);
 	memcg_slab_free_hook(cachep, &objp, 1);
-- 
2.26.2

