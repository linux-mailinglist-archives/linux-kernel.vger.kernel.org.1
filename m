Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD15280630
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbgJASEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgJASEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:04:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72122C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 11:04:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so6873735wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0OdyXaVNiyIQMSnkmN1U5DBWCyVDZmuQfjlNhLtDrKs=;
        b=dPA+Od53q5f/HBtQwvz6tXehIq+teMdNnK314CY3s0ajOt31vt/u/6D54Q/Ix/LC86
         VtbYmG/LRaO//ScEveC5LTytEFM1+3pyoHPWuviFMpXhjPErq3Ufy2aSE62Z1E54Jr6x
         fqWFaqqQi3HGXr9rIfyLZrmvxYUAsZ3HsNF8y8akiDP5oppHmkSq2PJk0baeSBr0X0ou
         AUH/o1uBlIATCN1Px1ykRaBmK5Mn1QE0VhyzivGl4dPLnU2lDdrakcyrmDF6NyYXkxzN
         SJIsUNhdD1tp2kvB482PCt/cq9B2r/JGgCl6SNVrMLV76ZijAIXnbqO8oNjGq3WyT6CK
         Rs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0OdyXaVNiyIQMSnkmN1U5DBWCyVDZmuQfjlNhLtDrKs=;
        b=K++IQ0M12z5zpGW6Khy4IhHWPRSLE8i5UpIJvNBjgxgEPV8LvZQGqcNWEzqhxr3lUR
         J/eitAHk8jhSuN4pfvmrmsZLzKfJvG4n0keXq+sqOaFuhtoMnnk4+qOTn0gZmGMHa5oO
         Rn+/Ww0ZmbJ8EIA8v22wR/ErfRCz9mayZLGk7ph8oPJbM2iDQtooFKE+usT+iU1HQXwT
         1PVr2+62ifi9fxTVsqQJmb8KP0cja6BjjWHexge8pMv8UJJ9S/Os1Ayz6D9+9fxmum5n
         Bdg363uOO/BljlK/1ioN/lV5lRrgr8wHh1sAelZTtEgEaauuI6/qgHcMru4M3KdkFITe
         888Q==
X-Gm-Message-State: AOAM530+dmNAtt/+KcyekaTrrK+L4l8Vl8cm9zSdGoUefWkAQDIhgWNM
        DiO4P9j55j6V+u7zhdxsWCBUww==
X-Google-Smtp-Source: ABdhPJwzl9G8I0FIwZnl+qK3rpBAlZVN5JVj57b7Bi+4u6kcK9IXkcXgdVGaQG1V73bZU6YmgI5YXQ==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr10259531wrm.174.1601575443811;
        Thu, 01 Oct 2020 11:04:03 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id k6sm950946wmf.30.2020.10.01.11.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 11:04:03 -0700 (PDT)
Date:   Thu, 1 Oct 2020 20:03:57 +0200
From:   elver@google.com
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 39/39] kasan: add documentation for hardware tag-based
 mode
