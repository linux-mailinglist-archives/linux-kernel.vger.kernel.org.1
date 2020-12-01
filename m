Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3012E2CAB8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgLATMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgLATMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:12:15 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D44C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:11:35 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id q22so2412668qkq.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ntCr/pSg4JSjFrxMtHG6/5C4LU/dmq+6fzeMtN2uAWo=;
        b=t0vLKiLJRvy0c0Nnj8o1sPgoGSFAC+rf0FMNPceESjE/RnamnVgF2DX8hdpQEFofd5
         qXUP1EhGMKMJBNp7SoJHwOkft/4/ztkAby1AQSO7Pl166Q1eIdtzUFezAyTQfIp8kQLU
         4SHUbR3m24HO8N7hfA0bVDJBeyVbV/l8NVfwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ntCr/pSg4JSjFrxMtHG6/5C4LU/dmq+6fzeMtN2uAWo=;
        b=THirxJfqgkZpoU39b5Ktxj0J9K2MLF5YsJevHUGgrHhPJF63iYZFPvmQ4TQNbD00g8
         kMBgxzelchlRgypgLSAFEacNJY5a5O9YR2D/+FjoPVFn1zs0tql0S4yzp/1HqmkbFAFT
         Iots/64M6uQyPX+Y3hBQGLRxPmKlzgTKsL2e3AIYbpzn9S6DvYic/FH6TXrgfcKaMeL0
         G4HHTwawwO5x6BNg7gR3XKiWLMECuC1fgq3PgF1YGcYcf1kBBflzSykzceFWpt81asMV
         PGJjAz8bviOXeXcoBoan3kQhhUFUqLkHqS80huXPz5FDLoDdeXHsoozvJ7buHsw8vm7m
         Uh1g==
X-Gm-Message-State: AOAM530QiHP3/IiX5R7+qK3lac9IziGchmeVsB34ZbR4aVmc0hsmb8L2
        cwM+gP1CLN8JGABKhJ8Poa46DA==
X-Google-Smtp-Source: ABdhPJz1K38BmdjVVwKV4VzTJ1WBU1g5hFGcYHPnBKILBTTVgyF0kGSrYv+ZOzpAXXzQtccijUsMFg==
X-Received: by 2002:a37:614b:: with SMTP id v72mr4470028qkb.355.1606849894348;
        Tue, 01 Dec 2020 11:11:34 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id u20sm435358qtw.88.2020.12.01.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:11:33 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:11:33 -0500
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
Message-ID: <20201201191133.GA221478@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125111541.GU2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125111541.GU2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:15:41PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> 
> > +/*
> > + * Ensure that the task has been requeued. The stopper ensures that the task cannot
> > + * be migrated to a different CPU while its core scheduler queue state is being updated.
> > + * It also makes sure to requeue a task if it was running actively on another CPU.
> > + */
> > +static int sched_core_task_join_stopper(void *data)
> > +{
> > +	struct sched_core_task_write_tag *tag = (struct sched_core_task_write_tag *)data;
> > +	int i;
> > +
> > +	for (i = 0; i < 2; i++)
> > +		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
> > +
> > +	return 0;
> > +}
> > +
> > +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
> > +{
> 
> > +	stop_machine(sched_core_task_join_stopper, (void *)&wr, NULL);
> 
> > +}
> 
> This is *REALLY* terrible...

I pulled this bit from your original patch. Are you concerned about the
stop_machine? Sharing a core is a slow path for our usecases (and as far as I
know, for everyone else's). We can probably do something different if that
requirement changes.

