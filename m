Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78D2CABAA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390414AbgLATVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLATVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:21:11 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:20:30 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id y197so2432289qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gvcwZazLD0aWAKt5JLN1s2XKk3UfdMLUwfX82KGCpdc=;
        b=bfmc4F3bJBRxByvRMIl9gd+rkjs6TtDwUM18GWNj438gxnj+hCHQ+kMwFsOAaXX4vG
         2k0D81n3Wmr77oEQ7hEul3u2CB0fk5ojNhqSXKdDltBWLxtuDjhdQbjE6JTcYJ2colwr
         b22aqiGhYZxUz6sCIax5poabt31HGpGLAh0Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gvcwZazLD0aWAKt5JLN1s2XKk3UfdMLUwfX82KGCpdc=;
        b=oOwFsBcKRPUCYOpaBCTP4PMWW5EpRbgYghkvCmtQ8d2OWSKX4ajM+25niaPAiaR+Co
         MMQoq99BqnQC3vFbKYdXw5Aw8qb+1L5yFI6f4XrBqKqIJA60K9HgjlOqU0tHTF93kKnh
         4MX2vbAxldJAegbOrh7GU/D1UQF9NTVOl2hdIGEW6lb5KBmY1Juj++hRxCn1YKxt2oRa
         Kg/TxC5q2NwYbteEHiNdh/UWrxxdgGyvsW5WbZtY42J0P+uZ3op5KkZFb4kfFjAbM1vf
         EYO0D5MHXI9CMiqfIGhV60oXL7QMldXsGLaVv51XEGs8IkB4HRRpMTh8RLU6ajw5W8xc
         88aQ==
X-Gm-Message-State: AOAM531zJnEevZiCqkuvPzON+viNbV0hzwzZxbGjpdAgGx9uDg4Iy3ij
        3IWMREE4KwN58wlPvR5BEmdKaA==
X-Google-Smtp-Source: ABdhPJzwbOe8E+Uznc9xPQrSMQbb4FFttEb5t0m2JjTri9dELFAbozAPQBOAFaSknCrL/tuhEpiejw==
X-Received: by 2002:a05:620a:7c9:: with SMTP id 9mr4523205qkb.329.1606850430139;
        Tue, 01 Dec 2020 11:20:30 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 72sm624596qkn.44.2020.12.01.11.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:20:29 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:20:28 -0500
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
Subject: Re: [PATCH -tip 22/32] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201201192028.GA222419@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125111014.GS2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125111014.GS2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:10:14PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> > +void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool group)
> > +{
> > +	if (!p)
> > +		return;
> > +
> > +	if (group)
> > +		p->core_group_cookie = cookie;
> > +	else
> > +		p->core_task_cookie = cookie;
> > +
> > +	/* Use up half of the cookie's bits for task cookie and remaining for group cookie. */
> > +	p->core_cookie = (p->core_task_cookie <<
> > +				(sizeof(unsigned long) * 4)) + p->core_group_cookie;
> 
> This seems dangerous; afaict there is nothing that prevents cookie
> collision.

This is fixed in a later patch by Josh "sched: Refactor core cookie into
struct" where we are having independent fields for each type of cookie.

I'll squash it next time I post to prevent confusion. Thanks,

 - Joel

