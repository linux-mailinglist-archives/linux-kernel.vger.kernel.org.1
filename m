Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9378A28E392
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgJNPsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgJNPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:48:19 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41236C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:48:19 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so5816233ioo.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWBbGofnbem7vN+9grXySFR9YOMo5GiSFkt1UyxFN+s=;
        b=e9g3yz2hjPHV0wHGPrm3cnB3QRN+F8ZbXcutLipifJdmzqdLZisA7PmuFnTj6MIjqA
         XMSsOdJGpotAi1rwTVYiZpBA3rsOXpS/N1BbIFHMv6zmgVkp3jusgsJm0jzsrzgS8Cpa
         hSoQuVhKpmWe9FRDfzXtqj7o8L02V4UayPbZ2lY6AmhGP6gt60eMyY5LLMXmmfTxxPdc
         KiSS8X7Dz/YA1jbcrADe/FH8fl3MC5RPfzg0DO99b8tbvF7avLfEh2e6ODT4vZkTp9+l
         cwpT2/Vy8qJ2wZ0phOxIb6EpH/yk+GsmVKiIBzTa6m9ucu4MuQrFvhUm4o02dtnlyC79
         FD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWBbGofnbem7vN+9grXySFR9YOMo5GiSFkt1UyxFN+s=;
        b=O0fiQatomZRA3f8dWSiMchV/E+8B69mF1tJV9eVgADlRgGCXLpE2WU+4nH9nn73O8+
         +elHS4kdaJ+5clsKZeh8Fa2xRhriPan5kAOvm1vT3vuRV5EUGTNE0MeOgfMTT5jc4h0q
         5LsqxFYAYVVXRINvCjvNP094jV1JZ4ovQB3A7Udz9136jA8AvBQQ6LuK2/8AN5euKeO3
         lkkZajfzsE6URCi3YZAEYPfm2fqSEcDQgMA9hQt8V9kYUfA79oHMrfOXgFUbgvdFUYqX
         eJSTLPYz194MKEyWvpvseQchpDGS3DL+529vd3ekc0nmHJ9+Fw7vJC4S3bivFzwhIqJ4
         OJMQ==
X-Gm-Message-State: AOAM5315g8+2/lCXNTaoaCT0mXMAOGLpIvjM919HAvWuguX3H/H3hDR0
        XsRSAmP//10AHdGF/bk/EOrUXqx0/amh19iBFHQ=
X-Google-Smtp-Source: ABdhPJyPsNGnHQ5bO09KsmFRSt+C02FbttZcI+y1mlloBhlXYQUMy4UnhY8jw9xB6efFVvRNTOackB+ksEU+u47AZqo=
X-Received: by 2002:a6b:9243:: with SMTP id u64mr3268208iod.197.1602690498597;
 Wed, 14 Oct 2020 08:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201014151614.29804-1-hqjagain@gmail.com> <20201014113823.4296521d@gandalf.local.home>
In-Reply-To: <20201014113823.4296521d@gandalf.local.home>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Wed, 14 Oct 2020 23:48:05 +0800
Message-ID: <CAJRQjodMzSAJd23F=RRhR=d2H=D3vWMvCbU9JYdGNQ9MTkpmmw@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Add rb_check_bpage in __rb_allocate_pages
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 11:38 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 14 Oct 2020 23:16:14 +0800
> Qiujun Huang <hqjagain@gmail.com> wrote:
>
> > It may be better to check each page is aligned by 4 bytes. The 2
> > least significant bits of the address will be used as flags.
> >
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  kernel/trace/ring_buffer.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 93ef0ab6ea20..9dec7d58b177 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1420,7 +1420,8 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
> >       return 0;
> >  }
> >
> > -static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
> > +static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> > +             long nr_pages, struct list_head *pages, int cpu)
> >  {
> >       struct buffer_page *bpage, *tmp;
> >       bool user_thread = current->mm != NULL;
> > @@ -1464,6 +1465,8 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
> >               if (!bpage)
> >                       goto free_pages;
> >
> > +             rb_check_bpage(cpu_buffer, bpage);
> > +
> >
>
> Why add it here, and not just add this check to the scan in
> rb_check_pages()?

rb_head_page_deactivate() in rb_check_pages() will clear the 2 LSB first.

>
> -- Steve
