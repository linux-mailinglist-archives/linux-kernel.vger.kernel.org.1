Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F012A3ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKCC6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCC6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:58:25 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2EC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 18:58:25 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id j31so4033865qtb.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U2xA/HbRLOw6XHbQShoDURGuCQGP53e4B3r3tAPxBhc=;
        b=NQJKCGR+JEkHQSKkv7ubbyXluSkHQEghx4RroMjj77gKv8NRELT7NfOVbEnF7ScWci
         Lh27Hc1LmzBiKu+ArA49vakhSf1jkKX++kbh4CPBTm3hnvFesJtzS+UvzvoAwZoipgJt
         Ox2GzmICjsivL/JM7kMe5GVC7eSOn2CvcjlM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U2xA/HbRLOw6XHbQShoDURGuCQGP53e4B3r3tAPxBhc=;
        b=UytnoiayWd1NdWm/wKdOm9HjzCF1LMOBVCgy0lnaYu9T48A5B4+fcTPyWbcHOUnXPz
         ShnsyMpKvFmyyenzvZsNKyFsAPIE6T9gbDIQpwIaExZ0gQ1gmfkeYkSE5Lc9osDSaoZ5
         q5UDkKi8W94mVHGSJu8PwrhR2UFVXnV7Sdez7UAiiLXaHwN4Mj5K3e0xbojfh6jNeiGZ
         j092lMKis5vrZKg/0gpj0irnRxa4j16gtQEUxGPI7bZ1MltT9HkrAcKEyWH4zPD+iIWt
         ecyvZP7enUI9HPcZ3kv81qostwxlcmZsK2haqpTxE4HGYH3DjNS2dzDNAF0CeRDwJQ4d
         wl3Q==
X-Gm-Message-State: AOAM530MgxcT9Mnt+4gsrNgTzsUS8xKm+aEN87EtP1a5I9t1d4SP+lB6
        Bc8uu14EmpmEGaDlpVNtpqVD3Q==
X-Google-Smtp-Source: ABdhPJzunUemKQ3YZnJ9g6CD2L3Ry/1psqXBKVbehwNoeAOv4xrSD4NfcaRn6MA2A0+nG5tQOw1ghg==
X-Received: by 2002:ac8:459b:: with SMTP id l27mr7538167qtn.282.1604372304175;
        Mon, 02 Nov 2020 18:58:24 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x6sm9094735qti.77.2020.11.02.18.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:58:23 -0800 (PST)
Date:   Mon, 2 Nov 2020 21:58:22 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        chris.hyser@oracle.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 24/26] sched: Move core-scheduler interfacing
 code to a new file
Message-ID: <20201103025822.GA693892@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-25-joel@joelfernandes.org>
 <c7466b5d-9850-9eff-3e67-f0cb1b578cc3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7466b5d-9850-9eff-3e67-f0cb1b578cc3@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 09:05:52AM +0800, Li, Aubrey wrote:
[..]
> > +int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
> > +{
> > +	struct sched_core_task_write_tag wr = {}; /* for stop machine. */
> > +	bool sched_core_put_after_stopper = false;
> > +	unsigned long cookie;
> > +	int ret = -ENOMEM;
> > +
> > +	mutex_lock(&sched_core_tasks_mutex);
> > +
> > +	/*
> > +	 * NOTE: sched_core_get() is done by sched_core_alloc_task_cookie() or
> > +	 *       sched_core_put_task_cookie(). However, sched_core_put() is done
> > +	 *       by this function *after* the stopper removes the tasks from the
> > +	 *       core queue, and not before. This is just to play it safe.
> > +	 */
> > +	if (t2 == NULL) {
> > +		if (t1->core_task_cookie) {
> > +			sched_core_put_task_cookie(t1->core_task_cookie);
> > +			sched_core_put_after_stopper = true;
> > +			wr.tasks[0] = t1; /* Keep wr.cookies[0] reset for t1. */
> > +		}
> > +	} else if (t1 == t2) {
> > +		/* Assign a unique per-task cookie solely for t1. */
> > +
> > +		cookie = sched_core_alloc_task_cookie();
> > +		if (!cookie)
> > +			goto out_unlock;
> > +
> > +		if (t1->core_task_cookie) {
> > +			sched_core_put_task_cookie(t1->core_task_cookie);
> > +			sched_core_put_after_stopper = true;
> > +		}
> > +		wr.tasks[0] = t1;
> > +		wr.cookies[0] = cookie;
> > +	} else
> > +	/*
> > +	 * 		t1		joining		t2
> > +	 * CASE 1:
> > +	 * before	0				0
> > +	 * after	new cookie			new cookie
> > +	 *
> > +	 * CASE 2:
> > +	 * before	X (non-zero)			0
> > +	 * after	0				0
> > +	 *
> > +	 * CASE 3:
> > +	 * before	0				X (non-zero)
> > +	 * after	X				X
> > +	 *
> > +	 * CASE 4:
> > +	 * before	Y (non-zero)			X (non-zero)
> > +	 * after	X				X
> > +	 */
> > +	if (!t1->core_task_cookie && !t2->core_task_cookie) {
> > +		/* CASE 1. */
> > +		cookie = sched_core_alloc_task_cookie();
> > +		if (!cookie)
> > +			goto out_unlock;
> > +
> > +		/* Add another reference for the other task. */
> > +		if (!sched_core_get_task_cookie(cookie)) {
> > +			return -EINVAL;
> 
> ret = -EINVAL; mutex is not released otherwise... 

Good find and will fix.

Minor suggestion: Could you truncate your emails when replying?

thanks,

 - Joel

