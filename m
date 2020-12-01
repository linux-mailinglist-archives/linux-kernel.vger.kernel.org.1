Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6142CAC80
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392422AbgLAThN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLAThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:37:12 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512A4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:36:32 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id y11so1411589qvu.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hNZMHtCuZ+zg70LmwAEupxaHE1lRjI7+oyWV0t26jrg=;
        b=UlEcIybmDlIoueI+4Lnu4CGs/T4GAQ5wKzh3J8ltJKyU5Dg3XpaxB5ucl51QOFdiSK
         x6Q0fRKUDgS0VRqgIrVz4a4fjxrMrce+Xx9DAdiLNn8BiA91VeCR0O6ewrAyyRG/wcrQ
         bg73YiX208SeDx/56Xak4/dHFAWd7cc4LDlAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hNZMHtCuZ+zg70LmwAEupxaHE1lRjI7+oyWV0t26jrg=;
        b=aeZZIWbVP21hTJRGIHEXxRaIW57lZN/Vw2BWtViRGu6hBvZOwzCvU1qEeOaZLueHCS
         bG5B33njjyygJmFmJ0uvHAFP2eSsP7KaEOjNI+Qawa5Q5Efy9qnlxovINP6lPLaV2/RW
         1S08CzXxzPFmJqCIkGT4o+EuGKvoIK0PxZcGxnqzNqlxVWgIXv/fw5UvdlgNgV633sBb
         Omt34BsgVjEw1mbrgq3KCG4ojf9V+1O91Mf+T+gcJOV1ukhQlj3PEjT6RwJWm3c9T0iA
         e2GtzxiOcESBkBGYtHSdvJJOsN2/KDlez39mSBsUZK3Z/Z342VXZyRWxajkQqxDj/Q0+
         3DJw==
X-Gm-Message-State: AOAM531LXwfXZSQKhUiauWknojbNFXHlublXpQE5Wl/Qq9YgjecA6VP4
        NeJoVsBHQGEn53F95BBCFZoP6Q==
X-Google-Smtp-Source: ABdhPJyquDScWgcbdBQerlNeAsyZ+k3xJXAVh68Ing78pVLtN9/kHORLTPLrqoC3f9ygrWfH23EUxw==
X-Received: by 2002:a05:6214:3a9:: with SMTP id m9mr4750124qvy.1.1606851391402;
        Tue, 01 Dec 2020 11:36:31 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id e10sm540172qkn.126.2020.12.01.11.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:36:30 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:36:30 -0500
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
Subject: Re: [PATCH -tip 23/32] sched: Add a per-thread core scheduling
 interface
Message-ID: <20201201193630.GA223927@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-24-joel@joelfernandes.org>
 <20201125130808.GY2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125130808.GY2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:08:08PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:53PM -0500, Joel Fernandes (Google) wrote:
> > +/* Called from prctl interface: PR_SCHED_CORE_SHARE */
> > +int sched_core_share_pid(pid_t pid)
> > +{
> > +	struct task_struct *task;
> > +	int err;
> > +
> > +	if (pid == 0) { /* Recent current task's cookie. */
> > +		/* Resetting a cookie requires privileges. */
> > +		if (current->core_task_cookie)
> > +			if (!capable(CAP_SYS_ADMIN))
> > +				return -EPERM;
> 
> Coding-Style fail.
> 
> Also, why?!? I realize it is true for your case, because hardware fail.
> But in general this just isn't true. This wants to be some configurable
> policy.

True. I think me and you discussed eons ago though that it needs to
privileged.  For our case, actually we use seccomp so we don't let
untrusted task set a cookie anyway, let alone reset it. We do it before we
enter the seccomp sandbox. So we don't really need this security check here.

Since you dislike this part of the patch, I am Ok with just dropping it as
below:

---8<-----------------------

diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
index 8fce3f4b7cae..9b587a1245f5 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -443,11 +443,7 @@ int sched_core_share_pid(pid_t pid)
 	struct task_struct *task;
 	int err;
 
-	if (pid == 0) { /* Recent current task's cookie. */
-		/* Resetting a cookie requires privileges. */
-		if (current->core_task_cookie)
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
+	if (!pid) { /* Reset current task's cookie. */
 		task = NULL;
 	} else {
 		rcu_read_lock();
