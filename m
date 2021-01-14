Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD42F6B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbhANThY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbhANThU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:37:20 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20AC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:40 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id i4so3053134wrm.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d+lRqXXla6mV/kMKnUzgl/DAB69C3QZUVHCf/SWSD4s=;
        b=HqcwClnACemM2BreGXjbZuHbh6LokgqSKM886rsXhYMs0v4uwRJA/1I64zVxzJOjLN
         0dI01vPBjEImR5HaBOvV2GaFYeK7da2uzLOajZcjbp9ZVjEf0p8KiMcMO5/ag5qv/SLc
         BO+3zoUsJEZsaX8uA3f6J6eut+UmGtFPik3sWGDaCDXar5io/R7Kr1xIP5z+4xEf2JO7
         YlMp1/UwDbbjGlycrk76vLmKAtCFCmCeFejImudBUceZcvxjkCmlTSDov7BYFHDymrwn
         lZisrTqwqpUJ8QgHmAaEG1Vzj9OVqFxk9FbyHYj8ePt8DqewkN3tr49f3NfolSHqvzON
         xDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d+lRqXXla6mV/kMKnUzgl/DAB69C3QZUVHCf/SWSD4s=;
        b=HPAm8/T5lyjJJMA/uCOET8Ixx/WYaI6AXnlMai4rbzy4s/yCxM8d+Oui5C0oQGcEA1
         P/XyCMfQLpalBL2u/QZDB7iK+Vxi4DIpYxlEdbmtRjKqZsD+Ez7fbuLIKbq09vh9UlUR
         bJEKcLodc3IvjwlsQhGPb5Rkor4lek72OxqFVViAN8BjWgyoiNPKy869Ry9OVW4DxZpw
         +7dwtxvaIA2QY27sU1QnUuzrMlSoPb+/1nO98/qq7eK3H9fcwSdU5U0VCYXVQe/uKoO4
         Lmt7nxWSqje71dpkABoew7mKjFrNdbnqtM3XKz4751tVpdup976tWPc34ldEEE+/AaHI
         Q2lw==
X-Gm-Message-State: AOAM532dY2GG6jacEEpqNOz61B4ymdPmm3bsXZY34fJ/rKukNoKOUqso
        zRzVkWAib/FivmuJzNqIZjoV/bUu+2Bgak8U
X-Google-Smtp-Source: ABdhPJzEQ53k5yQWEB0feLLtg91cuk/HNH37rQctEtucW5Gn8rr/RgxVl8rzUbLV1aVSGSQLaLIavCg3VRRcl28l
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a7b:cf3a:: with SMTP id
 m26mr2355477wmg.55.1610652999318; Thu, 14 Jan 2021 11:36:39 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:18 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <2ae5e3db477b08bddfe36a5fc7fb10955cd49f95.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 02/15] kasan: clarify HW_TAGS impact on TBI
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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

