Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297F827DD82
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 02:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgI3As6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 20:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgI3As5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 20:48:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5E5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 17:48:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so131996pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jfDxSkmpPjqtsnMdFLpAkBQJrfG5Oh0rLzmY203/J8Q=;
        b=fHcGrnQkLaCp+GP2WXdS/8+17sMxE6Exgu/8HJoq8GDh/Eql+Lkf0WNyQGeD4bTKRo
         eLKMZlmMcovC3ncFDCH7+X6AqjWM3hfTOrT7IqMttOTvSWOv18wnyn8fQTj2Q1FHIZqZ
         FFVFz6JkUurMhciKXo7irkeSNXneQPsp9jOrhEt9qTvDlz6pvQWfqevJVS9nbpr0n8f7
         xLZU3kY8aWrDTmL5Lg+n/IwG5JgDM1cyd/cTM9toTpxQD8hWsv7pOviLBbXI1OfC64W+
         E54nMpWT7Ov+YZHEBHDj7afFLOEvxm9iHts7Yzz22RHGxTy/C/s1TAV0KbcEscoGSMrN
         n2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfDxSkmpPjqtsnMdFLpAkBQJrfG5Oh0rLzmY203/J8Q=;
        b=o8RNWtchtUyEUw3iCk1/Uu5sNBMJyJtnR6FbXkqsUQahP1tE/eCFI6BVesZXJn6/AJ
         hhcGq58FV+8+YtDsLNeU3GH/kuSigohPAqdG7NYiaOG4aJ4qeUI2Tou5eavcqMLu6X5G
         euZ3OTHIjopwEmIA7HP1wU95Z7s/fnI4Uu2U26AtLWKmWv/0yzPADGfliLIN4+ld8gpn
         rvgs6O4PCmG1ful848k0VRievyILgh3e4QfRne1yw+8NQ8frMpPXQgo/vl3UWkiVleo9
         4q5t7K8s2A25KAIAUW6OUUljLWnT5fz2VBvh9VgDM5QjXw1xiUXlJRVTidmOYD/8wfs6
         gGYg==
X-Gm-Message-State: AOAM532xuT8Ufh7IO2JFOniQKReJSScNMQ0MicNjMpLt7dSbYNb1g1R/
        ijtcJZG4y1X3QqjEc/2OnyA=
X-Google-Smtp-Source: ABdhPJy9FBbKj5N52pO00whzAXKOxk2MPPEDOlfxBFIP2v8O6ew2JFpzwVY/2se0ETWEgL1lerE+vQ==
X-Received: by 2002:a17:90a:14a4:: with SMTP id k33mr181739pja.236.1601426935677;
        Tue, 29 Sep 2020 17:48:55 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id u2sm74238pji.50.2020.09.29.17.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 17:48:54 -0700 (PDT)
Date:   Wed, 30 Sep 2020 09:48:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, songmuchun@bytedance.com,
        john.ogness@linutronix.de
Subject: Re: [External] Re: [PATCH 2/2] sched: mark
 PRINTK_DEFERRED_CONTEXT_MASK in __schedule()
Message-ID: <20200930004852.GA987@jagdpanzerIV.localdomain>
References: <20200927161130.33172-1-zhouchengming@bytedance.com>
 <20200927161130.33172-2-zhouchengming@bytedance.com>
 <20200928073202.GA2611@hirez.programming.kicks-ass.net>
 <40ab934e-5b8b-735b-da65-3043efab9fdc@bytedance.com>
 <20200928090143.GA2628@hirez.programming.kicks-ass.net>
 <688eadd7-4ca3-3e32-3520-25977ff059a6@bytedance.com>
 <20200928102559.GF2611@hirez.programming.kicks-ass.net>
 <20200929142750.GT6442@alley>
 <20200929150933.GR2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929150933.GR2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/29 17:09), Peter Zijlstra wrote:
> > 2. The registration and unregistration of consoles should not longer
> >    be handled by console_lock (semaphore). It should be possible to
> >    call most consoles without a sleeping lock. It should remove all
> >    these deadlocks between printk() and scheduler().
> 
> I'm confused, who cares about registation? That only happens once at
> boot, right?

You can modprobe or rmmod (register/unregister) netconsole anytime,
for example.

	-ss
