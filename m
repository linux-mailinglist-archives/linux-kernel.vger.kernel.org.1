Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA812B2859
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKMWTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKMWRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:51 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1685C061A48
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:37 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id x20so6629541qts.19
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TQ3h/P2zSifjnEPKLUt8MfrzzWgegpurLotLIMb03KU=;
        b=OViFLnDTVEAxFsckz/o9boWChDoxestNvKjwTZsSPS7jrseTOgUX9USIFCNOWcVpZS
         r3EYgwV1T7nRg/vvajdNJoxIuOcVL9VyJuHySHsUf7f4ZqH1x6bVJ2F1IMnLBR3NaAxe
         GsqChWDLawz+nIIY2rcxcZ4ZP7Lk/U2IeM8Ft1vjba7gdP6gBK5PwM0c03LUrr+ZPQ4o
         ZUMNugUWF9uQLBq+3yUa+B3x4f6baVj7KNKW6SVrTIvz0G6gNoGt+b9FOgWoeQPSl0/t
         sgOmJIsfyfA4NKuaeIEwAuyUxdxqsFrDivJQnO7l/VxgIRVlgrnF9S0bkEPEbyDQ4SSs
         tIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TQ3h/P2zSifjnEPKLUt8MfrzzWgegpurLotLIMb03KU=;
        b=D25F0w45TYebjadayX5U3HYW1PbDT5N7br61DWylLTS4wQFwXKeq/wjaKbKTA+9xUe
         rn0fvqMb02lZTL451YgiCP4PhSQL61VqDxa0PSzK5fAQK/RixmR7Y4KpC/M914QllZjo
         SlbbVRutWpbjrI5rlhl/A6bNNOqG09Cf5tPc7FgJ+vVrPykDNOXWw0glRH097a2gQtCZ
         5blYyruNSzhiOFFSqQfX0Ld47W95d6HTLm06CLpou7o3M7kYr/BC7/hz0LhOFLn94SWh
         BIe+hoNS1i94nWIdvAvQQOuP3a1YQcbRom6wp3aqpSGbcZ5DNLtxEX1e9tOWpID2PXZS
         dtDw==
X-Gm-Message-State: AOAM531dtCAEMGKNclpNoQ+UGkhiMSdeErIwtUdmwzVc9mt9DqhWlgnu
        MiLVWSdK0alKlT9iM2bpEwESnEfEleSPS41l
X-Google-Smtp-Source: ABdhPJyyzzzWMa5ZfSEgGXq+uNnpkhGRH/ZM85ww0X98O3xAcNqQSmoe4gJo+qIxTd+l67OWdxYkvdchOYXxOEn1
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f254:: with SMTP id
 z20mr4721382qvl.36.1605305856867; Fri, 13 Nov 2020 14:17:36 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:16:02 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <67354d1e68484b547d222b8f0ef402887954be06.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 34/42] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
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
2.29.2.299.gdc1121823c-goog