Message-ID: <20201001180357.GW4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <b6edb566f7439224c3e235186305bc07de8d27b9.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6edb566f7439224c3e235186305bc07de8d27b9.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Add documentation for hardware tag-based KASAN mode and also add some
> clarifications for software tag-based mode.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: Ib46cb444cfdee44054628940a82f5139e10d0258
> ---
>  Documentation/dev-tools/kasan.rst | 78 ++++++++++++++++++++++---------
>  1 file changed, 57 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index a3030fc6afe5..d2d47c82a7b9 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -5,12 +5,14 @@ Overview
>  --------
>  
>  KernelAddressSANitizer (KASAN) is a dynamic memory error detector designed to
> -find out-of-bound and use-after-free bugs. KASAN has two modes: generic KASAN
> -(similar to userspace ASan) and software tag-based KASAN (similar to userspace
> -HWASan).
> +find out-of-bound and use-after-free bugs. KASAN has three modes:
> +1. generic KASAN (similar to userspace ASan),
> +2. software tag-based KASAN (similar to userspace HWASan),
> +3. hardware tag-based KASAN (based on hardware memory tagging).
>  
> -KASAN uses compile-time instrumentation to insert validity checks before every
> -memory access, and therefore requires a compiler version that supports that.
> +Software KASAN modes (1 and 2) use compile-time instrumentation to insert
> +validity checks before every memory access, and therefore require a compiler
> +version that supports that.
>  
>  Generic KASAN is supported in both GCC and Clang. With GCC it requires version
>  8.3.0 or later. With Clang it requires version 7.0.0 or later, but detection of
> @@ -19,7 +21,7 @@ out-of-bounds accesses for global variables is only supported since Clang 11.
>  Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
>  
>  Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
> -riscv architectures, and tag-based KASAN is supported only for arm64.
> +riscv architectures, and tag-based KASAN modes are supported only for arm64.
>  
>  Usage
>  -----
> @@ -28,14 +30,16 @@ To enable KASAN configure kernel with::
>  
>  	  CONFIG_KASAN = y
>  
> -and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN) and
> -CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN).
> +and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN),
> +CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN), and
> +CONFIG_KASAN_HW_TAGS (to enable hardware tag-based KASAN).
>  
> -You also need to choose between CONFIG_KASAN_OUTLINE and CONFIG_KASAN_INLINE.
> -Outline and inline are compiler instrumentation types. The former produces
> -smaller binary while the latter is 1.1 - 2 times faster.
> +For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
> +CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
> +The former produces smaller binary while the latter is 1.1 - 2 times faster.
>  
> -Both KASAN modes work with both SLUB and SLAB memory allocators.
> +Both software KASAN modes work with both SLUB and SLAB memory allocators,
> +hardware tag-based KASAN currently only support SLUB.
>  For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
>  
>  To augment reports with last allocation and freeing stack of the physical page,
> @@ -196,17 +200,24 @@ and the second to last.
>  Software tag-based KASAN
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -Tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64 CPUs to
> -store a pointer tag in the top byte of kernel pointers. Like generic KASAN it
> -uses shadow memory to store memory tags associated with each 16-byte memory
> +Software tag-based KASAN requires software memory tagging support in the form
> +of HWASan-like compiler instrumentation (see HWASan documentation for details).
> +
> +Software tag-based KASAN is currently only implemented for arm64 architecture.
> +
> +Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of arm64 CPUs
> +to store a pointer tag in the top byte of kernel pointers. Like generic KASAN
> +it uses shadow memory to store memory tags associated with each 16-byte memory
>  cell (therefore it dedicates 1/16th of the kernel memory for shadow memory).
>  
> -On each memory allocation tag-based KASAN generates a random tag, tags the
> -allocated memory with this tag, and embeds this tag into the returned pointer.
> +On each memory allocation software tag-based KASAN generates a random tag, tags
> +the allocated memory with this tag, and embeds this tag into the returned
> +pointer.
> +
>  Software tag-based KASAN uses compile-time instrumentation to insert checks
>  before each memory access. These checks make sure that tag of the memory that
>  is being accessed is equal to tag of the pointer that is used to access this
> -memory. In case of a tag mismatch tag-based KASAN prints a bug report.
> +memory. In case of a tag mismatch software tag-based KASAN prints a bug report.
>  
>  Software tag-based KASAN also has two instrumentation modes (outline, that
>  emits callbacks to check memory accesses; and inline, that performs the shadow
> @@ -215,9 +226,34 @@ simply printed from the function that performs the access check. With inline
>  instrumentation a brk instruction is emitted by the compiler, and a dedicated
>  brk handler is used to print bug reports.
>  
> -A potential expansion of this mode is a hardware tag-based mode, which would
> -use hardware memory tagging support instead of compiler instrumentation and
> -manual shadow memory manipulation.
> +Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
> +pointers with 0xFF pointer tag aren't checked). The value 0xFE is currently
> +reserved to tag freed memory regions.
> +
> +Software tag-based KASAN currently only supports tagging of slab memory.
> +
> +Hardware tag-based KASAN
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Hardware tag-based KASAN is similar to the software mode in concept, but uses
> +hardware memory tagging support instead of compiler instrumentation and
> +shadow memory.
> +
> +Hardware tag-based KASAN is currently only implemented for arm64 architecture
> +and based on both arm64 Memory Tagging Extension (MTE) introduced in ARMv8.5
> +Instruction Set Architecture, and Top Byte Ignore (TBI).
> +
> +Special arm64 instructions are used to assign memory tags for each allocation.
> +Same tags are assigned to pointers to those allocations. On every memory
> +access, hardware makes sure that tag of the memory that is being accessed is
> +equal to tag of the pointer that is used to access this memory. In case of a
> +tag mismatch a fault is generated and a report is printed.
> +
> +Hardware tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
> +pointers with 0xFF pointer tag aren't checked). The value 0xFE is currently
> +reserved to tag freed memory regions.
> +
> +Hardware tag-based KASAN currently only supports tagging of slab memory.
>  
>  What memory accesses are sanitised by KASAN?
>  --------------------------------------------
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
