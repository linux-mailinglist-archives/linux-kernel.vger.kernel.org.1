Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69B5280B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgJAXLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbgJAXLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:02 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA1DC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:01 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 7so74412qtp.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=w1E5zxU5l/CeX9umqlaBwf6hqmnsI5Vdz5NunkaUR1o=;
        b=VZjFuEKcSRZM8aMyx9Es0pIHwZ7u9Z8UvL0Td/wiYqk4Xm5ihXXs0ETcfSmZ5f61za
         NNm6+0v3Jc68lZ5FCen3zO+lAzcKWLX+Sg6dLqFCGCRSle1z48el8hbqqTtcaiYRfBpc
         uQ8MkNUFTI/WyDHBgTEzQm2a8+GNabM1EuSiirl1uGyXR6Npd3iN6LBp3ISJq5lNu05b
         MGx+JUUI+fymSF5gx/YdoFj8ZlUa9d/s7KwFTBAJ61qs5ndE/fGFuxLWRwxLEOR81xiy
         wzJfG4SgsTHTSKLPfn0lT/F55UZoVu4a91WLUaWFNfWNfl/D6fPBTtJPndlbZJtFC5vD
         T1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w1E5zxU5l/CeX9umqlaBwf6hqmnsI5Vdz5NunkaUR1o=;
        b=aLgI7UpOUXyHJYHhaV51Q+LaB2s9fAeM917aeHl1ZlFPr+O66M1b4jfYyz5IBWXAHU
         u0NbTDlGzi/iPXiv74C6BE8e19FFshpkbT1cxrcOxy20uo0cnWBZP618+UtqyGhjVq9n
         rPsWJFhwPhfY/VBSko5dCVqzAYY5r1jtT/s3IE6FmKkefPtizmj87LxnQ7KAt4ChWnNa
         nPdC4qqKydi1sZvAzxp2JGQ7c61ev1npD5TttBVw18X9EeVLcb2gEXptSYyBlwlQv1RA
         RYKiZZ8CKiV3DcprgOfoAoH6LFEYudFIS2HeQ5ABK4a9/KX13eb0HC2JLy8w0F1V0eV1
         32hw==
X-Gm-Message-State: AOAM5327Q/Rtbt7gNH+IhFEex/HsBjhFhT1+r0FYJls9M899MCZ2a6LD
        aZKTn+259Ref6WZTAlPtGbXgo4CXhMU8Qxq1
X-Google-Smtp-Source: ABdhPJzib8K4bOGf+SA2POXQO9GcIg9cSuLI7uelLspVqYmRzlqSefwDS/1lsaPsks8q/GUPSRmUJhRE5vDrp89T
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:abc5:: with SMTP id
 k5mr10210842qvb.40.1601593860931; Thu, 01 Oct 2020 16:11:00 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:08 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <d00def4a099b54e7aa68f4bd2068a3d99607f787.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 07/39] kasan: only build init.c for software modes
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

This is a preparatory commit for the upcoming addition of a new hardware
tag-based (MTE-based) KASAN mode.

The new mode won't be using shadow memory, so only build init.c that
contains shadow initialization code for software modes.

No functional changes for software modes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I8d68c47345afc1dbedadde738f34a874dcae5080
---
 mm/kasan/Makefile | 6 +++---
 mm/kasan/init.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 370d970e5ab5..7cf685bb51bd 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -29,6 +29,6 @@ CFLAGS_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags.o := $(CC_FLAGS_KASAN_RUNTIME)
 CFLAGS_tags_report.o := $(CC_FLAGS_KASAN_RUNTIME)
 
-obj-$(CONFIG_KASAN) := common.o init.o report.o
-obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
-obj-$(CONFIG_KASAN_SW_TAGS) += tags.o tags_report.o
+obj-$(CONFIG_KASAN) := common.o report.o
+obj-$(CONFIG_KASAN_GENERIC) += init.o generic.o generic_report.o quarantine.o
+obj-$(CONFIG_KASAN_SW_TAGS) += init.o tags.o tags_report.o
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index dfddd6c39fe6..1a71eaa8c5f9 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This file contains some kasan initialization code.
+ * This file contains KASAN shadow initialization code.
  *
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
-- 
2.28.0.709.gb0816b6eb0-goog

