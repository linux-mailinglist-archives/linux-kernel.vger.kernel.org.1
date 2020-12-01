Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497882CAB9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403990AbgLATRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390575AbgLATRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:17:39 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735F9C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:16:59 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f27so1992257qtv.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7tXSBzsdL7O7YBVuvE82Lz5cEkXsYtvNeQggMOfmljk=;
        b=vK+0IDpS0X4f9+CoU7xPUWx81rpLtYqMOZEu7OxMhwan/aW1opiWWvV1b6UA0u6UWG
         DjB4xugkPVkm4TnhzKGkqGojgixWuij5SAT1pV7fLw78bznhZ+P2t5mHsddIuUMKlDsn
         VuJhHcGmrByAkzrpBdDCWJ+wcM1UTR64VDZAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tXSBzsdL7O7YBVuvE82Lz5cEkXsYtvNeQggMOfmljk=;
        b=NxzfNxZ6FGBKpaE/4GoBG3HHbGGOAYSM/4fzeIKPGkPayZ6wB+BN98NA6MYC+3Tjof
         X/DLeYvCGw2BJqqlKbxJiJm3nngpJKGpnZfYP9HNHB6hcXyWW6rWVz8Y3tokFDnuQXbv
         sFo4yquV67Q8ohvQrJMgcztl0umC7qqvrJGy2xTQ5b/SKTh5g/YW1pb9IQdhIxdH7kaJ
         AjLPzBs2NmR1xMtoG9jNJvOHxtnz/5u5Q5fpU2W1/nmKfLKOvEA29UGRj+V+P0KlkIpC
         utTLo5o1vUbyhUJ4W2LbnYeM5TcPmnZacuD9mn/VhW3O5Q69+Bgdey/jBvl0iEhH1Ud7
         cirQ==
X-Gm-Message-State: AOAM530/X4m46iTml1Pq4SnnzmL8GPHWg8r7qlcfX3sFvfzv+9cxLLSx
        OJcDw9A3oIPETt7RKu7SkeSzTw==
X-Google-Smtp-Source: ABdhPJyzdipPhRThzQSf0BAZoURq/SRxLkMZojxuAbz11S9B5mDIRBkaps+pRV9XPq55/iV3KacdLA==
X-Received: by 2002:aed:2393:: with SMTP id j19mr4357454qtc.75.1606850218667;
        Tue, 01 Dec 2020 11:16:58 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id w138sm538720qkb.130.2020.12.01.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:16:58 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:16:57 -0500
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
Message-ID: <20201201191657.GA222202@google.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-23-joel@joelfernandes.org>
 <20201125111128.GT2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125111128.GT2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:11:28PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 17, 2020 at 06:19:52PM -0500, Joel Fernandes (Google) wrote:
> 
> > + * sched_core_tag_requeue - Common helper for all interfaces to set a cookie.
> 
> sched_core_set_cookie() would be a saner name, given that description,
> don't you think?

Yeah, Josh is better than me at naming so he changed it to
sched_core_update_cookie() already :-). Hopefully that's Ok too with you.

thanks,

 - Joel

