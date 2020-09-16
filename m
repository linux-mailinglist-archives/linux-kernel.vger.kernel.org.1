Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691BF26CD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIPVA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIPQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C0C0A3BFE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:24:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so6724816wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yWmAHcgT2wDa3AHqlJ16t/WowuUKj+5oH128IS3to+s=;
        b=ecyvxJA9SssekdAOtuviJ13pOnV2clLGkWhiOWO+2yrKD8LW/yxDkjFG3CzSaKPwdz
         lO4l8QLk4EjgOwdsycDk3JkggZLdyWLIjx79hY9n3+KYGB1WQIAQ4FECAlbZPLNNzst2
         +V8xxssKHQL+hxHT661evNUe9qi63Lr5THWvEXVzmU8ys481d4Icv0X7UrGAWcX3Y6R6
         TW53J0GJUqSsZ/FtTU9WDgV3l69ZLSMQ+ne9CePfgEfWy5GDf3/fHWWq15NCFehU95v3
         AHJkB5O7SLJY0IhMVow1YeZiDiMLuOOGL8aCTq8O7o0OtK/8YUEzsxMcZLk6TNgC2ruT
         WwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yWmAHcgT2wDa3AHqlJ16t/WowuUKj+5oH128IS3to+s=;
        b=RiVict7AuQ8+0J9iqiZ6HBslv4fvxtN4IY4LfuIq7WztDCP2cARaF7QqFHsxgEYkrp
         cF+b8OMC7ZKEt/P6WeFtLY2DjBS0N4jK5x1mFmwcrSvcX/20K017J+E9XlUAgPLkuyUl
         sm5Jy2MgC4sAQWotJ7FY9Aa+Ip3cqwjtakN0gapyA978kRdXnCvgmwpCCNPjTas/zoUT
         GCiuPVStFepoyfm1NyHXxcpv3P7RQbjfNcyPNAGUiVqp3bLFU286/fy4hMmS0AFzzJVx
         2lRdFUm5K1rEOjqLO+LnZDU9Do36Ev3tTpxuJ6PVW6DyLkwot1vYa2RN4EgoldA82pop
         m0eg==
X-Gm-Message-State: AOAM532D9MhTzbPkeQp1ON5wXmnfZW48ZeQ8biabBh5S3lg3giy1KCq8
        8uVlHfN1YJ3nXoRn8yFlYAAvYQ==
X-Google-Smtp-Source: ABdhPJyN8ng2AKyfXE308SyYBOpK5+vw1l709E5yQIVxjKXFjVd61eroffH5kXqXdkXmnXUZ3JvTow==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr19383508wrc.71.1600259054273;
        Wed, 16 Sep 2020 05:24:14 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id j26sm2567165wrc.79.2020.09.16.05.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:24:13 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:24:12 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 00/10] Independent per-CPU data section for nVHE
Message-ID: <20200916122412.elxfxbdygvmdgrj5@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200914174008.GA25238@willie-the-truck>
 <20200916115404.rhv4dkyjz35e4x25@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916115404.rhv4dkyjz35e4x25@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I was also wondering about another approach - using the PERCPU_SECTION macro
> unchanged in the hyp linker script. It would lay out a single .data..percpu and
> we would then prefix it with .hyp and the symbols with __kvm_nvhe_ as with
> everything else. WDYT? Haven't tried that yet, could be a naive idea. 

Seems to work. Can't use PERCPU_SECTION directly because then we couldn't
rename it in the same linker script, but if we just unwrap that one layer
we can use PERCPU_INPUT. No global macro changes needed.

Let me know what you think.

------8<------
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5904a4de9f40..9e6bf21268f1 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -195,11 +195,9 @@ SECTIONS
        PERCPU_SECTION(L1_CACHE_BYTES)

        /* KVM nVHE per-cpu section */
-       #undef PERCPU_SECTION_NAME
-       #undef PERCPU_SYMBOL_NAME
-       #define PERCPU_SECTION_NAME(suffix)     CONCAT3(.hyp, PERCPU_SECTION_BASE_NAME, suffix)
-       #define PERCPU_SYMBOL_NAME(name)        __kvm_nvhe_ ## name
-       PERCPU_SECTION(L1_CACHE_BYTES)
+       . = ALIGN(PAGE_SIZE);
+       .hyp.data..percpu : { *(.hyp.data..percpu) }
+       . = ALIGN(PAGE_SIZE);

        .rela.dyn : ALIGN(8) {
                *(.rela .rela*)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 7d8c3fa004f4..1d8e4f7edc29 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -4,6 +4,10 @@
  * Written by David Brazdil <dbrazdil@google.com>
  */

+#include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
+#include <asm/memory.h>
+
 /*
  * Defines an ELF hyp section from input section @NAME and its subsections.
  */
@@ -11,9 +15,9 @@

 SECTIONS {
        HYP_SECTION(.text)
-       HYP_SECTION(.data..percpu)
-       HYP_SECTION(.data..percpu..first)
-       HYP_SECTION(.data..percpu..page_aligned)
-       HYP_SECTION(.data..percpu..read_mostly)
-       HYP_SECTION(.data..percpu..shared_aligned)
+
+       .hyp..data..percpu : {
+               __per_cpu_load = .;
+               PERCPU_INPUT(L1_CACHE_BYTES)
+       }
 }
-----8<------

David
