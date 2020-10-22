Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21A295FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899774AbgJVNVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899534AbgJVNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:19:41 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA05C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:40 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 31so613255wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zMvzayRKcZjOHIZsW9PV/RuW73K9oxGh1X5zaP2bEOg=;
        b=Jl7LpW955l/dwj9TojILe9Xb+TqqDX/Xo2Z/09O4WWqaxkbtLts1gm1bh/P5/lU/R4
         /ycVct2F2bwDjYPI+eyvKUKV+LEV3NlyfJzuTxqZuRg8CW2mEZqiN+ThOhaggbGMHmO/
         sQJib58QVON48b/5W4KD1EI6ix/er4/oUXHUGbxu4uHV9VaDmgAiS5oCsen24e2vLtjB
         wQwvKboWNK27s1haqBmsswhp7Ve+OrOUAsUGRXyKvH4nqQ9/zui7lslB38o8dYqjHUg8
         rqnoSAKjre5bfzDPuq+b8RQelN16LiZyNKuHA3FSOoXz8aIsol9skZjbmx46l1Qd0EfU
         abQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zMvzayRKcZjOHIZsW9PV/RuW73K9oxGh1X5zaP2bEOg=;
        b=jQ4A9alyWNxOL8FhtpmV1L7oUhOuKnN+e0F/TmR3D0PhyoCl46VUXh+CC2j3ETPaP6
         mMupK99Kr/UxkUMtfh7eUJRTTkxc/VpMB0Svd0svzM8oeX8TOma8t/MjcF3xtQfJiDaj
         etXT+nk4QZJBXAyZ6i6BDpdHnd0/lItQtGtaQxtI0rF5+If2ARYfCIQHV76tskcuGHOR
         rJITQaJe472UkVjgcnKI8t9Nzas8/c3W+W7bDNf/8GORj4zbR97j6aeFH37HAv0pbC06
         n++p6iczqBVqcV5C1x8Q/ixq+lbHFoYc5QZA4KCPYr3V6uCpahljeli1v4ZzXesEenEZ
         6oEg==
X-Gm-Message-State: AOAM532h71DKmuiZazpougCPpHntH9cvoVQIU6QG7QMc+zznSxqKA/Sh
        eStVanLEqYHLz3sAPmbdvH/4/p+yXezjvufV
X-Google-Smtp-Source: ABdhPJy1zF0M4ifiMercLiyrFr+TTZ2TNMz/uq3oy1C9MnNbR57Fur3hTUw7Pnk/ecaOdgtH3sUdKnL7XFwrPF8M
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c7c9:: with SMTP id
 z9mr2640989wmk.91.1603372779361; Thu, 22 Oct 2020 06:19:39 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:18:58 +0200
In-Reply-To: <cover.1603372719.git.andreyknvl@google.com>
Message-Id: <155123c77b1a068089421022c4c5b1ccb75defd8.1603372719.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH RFC v2 06/21] kasan: mark kasan_init_tags as __init
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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

Similarly to kasan_init() mark kasan_init_tags() as __init.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/I8792e22f1ca5a703c5e979969147968a99312558
---
 include/linux/kasan.h | 2 +-
 mm/kasan/hw_tags.c    | 2 +-
 mm/kasan/sw_tags.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 7be9fb9146ac..93d9834b7122 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -185,7 +185,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
 
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 
-void kasan_init_tags(void);
+void __init kasan_init_tags(void);
 
 void *kasan_reset_tag(const void *addr);
 
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 2a38885014e3..0128062320d5 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -15,7 +15,7 @@
 
 #include "kasan.h"
 
-void kasan_init_tags(void)
+void __init kasan_init_tags(void)
 {
 	init_tags(KASAN_TAG_MAX);
 }
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index c10863a45775..bf1422282bb5 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -35,7 +35,7 @@
 
 static DEFINE_PER_CPU(u32, prng_state);
 
-void kasan_init_tags(void)
+void __init kasan_init_tags(void)
 {
 	int cpu;
 
-- 
2.29.0.rc1.297.gfa9743e501-goog

