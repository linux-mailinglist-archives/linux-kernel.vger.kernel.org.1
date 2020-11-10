Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F592AE345
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbgKJWVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbgKJWVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:21:12 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CC0C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:11 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id o81so1241526wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MgiGs2FK0RQ4JNcJFnsxjsC4BWa7qeyNid6Uf5IWwBE=;
        b=wL8k50M1AQHx0VbQL3xi2XuIKzEGXDqvuUVrYzcIQ94olxXzgz0KX0q6k1f4qHRqNr
         llatx03+5CGH/foSZCzS8+mbo9AsyH1v/WHAAFQvSGtKVFIsW7M2JVSL/RY77Ni7+UKv
         FEqOLEs61nCxCIKEpESSzhVsL4LPWnOcrnfbp/V6bK7D8N8vSYSVH1Vn1WBuBPKz1Xto
         AJ3cdtZ2Uum98aAUASzeWGCdAOuYczsaP5Ke24OgbosVmgCMZ6eufONNfo/5pI4knmaW
         5ez6cUJOUeYVfi5WRIAL3JvIxyUF+UP4ZCh+C3+BgUUsOc/4Liwv6fER/rLna14Yiuni
         6Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MgiGs2FK0RQ4JNcJFnsxjsC4BWa7qeyNid6Uf5IWwBE=;
        b=UubvAGh325NkrJrLrbqlfD7hW0VA1C/9NWT1sxCwNSXenlcryIew1XQk+C/GwqHXDM
         KEM9k9EE4z6KGtU9au0FQXzgDYJFKVEdnizXGTI1P68EcwCM+giOJcD6QpZqub4r6Hzn
         +x3RvMyBpqU/95TIqBD+3964+/QfG7PTzE6TJZpXKu6Ir20MAX7hwbzT2fKPxAQKN4GA
         HsHfsczIt/piNI/CzJ2x8rwG9oOpJGChwk9Nv8CsxNdEbnVXAToNY8BKSQEeGtHBzaPk
         fduocGNsgad26ImzBbbCZPj5KzkWF30xBZ5dc7uajRujkoMs+SkCbpoJk5f3v6KmIvna
         IPWQ==
X-Gm-Message-State: AOAM532hz6oac6QoqmEmEA0HHnXvDO/OzPl3HFqoxwF8fp+xFIPuxufY
        jm5AV4jX/hfDSvdY05vZe7DPK9IopjxXJoDo
X-Google-Smtp-Source: ABdhPJz8cb5hUXqbVxJ0PZ94Oo4nqDbSIaKQRp5eSLyEzi5Tgzn73vxMVKemqTEYC3dSSCt7/YBWoWzIAj4/5hyP
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:210a:: with SMTP id
 u10mr304573wml.98.1605046870141; Tue, 10 Nov 2020 14:21:10 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:20:21 +0100
In-Reply-To: <cover.1605046662.git.andreyknvl@google.com>
Message-Id: <dd492a97ed68200b1d7e2dce55ed9a7790525396.1605046662.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2 17/20] kasan: clarify comment in __kasan_kfree_large
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
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
2.29.2.222.g5d2a92d10f8-goog

