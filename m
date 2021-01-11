Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F322F1BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbhAKRKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbhAKRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:10:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74231C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:09:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w5so495066wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 09:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBhiCRQ/hU8nUHPJqyu8ucV/q20tb78qZ9F6AUF5dl0=;
        b=vdETX3AzAhGWS4XOn4U/L5M8mWyOcAW598aRM+jUl5TPCH8XLNK0r4mVzlinVSegPT
         0Bshyv5uEO/Ch6Nc/L2gE6yb/0cG4+1+4rLpSaMTsw8S88w6HqPfjfYYoHJeaXU0dtFB
         LSwEnYt0jq7sZi2yLNO4AMRS68Asn+Xp/feHXG1C9xN8lbjUrxRxRqvmjq7rIm7Nlt5s
         9eRuDUQcO76Ft46QvLZFpa8HqfhLIX5QUq1plsc+YbjGz5yX5iBust3IW1tRRDs9o5DC
         +2lG7OHbMB2mH26JeyxgT8EHYaJK/m38/CFtAQqDku9jlRIEJASEJbMMbpoXDvXm+cZh
         q6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBhiCRQ/hU8nUHPJqyu8ucV/q20tb78qZ9F6AUF5dl0=;
        b=dRHcEN/I3rzObVQ6EOZXIAkN2NKUqQNVZ1Lo51U8gIHZyXa/ZX75j3z5ZRKcikxG9w
         CpaJRD2jJCG2TaM2yQnOYIXRUAkAkrbKDWmxdHItY8eGca0qh5VnFeif0xBm3FsFtz6g
         zOs4k798zNtdfYgIutmHyhze79CFdsgltN3Vu1ZzqBKnCEnLM/qMwqqA3B3lQ66Sbrci
         scVWDPDiQ5ZTq1yB+2iaDeaI9sPKpyajnbgNyY1wSXYPrDzC59oY+JVUhzLZIUb0ic98
         n2/MliyzE+9gzLJAFm18EtWnML5Sgryp6s5n1adLF9Qg2ye3cINaXTxredo9ZVA/nkkB
         YObw==
X-Gm-Message-State: AOAM533mWfBhr+Z/Rp1I0KBoVaDg2HtHkBKmODr8/O6qj5FMhkkrtKQo
        7/1E/rTorgpWenz3Id1AfuK1QXJKibMmoApPUAAuiw==
X-Google-Smtp-Source: ABdhPJzkl/cTS0Y7f8oJDdXN6UMVH3mhUzOEeI3OG0cAZXbZU+ICVO+NCTcEQu9zCnNUV1pPl+AUmWRG5sI6Ed4lbf4=
X-Received: by 2002:a5d:4704:: with SMTP id y4mr120140wrq.358.1610384964099;
 Mon, 11 Jan 2021 09:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20210108205857.1471269-1-surenb@google.com> <875z43rd0u.fsf@oldenburg2.str.redhat.com>
 <CAJuCfpGwer93uKRE3nqtmLwsUnK_Cn-Zz1bXuFGX94mmVxqQZg@mail.gmail.com>
In-Reply-To: <CAJuCfpGwer93uKRE3nqtmLwsUnK_Cn-Zz1bXuFGX94mmVxqQZg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Jan 2021 09:09:13 -0800
Message-ID: <CAJuCfpHw8RKPPJFXt6sCmxDHKFvgKTJd_gJ4HV68BTWdTsvkeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 9:05 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Jan 11, 2021 at 2:20 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * Suren Baghdasaryan:
> >
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 6a660858784b..c2d600386902 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> > >               goto release_task;
> > >       }
> > >
> > > -     mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > > +     /* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> > > +     mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > >       if (IS_ERR_OR_NULL(mm)) {
> > >               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > >               goto release_task;
> > >       }
> >
> > Shouldn't this depend on the requested behavior?  Several operations
> > directly result in observable changes, and go beyond performance tuning.
>
> Thanks for the comment Florian.
> process_madvise supports only MADV_COLD and MADV_PAGEOUT hints which
> are both non-destructive (see process_madvise_behavior_valid()
> function). Maybe you meant something else by "observable changes", if
> so please clarify.
> Thanks,
> Suren.
>

V2 with Minchan's fix is posted at:
https://lore.kernel.org/lkml/20210111170622.2613577-1-surenb@google.com/T/#u

> >
> > Thanks,
> > Florian
> > --
> > Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
> > Commercial register: Amtsgericht Muenchen, HRB 153243,
> > Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
