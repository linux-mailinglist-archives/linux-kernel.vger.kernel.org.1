Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7132B285B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKMWTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgKMWRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:31 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A23C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:31 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id g3so3988694wmh.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JnUxOJIynAj3uI1y+sO3DfMh7ir+WlJGNb++LFrX210=;
        b=HJ+JRP0S6+eUg+e42XlAvr5+D8XnjnXcbJcnVWKyhHfxILa7L2iAAlvDT5PboLOAMO
         kG1l/8RNcBki2ToFLLjfQpmCzzWJfCzByewGvOnmF8hNskzssMLs1TFn8KOSfIn4q3mY
         pqXygbWN2nTDadrTM0bUhB+aN9dG+MTmUm+b7pongo++WW3H8QKIgfaTwo+TKenrmk2i
         nlD1BSYO4cB+xw7HeTEqdLyArv5S/JBaydVJwVWBSXkRVtHUz7ohI73Tjtfd3g0F9zJF
         3z/jlNDSL/2mC+BvmIrDgfdJWBSgYJ/3wqqvHcsqOpTgdsaUz3YDT58pfYhLOeacbTJ2
         pi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JnUxOJIynAj3uI1y+sO3DfMh7ir+WlJGNb++LFrX210=;
        b=FA1D2mpMH4XkBbr6A9C273PpGhgMw9VkTbEQgLtCoVdcM5X16g4TXr9wvBcK+bGLUN
         sEJ7EEaTyk0mp1mabW2tVS0MOGvxB4cpxLQGA+7Pl4pPA6Ky79SGKy8ItkS64OD2dKc6
         GSCe+aeo7KXmM84vSnWGm5589jUXjOGR4ZLOcKsNZwhv5DMVof+LQD2OX6doGVC3zCaO
         E9agoFbKTlc5w8CRJOYY1Rncle5JEApXzlZBL8gwyKhbgsi/yGgu9xKEk1yBAE/yq59b
         VQpKVa65VTpSSjtRBlJD7Tib2rRNUiDX5UUdpJLDNij2EGcuGD3DlFcv4WcasRtLrziQ
         8f2Q==
X-Gm-Message-State: AOAM530pfWeF030TNDhgOjAhYde4I36khvvJv6B73ps5KLC9rIIDJQ8u
        /OyIGKmX1N0BSztFgq1hJo+xAri/WKCP+NYF
X-Google-Smtp-Source: ABdhPJwDJaLX/cxCmyUXAbVS/RQJ0TrA2KB4sujqSM5M2kIGaUl5fRFE83fHcKShMFNRZpNFvJCZuVmHOB0E6NxM
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:1f05:: with SMTP id
 f5mr4382666wmf.98.1605305850004; Fri, 13 Nov 2020 14:17:30 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:59 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <b167fd21b86e7d728ba3a8e20be4f7e8373bc22c.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 31/42] kasan, mm: untag page address in free_reserved_area
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

From: Vincenzo Frascino <vincenzo.frascino@arm.com>

free_reserved_area() memsets the pages belonging to a given memory area.
As that memory hasn't been allocated via page_alloc, the KASAN tags that
those pages have are 0x00. As the result the memset might result in a tag
mismatch.

Untag the address to avoid spurious faults.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Change-Id: If12b4944383575b8bbd7d971decbd7f04be6748b
---
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 855627e52f81..4a69fef13ac7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7653,6 +7653,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 		 * alias for the memset().
 		 */
 		direct_map_addr = page_address(page);
+		/*
+		 * Perform a kasan-unchecked memset() since this memory
+		 * has not been initialized.
+		 */
+		direct_map_addr = kasan_reset_tag(direct_map_addr);
 		if ((unsigned int)poison <= 0xFF)
 			memset(direct_map_addr, poison, PAGE_SIZE);
 
-- 
2.29.2.299.gdc1121823c-goog

