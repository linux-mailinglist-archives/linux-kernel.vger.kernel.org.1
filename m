Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B6A2B9ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgKSX4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgKSX4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:31 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2BC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:56:31 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 131so6076218pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 15:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u0UY7gXEG/YjiBGc5+oT/Ul+7JF6TQ0ezaWQv2kxQtM=;
        b=F/+aTZtTHd45UcYt7QCxSukLrpW9NSwAqe1g9IYMjsrVO5Q2yPWjRN4DfVUawhG2xU
         G9rhyPJoDNanz8LwVmVT50PDt00xKEgjnkPmQNoSQUmDP/FTiGdox2aHx5SUt641DGmf
         bloNrYm5HQMOka8noSU1cpmUX9Esk4uvIRRoZ0VkEXO+2vOMKdw8J/diwUOPzBpwyaTd
         9C3OQNqQozqt3LR38NTTFUJiLojBx3wUyIQLm1iKmI4TP4r/lAQ2tMrTIXsAZPj6+s8d
         2f3L2ZFkzmvajzhRryld9hTXQnKPkzHpedWOttyRvlEP0FmTmhp7cmb6JlBbisLckJdv
         0N3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u0UY7gXEG/YjiBGc5+oT/Ul+7JF6TQ0ezaWQv2kxQtM=;
        b=CuiTFe1UT5fwseI02sb75h6wV0/NfGZdTpnh2T5CGIMkI8s1VI0wv7MUPr37oMzMyP
         61I7//YU4A+EeWSuEYUbXAKq+umxdU1rCla3nLuzQMSgcHeg6pv853d9tgn12MHBEufy
         S+7C+74D3cSULAIzMD/29jib+ojSTYDeQ9ZS/52GwVcqw3UDVZk2q3ik35EWiq7HqGqZ
         RtEwZDKiBGm5yzmwrkK9i9vgiFIILWjpvkDuAUuTt71i86d4swpLFFtwPBl933am4HDt
         gAUIe9eI231K6AMCMSzmX+nvyt6z4iSvNIC9EvRVIByEUdjkTNsqSYiqe0xnUgpUShKS
         l+6w==
X-Gm-Message-State: AOAM530vfeuMOXcw8K5AlRK5/m0FkmmNRs5KdOmeAf6D7rxBjshyb3x9
        G9qT0jAZNm0hK5rGV1ajKOA=
X-Google-Smtp-Source: ABdhPJy2RJtMmFpSze62UAsCsb8DyBxQS8alGYi6KmG9BUHb4EXPy818dTPOi2kU5QZHHrc8DQzuSg==
X-Received: by 2002:a17:90a:16c1:: with SMTP id y1mr6827673pje.168.1605830191133;
        Thu, 19 Nov 2020 15:56:31 -0800 (PST)
Received: from f8ffc2228008.ant.amazon.com (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id t16sm858259pga.51.2020.11.19.15.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 15:56:29 -0800 (PST)
Subject: Re: [PATCH -tip 02/32] sched: Introduce sched_class::pick_task()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
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
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-3-joel@joelfernandes.org>
From:   "Singh, Balbir" <bsingharora@gmail.com>
Message-ID: <025bb649-89c5-a353-1434-2da725adffd9@gmail.com>
Date:   Fri, 20 Nov 2020 10:56:09 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201117232003.3580179-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/20 10:19 am, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Because sched_class::pick_next_task() also implies
> sched_class::set_next_task() (and possibly put_prev_task() and
> newidle_balance) it is not state invariant. This makes it unsuitable
> for remote task selection.
> 

The change makes sense, a small suggestion below

> Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/deadline.c  | 16 ++++++++++++++--
>  kernel/sched/fair.c      | 32 +++++++++++++++++++++++++++++++-
>  kernel/sched/idle.c      |  8 ++++++++
>  kernel/sched/rt.c        | 15 +++++++++++++--
>  kernel/sched/sched.h     |  3 +++
>  kernel/sched/stop_task.c | 14 ++++++++++++--
>  6 files changed, 81 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0f2ea0a3664c..abfc8b505d0d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1867,7 +1867,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
>  	return rb_entry(left, struct sched_dl_entity, rb_node);
>  }
>  
> -static struct task_struct *pick_next_task_dl(struct rq *rq)
> +static struct task_struct *pick_task_dl(struct rq *rq)
>  {
>  	struct sched_dl_entity *dl_se;
>  	struct dl_rq *dl_rq = &rq->dl;
> @@ -1879,7 +1879,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>  	dl_se = pick_next_dl_entity(rq, dl_rq);
>  	BUG_ON(!dl_se);
>  	p = dl_task_of(dl_se);
> -	set_next_task_dl(rq, p, true);
> +
> +	return p;
> +}
> +
> +static struct task_struct *pick_next_task_dl(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	p = pick_task_dl(rq);
> +	if (p)
> +		set_next_task_dl(rq, p, true);
> +
>  	return p;
>  }
>  
> @@ -2551,6 +2562,7 @@ DEFINE_SCHED_CLASS(dl) = {
>  
>  #ifdef CONFIG_SMP
>  	.balance		= balance_dl,
> +	.pick_task		= pick_task_dl,
>  	.select_task_rq		= select_task_rq_dl,
>  	.migrate_task_rq	= migrate_task_rq_dl,
>  	.set_cpus_allowed       = set_cpus_allowed_dl,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 52ddfec7cea6..12cf068eeec8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4459,7 +4459,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	 * Avoid running the skip buddy, if running something else can
>  	 * be done without getting too unfair.
>  	 */
> -	if (cfs_rq->skip == se) {
> +	if (cfs_rq->skip && cfs_rq->skip == se) {
>  		struct sched_entity *second;
>  
>  		if (se == curr) {
> @@ -7017,6 +7017,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  		set_last_buddy(se);
>  }
>  
> +#ifdef CONFIG_SMP
> +static struct task_struct *pick_task_fair(struct rq *rq)
> +{
> +	struct cfs_rq *cfs_rq = &rq->cfs;
> +	struct sched_entity *se;
> +
> +	if (!cfs_rq->nr_running)
> +		return NULL;
> +
> +	do {
> +		struct sched_entity *curr = cfs_rq->curr;
> +
> +		se = pick_next_entity(cfs_rq, NULL);
> +
> +		if (curr) {
> +			if (se && curr->on_rq)
> +				update_curr(cfs_rq);
> +
> +			if (!se || entity_before(curr, se))
> +				se = curr;
> +		}

Do we want to optimize this a bit 

if (curr) {
	if (!se || entity_before(curr, se))
		se = curr;

	if ((se != curr) && curr->on_rq)
		update_curr(cfs_rq);

}

Balbir
