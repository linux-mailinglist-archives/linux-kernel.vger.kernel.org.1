Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855E62C1645
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgKWUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbgKWUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:02 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D917C061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:01 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id s8so13761265qvr.20
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=X0qNbr9WproLcGX2R7jejC4I91Gg1JCilClxf4uOdQ4=;
        b=X8wfvSUPWDOeubA5laS0MiS+5zHTHlfDCeXD7x++Y29NOmeLLnfbzlFHR4Hb5I2RLu
         9wd7W4DbL8t9WKn3i3FFJCexrLUKyqTUwXXHQ430kj8PdXDFnUpSI4xrd3GsfIU/ptme
         K5x/3lGScHV8LUNjww9qOHEJXgtGUueWlDXazSz1ByCXleTVf1o8CzId6vU/sQOvsLIK
         qdHzXbL8ZjXUmWsfu1sm/1iqAf842e3xeAL6FiYUl8MBbvK82iAc5qTIJtyBLOIjQMpZ
         rODbG8A5iOgyQ40ayjPhbqHoBebQeju5HciYk8AeFACmdvRUt57vrv0DQ7E+Gd4Gj2ZU
         TM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X0qNbr9WproLcGX2R7jejC4I91Gg1JCilClxf4uOdQ4=;
        b=WYwbuv4kKRQ1MO/vw+VZ8C3ErmJEA1xQbghy+baGtv+w+UotqYIQgXFLSP7AY8afuZ
         yxAMCoPFEC3FA8NY81QaokWWgWB6Q5F7NhKec3cdbBKDtCYTGGE1apDlEaZrHh/8NEPS
         sMJyFVm/19OgOl7A+Mw6nOHRFhxFVtPOQqxN53bYr025oHt/MxwZzzZfqZWhi0eqDhcS
         qJPTdoS8cgaR1dvGqkpkzB1BXdx8o0X2ZiWByrTTNJc8JZ739/I2pAjLSOhW9QqRMD/d
         kViv6vEUiXOA+QvscweAHdPrLAhshwwr69tQRq6bZeMWgjXYd9JAOq5NkpDfblS6QASc
         1u6Q==
X-Gm-Message-State: AOAM5313Re/Rc1/cnUKTyz17AcICdxlfiB/oRWontJZRDUjVoMQQxUQt
        ncJ0FoaiIdk3auBNk3FvTlRVi0paTJldK7Uz
X-Google-Smtp-Source: ABdhPJzImvXjbgZa+dqZyuNCYbUOjmgmMgki62vl+7qg8STo88r/i4TsRQg7xr1TST9CH00poNibD1gCn0B4pbPv
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:9a9:: with SMTP id
 du9mr1102774qvb.47.1606162500502; Mon, 23 Nov 2020 12:15:00 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:33 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <b2393e8f1e311a70fc3aaa2196461b6acdee7d21.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 03/19] kasan: introduce set_alloc_info
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

Add set_alloc_info() helper and move kasan_set_track() into it. This will
simplify the code for one of the upcoming changes.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/I0316193cbb4ecc9b87b7c2eee0dd79f8ec908c1a
---
 mm/kasan/common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 8197399b0a1f..0a420f1dbc54 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -327,6 +327,11 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
+static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
+{
+	kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+}
+
 static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 				size_t size, gfp_t flags, bool keep_tag)
 {
@@ -357,7 +362,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 		     KASAN_KMALLOC_REDZONE);
 
 	if (cache->flags & SLAB_KASAN)
-		kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
+		set_alloc_info(cache, (void *)object, flags);
 
 	return set_tag(object, tag);
 }
-- 
2.29.2.454.gaff20da3a2-goog

