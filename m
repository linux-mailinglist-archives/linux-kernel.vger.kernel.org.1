Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A229BBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1798519AbgJ0Q2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:28:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46195 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1809717AbgJ0Q1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:27:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id a23so1703351qkg.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TELKXTDeDcoH8K72SKRRPuWFrocQHfcvz7JvijdmZCs=;
        b=XX6cd5s07uoa2kIikoWllb2EdOYH2aDU09QMb1QezFV3qAitSu2qjdhGipqFAx5M9+
         VhQc/O/QBP9xGBJV3cO6sqST6sWrni/teutLMhWIxCa85YuZehjjS1up/3iI3Xwj+Kls
         wWw6Vd7p+2522nyVjpv35iDLYu5n72nnVa0tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TELKXTDeDcoH8K72SKRRPuWFrocQHfcvz7JvijdmZCs=;
        b=uWLKKftBjn/i0/AzQNdtsq3Uddyu2QVB5qHvKHboaSaqNEEL3hax7dYA/AOIz5Ujqj
         K4XWHNkEnKqZZEJIrj7e+29R4fmBt0gOu4KCQB/W4ZpMU4BC17EK9+KfkpxW+F55H/pV
         hiPE4yMFpHAfjXURDptKjJXYqfh7KHR5w9/7FXqemIZp/z2vrayJlzNif5kdTQIPo5yK
         6ffJwvG3yKRssbeDir0bTsWb9YoC448zoIa+BfP65huBvvYWsBklssRz31jhPqdPme1+
         8xBcFMGbUwzx/xhxdLz32fYtbd1DBXwIvnzcxzP/nE3fZ1S0z44N+2ZVASZLTe2iLvi3
         GrZg==
X-Gm-Message-State: AOAM532YrOCSWU6oFvRlf+fWHv8QqMdeloyAZSDWrGnSFrU5eg2RN9gx
        atXpmdA9PgoJzmsSRj7azrqrXA==
X-Google-Smtp-Source: ABdhPJyQOa0ez88a4hbsyc7dX6XmRPQ0d4c8Iu0HWjA5Vxc4k1D8jfcQEVziZ5R5Fw9xiwY+GmqzHg==
X-Received: by 2002:a37:9ed0:: with SMTP id h199mr2782348qke.407.1603816066656;
        Tue, 27 Oct 2020 09:27:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id a128sm1032094qkc.92.2020.10.27.09.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:27:46 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:27:45 -0400
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
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 03/26] sched: Core-wide rq->lock
Message-ID: <20201027162745.GB997376@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-4-joel@joelfernandes.org>
 <20201026115927.GH2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026115927.GH2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:59:27PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 19, 2020 at 09:43:13PM -0400, Joel Fernandes (Google) wrote:
> > +	if (!core_rq) {
> > +		for_each_cpu(i, smt_mask) {
> > +			rq = cpu_rq(i);
> > +			if (rq->core && rq->core == rq)
> > +				core_rq = rq;
> > +			init_sched_core_irq_work(rq);
> 
> That function doesn't exist quite yet.

Moved to the appropriate patch, sorry and thank you!

 - Joel


