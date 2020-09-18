Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1D270160
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIRPwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRPwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:52:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7699DC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:52:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q12so3185569plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=omeCvyN2X/k16jy28HRYjKOUfMdEZR+hVsENqh7IFVI=;
        b=cV5/3df6JX7tGrz+Rdke964MTO87L5//MzytRzCWjxkY3D1m0b7tRBIrUD7I76tUBF
         YHoBTBWChRevPrNVtB1Z1pmNMrR+PlQE17Smr+7pe1MccthckwPQKccHO55xotOSarlc
         gXK2z+m4rywK+NawdJq+KkqA7d4eCIyCVhWvBLr3xmiIoNVyk/Ta9r0vjp8GopnXhtnU
         yom0nDsp+QowXvEVy8cPdviNrZnV/YOImXBXfIu2pywCzLrBtB/85NmEv4CrtsB9np2g
         s7SRl0Pf18CysXDZY1egmGDYAR1kC47QzH0GcL/dlP9C3KhTzpkZ3dK+OGvTcceNu1lL
         cX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=omeCvyN2X/k16jy28HRYjKOUfMdEZR+hVsENqh7IFVI=;
        b=jGPb7KHNkBq3hA0fuQbojpUPMctxEPcC32hdLQsqw/O06LxM38oI053hgg/GkvB2zw
         lj8rDHePKynXqXa7JRzhRccjoEGEi16v0P+rdyEpn6U4X1rXHG/v+buTrpwGLq+AO3MZ
         Y+HN0GKx7aX+jlwfb5I7u69Ejw/FELmunhb9D1AIFJw5mbDlH6QZiEBQ2/9MfXAPzx6i
         REPqZnzXb/PXsOQyJwwgsw2b8nRVzZOZdKkSrJL5iQQUoSO3u4YNeFIaAwshfleV6eLp
         AGuhFxFiF53uR8+pLVgPLGulsqe/U1KGchXBX2y06+2f1gOekvESbqa6gMFyIl1Qg9dZ
         d/wQ==
X-Gm-Message-State: AOAM533AXmse8vsVz/SeGuWmlxCtI3TIcxGQgPXf/FLdlIlYCJJmbLYG
        yZhU2s9l3KCRWR3NGIYr1lNzEmtOI1ejhkrwxpHdPg==
X-Google-Smtp-Source: ABdhPJzfzgkmEWccoh9JoNBp0ZJ67ZkviSvCyqQnKf99vOYl96bUcqGFkN45FS2uV1Y3EF3tFGMeGxAAkVEML2XqRxk=
X-Received: by 2002:a17:90a:cc0e:: with SMTP id b14mr12998779pju.166.1600444351596;
 Fri, 18 Sep 2020 08:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
 <20200918151939.GA2465533@elver.google.com>
In-Reply-To: <20200918151939.GA2465533@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 17:52:20 +0200
Message-ID: <CAAeHK+ywW5S3fg=1=i4qXRNH_G3spXgV+f9XSAwtX1BUndyoKQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/37] kasan, arm64: implement HW_TAGS runtime
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 5:19 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
>
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 875bbcedd994..613c9d38eee5 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -184,7 +184,7 @@ static inline void kasan_record_aux_stack(void *ptr) {}
> >
> >  #endif /* CONFIG_KASAN_GENERIC */
> >
> > -#ifdef CONFIG_KASAN_SW_TAGS
> > +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> >
> >  void kasan_init_tags(void);
> >
> > @@ -193,7 +193,7 @@ void *kasan_reset_tag(const void *addr);
> >  bool kasan_report(unsigned long addr, size_t size,
> >               bool is_write, unsigned long ip);
> >
> > -#else /* CONFIG_KASAN_SW_TAGS */
> > +#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> >
> >  static inline void kasan_init_tags(void) { }
> >
> > @@ -202,7 +202,7 @@ static inline void *kasan_reset_tag(const void *addr)
> >       return (void *)addr;
> >  }
> >
> > -#endif /* CONFIG_KASAN_SW_TAGS */
> > +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
> >
> >  #ifdef CONFIG_KASAN_VMALLOC
>
> It's not visible by looking at this diff, but there is some
> #ifdef-redundancy that I do not understand where it came from.
>
> This is what I have to fix it:
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 613c9d38eee5..80a0e5b11f2b 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -40,6 +40,12 @@ static inline void *kasan_mem_to_shadow(const void *addr)
>  int kasan_add_zero_shadow(void *start, unsigned long size);
>  void kasan_remove_zero_shadow(void *start, unsigned long size);
>
> +/* Enable reporting bugs after kasan_disable_current() */
> +extern void kasan_enable_current(void);
> +
> +/* Disable reporting bugs for current task */
> +extern void kasan_disable_current(void);
> +
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> @@ -50,18 +56,6 @@ static inline void kasan_remove_zero_shadow(void *start,
>                                         unsigned long size)
>  {}
>
> -#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> -
> -#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> -
> -/* Enable reporting bugs after kasan_disable_current() */
> -extern void kasan_enable_current(void);
> -
> -/* Disable reporting bugs for current task */
> -extern void kasan_disable_current(void);
> -
> -#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> -
>  static inline void kasan_enable_current(void) {}
>  static inline void kasan_disable_current(void) {}

Oh yeah, I'll fix this, thanks!
