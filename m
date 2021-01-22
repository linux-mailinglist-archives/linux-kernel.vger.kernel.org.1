Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34A300045
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbhAVK2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbhAVKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:17:26 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E446AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:16:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u25so6806167lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ho+UEyNp5eYdEURBZ4SMf8N9WjtCKibpu023xdL0thQ=;
        b=z3riLNdz3S3gII/G4AcHW8uKq/se8NZPHRXlfo6dXTPiEfOrsLoasXGJ9jb7D6GrlM
         HnXYHLTmP5Be9JKQEhXRX3suzUSpoqdBT7daPIU81/mIVjircyw0PRQw69maZ4D32M4p
         JhxbTAOMKPaGnOA5EfpM5hv2OaIC6HNUtJVj9dP51jrsttPuJtZ78qHhUojfLhBSW1+O
         KZhUHJHwCGUp8GFb5ILWiBMR+0//aXOrCYRFY/YWYJ1T74BbqhZVp29CIQzdVKEoGhEy
         ilrGENrInnGqlDtjC72cXfKzPRYmj1ecQ7PV0EkHQY0jTT6j5o7421Spw2N9jPbapmEs
         o6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ho+UEyNp5eYdEURBZ4SMf8N9WjtCKibpu023xdL0thQ=;
        b=DE47+smVBdhY6QKQwbRzKCaXg42Fb/aAoDzMlxjbRKzdRsBDOokwg8c7HTiWNGn2d0
         wYxXFyIxq5uGN8iQvq0kTsG8/JzcEA/P3D40UVdahKgoi+bng3HeqSA3GY9gZ5B1dqMJ
         x/lNWqRz7C8nNia379oL31aOTdMwfCm1oU/UMOAbm5UhmHVAICh7toit9dLLb6TRlfKx
         BbaoDIhUUM9rzXf/EybTqDBvFGI9KOyEUoxmn1XF9k5aMzrAq5eJ1rv/kjgd1gGDTtih
         lHT0PXESoI+ry1fXrYGQ6lh82s1yzvcwLUXhRDLhKMfEhtxaRIIqSDmhQy0P8fPL3iZJ
         Nhfw==
X-Gm-Message-State: AOAM533G2457i1I1+3SgElnGKlZIpbe79QvH8tYvMSzOZhri6VavLvNz
        4pHJ2NDIWjD0ErXExw+aT3eemtHrehpMD5yQGIwmTZB7sNpOHA==
X-Google-Smtp-Source: ABdhPJwnI1FcGyRKwp/vj+Ss1axhLMqEoXDApG+LtR4T7WCUFQC0XdmamzQXWplkQ2gUlJdlmZEFAyxtTw90Mh9+QaU=
X-Received: by 2002:a05:6512:48d:: with SMTP id v13mr454109lfq.546.1611310597311;
 Fri, 22 Jan 2021 02:16:37 -0800 (PST)
MIME-Version: 1.0
References: <1611308311-2530-1-git-send-email-sumit.garg@linaro.org> <20210122094810.6o32gzoqtwgqi5hn@maple.lan>
In-Reply-To: <20210122094810.6o32gzoqtwgqi5hn@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 22 Jan 2021 15:46:25 +0530
Message-ID: <CAFA6WYO0MFn8A-yDjThrBj_DxEpS3j6DixJX9gi49So99BZg2Q@mail.gmail.com>
Subject: Re: [PATCH] kdb: Make memory allocations more robust
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 at 15:18, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jan 22, 2021 at 03:08:31PM +0530, Sumit Garg wrote:
> > Currently kdb uses in_interrupt() to determine whether it's library
> > code has been called from the kgdb trap handler or from a saner calling
> > context such as driver init. This approach is broken because
> > in_interrupt() alone isn't able to determine kgdb trap handler entry via
> > normal task context such as [1].
> >
> > We can improve this by adding check for in_dbg_master() which explicitly
> > determines if we are running in debugger context. Also, use in_atomic()
> > instead of in_interrupt() as the former is more appropriate to know atomic
> > context and moreover the later one is deprecated.
>
> Why do we need the in_atomic() here? Or put another way, why isn't
> in_dbg_master() sufficient?
>

Yes, you are right in_atomic() is redundant after looking at usage of
GFP_KDB. Will get rid of it in v2.

-Sumit

>
> Daniel.
>
>
> >
> > [1] $ echo g > /proc/sysrq-trigger
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  kernel/debug/kdb/kdb_private.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> > index 7a4a181..7a9ebd9 100644
> > --- a/kernel/debug/kdb/kdb_private.h
> > +++ b/kernel/debug/kdb/kdb_private.h
> > @@ -231,7 +231,7 @@ extern struct task_struct *kdb_curr_task(int);
> >
> >  #define kdb_task_has_cpu(p) (task_curr(p))
> >
> > -#define GFP_KDB (in_interrupt() ? GFP_ATOMIC : GFP_KERNEL)
> > +#define GFP_KDB (in_atomic() || in_dbg_master() ? GFP_ATOMIC : GFP_KERNEL)
> >
> >  extern void *debug_kmalloc(size_t size, gfp_t flags);
> >  extern void debug_kfree(void *);
> > --
> > 2.7.4
> >
