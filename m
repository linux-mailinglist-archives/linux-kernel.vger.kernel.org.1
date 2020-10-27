Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A436C29BEF0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814668AbgJ0Q6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:58:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36276 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1814650AbgJ0Q6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:58:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id c5so1512787qtw.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bHm2dZZKvQUPA4cpwWgITpEgSjinbDnYFXp73dIVwnM=;
        b=FdhjNNZVp413rO74cm3kZ9blzWIHuyQgA262brJvBJnHuwcNWKLQRGMP7CorjS3ugU
         qMj64HS+uZH27OLLQjvFY086Gq4sXzufbh1i4BiVRVxTzqW8dospHE08QOkY703Orc72
         mqICBUVVThS5MW0NDuyv/F2iHX10z0YdwDuXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bHm2dZZKvQUPA4cpwWgITpEgSjinbDnYFXp73dIVwnM=;
        b=sKU4rmTRvQgW/ArqAUdzVz5AyXa5JryQX4pqthibBAxX4nEZRVc5OJ+KbAswpRO6SV
         ADLLh6JJadBQqW4x4mGbYzrlP8J/7d707ANcR8QMkkyl0RxE9fGMMC+qonymzZMaCySC
         0IMwMaCGyBgnb0ANzFgKTfH5Sjelge4asYqG7xM61CFtrQ1KxHVI1UDzNlMQXrxEyKWS
         dQ2U+pXeJAJ5o3ACxi8z5emrY6J67w57wvaPyaVTdbvAJRvKAUcbXeiCSvnx4m0s0N8y
         9+nsVfs0Qj+VGPSbSAj3j0IN3yRjtajcFp0mtHkMeTZ1tT4uMQDKzuDFY4JZ3joeUP1z
         VCGw==
X-Gm-Message-State: AOAM530jRlTenFmJHlkRq4m59sxINH7TEJ5mtMZve8qthI7iWuM1zm89
        +ElktLzbXsZKM1xvzblMnw+j9Q==
X-Google-Smtp-Source: ABdhPJyqa2zU57Co3m9P2w7igJs1pUMMRLkEtoXN2fe40cOeyUFYlUCii9M9GMAuc+DdGKOdHla4rA==
X-Received: by 2002:ac8:7b82:: with SMTP id p2mr1215369qtu.48.1603817884208;
        Tue, 27 Oct 2020 09:58:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q20sm1170004qtl.69.2020.10.27.09.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:58:03 -0700 (PDT)
Date:   Tue, 27 Oct 2020 12:58:02 -0400
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
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 06/26] sched: Add core wide task selection and
 scheduling.
Message-ID: <20201027165802.GA1005883@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
 <20201023135400.GA2651@hirez.programming.kicks-ass.net>
 <20201023175724.GA3563800@google.com>
 <20201023192654.GH2974@worktop.programming.kicks-ass.net>
 <20201023213118.GD3563800@google.com>
 <20201026082814.GD2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026082814.GD2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 09:28:14AM +0100, Peter Zijlstra wrote:
> On Fri, Oct 23, 2020 at 05:31:18PM -0400, Joel Fernandes wrote:
> > BTW, as further optimization in the future, isn't it better for the
> > schedule() loop on 1 HT to select for all HT *even if* need_sync == false to
> > begin with?  i.e. no cookied tasks are runnable.
> > 
> > That way the pick loop in schedule() running on other HTs can directly pick
> > what was pre-selected for it via:
> >         if (rq->core->core_pick_seq == rq->core->core_task_seq &&
> >             rq->core->core_pick_seq != rq->core_sched_seq &&
> >             rq->core_pick)
> > .. which I think is more efficient. Its just a thought and may not be worth doing.
> 
> I'm not sure that works. Imagine a sibling doing a wakeup (or sleep)
> just after you done your core wide pick. Then it will have to repick and
> you end up with having to do 2*nr_smt picks instead of 2 picks.

For a workload that is having mostly runnable tasks (not doing lot of wakeup
/ sleep), maybe it makes sense.

Also if you have only cookied tasks and they are doing wake up / sleep, then
you have 2*nr_smt_picks anyway as the core picks constantly get invalidated,
AFAICS.

I guess in the current code, the assumptions are:
1. Most tasks are not cookied task
2. They can wake up and sleep a lot

I guess those are Ok assumptions though, but maybe we could document it.

thanks,

 - Joel
