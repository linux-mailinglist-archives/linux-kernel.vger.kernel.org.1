Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054D62AE2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbgKJWNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731907AbgKJWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:12:07 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3A3C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:05 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id e9so22080ejb.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Pg6PJaVDUkAITFjkMU6ng0d8HxlghasMrqy2nxiQARg=;
        b=N+EE4tAaZWyBdZ5DiXHWZpSJp8Nle0s95seQ+AN71cupw7jOVnCpnB+57fO5p11qQw
         NOqjGDLxKaMUNUrdnzVgdtKXagIpv3kt8kv8FmZDaBMzNAuU30Es9QMLoZSckPmlLOIZ
         n9wFGp9vfEkKNf2+PxPbECtpMTuDbXZR9A3SoUI5K79S+nnRQItz63jv4+1uuNsQhGfl
         Gmpw4s5LnA5xBF28wa28kmwMLpz9kMLagixOYxWiZIWOTvP/o/WwswbMC5JfQ1ilJ67j
         iy/GvPrll7ccA0ltjQWNiFbghcjwYHY7u29dx6CXcgWKABoOI9igHKUM78lLvnXARjav
         uz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pg6PJaVDUkAITFjkMU6ng0d8HxlghasMrqy2nxiQARg=;
        b=aJjFiK9c4aCPZPrNu209DFww+HCXkz/EEZ35ceKKU95b+cama1DRiC7Tc55N1pBmre
         +B/HJPmuAYM+ET/ttG/4n8WpsTzxueZ6h8Pn9nUf35/00D7Qyu4v9fclmNSt/qK6lMsW
         9EP0yJnFZUbbyf5XQg9AGhS+TI+s16OsOQTN97B9m/r9K4cXTlFA34T+gbhQISQgdCqc
         jftdPwyKWokdNkUSEwAHTRgKpe+NV0qknk2o4GHJbgBJBbZpoySSOzkn85B6QftISYwd
         Iilr6gSfUKIu/CapThNgym4hA1UXFViZuLVS8izz1IeumcYJto979+o3JTtQpTIxANUd
         nyRw==
X-Gm-Message-State: AOAM531IzIOhowPQAFTUwjF7fFOnVHK59yML5GcEACsGQzVqhirfnN6r
        gu3jzfgl1NVdcAjkHnyJKejDpKd9rZmH6qzg
X-Google-Smtp-Source: ABdhPJzGlB7rJVf5/zTLMwiVrmTH5i8CIP9E0LbpZaVUCC9JCVO92ec3hheCVddG7JN0TUWg8SAPkiySAFIjtZaS
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6402:1a33:: with SMTP id
 be19mr1661521edb.47.1605046324324; Tue, 10 Nov 2020 14:12:04 -0800 (PST)
Date:   Tue, 10 Nov 2020 23:10:21 +0100
In-Reply-To: <cover.1605046192.git.andreyknvl@google.com>
Message-Id: <67c17dafa28036b628234c8f1d88368af374449c.1605046192.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v9 24/44] kasan, arm64: don't allow SW_TAGS with ARM64_MTE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software tag-based KASAN provides its own tag checking machinery that
can conflict with MTE. Don't allow enabling software tag-based KASAN
when MTE is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1515f6f153a0..25ead11074bf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -134,7 +134,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
-	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
+	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.29.2.222.g5d2a92d10f8-goog

