Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927332D0678
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 19:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgLFSQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 13:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgLFSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 13:16:42 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B5C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 10:16:01 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id q22so10596691qkq.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pWt8FoKKtD8zIswPHKcwjwbCQY3F1WjvdUrvbkIp3CU=;
        b=QtjJ4tM3iv0tYKd7PP/EB7OaCVmztCmtmQS3OEMa5T+oLCL+pC/kU+0CXf+VgxViXG
         PsXpt+KpASm6QBNINE1CdbtOTVeg5hVtVU3LhIJfHd7+tN3lynwEuo5ymOiEyZi2525p
         ddHr4hjO6uGoiMdQa9TIqwnBvJ3QFbOOjyHXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pWt8FoKKtD8zIswPHKcwjwbCQY3F1WjvdUrvbkIp3CU=;
        b=G7qZUNnwW44RDb2mScGPGavWSpr9yas0fYITnJrDGP+EI0QUQMLa5GliQzo9rW0DaP
         hHAWkxrwxYLJD4A1fpVUgpgOSYp2+giMaaboWzuRMPup1Y4wLt6F7J78e/041AQvMz2n
         W52YnXttgH6d/eaICnxnjvRro6Z29bBJ8To2R7mbkT464XLK+/Az7B62nntr+Z3FV+rb
         iJG8EFAG4ZxHkQQ4MrJ7YnfmZn54qy+7hZ55/Dq6OKliYObJTZofDhtV4Oh0BxXzAXHi
         Ob66lT80Ki0OtkbPRjCddP4lPaqyNda93tqI6VOZlVRXN8ZFwiEhfwC4tTh0RI50dPTT
         v0ew==
X-Gm-Message-State: AOAM531OcNxsUyKaYqB5n4TJbZg7mfOoe/3r2ZX3sqnwlyCuycK3BJO+
        2WVD8IZe+KXIpkxApLyZUpnXRw==
X-Google-Smtp-Source: ABdhPJwltDlzLMWro5sdYyPqWp9LxJhu0N0GOo3kfCYKMfrewJkFlMxP9rv+d4oMSljemhR+XyWrbg==
X-Received: by 2002:a37:8081:: with SMTP id b123mr4830956qkd.157.1607278560886;
        Sun, 06 Dec 2020 10:16:00 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id m190sm4935754qkd.54.2020.12.06.10.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 10:16:00 -0800 (PST)
Date:   Sun, 6 Dec 2020 13:15:59 -0500
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
Message-ID: <20201206181559.GE201514@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125111541.GU2414@hirez.programming.kicks-ass.net>
 <20201201191133.GA221478@google.com>
 <20201201192050.GX3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201192050.GX3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:20:50PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 02:11:33PM -0500, Joel Fernandes wrote:
> > On Wed, Nov 25, 2020 at 12:15:41PM +0100, Peter Zijlstra wrote:
> > > On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> > > 
> > > > +/*
> > > > + * Ensure that the task has been requeued. The stopper ensures that the task cannot
> > > > + * be migrated to a different CPU while its core scheduler queue state is being updated.
> > > > + * It also makes sure to requeue a task if it was running actively on another CPU.
> > > > + */
> > > > +static int sched_core_task_join_stopper(void *data)
> > > > +{
> > > > +	struct sched_core_task_write_tag *tag = (struct sched_core_task_write_tag *)data;
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < 2; i++)
> > > > +		sched_core_tag_requeue(tag->tasks[i], tag->cookies[i], false /* !group */);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2)
> > > > +{
> > > 
> > > > +	stop_machine(sched_core_task_join_stopper, (void *)&wr, NULL);
> > > 
> > > > +}
> > > 
> > > This is *REALLY* terrible...
> > 
> > I pulled this bit from your original patch. Are you concerned about the
> > stop_machine? Sharing a core is a slow path for our usecases (and as far as I
> > know, for everyone else's). We can probably do something different if that
> > requirement changes.
> > 
> 
> Yeah.. so I can (and was planning on) remove stop_machine() from
> sched_core_{dis,en}able() before merging it.
> 
> (there's two options, one uses stop_cpus() with the SMT mask, the other
> RCU)

Ok. What about changing the cookie of task T while holding the rq/pi locks, and
then doing a resched_curr(rq) for that RQ?

The holding lock ensures no migration of task happens, and resched_curr()
ensure that task T's rq will enter the scheduler to consider the task T's new
cookie for scheduling. I believe this is analogous to what
__sched_setscheduler() does when you switch a task from CFS to RT.

> This though is exposing stop_machine() to joe user. Everybody is allowed
> to prctl() it's own task and set a cookie on himself. This means you
> just made giant unpriv DoS vector.
> 
> stop_machine is bad, really bad.

Agreed.

thanks,

 - Joel

