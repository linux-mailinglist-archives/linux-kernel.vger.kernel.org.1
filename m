Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9B244DDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 19:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgHNR2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgHNR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:28:02 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880FC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i4so6527547qvv.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l6ZIwvY6syyAP67b2MO5JHAbeJPBE9lyCC+sGAziw0Y=;
        b=a+6DNaeGtiK8RCbbEJSYLo+X1UMhNxWoSfsXBd3ip7DAyvTiyPTnoLrmeGVgbLvsLx
         CfpZKFFIvUuTxkBYDZDQn4jbGgswxQdQkBs5VxOgEcg5+iRb7bqLWyASx3w3iF6+2dk1
         pbgqCiTuFstwf5I6mi0DpUvGIbwg/XLzQm17VEOz7spf7VI+6MEL2AH29BoM7qpqlkUb
         9ce6X7/d2RmXIOEQQ9dwmguTJZxg6DC/de53tpFF7HdIloSioMjjzjIprIayyVndKKl+
         Dft04zNWux8SRfTG5d0zwMQLGVh2OUWV29lifG2KiF2tIJZ3GI3MbAiHjiMNSGd827mX
         +UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l6ZIwvY6syyAP67b2MO5JHAbeJPBE9lyCC+sGAziw0Y=;
        b=ThNI7UzaKiFWRvq/ytL/xoWs6Mu1Fkn7gyi8PJWClcHKNZ5M6OkFQsVWOsUIoa2Er7
         BFvIBooNXrUvZtxbfWGQhxpAasHKPmbzOc43eAsH9ZoWWdMhjom81JkEQxgILWnHQa3N
         kuroCX98BSVtIY42zgqewZiYgORL12vT3nV/rkmE3YdTKBBgmi6ZxPutnhL4hj75YPup
         EGko5GapHm3xQx6P9P/RacEyL0brRCHGkHCZ6XVad+DOVIsDJtep7CS45LFJhkh5VmSv
         l2Hj0CzF5urxn0IF+ucCA26TxUaZKjA5VzK55x7Ze42PPJkDLQXzvgZ0O5kNXngHGCTA
         7Nag==
X-Gm-Message-State: AOAM531Zxoh3AtwDJm7TbDH4Ewl8ALGAhqjfmVC1dLKvQyDV86CBEVz5
        zZJiZVsJxKnCR5Qfgi4N0EomPUtEZAduAudK
X-Google-Smtp-Source: ABdhPJy3uOE8d50CkEhPANU8s2DSDIvcOJG7lmvrwT9uA8T2s4Kv8enADBz7gFdwS2uXrMPjd1s0rvPxNPa2NPmj
X-Received: by 2002:a05:6214:1841:: with SMTP id d1mr3456365qvy.135.1597426081697;
 Fri, 14 Aug 2020 10:28:01 -0700 (PDT)
Date:   Fri, 14 Aug 2020 19:26:58 +0200
In-Reply-To: <cover.1597425745.git.andreyknvl@google.com>
Message-Id: <e0683edc00699fcc0fc1fbc3cb1320875ff434f2.1597425745.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH 16/35] kasan: kasan_non_canonical_hook only for software modes
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

kasan_non_canonical_hook() is only applicable to KASAN modes that use
shadow memory, and won't be needed for hardware tag-based KASAN.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8ad1ced1607d..2cce7c9beea3 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -376,7 +376,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
-#ifdef CONFIG_KASAN_INLINE
+#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
+	defined(CONFIG_KASAN_INLINE)
 /*
  * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
-- 
2.28.0.220.ged08abb693-goog

