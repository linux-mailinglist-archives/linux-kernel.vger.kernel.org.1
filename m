Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A992CAAEA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392307AbgLASjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbgLASjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:39:15 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D064C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:38:35 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id n9so1326822qvp.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=spbeJrYokZ4Y9gd+VUqvGSeszDzVDW8TLup0VduoFa4=;
        b=wG+rshCludoC3+pPQIORQBUsVYLwBiM92Y9aSc80oBzfU6xLHThKui6WG29QRZeLpy
         6tpTg+wdqPt8fTAosTT1Gyyj1eYP77PeKLDnok2qsjatn2wMx4KbBsX5Qincrj12H6Eb
         EerjombU1XJ5VHX9TP2pYSs/GepdTOAwCg1G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=spbeJrYokZ4Y9gd+VUqvGSeszDzVDW8TLup0VduoFa4=;
        b=YkUK3yoexji9DxZhl2TZ44mLOy//TB7PAUBb1Ye2fNPz2TE9STjA+POLdJu3k0Vlkr
         +tSlvBnJF4+x+93MQ5zq1EDTKP8dKwYNJWCIqkQbPifOHWv8TvB4I7b6J+CrbW8ds7vU
         Uw1tfYhs75+n0Vrr//Ewa9mMjv2fNanZXmUl55l/tfk2YXh5RHW8mlD9IK0UJb2InwS+
         B3tjnKriNbe0zM4z+YfOoA1zpMnCb/eCzUA4LeAJwze4teqru4s8rLUBUiX0+XU2/Hk/
         IqT0ylbeDQYFEHP9XBRgVKwRvAmN2y9v92/AmCYtNtBX5sjphvxE0i9Zs/fRgHkE+Xs0
         euBg==
X-Gm-Message-State: AOAM532umHvXxNa4L6t/z9ucwXoTw8UJvF9ibwCca3cUtpval3TJI/Oc
        GHjrZ+NTN7wkD2ms0PQTDOt/pg==
X-Google-Smtp-Source: ABdhPJwo3rOwNH9qnKp5Re475p+Gdst1fA4g6+X7rFdG4OqklCLSX4jt9nKcnE3h6uarTioeEcTazA==
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr4495835qvd.27.1606847902210;
        Tue, 01 Dec 2020 10:38:22 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 8sm394322qkd.131.2020.12.01.10.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:38:21 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:38:21 -0500
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
Message-ID: <20201201183821.GA211031@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125125447.GV2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125125447.GV2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 01:54:47PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> > +/* Per-task interface */
> > +static unsigned long sched_core_alloc_task_cookie(void)
> > +{
> > +	struct sched_core_cookie *ptr =
> > +		kmalloc(sizeof(struct sched_core_cookie), GFP_KERNEL);
> > +
> > +	if (!ptr)
> > +		return 0;
> > +	refcount_set(&ptr->refcnt, 1);
> > +
> > +	/*
> > +	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
> > +	 * is done after the stopper runs.
> > +	 */
> > +	sched_core_get();
> > +	return (unsigned long)ptr;
> > +}
> > +
> > +static bool sched_core_get_task_cookie(unsigned long cookie)
> > +{
> > +	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
> > +
> > +	/*
> > +	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
> > +	 * is done after the stopper runs.
> > +	 */
> > +	sched_core_get();
> > +	return refcount_inc_not_zero(&ptr->refcnt);
> > +}
> > +
> > +static void sched_core_put_task_cookie(unsigned long cookie)
> > +{
> > +	struct sched_core_cookie *ptr = (struct sched_core_cookie *)cookie;
> > +
> > +	if (refcount_dec_and_test(&ptr->refcnt))
> > +		kfree(ptr);
> > +}
> 
> > +	/*
> > +	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
> > +	 *       sched_core_put_task_cookie(). However, sched_core_put() is done
> > +	 *       by this function *after* the stopper removes the tasks from the
> > +	 *       core queue, and not before. This is just to play it safe.
> > +	 */
> 
> So for no reason what so ever you've made the code more difficult?

You're right, I could just do sched_core_get() in the caller. I changed it as in
the diff below:

---8<-----------------------

diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
index 800c0f8bacfc..75e2edb53a48 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -274,6 +274,7 @@ void sched_core_change_group(struct task_struct *p, struct task_group *new_tg)
 /* Per-task interface: Used by fork(2) and prctl(2). */
 static void sched_core_put_cookie_work(struct work_struct *ws);
 
+/* Caller has to call sched_core_get() if non-zero value is returned. */
 static unsigned long sched_core_alloc_task_cookie(void)
 {
 	struct sched_core_task_cookie *ck =
@@ -284,11 +285,6 @@ static unsigned long sched_core_alloc_task_cookie(void)
 	refcount_set(&ck->refcnt, 1);
 	INIT_WORK(&ck->work, sched_core_put_cookie_work);
 
-	/*
-	 * NOTE: sched_core_put() is not done by put_task_cookie(). Instead, it
-	 * is done after the stopper runs.
-	 */
-	sched_core_get();
 	return (unsigned long)ck;
 }
 
@@ -354,12 +350,6 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 
 	mutex_lock(&sched_core_tasks_mutex);
 
-	/*
-	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
-	 *       sched_core_put_task_cookie(). However, sched_core_put() is done
-	 *       by this function *after* the stopper removes the tasks from the
-	 *       core queue, and not before. This is just to play it safe.
-	 */
 	if (!t2) {
 		if (t1->core_task_cookie) {
 			sched_core_put_task_cookie(t1->core_task_cookie);
@@ -370,7 +360,9 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 		/* Assign a unique per-task cookie solely for t1. */
 
 		cookie = sched_core_alloc_task_cookie();
-		if (!cookie)
+		if (cookie)
+			sched_core_get();
+		else
 			goto out_unlock;
 
 		if (t1->core_task_cookie) {
@@ -401,7 +393,9 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 
 		/* CASE 1. */
 		cookie = sched_core_alloc_task_cookie();
-		if (!cookie)
+		if (cookie)
+			sched_core_get();
+		else
 			goto out_unlock;
 
 		/* Add another reference for the other task. */
