Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132782F18BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbhAKOxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbhAKOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:53:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76CDC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:52:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b26so38091825lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cd6LNDxb/T9C1tLnPAcNFBbsDxBB86SlYkicnzgmtiM=;
        b=eekP684iX5CvLUERIXRscg4JnyfKVUUG1V3uTqG+OfSlkzQYDtBjzZxmY70hSmaRnF
         lcsJqS7i1/40jlCQRI3B6ILKMPhiMpygP6xVWlYgqDuNEG1wAE3gqv/w6ROL+9BmggS1
         KeJE4C5+trZTZ2sefsmhJrz0IGqR4cM1RO4dG+ybXV+Qt67n2dX1qo2uVTFk8Q6bB1Wx
         UOsUqFf1c9fFuDdHp3wZutQBgLzFOvnuqNkK1rDk7OkdVngm9WZ9OuhMt2GpuhSZBcQB
         rUNZq7rPGbUF278mTpqTd4iltctLnifik+B6WlkpQoRhPTefeCKUXJ2kC26aGxoVto4F
         Y50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cd6LNDxb/T9C1tLnPAcNFBbsDxBB86SlYkicnzgmtiM=;
        b=rwkkk4SVvp9FzQaBfKqkvAju4RJII//MY8d0ZKUquuIgprhf0tJ6r5fjB0ccDXIJRd
         hSEBeW96Ovgq3AISBGPsxs5ryWgT7kMGOp8bjuUOuFLid5IAh5n8/ppPvwISOSS7CSkx
         7Ux3rS+JGYyOoOYnxOe6WiXnflSlP7WDhyAY9SqSSa4toFSR8rJzj7nKczq5+0D5+EJC
         NGfrVTrhECSEe77IH5Z3Yn2V2zbHlsbOaQpTE0oSzW+qcYJDgJnntB5Clog52NgsIlqU
         sbzqr7k+Bk/TTlfv7G1P5szEZOGKsX5L/uMH4JHf8TLfyiTfNagn9aKvPEJyXMpWo8RO
         /nuQ==
X-Gm-Message-State: AOAM530VOMGyfIhERf+KfiGho9d8RIBGOXex80i4FQLWDDZTk1znj3FP
        z7dX2cy31U8dLFYn8kkfMQtShgaErTYpvo+uysmObg==
X-Google-Smtp-Source: ABdhPJwqYNOqgYlgvF45oWr3krJHjRAE8J81zBIM8vPYx2a1hRxAN4Vm40fHJ6vT5fV6YANBxHVnAU+76xBfaT9tyv4=
X-Received: by 2002:a19:7718:: with SMTP id s24mr7765819lfc.277.1610376749388;
 Mon, 11 Jan 2021 06:52:29 -0800 (PST)
MIME-Version: 1.0
References: <20201214164822.402812729@infradead.org> <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com> <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net> <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
 <20210108144058.GD3592@techsingularity.net> <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
 <X/i3TbRRS9chYb3l@hirez.programming.kicks-ass.net>
In-Reply-To: <X/i3TbRRS9chYb3l@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Jan 2021 15:52:18 +0100
Message-ID: <CAKfTPtCQyuf-ERcD=zxF-u1HJmVemSC4L4uSKOc35jr7Cf_MoQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost accounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 at 20:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 08, 2021 at 04:10:51PM +0100, Vincent Guittot wrote:
> > Another thing that worries me, is that we use the avg_idle of the
> > local cpu, which is obviously not idle otherwise it would have been
> > selected, to decide how much time we should spend on looking for
> > another idle CPU. I'm not sure that's the right metrics to use
> > especially with a possibly stalled value.
>
> The thinking was that if this CPU has little idle time, this CPU should
> not spend a lot of time searching...
>
> That is; if we spend more time looking for places to run, than we have
> idle time, we're loosing cycles we could've ran (supposedly useful) work.

I understand the rationale of looking at previous avg idle time to
decide how much time we can "waste" at looking at a cpu for the waking
task. The problem is that this value is "stalled" and it gives us an
idea of the duration of the next idle time but not really when the
next idle time will happen, which can be in several seconds from now.
And we can have already use this next avg_idle time for other wakeups
search

>
> The only counter argument is tail latency.
