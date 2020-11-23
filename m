Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57E52C15F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbgKWUJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgKWUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:09:49 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:48 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id b12so1335516wru.15
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gEnDsD+N69lIXG3Ma+biKqxogEfpaBdkZlhoQUvyVBc=;
        b=FfWNnS6DgP7aoSkRvg3HeByQaSuDigoEyB8i2MUSZPS83BNAnfQl+QDxbBoeIDw2Zz
         lEJsVW3NR8061h7oS71deZYKO+i6jkdR7FmyaU9S6qYasJqCcaRrKGZX5IHSsFGwQrVn
         jE0ZUFb3ZJFyEqQvpFR66i/Gk0GQm/86LYNy3MjVTHrCYtCQxp+6c19nGjV+lyHp/otk
         1KfcVpxv8JmvBBUCuimojZ5ltow/aDbCCrVGcoFPuCb+DE8F8sp71QozB/A7Q/f/e8/h
         ibjeDB0aU3qVOlaDoFUt3NUcn8A+vDFK/n/eY08TwQdt67SESvF/YY1dinvgJa9VO3zX
         VlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gEnDsD+N69lIXG3Ma+biKqxogEfpaBdkZlhoQUvyVBc=;
        b=ottjxtSdQ94uNkd7prnyWt5rqoRQhd8rbKqqaIXk5UcWP23ylkirqnqg09oz2RxX+e
         bIPxhZx6UxfeKOLzRQe3Bi1EBXHo97AZsUxBDT/vZTFpiW7yjFvedTBqmq/nnBPbEEmG
         9QjoEMEFQVGZuQxscekKzi34bkZdTr8S3UI3mXOIiJk2F+g+zc5zwkBJKZU2rpMfsglJ
         AAkpnzQQMd56UIgqDhU3PI4ov+5MWACwgtF2JqUoPP1mElPSjTXazUB1Juw6kl4za+9g
         0Nalu0TcOMUBKIF9hyc1uaWjIcHfIxD5ADXlrw71KabmrPBceT/9HR6E+m+DOjcyXr6P
         nj6w==
X-Gm-Message-State: AOAM531hIUtCGw0JxA9PBwDbiK72DLzB47Id+OHgOTkpqqp+lg+pyijd
        irb7sPFg2bb/CnpxzHYKSus7UgqkkLCtd+v2
X-Google-Smtp-Source: ABdhPJxuTyKGJpJ9R13tryozNvCIfSMHFYGMbWGDD7E7GAT3bPdC8BzbC8PwCKdMykkLVk97+KSIe7Ogp0sZD3jA
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:398a:: with SMTP id
 g132mr585815wma.51.1606162187602; Mon, 23 Nov 2020 12:09:47 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:07:58 +0100
In-Reply-To: <cover.1606161801.git.andreyknvl@google.com>
Message-Id: <3d15794b3d1b27447fd7fdf862c073192ba657bd.1606161801.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606161801.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v11 34/42] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
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

Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
---
 mm/kasan/kasan.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index bc4f28156157..92cb2c16e314 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,7 +5,13 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#include <asm/mte-kasan.h>
+#define KASAN_GRANULE_SIZE	MTE_GRANULE_SIZE
+#endif
+
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 
 #define KASAN_MEMORY_PER_SHADOW_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
-- 
2.29.2.454.gaff20da3a2-goog

