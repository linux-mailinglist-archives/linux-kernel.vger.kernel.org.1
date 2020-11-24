Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5612C2DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390345AbgKXRHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgKXRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:07:46 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:07:46 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id y197so21288856qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aNXvn4/3k/XGywoP6C9b+pZ0yxAKPIO0oxQPosS4HbM=;
        b=iA9+PAPTrP4eD0qcD8/sTZZ34g/wH3oACYjBdIASYZcCxL49ZUOofi0apyQp7Z0qfY
         G2OjvCROWNo0t0oFvMyA0licDrxsoTLCk5mgrVipL3MtWghrB+s8QDfwuS1s4WudA8KZ
         vT7P7ZnMB2jy/vAlGlvggc3aYgkfSWsquagCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aNXvn4/3k/XGywoP6C9b+pZ0yxAKPIO0oxQPosS4HbM=;
        b=Fg9w+HUoUWgXPDMBvoas+TBntedM7MGmrr7hB6nak4Tqz6gYU1qeMTgM69uPIFFf9Z
         espQzN0tf1lE69aHlp4kRDDVsOY+KVo8gHmqgn6vg0JPu27O5ULdw7uth1MhmvkZn/gb
         SX7821vHLV1e4kG5i9Abbdj4v3WBvuAy4IQq5TKnn0AR+/YdIfm/My6gj00EmhSkmkih
         WBnudcDw/IT4xAAC7EklBvh2SyyOqtyb+iHwKmelEeA+9ciXAX93ymw3yeu52Ewicj3h
         OVyf2yRT2Oxtz0S5nQOU6ElhNeIJ+A0n5H6USGX3uilfchLIfogZPlocTjMoT19fn1EY
         CxXg==
X-Gm-Message-State: AOAM530l0YuLOhzoI26yQ5TwoO3zIJtiJJaxN/hjdJSze61/b+zjFUJj
        /JOaOFT90XGUZdFzxWWGS4wV2w==
X-Google-Smtp-Source: ABdhPJx2meuls0roa8BOeAtgpkESmOYElu8i+vto2kzhW0faz+N3ss8u4ZdB6w6wKM7CdZBd8yQlRg==
X-Received: by 2002:ae9:c211:: with SMTP id j17mr5759635qkg.458.1606237665494;
        Tue, 24 Nov 2020 09:07:45 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t56sm12686345qth.27.2020.11.24.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:07:44 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:07:44 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 15/32] sched: Improve snapshotting of min_vruntime
 for CGroups
Message-ID: <20201124170744.GD1021337@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-16-joel@joelfernandes.org>
 <20201124102741.GW3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124102741.GW3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Nov 24, 2020 at 11:27:41AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:45PM -0500, Joel Fernandes (Google) wrote:
> > A previous patch improved cross-cpu vruntime comparison opertations in
> > pick_next_task(). Improve it further for tasks in CGroups.
> > 
> > In particular, for cross-CPU comparisons, we were previously going to
> > the root-level se(s) for both the task being compared. That was strange.
> > This patch instead finds the se(s) for both tasks that have the same
> > parent (which may be different from root).
> > 
> > A note about the min_vruntime snapshot and force idling:
> > Abbreviations: fi: force-idled now? ; fib: force-idled before?
> > During selection:
> > When we're not fi, we need to update snapshot.
> > when we're fi and we were not fi, we must update snapshot.
> > When we're fi and we were already fi, we must not update snapshot.
> > 
> > Which gives:
> >         fib     fi      update?
> >         0       0       1
> >         0       1       1
> >         1       0       1
> >         1       1       0
> > So the min_vruntime snapshot needs to be updated when: !(fib && fi).
> > 
> > Also, the cfs_prio_less() function needs to be aware of whether the core
> > is in force idle or not, since it will be use this information to know
> > whether to advance a cfs_rq's min_vruntime_fi in the hierarchy. So pass
> > this information along via pick_task() -> prio_less().
> 
> Hurmph.. so I'm tempted to smash a bunch of patches together.
> 
>  2 <- 3 (already done - bisection crashes are daft)
>  6 <- 11
>  7 <- {10, 12}
>  9 <- 15
> 
> I'm thinking that would result in an easier to read series, or do we
> want to preserve this history?
> 
> (fwiw, I pulled 15 before 13,14, as I think that makes more sense
> anyway).

Either way would be Ok with me, I would suggest retaining the history though
so that the details in the changelog are preserved of the issues we faced,
and in the future we can refer back to them.

thanks,

 - Joel

