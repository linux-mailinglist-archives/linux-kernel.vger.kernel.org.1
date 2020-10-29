Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21CA29F505
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgJ2T0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgJ2T0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:26:36 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495F5C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:35 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id s5so2417326qkj.21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LIY2nrONxUEpI3abKUGgXLbsvOzrU8dATPLwmTEHaeU=;
        b=g2qMPTpMRCB7y7a5XBXi8pcG5Be2+QTVfRqwzLSuTHrmpUBkW7++Y8pb8rH7H+iCVv
         dLfu6DcuR6RNfHoxWA5Sn1RyaP+GyVdan7WUnLMbkwlGUfg7Gs6OUiZmTdCEivhv2njN
         1+QnSEWgvkOEip7ngg1ZPHAgOh1hP5xy5MjgmfdAIYGhOmtlamXhXhBfc/tch+vxZndM
         v/yF8ELkJDwQ6heo/HcFSOElOqcmBM1pQ8ezZxxHHOfWPznsjnnW/gSgBEyXtfprnUKL
         Q2Xgdzj/Yw1+oh/c1tJ1jsd/Mz5rAnibs/ry+eZ/nvAD+BHFHe0bHaCoMppMELWqT9QL
         dvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LIY2nrONxUEpI3abKUGgXLbsvOzrU8dATPLwmTEHaeU=;
        b=Qw/LZL9utxFcqPtTk+JxvDQM3k2sUCTiX0P7cOOklsmURbuwfPTCUHqYGwSr4doEUr
         LmhgvUXsHDPesnIQGZD+CsLjEGJyibu9qIA654kCzhY8G6uaXZgvi0UH+wKoaWwBSVfJ
         1LpgAS1AIfvAhGspRyeceIWccFYkyUnUJD6VW6L5qV5sChTmosiCIRrKe00/JmDmuWld
         tthZ9uEqcLH8+5xjgN7GnySFnch/0V/+uchfcnLIZ+UdPDhFcfBKPFi/ItHi6QvKByM1
         RvqpztGSjtFr28XabznpaxNIuZnDTQ8DBXYch64drBldaRxYtJABrVdarD2yU3am+QCm
         z/MQ==
X-Gm-Message-State: AOAM533xvnq7vyhW1lzII/RxyFcPv8SL/bsdlpj6YvMIz8VDMRwdrehA
        l8EWpofMY30tk02BUQYjYHE/MliK6z8Q99rI
X-Google-Smtp-Source: ABdhPJyNhqm8DvHtO9XFSLYqpLFv7mfHIx+BXcx6daOaoJuc9SferdhX1mKQ9T/IX2Odx+h+KtZ8xgiElRhXQW2q
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:b48d:: with SMTP id
 c13mr5755976qve.13.1603999594373; Thu, 29 Oct 2020 12:26:34 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:25:32 +0100
In-Reply-To: <cover.1603999489.git.andreyknvl@google.com>
Message-Id: <d06c8e518e50d119785963b596fafacfdd6846b9.1603999489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1603999489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 11/40] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only generic KASAN mode supports vmalloc, reflect that
in the config.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I1889e5b3bed28cc5d607802fb6ae43ba461c0dc1
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 542a9c18398e..8f0742a0f23e 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -155,7 +155,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.29.1.341.ge80a0c044ae-goog

