Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9235F2CE49D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgLDAwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgLDAwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:52:35 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FBC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 16:51:54 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d5so2887361qtn.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 16:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCJpgZmnm7u2UzSgzFamkTMFrZoFYbYSyOFOjjq/gmM=;
        b=PEcpit1+ITdCBshasduZ4KTJ7+dygWh1eRTOJlYGKKQshaZtnqFC9aRwFujSdsiKKd
         4EtVxrTTpIc8FuEJlo4IH86vIQdqOHW2R9/tNiV3ZlrsdNoxQ8HY2o0FrvhWW3Gx1rms
         PWPefErPc3kBh8kV+iqCfh6Veo2Mg8/KGdJaIYhpvtgy+QP+IClGlIhHDfo4OE2+HF1v
         DZmHW1RdBmGzjjtsajdm+tbZpFtGs0fNQRaMARAwgPOLmfLeNJo8n/0yFAMKc6BxQTlt
         3Pw1+rYtmhH0MsHLbKlP3zmud+MNfnnMTduNKzdaC/tyVZ6L6WzoXE1BOSTaRNmrjS84
         V1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCJpgZmnm7u2UzSgzFamkTMFrZoFYbYSyOFOjjq/gmM=;
        b=WafGraQrp/n7061z08qBv0rU/cMugWtrzpc3aT98Nsv08GAYRRFAXnNnjTIc01Zk5m
         RJQemebk82uEmSVas815NZ7ivoH/Dk+6Ew/Z/40XR9c1ywkXUfriy5+i29qRBY/sux5R
         C0SnlcqBJAbWQPGdY3Tl//8uTbnG0INPMPAm8mEZfQ4urvS20IrjGYKW4z3WfCxwin2t
         sOHu9el9/ELekxPzl5f2XeDtlBY6u4THoge1GJSxFnpM7hLC/gXltgZSNb0+HJr/2YPT
         +uyrknKh104RqhUKHQxnMfQsuELk6V0/p1FMr0UcG65Qmlmxl/bSZ6U12N8lU3oSAAzJ
         /GnA==
X-Gm-Message-State: AOAM531GvOdBmk3xa8Zmm59x0I3b7SWLOXJboSdX0k5fSGRJ5B+KPPt9
        WPvdD/e5FsPvWk90wzFQxrBxnapmaCkEYw3Hg/AUyQ==
X-Google-Smtp-Source: ABdhPJw5xin+lmW0k7HmspvOK0xJY6gAT4MUdksz6Q5taOKYlsIkDWN2K9lVekPs4sUmxJZ6/HGN2htyxNLduuScGV8=
X-Received: by 2002:ac8:67da:: with SMTP id r26mr6231554qtp.101.1607043113656;
 Thu, 03 Dec 2020 16:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-27-joel@joelfernandes.org> <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
 <CABk29Nv7+nD1oU9iBhAFAuFoiPM5i7eCOtuG7vuQVcE8+Va=nw@mail.gmail.com> <20201202080211.GD3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201202080211.GD3021@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 3 Dec 2020 16:51:42 -0800
Message-ID: <CABk29Ns-QWGV+XpN8TJ5CL50jhrpqKAhfoOfaPSCjiFq7S7j1Q@mail.gmail.com>
Subject: Re: [PATCH -tip 26/32] sched: Add a second-level tag for nested
 CGroup usecase
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        Oleg Rombakh <olegrom@google.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 12:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 01, 2020 at 10:18:00PM -0800, Josh Don wrote:
> > Hey Peter,
> >
> > On Wed, Nov 25, 2020 at 5:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Why can't the above work by setting 'tag' (that's a terrible name, why
> > > does that still live) in CDE? Have the most specific tag live. Same with
> > > that thread stuff.
> >
> > The motivation is to allow an unprivileged user the ability to
> > configure the trust hierarchy in a way that otherwise wouldn't be
> > possible for a given cgroup hierarchy.  For example given a cookie'd
> > hierarchy such as:
> >
> >       A
> >    /  |  |   \
> > B  C  D  E
> >
> > the user might only want subsets of {B, C, D, E} to share.  For
> > instance, the user might only want {B,C} and {D, E} to share.  One way
> > to solve this would be to allow the user to write the group cookie
> > directly.  However, this interface would need to be restricted to
> > privileged users, since otherwise the cookie could be configured to
> > share with any arbitrary cgroup.  The purpose of the 'color' field is
> > to expose a portion of the cookie that can be modified by a
> > non-privileged user in order to achieve this sharing goal.
> >
> > If this doesn't seem like a useful case, I'm happy to drop this patch
> > from the series to unblock it.
>
> Well, the traditional cgroup way of doing that would be to:
>
>          A
>         / \
>        T1 T2
>       / \
>      B   C
>
> And tag T1 if you want B,C to share.
>
> So me the color thing reads like an end-run around the cgroup hierarchy.

Restructuring the cgroup resource hierarchy to incorporate the trust
domains is not necessarily trivial (as is the case for us).  I agree
though that that would be the ideal correct solution from the cgroup
hierarchy perspective.
