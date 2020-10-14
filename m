Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241A028E48A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbgJNQck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbgJNQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:32:40 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A7AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:32:39 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id n6so5909455ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8B1b67LV7GcK3X+6yPNOWg/2xf6f4j15sYSu/rEI0pQ=;
        b=nCeMhgkuY5i99JMaskXEuSDVWP+iH45vJfGnX9EdydvztWBJ6XGVQeQDA/BQU9cGj6
         wr5u9ec+UWlbcs1LUumE8haPpoQMpAPaO8+9kXcD8gGzX1rYF2CjMpwMFxskcG9WtoEk
         l4XeT5NxohuwafKO05cvfbTfGCjpOgz7+hs9jThItgq+by2oOB8Whcqrh6KX52GjtQ5Z
         MA5BIe/ZljUfWNBLpmpNjN4b+d3BtU+bH+t6WHWqAAu+2NTRj2kRumFjIsiQ9ETTfvEr
         iiu+XkKnq/ONL5HMajsRRoN0diRgTVQrWRi/ADz94BmpKyg4gJF9hrhrhNLBEPfiOtO2
         KR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8B1b67LV7GcK3X+6yPNOWg/2xf6f4j15sYSu/rEI0pQ=;
        b=iYtCmmDbLp/xlvs0A5e7oUqL1QC4LI3PokLlnPE28rBuMg5gQUFxPj4X6Otme1F18q
         RaZjdFCjVVGCd5o+W0ZON8sfdvcnP5ALxIcmzIHHHlB48TOnXLy3b5lV5HskuzOG02+B
         Ix+3X1exYGI01mF4ylSoxWBppVsf+vAKgz8J8jnUV9Es1jfXJvvX67g9wzpz6Z1pe6ru
         usmQMwfNMloGh8/aJjBoXTPDnC3f33x+F94ANeHyVCawFyHqErnxWurhi5tumHAy5Ybm
         2Ge/J/LTHEQPg7UBEVP6OGx6+0lADxaZUTEfRl6Ia+xSN4svkl5E9c6OyYjA45l5pPy0
         M/sA==
X-Gm-Message-State: AOAM530htL4voubsMOoUn7+Pscviy8a2zGuV5T+rLoTDNDRqXdoVqmQ4
        9rFfhP3lz04mojvT9af+RSsUM/ickX+nSe8e61N17dGxzVsxNg==
X-Google-Smtp-Source: ABdhPJzzVmbDuxvQwoFcnGQf8XBzcUnBjTYFYc01UCjxLnn0AgTPCd+NyBvYp2/khPyqOG9Nt1+MEyiI4Iq8u96f7h0=
X-Received: by 2002:a05:6602:144:: with SMTP id v4mr126076iot.115.1602693159333;
 Wed, 14 Oct 2020 09:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201014151614.29804-1-hqjagain@gmail.com> <20201014113823.4296521d@gandalf.local.home>
 <CAJRQjodMzSAJd23F=RRhR=d2H=D3vWMvCbU9JYdGNQ9MTkpmmw@mail.gmail.com> <20201014121136.042a5c37@gandalf.local.home>
In-Reply-To: <20201014121136.042a5c37@gandalf.local.home>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Thu, 15 Oct 2020 00:32:28 +0800
Message-ID: <CAJRQjodpfXmLRotz0XXomQSgi5d3YCKtHmL3h17LRBpDN5vMQw@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Add rb_check_bpage in __rb_allocate_pages
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 12:11 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 14 Oct 2020 23:48:05 +0800
> Qiujun Huang <hqjagain@gmail.com> wrote:
>
> > On Wed, Oct 14, 2020 at 11:38 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Wed, 14 Oct 2020 23:16:14 +0800
> > > Qiujun Huang <hqjagain@gmail.com> wrote:
> > >
> > > > It may be better to check each page is aligned by 4 bytes. The 2
> > > > least significant bits of the address will be used as flags.
> > > >
> > > > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > > > ---
> > > >  kernel/trace/ring_buffer.c | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > > index 93ef0ab6ea20..9dec7d58b177 100644
> > > > --- a/kernel/trace/ring_buffer.c
> > > > +++ b/kernel/trace/ring_buffer.c
> > > > @@ -1420,7 +1420,8 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
> > > > +static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> > > > +             long nr_pages, struct list_head *pages, int cpu)
> > > >  {
> > > >       struct buffer_page *bpage, *tmp;
> > > >       bool user_thread = current->mm != NULL;
> > > > @@ -1464,6 +1465,8 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
> > > >               if (!bpage)
> > > >                       goto free_pages;
> > > >
> > > > +             rb_check_bpage(cpu_buffer, bpage);
> > > > +
> > > >
> > >
> > > Why add it here, and not just add this check to the scan in
> > > rb_check_pages()?
> >
> > rb_head_page_deactivate() in rb_check_pages() will clear the 2 LSB first.
> >
>
> Well, you could just add another scan there, but if you want to do it this
> way, then remove passing the int cpu to these functions, and use the
> cpu_buffer->cpu, as keeping the cpu is just redundant.
Get it.
>
> Also, did you see an issue? This check is more of me being paranoid to
No, I'm a little paranoid too following the code :-)
> make sure we don't crash later. I've honestly never seen it trigger.
>
> -- Steve
