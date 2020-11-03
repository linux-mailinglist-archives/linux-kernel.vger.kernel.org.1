Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39DBE2A3AAE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgKCCyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgKCCyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:54:22 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3C2C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 18:54:22 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id a64so10156440qkc.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v4tYR4zVFE27wjWJx5mUbwrxvuP8uO6s0qs8bS7gdug=;
        b=ELW25Rwt4ROd+BEn29Q55Jl/v74VGbe0DbVyy3Y+1bYEQm2gAS+yl82Pt2wJY9eLI/
         eN56pkGIfTiNSZh1sJgvZ5ICabcBcsGIhKsNlw6Cv1O4ON0HwYzekqP5j1lRVUWpiFS7
         AetFmq7SkEIfE/JHTSWHYZkRWRJUMwFwEtWBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v4tYR4zVFE27wjWJx5mUbwrxvuP8uO6s0qs8bS7gdug=;
        b=Ol+C+BQbdKLUoYgEHtwwOh7WRYlf/ftHdnGJpfOcm07kbti6K9I0hh3OSFUt8i0N6v
         YUCIfRc/3lRY0sKrkr04OKKRH2Tz8N2Eh85I/RkllgP429ImKB2120CN5XBWT7LSs/ae
         R/dyNzjovmK1SO85SKzCBXpZnNCmP1iA5yYbgD4U9TgA/U8umDo6qyt4B97E2tz5BezG
         qDdPgFf/nhOYtjVK2bUOL9NqCSfauyT7ErExdnKlEdjxCIWidOufGkJge2hVO1vmWYJk
         3gjc1Y9tDVrWx3A8g283oZLyxXcZJ9uCj4hYrP/+oSRga5F8+Pm8aPiO0X6Gq9nsh270
         1IEg==
X-Gm-Message-State: AOAM533i0xYyWD/e3BgE2KznOxok1ficsSSlMU/08O1T89WYPX13gPZK
        RbT+bUbu3KbiP55DCRZix0q6EQ==
X-Google-Smtp-Source: ABdhPJxBxq70XgHfvIXuzTnKk4YWXm4ujjlvmoHjuXtaqcVWKCibBvDu+DV24FU1TkTYgpvdvsfMpg==
X-Received: by 2002:a37:98c:: with SMTP id 134mr4556825qkj.339.1604372061627;
        Mon, 02 Nov 2020 18:54:21 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g78sm3266687qke.88.2020.11.02.18.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:54:20 -0800 (PST)
Date:   Mon, 2 Nov 2020 21:54:20 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Josh Don <joshdon@google.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
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
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>, chris.hyser@oracle.com,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Benjamin Segall <bsegall@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH v8 -tip 19/26] sched: Add a second-level tag for nested
 CGroup usecase
Message-ID: <20201103025420.GA692757@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-20-joel@joelfernandes.org>
 <CABk29NsgPcpOpDzixKtdkK85H1xq2XHXHUm6B96nS-4zKzpRwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NsgPcpOpDzixKtdkK85H1xq2XHXHUm6B96nS-4zKzpRwg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 05:42:12PM -0700, Josh Don wrote:
> On Mon, Oct 19, 2020 at 6:45 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > +static unsigned long cpu_core_get_group_cookie(struct task_group *tg)
> > +{
> > +       unsigned long color = 0;
> > +
> > +       if (!tg)
> > +               return 0;
> > +
> > +       for (; tg; tg = tg->parent) {
> > +               if (tg->core_tag_color) {
> > +                       WARN_ON_ONCE(color);
> > +                       color = tg->core_tag_color;
> > +               }
> > +
> > +               if (tg->core_tagged) {
> > +                       unsigned long cookie = ((unsigned long)tg << 8) | color;
> > +                       cookie &= (1UL << (sizeof(unsigned long) * 4)) - 1;
> > +                       return cookie;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> 
> I'm a bit wary of how core_task_cookie and core_group_cookie are
> truncated to the lower half of their bits and combined into the
> overall core_cookie.  Now that core_group_cookie is further losing 8
> bits to color, that leaves (in the case of 32 bit unsigned long) only
> 8 bits to uniquely identify the group contribution to the cookie.
> 
> Also, I agree that 256 colors is likely adequate, but it would be nice
> to avoid this restriction.
> 
> I'd like to propose the following alternative, which involves creating
> a new struct to represent the core cookie:
> 
> struct core_cookie {
>   unsigned long task_cookie;
>   unsigned long group_cookie;
>   unsigned long color;
>   /* can be further extended with arbitrary fields */
> 
>   struct rb_node node;
>   refcount_t;
> };
> 
> struct rb_root core_cookies; /* (sorted), all active core_cookies */
> seqlock_t core_cookies_lock; /* protects against removal/addition to
> core_cookies */
> 
> struct task_struct {
>   ...
>   unsigned long core_cookie; /* (struct core_cookie *) */
> }
> 
> A given task stores the address of a core_cookie struct in its
> core_cookie field.  When we reconfigure a task's
> color/task_cookie/group_cookie, we can first look for an existing
> core_cookie that matches those settings, or create a new one.

Josh,

This sounds good to me.

Just to mention one thing, for stuff like the following, you'll have to write
functions that can do greater-than, less-than operations, etc.

static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
{
	if (a->core_cookie < b->core_cookie)
		return true;

	if (a->core_cookie > b->core_cookie)
		return false;

And pretty much everywhere you do null-checks on core_cookie, or access
core_cookie for any other reasons.

Also there's kselftests that need trivial modifications to pass with the new
changes you propose.

Looking forward to the patch to do the improvement and thanks.

thanks,

 - Joel


> > More information about attacks:
> > For MDS, it is possible for syscalls, IRQ and softirq handlers to leak
> > data to either host or guest attackers. For L1TF, it is possible to leak
> > to guest attackers. There is no possible mitigation involving flushing
> > of buffers to avoid this since the execution of attacker and victims
> > happen concurrently on 2 or more HTs.
> > 
> > Cc: Julien Desfossez <jdesfossez@digitalocean.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Aaron Lu <aaron.lwe@gmail.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@intel.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Co-developed-by: Vineeth Pillai <viremana@linux.microsoft.com>
> > Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >   .../admin-guide/kernel-parameters.txt         |   7 +
> >   include/linux/entry-common.h                  |   2 +-
> >   include/linux/sched.h                         |  12 +
> >   kernel/entry/common.c                         |  25 +-
> >   kernel/sched/core.c                           | 229 ++++++++++++++++++
> >   kernel/sched/sched.h                          |   3 +
> >   6 files changed, 275 insertions(+), 3 deletions(-)
> >
The issue is with code like this:

