Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA332700C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRPTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:19:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:19:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so5960040wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LN66O5JSkYCxOmUnEcN+noTfKpC7LQl7RqBfE76tpKc=;
        b=njwtxF5oKOoIDCTtN7M94k1G+G0/E8GCFJd727PAZrNOP/hvMByvmLc043VdjseTxR
         WCNJRDar5juEL+QEPBtOF2DJQFYVX9B6QCwDwrnHVmzunwN68Q3ELK3pW+ijCPE3U0/x
         hmlVC2MSoNOzGlY1hkRqyj9y94hK0Whn6SUd4oy9FgQUeciQxPaUwGXmN9fUWhk5wGPm
         UJM2yEKaGKfWBQY830rCfu7i128RlgfcYZ59wQShEBO7XCX1APnK3mlhhf5aGO171hUO
         Y3oAlJKm/T/hNhIe/XOQFwy1nCNayYPk6XYUVt2pRbPAOKY61Gj5mwDwD9iZwXevqhgF
         JM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LN66O5JSkYCxOmUnEcN+noTfKpC7LQl7RqBfE76tpKc=;
        b=r4OE/32zB3MWjnCuvYEQDPs8sLJy8BqramDfovmQTcHRJzT5RbbyNi1z9mA/zhwhrU
         VqP1zFsDctlrnFw3jQsco+YL64wPRt54iH1qjSfft+CLrJ5dq6czW8tvMvt3duC+2jxt
         k6Snux0UKC1oQHIDNq19z3sG7Pe/td0sOkgiE3YzHYwFc8HMoGxgaugpP0WS57tnx6MP
         Pz45vFqZErd2flhFYqTtDa5QKidhlj8tPMIk4FA3HzylbW+caI95vCj7XAZy2hcjsJOU
         6GvwW2YfWGEpWKgVHWRWRIdTJ2BJTbFoCla/Ox1vg8aMLrtAv/WzMtDTucm8kWJlCl5T
         msNw==
X-Gm-Message-State: AOAM532yglxK4h0rhNNJYiG90tG6J+G6lgYnDoZPl+8OSQsdvrL/4luL
        uOGdpuKuwfpNJ35HBWBZ3HdPZQ==
X-Google-Smtp-Source: ABdhPJyQq37a0beUlQ6BSXGA/W7iHrPH98l0i+hBHKR5luytBVxYilwdiT6p59tx580L9FUNOh+i4A==
X-Received: by 2002:a7b:c085:: with SMTP id r5mr17054390wmh.52.1600442385292;
        Fri, 18 Sep 2020 08:19:45 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id v128sm5556561wme.2.2020.09.18.08.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 08:19:44 -0700 (PDT)
Date:   Fri, 18 Sep 2020 17:19:39 +0200
From:   Marco Elver <elver@google.com>
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
Subject: Re: [PATCH v2 33/37] kasan, arm64: implement HW_TAGS runtime
Message-ID: <20200918151939.GA2465533@elver.google.com>
References: <cover.1600204505.git.andreyknvl@google.com>
 <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:

> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 875bbcedd994..613c9d38eee5 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -184,7 +184,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
>  
>  #endif /* CONFIG_KASAN_GENERIC */
>  
> -#ifdef CONFIG_KASAN_SW_TAGS
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>  
>  void kasan_init_tags(void);
>  
> @@ -193,7 +193,7 @@ void *kasan_reset_tag(const void *addr);
>  bool kasan_report(unsigned long addr, size_t size,
>  		bool is_write, unsigned long ip);
>  
> -#else /* CONFIG_KASAN_SW_TAGS */
> +#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>  
>  static inline void kasan_init_tags(void) { }
>  
> @@ -202,7 +202,7 @@ static inline void *kasan_reset_tag(const void *addr)
>  	return (void *)addr;
>  }
>  
> -#endif /* CONFIG_KASAN_SW_TAGS */
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
>  
>  #ifdef CONFIG_KASAN_VMALLOC

It's not visible by looking at this diff, but there is some
#ifdef-redundancy that I do not understand where it came from.

This is what I have to fix it:

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 613c9d38eee5..80a0e5b11f2b 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -40,6 +40,12 @@ static inline void *kasan_mem_to_shadow(const void *addr)
 int kasan_add_zero_shadow(void *start, unsigned long size);
 void kasan_remove_zero_shadow(void *start, unsigned long size);
 
+/* Enable reporting bugs after kasan_disable_current() */
+extern void kasan_enable_current(void);
+
+/* Disable reporting bugs for current task */
+extern void kasan_disable_current(void);
+
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 static inline int kasan_add_zero_shadow(void *start, unsigned long size)
@@ -50,18 +56,6 @@ static inline void kasan_remove_zero_shadow(void *start,
 					unsigned long size)
 {}
 
-#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
-
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
-
-/* Enable reporting bugs after kasan_disable_current() */
-extern void kasan_enable_current(void);
-
-/* Disable reporting bugs for current task */
-extern void kasan_disable_current(void);
-
-#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
-
 static inline void kasan_enable_current(void) {}
 static inline void kasan_disable_current(void) {}
 
