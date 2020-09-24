Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1A277BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 00:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgIXWwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 18:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIXWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 18:52:11 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F8C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:11 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b54so494174qtk.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sJr1Ezt1QTZM7xCujMwarLHpec0t/6/LWXnFkCD3rjo=;
        b=jivKxzVoAqHEDzrLm2QWD+GaZd20HIIDkT7YFuurx42lKizh/iMLEE23jRxB12jFID
         We5xivpAwjCnlv5xomqCSC7/eMfSdN3LieY8CJ0UGPwAfpPIf9YGF/ZpmgYbhtW7QrIy
         XO76Kw+2clcdws74esaGni5Uh1pzlxSRZWVusu9klcWgw5WTjswUK2scaohBiL0DQyDc
         qLEK8nXlcGxr+LF50wVKg4kVk6yjFf3fzdFJBmYlBAimYPpFPOTUA/tN+5P+gD/isLJr
         PLcA7eax7VE/GvkZfOOLZYOO3jRN3xtQVIqbXNOeXmE9STyBuywMrU9YgkYSR9xR9NsT
         fkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sJr1Ezt1QTZM7xCujMwarLHpec0t/6/LWXnFkCD3rjo=;
        b=NZ9uaSc4zpVIqSImOWdfcsxvCZ+jsPzFKNdchURQjnrmghJDMf3AjxApPtcMhB6Ozb
         eK580hEQ+pGhTNkOEHU+TPCKrOcrQ9oSqR0lN6/UYo85EAyrvQj7xKe8swWU/6O13P4j
         Ofbhzj+HPm/2TpcCfUvANARwB415ICCX/cv0glfA96A6h3nB1j70olFAEqVGX55eSsFb
         eoFWPOYdHK0LIgCbL3UPJHe/IPYuplodJmR3LP7eQjN6ZOxuuJSm8c+PU9R1/b8+l+OM
         QeoyESO06QwS6mDdbtEi6p2nL6Ps/Clz/6s0G9vzNADDgcy5/x/4xpqMwKP8+pv8c2kE
         /INA==
X-Gm-Message-State: AOAM533Yq2oRxbwPkIaH0zjMN5i6ZXCwUBCO6d+nkGgDBRNFtkzJqALJ
        lQUo/UpaUR0undrRLhHzWP2/89oQ6HZuHSuS
X-Google-Smtp-Source: ABdhPJyj/wxjt8fJOh/sNJijCsRPMcQiNlo82eRx5FuCsllihp9L7x7AZbmZRFE367ZIrj/iiDtX0ik/AhqH/Lsa
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f6c4:: with SMTP id
 d4mr1575582qvo.41.1600987930210; Thu, 24 Sep 2020 15:52:10 -0700 (PDT)
Date:   Fri, 25 Sep 2020 00:50:39 +0200
In-Reply-To: <cover.1600987622.git.andreyknvl@google.com>
Message-Id: <08b7f7fe6b20f6477fa2a447a931b3bbb1ad3121.1600987622.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1600987622.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 32/39] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
---
 mm/kasan/kasan.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 9c73f324e3ce..bd51ab72c002 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -5,7 +5,13 @@
 #include <linux/kasan.h>
 #include <linux/stackdepot.h>
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
+#else
+#include <asm/mte-kasan.h>
+#define KASAN_GRANULE_SIZE	(MTE_GRANULE_SIZE)
+#endif
+
 #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
 #define KASAN_GRANULE_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
 
-- 
2.28.0.681.g6f77f65b4e-goog

