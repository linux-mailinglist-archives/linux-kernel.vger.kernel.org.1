Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F9280AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbgJAXKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbgJAXKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:10:50 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F090C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:10:50 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c204so38869wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Tqg/PaARbGGjCbcEwXf/kx8hqamrKXV0hm6ycbrMYh0=;
        b=q1pZ45jUsDvC6RvvpVmUMxcDN+QzWRxle3LyQiQaqFNru6DzMYAJadyiLi5IFf5eAb
         H33N7IsVEHrUo8tnhwOwvTzqgSlknCy2afyTDva3reU5L2BQlbJXiiUFTBWfWeLQ1Osl
         PUUeb6ekQnePKtJAOtnXVi/rt7dmR3qrVWq9q3IlnRtcgTAmKnMV45bzkudHHKNZ/M/n
         JidM9Ux1tPsdUOvFvhG3aruIlI5XXTsjN2sk5zbZJshDSlzdV6+PD2k2kVhF4fG3yuPx
         swJbz0o6mk02yn3Lj/F2pFW5IeYTjkL4t29wn1EcpKvzaRmpQzSFPDKrL8zj0MLoKkI8
         kwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tqg/PaARbGGjCbcEwXf/kx8hqamrKXV0hm6ycbrMYh0=;
        b=LmVhehkX1po9wmNZiJUJI02Bc7KoH/yjN/pFoKkl+FQfTSvzYh6n2yDX17RDn2GWPM
         wAAVzqRWEm5sz4SyY+oNYpKTd4kNpLdM6SZ74vvgcJ5gX6H7KE0UmILUvosQfqJFZP/1
         Gb4HdvbJKQ6cdNtv2jM4xwrwL0VcJY6Ktcs2LrsPvxVYtZtEeuEFFI2X5kGwdIP6dPOd
         nB2byo/XRv8thRz3djLVRytQoKokv+MVZiXH5UV0PfLJOCEzmFMASVBJTvh7GJVE0PRv
         t0Dw1M/28KNZZt6/kPIrXR1lG5vRt8mFPC3zyDpz04YROytM9hIcOsF+NlTiS5MgMvXe
         FVGQ==
X-Gm-Message-State: AOAM532EXl0m3QeXpCKY63JiQUXPthKSoHabBPmFb+fRQ4mCE201+T3Q
        otRsiqBnaw/9y07FyL3PCy5XtlLnOitUtGrs
X-Google-Smtp-Source: ABdhPJyU61rTBjDi8+okt2SjchYj5K8iGK/EP2NSjf+t0b0AHBjEvvTYReNuAaJ6C1xIDP8sEiXE+jwT5iC/1MUs
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:600c:2146:: with SMTP id
 v6mr2207908wml.159.1601593848953; Thu, 01 Oct 2020 16:10:48 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:03 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <ce172045681b07836b42e5d9761be8d2d6d98b06.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 02/39] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
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
index 047b53dbfd58..e1d55331b618 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -156,7 +156,7 @@ config KASAN_SW_TAGS_IDENTIFY
 
 config KASAN_VMALLOC
 	bool "Back mappings in vmalloc space with real shadow memory"
-	depends on HAVE_ARCH_KASAN_VMALLOC
+	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
 	help
 	  By default, the shadow region for vmalloc space is the read-only
 	  zero page. This means that KASAN cannot detect errors involving
-- 
2.28.0.709.gb0816b6eb0-goog

