Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09662CAB18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgLASxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLASxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:53:35 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD97C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:52:55 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b144so2314589qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2kmg+QjxBvdm0BOUNryItSDLgqhYSL+859ntkFtN5nM=;
        b=AruuQ0AoxNhKjczbBu4NbTMh85geFZglg+a/+xCO3Jq7wl8Gt0ocRvBnFMsoqdq/LO
         QXaIo853JKTem2nq/Elyz3wSMLIroe4YHTGAjt4/jy9O6b4JEEqgSfL3HylVgn++mhqW
         i1t0elNlaCas6aH4JG3g3POWC4hEUOm9eaDTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2kmg+QjxBvdm0BOUNryItSDLgqhYSL+859ntkFtN5nM=;
        b=DZ4cwEaRmKXTNtHGgezLH5JM8ZeXFwUmfAXddlPbSEL67UA/kB8dqZGcSfMwNLDztV
         IC/sim3LW03O6dWKYO47UEFqfko870wlZleSwCxSbBqgpD35VEpg9HMqzo/zDmsZ9Iu+
         lJH7NFqMCiIVSeIShwcUIy8o6scNFBlk3SGJKYmUYySCfm7b/hSBXohndLtVyuEy8vML
         mBVnIOqWUT6GjUNhwrL5yrLiT2qX5kDBWDzVYDNAJw6jnBehdE3+ojrpaQ3vzwZE5RGk
         /0MXIOOZsFuHCFOcVG45lPw35J9afBKQhVtDIfcO8vW8721ZISeRm2+Y0kLao5r8++Lo
         plkQ==
X-Gm-Message-State: AOAM53167YPE2lgcDOmeN9WOQu0PdfJOGf+woiemsaukcZRxKcxuMNZx
        LtpYZVIMOfmywTpazKP4+oG7jg==
X-Google-Smtp-Source: ABdhPJzV1i0K4BsQShaN2kSA/cyhwuh0alka6zeDzJOYMp4JhgVlyOJh+Hz+j7hdCT2d1z+bKx/HRQ==
X-Received: by 2002:a37:6287:: with SMTP id w129mr4394225qkb.261.1606848774354;
        Tue, 01 Dec 2020 10:52:54 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id a13sm456420qtj.69.2020.12.01.10.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:52:53 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:52:53 -0500
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
Message-ID: <20201201185253.GA215200@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125130322.GW2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125130322.GW2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 02:03:22PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
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
> 
> See below, but afaict this should be refcount_inc().

Fully agreed with all these. Updated with diff as below. Will test further
and post next version soon. Thanks!

---8<-----------------------

diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
index 2fb5544a4a18..8fce3f4b7cae 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -288,12 +288,12 @@ static unsigned long sched_core_alloc_task_cookie(void)
 	return (unsigned long)ck;
 }
 
-static bool sched_core_get_task_cookie(unsigned long cookie)
+static void sched_core_get_task_cookie(unsigned long cookie)
 {
 	struct sched_core_task_cookie *ptr =
 		(struct sched_core_task_cookie *)cookie;
 
-	return refcount_inc_not_zero(&ptr->refcnt);
+	refcount_inc(&ptr->refcnt);
 }
 
 static void sched_core_put_task_cookie(unsigned long cookie)
@@ -392,10 +392,7 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 		sched_core_get(); /* For the alloc. */
 
 		/* Add another reference for the other task. */
-		if (!sched_core_get_task_cookie(cookie)) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
+		sched_core_get_task_cookie(cookie);
 		sched_core_get(); /* For the other task. */
 
 		wr.tasks[0] = t1;
@@ -411,10 +408,7 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 
 	} else if (!t1->core_task_cookie && t2->core_task_cookie) {
 		/* CASE 3. */
-		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
+		sched_core_get_task_cookie(t2->core_task_cookie);
 		sched_core_get();
 
 		wr.tasks[0] = t1;
@@ -422,10 +416,7 @@ int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
 
 	} else {
 		/* CASE 4. */
-		if (!sched_core_get_task_cookie(t2->core_task_cookie)) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
+		sched_core_get_task_cookie(t2->core_task_cookie);
 		sched_core_get();
 
 		sched_core_put_task_cookie(t1->core_task_cookie);
-- 
2.29.2.454.gaff20da3a2-goog

