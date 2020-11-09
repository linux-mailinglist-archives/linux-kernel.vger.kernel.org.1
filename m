Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9E42ABE24
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgKIOB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730035AbgKIOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:01:57 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EEEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:01:55 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id e5so2338913qvs.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ruVSjDZDRurayBLmYyYR2veA1e5iE10q7XYnooMQvs=;
        b=I7kW91bk0uBvrlkJhQrFt5YKmaWbeu0rpb8qa6RuunmdqC2Hn4Kli2yhGMVByErrZB
         AZ5Vg9PkOzAAkRxa37YLlZ6HsMTgFOM7vsiq7EQFXLfZ4KQ9I54IEH1laoXwG3Y8Jko2
         wLY11KBmfS/ZI1yG7JAnk6uUEfVdZRh2MWE8hHWMv/2CPCiSjRO8WnSMl+fSoNnr5BR/
         8pv6zU9+EhUMnvb7cLMvtxNAZCAYX4Kiui8dIdrdo4DrN5dtk00SSA5WwY/bs7ENg87l
         qRAOBYFHLOhYlKp5ug+Q9mLrcU+fKnTQRTbPVyMGOlDDHyalAvYfp1BYVQLsw6kko2oI
         AR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/ruVSjDZDRurayBLmYyYR2veA1e5iE10q7XYnooMQvs=;
        b=lHF25G+Wt0BBFtjcH6FPpHRv5NSuM6YZ5+OCZ9IWMxxpqIK0yLVO2WZOIZNifNNf/F
         rBjvkHGE624At/o+P53k+HS5YHr0uSwgSTZd6ro94f1UqUG9FxcFzKqLDPL21zky6miU
         7rBuYBAP3JZVsB7NBirvEOQShwQFuzdgSIyMMvuZHvoXIhosG4lhttLVZ3XkNokoXNq1
         Mny/BShuhN42cHR98kLXBVZhfDFrXLuNoIIUT2xj5S3TjQhwGjtWSvU2joXKKXCpNetw
         mJu3iLPld3UalIfQR6/csaRWHbK4fObG/4vW8+KY2jaz/Zez45L9PSzBw2c7/STlys09
         StQw==
X-Gm-Message-State: AOAM532crFrUcbcfsA5HTGpRZcfSrDjORoj3IvP2DCuavwWZSTcEz7lu
        2OHsjiwela8OB0hoBjOBt5M=
X-Google-Smtp-Source: ABdhPJy/UCVRsADK6liBFCEnwsUVvRK90KPFjq7S2YvwiDfZjafq9pPvWElV5M4G56YfxDLWZMpEIg==
X-Received: by 2002:a0c:b2c6:: with SMTP id d6mr14783923qvf.38.1604930514196;
        Mon, 09 Nov 2020 06:01:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc2b])
        by smtp.gmail.com with ESMTPSA id f189sm2240333qkb.84.2020.11.09.06.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 06:01:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Nov 2020 09:01:41 -0500
From:   "tj@kernel.org" <tj@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "neilb@suse.de" <neilb@suse.de>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Message-ID: <20201109140141.GE7496@mtj.duckdns.org>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Nov 09, 2020 at 01:50:40PM +0000, Trond Myklebust wrote:
> > I'm thinking the real problem is that you're abusing workqueues. Just
> > don't stuff so much work into it that this becomes a problem. Or
> > rather,
> > if you do, don't lie to it about it.
> 
> If we can't use workqueues to call iput_final() on an inode, then what
> is the point of having them at all?
> 
> Neil's use case is simply a file that has managed to accumulate a
> seriously large page cache, and is therefore taking a long time to
> complete the call to truncate_inode_pages_final(). Are you saying we
> have to allocate a dedicated thread for every case where this happens?

I think the right thing to do here is setting CPU_INTENSIVE or using an
unbound workqueue. Concurrency controlled per-cpu workqueue is unlikely to
be a good fit if the work can run long enough to need cond_resched(). Better
to let the scheduler handle it. Making workqueue warn against long-running
concurrency managed per-cpu work items would be great. I'll put that on my
todo list but if anyone is interested please be my guest.

Thanks.

-- 
tejun
