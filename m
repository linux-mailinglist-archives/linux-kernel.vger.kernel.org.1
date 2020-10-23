Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291C9297642
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbgJWR51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbgJWR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:57:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D26C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:57:26 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id de3so1111284qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+JxUy2GzdZMt7Q+iclaVOAYK8LG1kSIynwbO5JGpQtw=;
        b=IfyuZyHQUSZF54cxePIo+EYiT8WqQLlcDVR/WgupdQWUTciWs4l/nyezKQcZsM+RZw
         NDbC1uc1OsP79IzK2TcM7lc1Ls7rx1tcFc3yaPr1681HDUngev1KcdyKC+XnbB1ZXEqI
         zeHUSUpwDX5zBWKyclODe+UVn+Rs6Rm0XUxrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+JxUy2GzdZMt7Q+iclaVOAYK8LG1kSIynwbO5JGpQtw=;
        b=S8JMmKbS73QAYTQdEX5sf24ZawxV6Svie9wCsxsDC9HhoSG8syHwWxyypmAuGffbm7
         3qH38P913wMOLPSCMqoJcZLW+vNti4Hi2ObuzTMG2TWM5aN5a5sqEavozXzYaO06JD2i
         /IQ2rQoFlFD59VerZaZmMUL1iqM3wxaaB5S9bzPtmxGO9vWOnzHfnv4mVikEUFiwSuVL
         EDrhLFQg2a0mtt0FZPBVQqwHxhfjGCDkKNNggLXBV3yxic4igOZOc71JiTDeHIHXCz6a
         FmDgaEOxuo5npk45wlRllJT9w+VhS47wrCX2dUieUDAj+wSwRBLW+gG1aLg6/szooCgV
         osXw==
X-Gm-Message-State: AOAM531rkWeQs3N/4CdRGMOoATTqk99388VHlWwBgCwrTc2/NLZBSacS
        CtGrU7i4gJPMScgv7hB7V47uZw==
X-Google-Smtp-Source: ABdhPJyBgnsf0H7F+UybCjNc9BOLL/fcT9QjCvIde7QzsFPAyynBlrbOVseoHr/JOv//LWnmpvjqVg==
X-Received: by 2002:a0c:ba85:: with SMTP id x5mr3482644qvf.7.1603475845975;
        Fri, 23 Oct 2020 10:57:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id h125sm1229414qkc.36.2020.10.23.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:57:25 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:57:24 -0400
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
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 06/26] sched: Add core wide task selection and
 scheduling.
Message-ID: <20201023175724.GA3563800@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
 <20201023135400.GA2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023135400.GA2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 03:54:00PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 23, 2020 at 03:51:29PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 19, 2020 at 09:43:16PM -0400, Joel Fernandes (Google) wrote:
> > > +			/*
> > > +			 * If this sibling doesn't yet have a suitable task to
> > > +			 * run; ask for the most elegible task, given the
> > > +			 * highest priority task already selected for this
> > > +			 * core.
> > > +			 */
> > > +			p = pick_task(rq_i, class, max);
> > > +			if (!p) {
> > > +				/*
> > > +				 * If there weren't no cookies; we don't need to
> > > +				 * bother with the other siblings.
> > > +				 * If the rest of the core is not running a tagged
> > > +				 * task, i.e.  need_sync == 0, and the current CPU
> > > +				 * which called into the schedule() loop does not
> > > +				 * have any tasks for this class, skip selecting for
> > > +				 * other siblings since there's no point. We don't skip
> > > +				 * for RT/DL because that could make CFS force-idle RT.
> > > +				 */
> > > +				if (i == cpu && !need_sync && class == &fair_sched_class)
> > > +					goto next_class;
> > > +
> > > +				continue;
> > > +			}
> > 
> > I'm failing to understand the class == &fair_sched_class bit.

The last line in the comment explains it "We don't skip for RT/DL because
that could make CFS force-idle RT.".

Even if need_sync == false, we need to go look at other CPUs (non-local
CPUs) to see if they could be running RT.

Say the RQs in a particular core look like this:
Let CFS1 and CFS2 be 2 tagged CFS tags. Let RT1 be an untagged RT task.

rq0	       rq1
CFS1 (tagged)  RT1 (not tag)
CFS2 (tagged)

Say schedule() runs on rq0. Now, it will enter the above loop and
pick_task(RT) will return NULL for 'p'. It will enter the above if() block
and see that need_sync == false and will skip RT entirely.

The end result of the selection will be (say prio(CFS1) > prio(CFS2)):
rq0		rq1
CFS1		IDLE

When it should have selected:
rq0		r1
IDLE		RT

I saw this issue on real-world usecases in ChromeOS where an RT task gets
constantly force-idled and breaks RT. The "class == &fair_sched_class" bit
cures it.

> > > +                          * for RT/DL because that could make CFS force-idle RT.
> > IIRC the condition is such that the core doesn't have a cookie (we don't
> > need to sync the threads) so we'll only do a pick for our local CPU.
> > 
> > That should be invariant of class.
> 
> That is; it should be the exact counterpart of this bit:
> 
> > +			/*
> > +			 * Optimize the 'normal' case where there aren't any
> > +			 * cookies and we don't need to sync up.
> > +			 */
> > +			if (i == cpu && !need_sync && !p->core_cookie) {
> > +				next = p;
> > +				goto done;
> > +			}
> 
> If there is no task found in this class, try the next class, if there
> is, we done.

That's Ok. But we cannot skip RT class on other CPUs.

thanks,

 - Joel

