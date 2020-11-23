Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A52C1651
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 21:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbgKWUPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 15:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbgKWUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 15:15:33 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:32 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id n19so320022wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 12:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SLF2Qvc7gBcEHnpk1EaOz5XsuYMk/rWEwWdOy/HR3J8=;
        b=gPxuvkeWbzAL10okCvnV63J6yKq5+nJDEf3KTpJZbFspTv57Fe66PFPktm1spET60q
         yEGt0mvxByroPr8UW1XHzCutUzRXJsgufyPVovhwfXtPDiEbDJ3ESK6fiWenjl6VJ4Bn
         IirhAvXSxowHsx4WAf+eZlDnt97b+hVAgKp+zd0ZIl9HcAiBAo05ye8vRfvtk1GV3JGN
         b4QWlJnRe6K1ElxT1mvUrNUmLjvjl09A2f0Nbldpda1qdIfcjYvQA1j1TVKHIlXFrlyW
         ettj4xS8+Zhq139aDT9rcGaB1iY/WgEABjb9kPtV5u9O9nMMri6xNgVguCVhD+eax7uL
         xxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SLF2Qvc7gBcEHnpk1EaOz5XsuYMk/rWEwWdOy/HR3J8=;
        b=q8GyCdHRwbrYyAmk2HcbmjJ11gShCHDr9ugdpYGn9ZJiVvGDcbQHtnb7lKaCgwepu4
         mjsAcKLIH7Is0bqy8x2LhjEvTtMt0S0aox4dh6fpV6aRvJjJ06Al/DozvSLnB3jj3NkZ
         msVmjuhJ65TZc6MszQgHaSl5iD1NtAv52XmHYQdHeJl8N4FYa3KUEvxvrcVBekTj6zAg
         W5t9btU68n3cM2o40pchnuHTdB9vzThC4EfuOo/gfTOtsuMe7NT9ZagMPNJhLnfjRRaA
         nodXeJPaaWKR84rwLS+MnsY8eEGX8mh6jsMocGQYcQAk5vt/gLoWh7UT/a1fBei31oNM
         vFFw==
X-Gm-Message-State: AOAM532Bv0zavyg1dJQBGEtHei44axMsw0EUgZOjNbV263nKYWeysLY7
        x72fe3SfJvHZfMSBcwxmIZxPs2v8p+SVH6Ft
X-Google-Smtp-Source: ABdhPJzCMxIzE1RMShDMDCcSDUVJ4JkQIYpCzwGXhmF3084iS9J11LT0NWXFlyiI8uA5UJueQ+y3msS6pvgNj8vl
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:c00b:: with SMTP id
 c11mr587868wmb.175.1606162531510; Mon, 23 Nov 2020 12:15:31 -0800 (PST)
Date:   Mon, 23 Nov 2020 21:14:46 +0100
In-Reply-To: <cover.1606162397.git.andreyknvl@google.com>
Message-Id: <1c8380fe0332a3bcc720fe29f1e0bef2e2974416.1606162397.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1606162397.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH mm v4 16/19] kasan: clarify comment in __kasan_kfree_large
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
2.29.2.454.gaff20da3a2-goog

