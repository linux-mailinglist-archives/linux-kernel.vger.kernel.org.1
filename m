Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29D52BB11E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgKTQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgKTQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:58:56 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D32C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:58:56 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id y197so9507845qkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 08:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dZU2/rSuaY/fzVGQtlZIqumHWvBMB2vKRreAkiBccgo=;
        b=r0fCgIVT0By7QRsp5yZAdjzJp4kJVVvUhxdvYEcRQ7EccfqcAb2EAnp9HQJ5sxyxbB
         0pPzKU0nh7wJ+aXTT7EMI657YhsX8ZLh4TbmDE6fQyfpj4z0vwPWme1fJp7vFqjcTyWX
         Q9RMItao7VG7Bn+4NbGhle3ssXOXaKdjdeqIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZU2/rSuaY/fzVGQtlZIqumHWvBMB2vKRreAkiBccgo=;
        b=gA38xqaGry1TZiSBvmeFD3sQVfdjVry2R2NGbLgm8H1ZTFuTzM0HrMjSBhpaU30FvT
         YPfdSRc0argMKl0rkALGS54p8v6eAs7nebO5Kt4YoHa+AQFA588kmOu25R4OubMdpTwK
         0rT0Hsp3q5vnKPzcMjGCFrL1sunOCho3Hd5ZCL4yvQhVHIt0vOC3FPSkTFaPNqxKpXBa
         XLc+Bs+kPutMfJ0++LXdPePJu9r42k6dSAcAjIf1gfE3vdQ5g78D9a6VC+PhlgcPUu4K
         t2+h7ak7N2Bgm2td4CTkdyB3J8LakbNB0R4Bc7LFWCS+/r2vkOzV3EIOu93Z9tAR2CJU
         6Vmg==
X-Gm-Message-State: AOAM532HeBa59kJOAi33OQgw2WVAM0pkTlTubRkTaofw7KMsD09pXeXR
        3FlLocsi3IHegaGUm408xKRc4g==
X-Google-Smtp-Source: ABdhPJw4RJUTBKcFX5TOEaeb8eFhYYoDERQXJRsS5XPnWqudYH/trLu37r/vrkZ3Mja7QImpvkCdVQ==
X-Received: by 2002:a37:7b44:: with SMTP id w65mr17935914qkc.350.1605891535325;
        Fri, 20 Nov 2020 08:58:55 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id j202sm2206173qke.108.2020.11.20.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:58:54 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:58:54 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Singh, Balbir" <bsingharora@gmail.com>
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
Message-ID: <20201120165854.GB1021337@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-3-joel@joelfernandes.org>
 <025bb649-89c5-a353-1434-2da725adffd9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025bb649-89c5-a353-1434-2da725adffd9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:56:09AM +1100, Singh, Balbir wrote:
[..] 
> > +#ifdef CONFIG_SMP
> > +static struct task_struct *pick_task_fair(struct rq *rq)
> > +{
> > +	struct cfs_rq *cfs_rq = &rq->cfs;
> > +	struct sched_entity *se;
> > +
> > +	if (!cfs_rq->nr_running)
> > +		return NULL;
> > +
> > +	do {
> > +		struct sched_entity *curr = cfs_rq->curr;
> > +
> > +		se = pick_next_entity(cfs_rq, NULL);
> > +
> > +		if (curr) {
> > +			if (se && curr->on_rq)
> > +				update_curr(cfs_rq);
> > +
> > +			if (!se || entity_before(curr, se))
> > +				se = curr;
> > +		}
> 
> Do we want to optimize this a bit 
> 
> if (curr) {
> 	if (!se || entity_before(curr, se))
> 		se = curr;
> 
> 	if ((se != curr) && curr->on_rq)
> 		update_curr(cfs_rq);
> 
> }

Do you see a difference in codegen? What's the optimization?

Also in later patches this code changes, so it should not matter:
See: 3e0838fa3c51 ("sched/fair: Fix pick_task_fair crashes due to empty rbtree")

thanks,

 - Joel

