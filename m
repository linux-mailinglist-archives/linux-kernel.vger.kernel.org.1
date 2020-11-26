Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58CB2C5DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbgKZWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 17:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgKZWjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 17:39:17 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67FC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:39:15 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id r18so3915958ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dp1u6t3d7ucUrhsqsGYYgxSnYCEt2fNrvle7OeX81K0=;
        b=oWjfCZKII7My0aK4XJzYpUQeWYtySXYbsDZxBr85C2ySKhFOgoxQsGUQ48df7kdK4+
         EmnDcXk+IavPkFstSTfSbaPBSpFa+NOUjMFi63G6Zd3Pd53utSxv9BFWln44c8zijYmr
         gfXFy4ReNy1TvGOJBQ99SWicpxMzM/u3XAysFKoqV1x6Ygdt5a2F2CTuoHM7mfiBB7CF
         N975Gn4QQKS0rTY4mM9ohEV63SEMY9Jp5l2XtaknfzhV3q4t53LqsENG+ojSrO/hMB9S
         GVrGXhUkhccBrVP1/X/cBhfXOZcGdahX7REIOmo6sTtwu9ClqdxNDjHtO9DZW9J+yyaR
         sevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dp1u6t3d7ucUrhsqsGYYgxSnYCEt2fNrvle7OeX81K0=;
        b=HcQlVcgK1+U83g06eWq1VmmqRMl7SqVv1gXFQfwHVh14d7z9nARS8X4jCQ+hd1lXmm
         Dfm7S7W4bRl3L40ZT3ye+IC19adhMf/4WUzwuVEBc3JHWi5nXX3lnCc8CHf1Pwb+6x4W
         ivx3tjxNkRiSW8bk1zY88SCCCU5exyb8LmC7XwmeeZ7hJfPtOyJfeJ9EqiuzlPfzEAO7
         DnV13T0D8QduFtIuQDdEq6A/28M1xYgh+ywjMkLaI2JlGUJRizMsKUCRvQ4rta+E9ZhM
         MXfaRl+hVhdjodii7s75L5z/XhypsJZZpVu2gQG3dO9y61Ir2zzVsmVOOZUB69FgjDwA
         wqQA==
X-Gm-Message-State: AOAM533MjPlnCPgto0Ca/uMi071OuA3qs+3UjtvHaN559GJHMZlIp25T
        Uc+Pb0eT7QA6qYmRy0MUkaycXuqdERYzg7tcaMlq0w==
X-Google-Smtp-Source: ABdhPJydEIHq8/Z+r2aKN1aX6tfHkwNR/Dht4tA8/sItY5pqYvGEhvbW2uYDE1EhADZP+UlrKR35SUjJuI5MIFhpdaI=
X-Received: by 2002:a05:651c:112e:: with SMTP id e14mr2090977ljo.388.1606430353716;
 Thu, 26 Nov 2020 14:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20201126130606.2290438-1-anders.roxell@linaro.org> <8affd609-f037-8b21-853a-8b87299db044@gmx.de>
In-Reply-To: <8affd609-f037-8b21-853a-8b87299db044@gmx.de>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Nov 2020 23:39:02 +0100
Message-ID: <CADYN=9+pSK2SHY4ncFaseT9qz6BoTCUxi0e3poTDao4v=S_84g@mail.gmail.com>
Subject: Re: [PATCH] parisc: signal: remove _SA_SIGGFAULT
To:     Helge Deller <deller@gmx.de>
Cc:     James.Bottomley@hansenpartnership.com,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 at 15:46, Helge Deller <deller@gmx.de> wrote:
>
> On 11/26/20 2:06 PM, Anders Roxell wrote:
> > When building tinyconfig on parisc the following error shows up:
> >
> > /tmp/kernel/signal.c: In function 'do_sigaction':
> > /tmp/arch/parisc/include/asm/signal.h:24:30: error: '_SA_SIGGFAULT' undeclared (first use in this function); did you mean 'SIL_FAULT'?
> >  #define __ARCH_UAPI_SA_FLAGS _SA_SIGGFAULT
> >                               ^~~~~~~~~~~~~
> >
> > The changes in the two individual patches listed in 'Fixes' below are
> > OK.  Remove the _SA_SIGGFAULT define since PH-UX isn't going to be
> > supported according to commit 41f5a81c07cd ("parisc: Drop HP-UX specific
> > fcntl and signal flags").
> >
> > Fixes: 23acdc76f179 ("signal: clear non-uapi flag bits when passing/returning sa_flags")
> > Fixes: 41f5a81c07cd ("parisc: Drop HP-UX specific fcntl and signal flags")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/parisc/include/asm/signal.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/parisc/include/asm/signal.h b/arch/parisc/include/asm/signal.h
> > index 30dd1e43ef88..715c96ba2ec8 100644
> > --- a/arch/parisc/include/asm/signal.h
> > +++ b/arch/parisc/include/asm/signal.h
> > @@ -21,8 +21,6 @@ typedef struct {
> >       unsigned long sig[_NSIG_WORDS];
> >  } sigset_t;
> >
> > -#define __ARCH_UAPI_SA_FLAGS _SA_SIGGFAULT
> > -
>
> Which kernel are you testing?

I used used linux-next tag: next-20201126

Cheers,
Anders

> I don't see this line in current git head...?!?
>
> Helge
>
> >  #include <asm/sigcontext.h>
> >
> >  #endif /* !__ASSEMBLY */
> >
>
