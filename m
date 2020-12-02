Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56D12CB51A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgLBGhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgLBGhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:37:11 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443EAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 22:36:31 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z3so334292qtw.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 22:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j14UEcKmJgy4lNmxfpEAdBtZK/nOSuRQd1wQuM4Od1E=;
        b=RTD0vff3lrnnpN6BMiGm5i+HzyAIgWqLaUkwzRpoxkxqdNqpAKL9yXe7H3uG/tFSPX
         Qe6xvPqvTAYKBy5t3STMzHOrpMsPIpVNWDyuSpMCQnWMK6rRwHoS1jwsJpA78NXye3KD
         5gKiqcDtkWDZt5coGI/T3Cj5o2pvO++q6tbw02ozfOD2+M5ZcGHF2VwVLzfGJmmkQ4K+
         ESm+aYByF1KmN77hvFSOHgrgtUieyZo7otkH6jaTrbHT0NJYlmIFfewmszqvEWY6ytgM
         lCPDseK9C+FnZx3AVtPLiK1CGpYPm6VKaPrQnuiIgFPjVaxuO/9pUnXkhnrDO48/aN9J
         iI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j14UEcKmJgy4lNmxfpEAdBtZK/nOSuRQd1wQuM4Od1E=;
        b=RHjs8kGOTP7sXHDyIpp9AfXwbE3xZPdMwUS/l32dcGa4ykN+G4QUWDjticHrTMsOCZ
         RqIxufODfCHnkduCiooCNTtBltF+pMpoqsdzRBYD3PMH8PJFV1SzHdvIz10n44yLnQCp
         vwOA9ZSXDI6FvmW/EBJiKQiVFospMcIgMHuc4Yc15U2q9TAhPf5uzJHa3JlvOc2whZAo
         NnjuBtNlelEjJZNgYMw0wXPJhwL2w9yILyohjcFnDZEJGmoMUIwbqU7k/azStCMYmIWp
         h8lZewg3cIa1FxIqDIHm98Sexx9m1jqJcxclH9ULZpCC+ZBUrUqBBhUrGJ56e5m9e8Ls
         GH2g==
X-Gm-Message-State: AOAM532ZXnIDmZmbKppiP6CPvWOiJHE3XDOXjzWE4VyXliwvgXIrp4G7
        4qB+COMSyOtSpJVxQyWjpUC3Kura/gJdphmR6fvovw==
X-Google-Smtp-Source: ABdhPJyx7mhAlH9ykexLKzfMMkrAV88ELd0GrlglUU10reKQp9IBbN7i8yP4OYHXj0xCe+qex6SdVx8YbguEsU1sCgc=
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr1154850qtw.293.1606890990020;
 Tue, 01 Dec 2020 22:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org> <20201125111014.GS2414@hirez.programming.kicks-ass.net>
 <20201201192028.GA222419@google.com> <20201201193451.GY3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20201201193451.GY3040@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 1 Dec 2020 22:36:18 -0800
Message-ID: <CABk29NvoymPokXpoLkFZPDXDM0DoCVOJNTy9qVVQsaTgcBcJNg@mail.gmail.com>
Subject: Re: [PATCH -tip 22/32] sched: Split the cookie and setup per-task
 cookie on fork
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>, chris.hyser@oracle.com,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Oleg Rombakh <olegrom@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So I don't think that later patch is right... That is, it works, but
> afaict it's massive overkill.
>
>         COOKIE_CMP_RETURN(task_cookie);
>         COOKIE_CMP_RETURN(group_cookie);
>         COOKIE_CMP_RETURN(color);
>
> So if task_cookie matches, we consider group_cookie, if that matches we
> consider color.
>
> Now, afaict that's semantically exactly the same as just using the
> narrowest cookie. That is, use the task cookie if there is, and then,
> walking the cgroup hierarchy (up) pick the first cgroup cookie.
>
> (I don't understand the color thing, but lets have that discussion in
> that subthread)
>
> Which means you only need a single active cookie field.
>
> IOW, you're just making things complicated and expensive.
>

For the per-task interface, I believe we still want to prevent two
tasks that share a task cookie from sharing an overall cookie if they
are in two separately tagged groups (Joel please correct me if I'm
mistaken there). That's why in Joel's older patch, the overall cookie
was a combination of the task and group cookies.  My concern about
that was the potential cookie collision.

I followed up on the 'color' portion in the other thread.

Thanks,
Josh
