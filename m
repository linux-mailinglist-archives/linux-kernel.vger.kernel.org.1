Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE46D2C186D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbgKWWbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgKWWbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:31:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:31:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id m9so15603477pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPnDLVKj+DPxr083osv3zXyPFQhs54KxYx09xwb42ic=;
        b=Tefczu192j63TB+7ma9/BNgcAY6j9leOp+37CRRI6fsbIk55o21Ow3NcCKAu4YC9rH
         BCrWf621SzFcBHdxIezBsjUq6+F/Ux9wCQjZPHEIiC30qkMBA08nbrvpqEJPzdD53CtA
         k3YLuHhV79QFhdqTSirKsFOpWQM/5Ciq6vxqIXm956hkiffWHyLvS53JTIfl/i/+2LE9
         8sxTIkgtjy/xu9xBz0Q8uFpCV4/CXnlkVNl5VS+RJ5VTk+GoOEl8KnrGv2/YxM4VFkzf
         yzfPL8EBs8tja7OeVvZ2B/0YQs2+VrdJLlwOSAWay4+gVtQQdCjhdqLa2/XFVC+k7pFn
         +cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPnDLVKj+DPxr083osv3zXyPFQhs54KxYx09xwb42ic=;
        b=Ll/CThe2bQlfDhbUpSAYHNqWiF8IuAXWRvEkd58w033fiq3SufWaKj8Szw22bQH5u/
         czNZlFBPHC/kWFireJAyiA8DOgy4uyi+vR/wYtPFkFgOjBtJZT8/LoaUw2WoBT5daMnF
         tigf+Iy2icwkTTwK89K7UDvaOnlS7Rn/YrtfwpO5qhC83Ap5vXiN84oJeZxs0wJ84qNy
         VAaAu1rqH9cLoHZZVBiId6K3HjOj+kHJa7PlXoyReEIzfecsk2y5oWzJBfvify9/dffG
         8JE32FAWPnkS9jkkwuEiTdv/TrHM+cSpkgdYFeA8q6Uz6U/9d6G0Og8XU1JtKGBRb70e
         8yQg==
X-Gm-Message-State: AOAM531a49CiuP3TzRcY11GxmRDS8lRzcr0+JQLezrInNXxy96NnjElF
        XS3BEiJecTFUK9P9fKsVhzU=
X-Google-Smtp-Source: ABdhPJwohrQvFjAf+gh8SwbyGSafFGxJCurXWvinLI1+RHCdGLuMbPbi2a4gvIU5vsTtUao52JHuIw==
X-Received: by 2002:a63:ea04:: with SMTP id c4mr1320558pgi.412.1606170667676;
        Mon, 23 Nov 2020 14:31:07 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id j69sm4190739pfd.37.2020.11.23.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:31:05 -0800 (PST)
Date:   Tue, 24 Nov 2020 09:31:02 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: Re: [PATCH -tip 03/32] sched/fair: Fix pick_task_fair crashes due to
 empty rbtree
Message-ID: <20201123223102.GA8893@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-4-joel@joelfernandes.org>
 <cab6918c-7b52-923c-4274-f92e9f0a5cd2@gmail.com>
 <caa77c3c-dc21-5c64-8236-d9e7d4c90995@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa77c3c-dc21-5c64-8236-d9e7d4c90995@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:11:06PM -0500, Vineeth Pillai wrote:
> Hi Balbir,
> 
> On 11/20/20 5:15 AM, Singh, Balbir wrote:
> > On 18/11/20 10:19 am, Joel Fernandes (Google) wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > pick_next_entity() is passed curr == NULL during core-scheduling. Due to
> > > this, if the rbtree is empty, the 'left' variable is set to NULL within
> > > the function. This can cause crashes within the function.
> > > 
> > > This is not an issue if put_prev_task() is invoked on the currently
> > > running task before calling pick_next_entity(). However, in core
> > > scheduling, it is possible that a sibling CPU picks for another RQ in
> > > the core, via pick_task_fair(). This remote sibling would not get any
> > > opportunities to do a put_prev_task().
> > > 
> > > Fix it by refactoring pick_task_fair() such that pick_next_entity() is
> > > called with the cfs_rq->curr. This will prevent pick_next_entity() from
> > > crashing if its rbtree is empty.
> > > 
> > > Also this fixes another possible bug where update_curr() would not be
> > > called on the cfs_rq hierarchy if the rbtree is empty. This could effect
> > > cross-cpu comparison of vruntime.
> > > 
> > It is not clear from the changelog as to what does put_prev_task() do to prevent
> > the crash from occuring? Why did we pass NULL as curr in the first place to
> > pick_next_entity?
> A little more context on this crash in v8 is here:
> https://lwn.net/ml/linux-kernel/8230ada7-839f-2335-9a55-b09f6a813e91@linux.microsoft.com/
> 
> The issue here arises from the fact that, we try to pick task for a
> sibling while sibling is running a task. Running tasks are not in the
> cfs_rq and pick_next_entity can return NULL if there is only one cfs
> task in the cfs_rq. This would not happen normally because
> put_prev_task is called before pick_task and put_prev_task adds the
> task back to cfs_rq. But for coresched, pick_task is called on a
> remote sibling's cfs_rq without calling put_prev_task and this can
> lead to pick_next_entity returning NULL.
> 
> The initial logic of passing NULL would work fine as long as we call
> put_prev_task before calling pick_task_fair. But for coresched, we
> call pick_task_fair on siblings while the task is running and would
> not be able to call put_prev_task. So this refactor of the code fixes
> the crash by explicitly passing curr.
> 
> Hope this clarifies..
>

Yes, it does!

Thanks,
Balbir Singh.
