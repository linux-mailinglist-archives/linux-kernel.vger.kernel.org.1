Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD70E2C4B64
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 00:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgKYXTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 18:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgKYXTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:19:44 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D39C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 15:19:44 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w187so3797047pfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 15:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afKXxLX/izYfyyB9oQMohUAdu4xtjRHSqiKSx+Whd3Q=;
        b=r4plu1fqB3knZg9ornwiE4Knf97ou/qnfHjO6/05pGxqmtwIYcXB8Qu9ztRU9EGYV2
         SZI2Y4TjE3UcSNNxuDqZsNlldotTpN2LHo/WgN4SaIy84t7O81hrtQi55qno1jscyYeA
         6YYWRc70YnRBCCOdTX51I8TCCl4pcEV8fmjH5ODGfg7p6pz+Imgid/jsuUQg8AvRkWIf
         5QA6spszM/m6PE/aOE5edZ3kdYmGoCc0nudVFBjJoeK9c3nY4wps5bIjTAq1zuhx3Vic
         Iw41HH0mbmSGOY5GLbKOaukhiurWcaz7gNWd9vGF7JtXXPqR96Bo0ocsVkDVHBfbAECU
         47Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afKXxLX/izYfyyB9oQMohUAdu4xtjRHSqiKSx+Whd3Q=;
        b=tpaXx/pOcHDWk3HL79LI3pneFp5aYmG1l7RSH9oWXGX5Y+r+2Nue9WWZ/U74R8Mm86
         ft8EmeNpfCSeE2wPCF4w2BRlzkeQTixEqO6A4WBuxGHku52TKOyvFnCDQm3LA461CrU3
         X+cFrFWojHYwZYcT+ek1VmYNqZKB1x6mkP1Go251Rnmar4AsIX+BEVIzLIhrCzJUSPM+
         u39UGsAaSiqLwv+kGd0K/IX246YyypBzvimzOxY6wlwJqwPYlghTXxlHioXzKCDOlEhp
         Rjl4h8tziEMfErzmVaI69c9e9Gvhe/n2XRbhrtwEmq1+nRKbjVm9/Z2bboj0V4Rlea7O
         xohA==
X-Gm-Message-State: AOAM533q+eRz7u4VnH6KISWrptR9Vh8tU7s+kK9B3TR3m1CmNebifPwi
        CDjtn37O0F5wojagEfShVYI=
X-Google-Smtp-Source: ABdhPJyTvnCE2MKjQY2jFTP0laMqQWtSK2CZYueWO3cpwjHid7GrQQy8d9Y8UkvmoXWO8HoDbJkTRw==
X-Received: by 2002:a62:c1c1:0:b029:198:14d8:6e98 with SMTP id i184-20020a62c1c10000b029019814d86e98mr263952pfg.10.1606346384152;
        Wed, 25 Nov 2020 15:19:44 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id j19sm2773164pff.74.2020.11.25.15.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:19:41 -0800 (PST)
Date:   Thu, 26 Nov 2020 10:19:38 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 02/32] sched: Introduce sched_class::pick_task()
Message-ID: <20201125231938.GE163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-3-joel@joelfernandes.org>
 <025bb649-89c5-a353-1434-2da725adffd9@gmail.com>
 <20201120165854.GB1021337@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120165854.GB1021337@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:58:54AM -0500, Joel Fernandes wrote:
> On Fri, Nov 20, 2020 at 10:56:09AM +1100, Singh, Balbir wrote:
> [..] 
> > > +#ifdef CONFIG_SMP
> > > +static struct task_struct *pick_task_fair(struct rq *rq)
> > > +{
> > > +	struct cfs_rq *cfs_rq = &rq->cfs;
> > > +	struct sched_entity *se;
> > > +
> > > +	if (!cfs_rq->nr_running)
> > > +		return NULL;
> > > +
> > > +	do {
> > > +		struct sched_entity *curr = cfs_rq->curr;
> > > +
> > > +		se = pick_next_entity(cfs_rq, NULL);
> > > +
> > > +		if (curr) {
> > > +			if (se && curr->on_rq)
> > > +				update_curr(cfs_rq);
> > > +
> > > +			if (!se || entity_before(curr, se))
> > > +				se = curr;
> > > +		}
> > 
> > Do we want to optimize this a bit 
> > 
> > if (curr) {
> > 	if (!se || entity_before(curr, se))
> > 		se = curr;
> > 
> > 	if ((se != curr) && curr->on_rq)
> > 		update_curr(cfs_rq);
> > 
> > }
> 
> Do you see a difference in codegen? What's the optimization?
> 
> Also in later patches this code changes, so it should not matter:
> See: 3e0838fa3c51 ("sched/fair: Fix pick_task_fair crashes due to empty rbtree")
>

I did see the next patch, but the idea is that we don't need to
update_curr() if the picked sched entity is the same as current (se ==
curr). What are the side-effects of not updating curr when se == curr?

Balbir

