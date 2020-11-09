Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49212AC085
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgKIQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:10:21 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54696C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:10:21 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id y197so8386803qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChSPT0l5ZEMZ6nZWanzzqsrfnnTGnBObboFP+tyZLDA=;
        b=YP0wiDZyb6WVNeWkjV6j1/15aSLQCPhQ0Pp1zjFYJFdi208Q5RPaRILNiKsLQcx9LZ
         ZENqxMAbPr3P9Q1QlefYFNs+PM0pEdT2BiuU/4FFWYglPPlRFHBe8DD0b+Cn96SOHyvo
         d4wgenEjjygmOw4qgKApSSwM+OikQnQGWK/3+idLjuzHFQZC5i+BQI1IN+UGixSNtgqu
         Xjl740RoXUuAMrTrcLjHF4JiEiJoLpl7MSfoQYNWPvakjM4yr5LxfYUfzRuP58VJ2E/Q
         ZBoppR1nMoJsudIvJv4rV1Ibh/iH0zgxCA++Ym41nkdlIyD6QoeKnZiPXV+o1BAiQAG0
         Uk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ChSPT0l5ZEMZ6nZWanzzqsrfnnTGnBObboFP+tyZLDA=;
        b=bfoN7WSllZezSLI0XK7qtXFOMaOSbrFuXJ6op3HVcHBu7D8KZ82c5AziugEsaP6Jkq
         SWQiK5fY00wTczFpUNZS30W3MwKR3pB++sCWQzU647hjrwD9cgusO99Wno1YmhtkG0kN
         CInxhgTWwZc0oQiObwK/q1IPKzP9lGdK4rqEfj6UFwoHt/aQsHHntAJ5Md8n9z1NKYgW
         35RiiZ5BUfDNfzPtBUKytMao5kmwIIA9/YMIJxDs/wqrr/97ICjnIHaBTvMALYiz8zE/
         9oVHatDltjuypElIMfcXIbNg10pzGLGhOFYEU0MRcdxljvv2KHnsajZ8vlURoodq6shT
         ATXw==
X-Gm-Message-State: AOAM533M+EEzM3F1jPG/Bk2H3q/YlAyKugXje5SZVIL5GicLlZQ4CtW0
        t1FxbnXSa+36+pq1oALShhk=
X-Google-Smtp-Source: ABdhPJzz730uJzIPJVRQrlG/Ra915Csy4WJMKOlX3bc0IoY1XCWaqf7krgOU12CM7hWyWfEddPk7bg==
X-Received: by 2002:a37:e212:: with SMTP id g18mr13677438qki.366.1604938220251;
        Mon, 09 Nov 2020 08:10:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc2b])
        by smtp.gmail.com with ESMTPSA id m15sm6254529qtc.90.2020.11.09.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:10:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Nov 2020 11:10:07 -0500
From:   "tj@kernel.org" <tj@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Message-ID: <20201109161007.GF7496@mtj.duckdns.org>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109140141.GE7496@mtj.duckdns.org>
 <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 09, 2020 at 02:11:42PM +0000, Trond Myklebust wrote:
> That means changing all filesystem code to use cpu-intensive queues. As
> far as I can tell, they all use workqueues (most of them using the
> standard system queue) for fput(), dput() and/or iput() calls.

I suppose the assumption was that those operations couldn't possiby be
expensive enough to warrant other options, which doesn't seem to be the case
unfortunately. Switching the users to system_unbound_wq, which should be
pretty trivial, seems to be the straight forward solution.

I can definitely see benefits in making workqueue smarter about
concurrency-managed work items taking a long time. Given that nothing on
these types of workqueues can be latency sensitive and the problem being
reported is on the scale of tens of seconds, I think a more palatable
approach could be through watchdog mechanism rather than hooking into
cond_resched(). Something like:

* Run watchdog timer more frequently - e.g. 1/4 of threshold.

* If a work item is occupying the local concurrency for too long, set
  WORKER_CPU_INTENSIVE for the worker and, probably, generate a warning.

I still think this should generate a warning and thus can't replace
switching to unbound wq. The reason is that the concurrency limit isn't the
only problem. A kthread needing to run on one particular CPU for tens of
seconds just isn't great.

Thanks.

-- 
tejun
