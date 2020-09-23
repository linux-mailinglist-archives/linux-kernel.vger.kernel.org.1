Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EFB275DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIWQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWQlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:41:00 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE2C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:40:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so15345487pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u26ETgHdMj6kI9HjFylSBAFJfoyLr2qc9o6DaGmIgsM=;
        b=GCCpqjt+xCbzlLZm3di8051exilcDeoMNjhg6RzrzuYxfdNlVC4DPmq2osvs2nhbLg
         AVRWcnVKfcl3Eye/39tHmojENyd1FmiUCjKmndh9bpgXv3htMg7P8L7aA9sA7CC65tRo
         IN7Np/U5aImgIeLco+W+JBJluAsjacIk3aitKdLycM3M7MmutRZQniczFhRcbOeTpzTJ
         Ew6PPkr5IDicU5nhpFFZt0BPsn+OkCPo4NU4foVMPTCCWV3rRr87fg+ctwjw1s3w18z2
         ki5Oflv/oO/zrwiHCZgDVCukeIXRMYee45HZJhZstbJScUiboCOOXKJfayY6Gdv1ZgKm
         lkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u26ETgHdMj6kI9HjFylSBAFJfoyLr2qc9o6DaGmIgsM=;
        b=ln82oYi5/SzrcuCdG9yKIF08TH8REBs7ZdyAJ3UxyoOMktDww14F5eiSTbOxY6no0t
         JnAtU8GDLoiZyyBGrU5ez3JRoZIg4ejgcgqfqIY92N/JYi7HG6JBATv8d/rENgU1Y0Wa
         1PBbmysrAjCdTYwadCJYjbiMwf/s4ZhYZZREEMiRbIFXyQ2vqd8vgfjAxQn/yu5bfLGp
         dCELhNddewdZ09qCbQyEFdqV66afD0NAaaWIQMRU+J8jTM0Y4mVyhdX2tItLvQkpm93Z
         RMJHSWIVDOU1M8tpFHgNgXQkHcEXv6NjEH03FB1v0EAPdxNBbnEEAlFR3Po5T5RoErl5
         9XrQ==
X-Gm-Message-State: AOAM530H3+AVjD7lIX0ek3WSaVDE9s/N2JwnHjKU5fzQud7rfZHzdDsd
        fCW5n+AxeAk7qFdElcg+xGPMJVKCSJVkP/NxopdizQ==
X-Google-Smtp-Source: ABdhPJyifYPt6VI6ck9zLGf+I19aMcVsmGBwJEnK5WAIIs8oiQmwI9vuLma09GDug/1Ia9XnhvlJ7Jtw2DDqRwyUAX8=
X-Received: by 2002:a62:2985:0:b029:142:2501:34d6 with SMTP id
 p127-20020a6229850000b0290142250134d6mr581517pfp.47.1600879259125; Wed, 23
 Sep 2020 09:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200917181347.1359365-1-axelrasmussen@google.com>
 <CALOAHbDSHGeXjJN3E5mTOAFTVsXAvQL9+nSYTqht5Lz8HRNv0A@mail.gmail.com>
 <CAJHvVcg6eY0vVtfi8D6D9aus7=5zeP2H7Yc0mY5ofXztSzOFqQ@mail.gmail.com>
 <CALOAHbBr=ASfvHw1ZscWBE=CY-e7sBrLV0F5Ow=g1UGxmQsWcw@mail.gmail.com>
 <20200922125113.12ef1e03@gandalf.local.home> <CALOAHbD2qgvd7CHy6ZFJ_h8drtRWEU=E-hPofY-TuGTNfxyQbw@mail.gmail.com>
 <20200923120924.49638d90@oasis.local.home>
In-Reply-To: <20200923120924.49638d90@oasis.local.home>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 23 Sep 2020 09:40:23 -0700
Message-ID: <CAJHvVcgmJYZS=+g2_V7Bkx3fVGVZEytdpQDQgxu2nEe3qJh2OQ@mail.gmail.com>
Subject: Re: [PATCH] mmap_lock: add tracepoints around lock acquisition
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 9:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 23 Sep 2020 18:04:17 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > What you can do, and what we have done is the following:
> > >
> > > (see include/linux/page_ref.h)
> > >
> > >
> > > #ifdef CONFIG_TRACING
> > > extern struct tracepoint __tracepoint_mmap_lock_start_locking;
> > > extern struct tracepoint __tracepoint_mmap_lock_acquire_returned;
> > >
> > > #define mmap_lock_tracepoint_active(t) static_key_false(&(__tracepoint_mmap_lock_##t).key)
> > >
> > > #else
> > > #define mmap_lock_tracepoint_active(t) false
> > > #endif
> > >
> > > static inline void mmap_write_lock(struct mm_struct *mm)
> > > {
> > >         if (mmap_lock_tracepoint_active(start_locking))
> > >                 mmap_lock_start_trace_wrapper();
> > >         down_write(&mm->mmap_lock);
> > >         if (mmap_lock_tracepoint_active(acquire_returned))
> > >                 mmap_lock_acquire_trace_wrapper();
> > > }
> > >
> > >
> > > -- Steve
> >
> >
> > Great!
> >
> > Thanks Steve.
>
> If the above becomes useful, I may just add helper functions into a
> header file that you can include. Perhaps call it: tracepoint_active()
> and you need to pass in as an argument the name of the tracepoint.

Thanks for this suggestion Steven, it's working quite well.

I also have a very short patch to the tracing which allows plumbing
the string values through to "just work".

I plan to send out a v2 before the end of the week.

>
> -- Steve
