Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05552B8C43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKSHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgKSHYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:24:52 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:24:52 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 199so4465876qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJvxtkKdIZbJIrTjjcf776wJG723M+Fx0Qi+vbSWmSA=;
        b=m/H6PFwkb8nODNrDDXNAGXyXDeh2e2LJ9H6mDokTkLYq+krvuO3acvJwuHyef6fGtG
         yo45erauXgbhNYosQ72rPLkAyOcr8mZ0k/EYN9dHzjb3K/MEUb6F7VZgSt9PQqE3WoH2
         J/mDzO6MroIRLnRAkplJxCnqkbgjnvw7P0uk2rpaUPJTivIPxKuTB/GL2fLkSB/l9gu4
         pq043302UQQpOdXTYNDeBoQKx7hcZqcurD+WXWcrQc8GIqgKCFhBdnvVWNEfN7cnO7xS
         TCJOaeuxUyTUgNsNdJzjQB/clD8fJIS1abhxSigDpeLb6lfnpWRRbk1fXk5FD7kVEgS1
         xmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJvxtkKdIZbJIrTjjcf776wJG723M+Fx0Qi+vbSWmSA=;
        b=U6+1eQQZ4SLJJgWBu8jfy12ofqm2aKWgnjLvewZ+9j+TKt8RZIemYcYUg0uHBPHGRQ
         KtOBgqM6qm2VvDxn7cuVrsFf334Pgwsdr9WthQQ3g0ts5UJ2d+G5nS1k7cmMpFYVhB5R
         20oNFA4PaXklLJysDsSUgpu8ChhjqfjMcCHkw9axblLv+tnj5WqTtBAe3xgaCcyiiBU1
         5vAj/i9l7pmlbBwVW2o1dVZ5SgEEutiTXy5Uq9TIHOymS8QRUxiM2SabDwXYs1n1yxDX
         +HUgNNezkzpnqc3X1nuPlpcEZTAumk2pb0/OYQQ31saQgUgDUVBHs2s45ERVxqQ76p5k
         JxAw==
X-Gm-Message-State: AOAM532kMe5C00lzQFZOqm0vBEC78OtfevqIr3On+nzx7pwgnPsT+Yv0
        hBi/gAJHW0SNOeV7xngVh33ulNa58EW13AgvD+AH9dcqkNhhiA==
X-Google-Smtp-Source: ABdhPJw4WlvKAxa6w1Ko4cuKVKlJz9aqZQEqSLIOMhLRB96UUQC0kWFnBCZkuecnCiuVlzFZ4cIfNv75cjq7kXTrBGE=
X-Received: by 2002:a37:49d6:: with SMTP id w205mr9852750qka.501.1605770691430;
 Wed, 18 Nov 2020 23:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20201116023846.awjtbzh2o2yj4fvn@mozz.bu.edu> <CACT4Y+bh_QfSNVKVE=zODNKL5_8RLdcLf-j2ky0FJE_1hUi_hw@mail.gmail.com>
 <CAAeHK+wxupr3kqnr69QphciLLp13+A_7CgU+o_J7xBBxnRdbMg@mail.gmail.com> <20201118022036.dpi36duvtnwnuj2o@mozz.bu.edu>
In-Reply-To: <20201118022036.dpi36duvtnwnuj2o@mozz.bu.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Nov 2020 08:24:40 +0100
Message-ID: <CACT4Y+a-D2bhzrgtMaR_J+j_db72BjDxE+yFCQY_cnNawqtMrQ@mail.gmail.com>
Subject: Re: Collecting both remote and "local" coverage with KCOV
To:     Alexander Bulekov <alxndr@bu.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 3:21 AM Alexander Bulekov <alxndr@bu.edu> wrote:
>
> On 201116 1805, Andrey Konovalov wrote:
> > On Mon, Nov 16, 2020 at 9:35 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Mon, Nov 16, 2020 at 3:39 AM Alexander Bulekov <alxndr@bu.edu> wrote:
> > > >
> > > > Hello,
> > > > I'm trying to collect coverage over the syscalls issued by my process,
> > > > as well as the kthreads spawned as a result of these syscalls
> > > > (eg coverage over vhost ioctls and the worker kthread). Is there a way
> > > > to collect coverage with both KCOV_REMOTE_ENABLE(with common_handle) and
> > > > KCOV_ENABLE, simultaneously?
> > > >
> > > > Based on the code it seems that these two modes are mutually
> > > > exclusive within a single task, but I don't think this is mentioned in
> > > > the Documentation, so I want to make sure I'm not missing something.
> > >
> > > Hi Alex,
> > >
> > > Yes, it's probably not supported within a single task. The easiest way
> > > to verify is to try it ;)
> > >
> > > It is possible to collect both coverages, but you will need 2 threads
> > > (one just to set up remote KCOV).
> > >
> > > Unless I am missing any fundamental limitations, I would say it would
> > > be reasonable to support this within a single task as well.
> >
> > I think the reason we did that initially, is because we don't care
> > about normal coverage for USB emitting pseudo-syscalls. Filed a bug
> > for this: https://bugzilla.kernel.org/show_bug.cgi?id=210225
>
> I'm interested in adding support for this. Looking through the code, I
> can think of ~two approaches:
>
> 1.) Allow the same kcov fd to be used to track coverage with both
> KCOV_REMOTE_ENABLE and KCOV_ENABLE. If we try to use the same coverage
> bitmap for both the remote and the local coverage, I think the local
> part would have to deal with the kcov_remote_lock. If the local part
> continues to write directly into the user-space coverage-area, as it
> does now, it seems it would require locking for each __sanitizer_cov
> call.  Alternatively, the local and the remote parts could write into
> different coverage-bitmaps, but I'm not sure if there is a neat way to
> do this.

This has 2 problems:
 - performance (__sanitizer_cov is by far the most performance
critical part of kernel with KCOV=y)
 - recurions, locks are also traced, so it's not that we really can
call anything there

> 2.) Allow multiple kcov fds to be used by the same task. In the task,
> keep a linked-list of pointers to kcov objects (remote or local). For
> each __sanitizer_... call, walk the linked list and check if any of the
> kcov objects match the requirements (trace_cmp/trace_pc/remote). This
> would also have the side-effect of enabling simultaneous PC and CMP
> tracing. Of course, it seems that this would add some overhead (in the
> case of a single open fd, there would be extra pointer dereferences to
> get the area[], size, etc).

Walking linked list in __sanitizer_... has the same performance
problems, but I think we don't really need to do it.
Assuming we have at most 1 KCOV that traces the task itself we can
continue keeping it cached in task_struct:
https://elixir.bootlin.com/linux/v5.10-rc4/source/include/linux/sched.h#L1254
and __sanitizer_... will continue using these fields.

For the kcov pointer in task struct:
https://elixir.bootlin.com/linux/v5.10-rc4/source/include/linux/sched.h#L1257
we either have a linked list, or 1 pointer for local tracking and a
separate list for remote kcov's:
struct kcov *kcov; // local tracing
struct kcov *remote_kcovs; // remote tracing, can be more than 1
Whichever is better I am not sure, it seems that some functions would
benefit from a single list (KCOV_DISABLE), while others would benefit
from separate fields (KCOV_ENABLE).
Maybe the simplest code will be if we use both approaches -- put all
kcov's into a list, but also cache the local kcov into a separate
field? Then KCOV_DISABLE could just walk the list, but KCOV_ENABLE can
continue checking 1 field.
