Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4354B2F4FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbhAMQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbhAMQWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:22:32 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9282C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:21:51 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id eb4so1810717qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d+lRqXXla6mV/kMKnUzgl/DAB69C3QZUVHCf/SWSD4s=;
        b=YKY7gx5S6rvhB3FKwi5kA+KeiyuThowa1q3Pn6R9kn/8K5UVSFWKkUei5Bei4weIpg
         RoiZvLY4Zj4MoFYzYwTRxxZqdiXikRu8P8KMuCf/AGwywlpkWHU9YJEq/IdT2bbqV6t3
         FIXMAgHT47R0nIuRdCUuu9t2/bh2UMO69MQDf82Mn4oGPwT99lhCRgqxbcs/ZWec+ET7
         /f70R4/NCq7napCaOHyjk2i6Dcippqp62D27rt9enK2JurYXvB7YXDvumFCQDL3jBmsC
         D93zbdu+CZr9RnZVi2CkFR7GZm3U0xAxJGYSU2gcprRXw8ADgy6IhK74Ae/z0Epr8jAT
         vUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d+lRqXXla6mV/kMKnUzgl/DAB69C3QZUVHCf/SWSD4s=;
        b=WMa8Go5XPWQ073fxwoZ1GDwtAOhgBzPD3EAUmBzUalNouHA4VywvX9yMvFGrQje1dW
         BCA8NiDEbzWRidCFtjUa1eGYv2/NM/gfyRFzgdFun6yCcB8FLvnaBuUAw5idmJrgK8Q1
         2FpR8mpMbZiPFZR/6lCDeBly8KbNt0/BZDnGIImYvLaO8fvPjJvA6yWwgDQ7D4geB9vL
         JYbtH5U4fDIdjwpgznRh9KliXvK+R7jy+40crjp7oMYZbruOJLnVpkZmwHp+sUbvQtAw
         omQohZuEtnN/OW95eD8Qu9UZZna4ghiaGywXOXJoyUaoXaQ481DxbEpydsh/X7p4CwhX
         gdsw==
X-Gm-Message-State: AOAM532Y0ZdQWX+csOOjArqV9UG81WJAQUJB+JIIiNzynkT6JJWtmt/B
        87D0Bh0XxYfRy6QGQlBBPj9vl5yGMBVuehRn
X-Google-Smtp-Source: ABdhPJx8+Oe7Mabnt4SPnvm3MnNRhLLp0Srowiy6PiObbMS1CIb56O1EYntDqekZUTCBtg9FLXBUbZu+17f2DcQW
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:ad4:4870:: with SMTP id
 u16mr3018876qvy.44.1610554910673; Wed, 13 Jan 2021 08:21:50 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:29 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <1d82c593424e75ce15554a77e64794a75f8ed0c9.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 02/14] kasan: clarify HW_TAGS impact on TBI
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

Mention in the documentation that enabling CONFIG_KASAN_HW_TAGS
always results in in-kernel TBI (Top Byte Ignore) being enabled.

Also do a few minor documentation cleanups.

Link: https://linux-review.googlesource.com/id/Iba2a6697e3c6304cb53f89ec61dedc77fa29e3ae
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 0fc3fb1860c4..26c99852a852 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -147,15 +147,14 @@ negative values to distinguish between different kinds of inaccessible memory
 like redzones or freed memory (see mm/kasan/kasan.h).
 
 In the report above the arrows point to the shadow byte 03, which means that
-the accessed address is partially accessible.
-
-For tag-based KASAN this last report section shows the memory tags around the
-accessed address (see `Implementation details`_ section).
+the accessed address is partially accessible. For tag-based KASAN modes this
+last report section shows the memory tags around the accessed address
+(see the `Implementation details`_ section).
 
 Boot parameters
 ~~~~~~~~~~~~~~~
 
-Hardware tag-based KASAN mode (see the section about different mode below) is
+Hardware tag-based KASAN mode (see the section about various modes below) is
 intended for use in production as a security mitigation. Therefore it supports
 boot parameters that allow to disable KASAN competely or otherwise control
 particular KASAN features.
@@ -305,6 +304,13 @@ reserved to tag freed memory regions.
 Hardware tag-based KASAN currently only supports tagging of
 kmem_cache_alloc/kmalloc and page_alloc memory.
 
+If the hardware doesn't support MTE (pre ARMv8.5), hardware tag-based KASAN
+won't be enabled. In this case all boot parameters are ignored.
+
+Note, that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
+enabled. Even when kasan.mode=off is provided, or when the hardware doesn't
+support MTE (but supports TBI).
+
 What memory accesses are sanitised by KASAN?
 --------------------------------------------
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

