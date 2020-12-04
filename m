Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B022CE469
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgLDAVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLDAVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:21:15 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB3C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 16:20:34 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 62so1962557qva.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 16:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6cHrD+hDcDbuThecWmZmMZN5skYLKJ6DKcVcZzyV+Y=;
        b=aXVHLdNXp+dDWXUJIior7k8202+QFoR3nFZHHXuVH4ygxjquHKbOO3nqqAnPpwSdoO
         wx2Upp7S4R542wkAR4SQDVHNtLDwNWWdb7zr0Ror0X0mUMhBKqypSgLOVBWZ9ztrH4v6
         Jl/4W0dCv5KDFcT66pU8/gd5XhdiBu9uU+BQvHFNj14/2p1zpFhP55u+iePzk2i0J38k
         j5jOmCXCK3uQ3gAlGnouWTnC4ZE/CkvL1c3nBUMfjh1tVR0ttuAqA1K05dTJK2cDqT1V
         gMzyu16hQs2C5IYUaa3kdWaUYS0yB8R1waunQXcxgfDM+mwVxt9ZGfPj0oCMrEIcSgrh
         geEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6cHrD+hDcDbuThecWmZmMZN5skYLKJ6DKcVcZzyV+Y=;
        b=Xa/Ndd+HT6zDgz+NambvYytylYE8SubZWxr90DqhxmOST04M7OodCRqS3kV7NdLXYW
         acOLlxoPxJB1o28At9rrQxC38droTAJZVxI5DVDuyjhyBbZdPOb6EnUlElmWv6WmDPX+
         9Fs/365DKeMe/Gbi5Qc9Lh1uqBeNi9UtKWr69f0ZkSNjy3+gC8x5ykGDhU4s6Vqd4WJp
         dyYzDvoad7p7+eVoklgL1y4mDvy+Cce/Vw1+qkWM2u5+ZP+l4ObcbKY8K9QHgRo7bzmx
         bYbH+GMVhyajVB+pAvtA7DKntWoYMpaHaJQ9SbJooBy1I1k+g8LwbLG2jXipjPDfo4iO
         g0Vw==
X-Gm-Message-State: AOAM530jIUDd2vgZI2SaNsCFJoTzZVsr5mmic/umcfT1zLX6FS7SRN6v
        mLZ/GTtoYeSIgIjmre6/ByCoed+P15imNbwZ/whTBw==
X-Google-Smtp-Source: ABdhPJxGzD6wJLJ3mSxoGSfruXpVGZyIsv6rHjDY2mqSW0iSkKmo4nTXEf+7uidW5sZntNymdMWEUpzcYXjTbARHtTI=
X-Received: by 2002:ad4:4745:: with SMTP id c5mr2007040qvx.2.1607041233599;
 Thu, 03 Dec 2020 16:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org> <20201125111014.GS2414@hirez.programming.kicks-ass.net>
 <20201201192028.GA222419@google.com> <20201201193451.GY3040@hirez.programming.kicks-ass.net>
 <CABk29NvoymPokXpoLkFZPDXDM0DoCVOJNTy9qVVQsaTgcBcJNg@mail.gmail.com> <20201202075447.GC3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201202075447.GC3021@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 3 Dec 2020 16:20:22 -0800
Message-ID: <CABk29NtiM+1Etg82zh-vTynZLAyiOWtXA6gM6VZwP-f7yQf7cw@mail.gmail.com>
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

On Tue, Dec 1, 2020 at 11:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Then disallow sharing a task cookie when the tasks are in different
> cgroups or disallow cgroup movement when they share a cookie.

Yes, we could restrict task cookie sharing to tasks that are in the
same cgroup. Then the cookie easily just becomes a single value;
either the task cookie or group cookie.

The advantage of the approach with the cookie struct is that it is
easily extensible, and allows for trust models that don't conform
exactly to the cgroup hierarchy (ie. our discussion on cookie color).
The overhead of the approach seems tolerable, given that updates to a
task's cookie are not in fast paths (ie. prctl, setting cgroup cookie,
sched_move_task).  Are you more concerned with the added complexity of
maintaining the RB tree, refcounts, etc?
