Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42222B2871
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKMWVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgKMWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:20:56 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA0C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:54 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id t11so7019451qvp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yi0H/DT0iolgmo7NG/qMiO64up+Qc265jwkA+xu3tVM=;
        b=JaBlZxu7lA5jybjquVXOefu6xeeFogoBoXU1MliVu8hO4i5YwE0yAHxz10jpwLhOUG
         QZIoujH6ck0jbRoIZBq4jaoY1p7aSmkbWN63j+ihIJcWjrgLqYFrcHgb8SaxZ9IpWSsG
         VOoGkItovexEkREiFcSvUf6iTwO1D2zvHAHwp3Tn21E/jemeZR9ein17hD8X3olghKqF
         hV9KNqoNkDz0dNidKD/eBsaEhqtf0c7RYIgON5+4XvohOM1GeltX35tQ5aOnIAzpDebT
         Ly75REWb81h6l041aTpotOhJ5bbwNpW7TLTJdhFtMH+9I3OoDEcW4pgjVVfxTFyFlDin
         Raxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yi0H/DT0iolgmo7NG/qMiO64up+Qc265jwkA+xu3tVM=;
        b=IJbqLxEkP5TbhxJBCL8m594J+QvAkBcGYwJbSGS2WF6ULFzYSlGcfDFDmf3WFjC6Z8
         zVQqvwuAeg8niOpsHokFYw3+YfLgk57hoCQ3s6YWQV6q3w8UFDQ2gF4XS8untaWAoZlq
         JNQotiuF/SkJPNI2Wgy1JjlwgH9iqE4s9xLwhvW6TrV1eUVs1RheekruJNnGL7z2ZN2Q
         j7cKfr1kI0XV9XVkr0WtfO7GeLPr8OrYajfOd26rVyWZaxAMziExm0bU5RSAvAKK/TB8
         zIG4PtBBV3LC74r6Mwt02FWL3qWN3Gc5kbevz3TD3q3jYACB9/uhYnQuTy3KWK37qc3a
         d5sQ==
X-Gm-Message-State: AOAM533w4G5Hy5wEw5sGUM3pTDv3xaJSLqX+JF3JKQTCzdC+CSneYPly
        lKvQdKmezWhpXmVcOe/zMo6vh9IrYDTFIlph
X-Google-Smtp-Source: ABdhPJy0Q043vk8cHOStNvQydNlkW0VoeWxy1kyCkq36QgHv0e9VO0VOgQiCfIHAjZb++EoHTDq0EEdvZhMlArtL
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:fdcb:: with SMTP id
 g11mr4476840qvs.58.1605306053723; Fri, 13 Nov 2020 14:20:53 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:20:06 +0100
In-Reply-To: <cover.1605305978.git.andreyknvl@google.com>
Message-Id: <ef974bf9a5cbab8fbf5d8fdf7c4468b04659d980.1605305978.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v3 16/19] kasan: clarify comment in __kasan_kfree_large
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

Currently it says that the memory gets poisoned by page_alloc code.
Clarify this by mentioning the specific callback that poisons the
memory.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Link: https://linux-review.googlesource.com/id/I1334dffb69b87d7986fab88a1a039cc3ea764725
---
 mm/kasan/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 821678a58ac6..42ba64fce8a3 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -453,5 +453,5 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr)))
 		kasan_report_invalid_free(ptr, ip);
-	/* The object will be poisoned by page_alloc. */
+	/* The object will be poisoned by kasan_free_pages(). */
 }
-- 
2.29.2.299.gdc1121823c-goog

