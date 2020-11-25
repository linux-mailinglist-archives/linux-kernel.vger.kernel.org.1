Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF32C49DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbgKYV2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732060AbgKYV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:28:34 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21933C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:28:34 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id k11so879130pgq.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TEKekla+RKDZzxcpwcoco3ZCfku7RtHZxgTQ+E5cu/c=;
        b=ExcUbg65EY3y8gWSVHVqTaSz+Lpco8rTUp4reA9wkWRgUfxeEoqfhUp+yFfSlI27pj
         wV6DdK9Fk1cwLcPh6G/FtigrtG/fYlWEvkXxCxsWvuoHIhRculNe4WrEtfsQZzSvIKfB
         Ee27Qlf73/iJd7Qpl8o8wR3ME4YPsTHwZEY4w2zTpSDz4U0pSM8rUiNm2XHp3vH40bv2
         s1sI948fDe1bELAFTeTrgQ8mhR65eWc8J7Mux4b9IvGgRBl2olx5NLJRz4jL+VvAaPx+
         E+eal8O9Hh7L6earr9Mdf3u3oX5QTaVdCBTaJmRDjn8SF1pEFF6sNKzYUkSJ/V3W1YpQ
         gaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TEKekla+RKDZzxcpwcoco3ZCfku7RtHZxgTQ+E5cu/c=;
        b=H+oKQ/mkoY8fS0jOpsLKJGCXGFchld1tcfjsslHcXAYOwdnWQ+4m3ufN5r5g++8HSI
         JhfPRX0IwTr6V79mEwcqVMhuyTjItSWogZ/opKbSUuWSp6geXXI7EQQEu/XViMv3FJcq
         U2vueExpq7rarNRbD5SQnFJlBEw5qkijigJDk9Ipk0RNWLTQzYeGwPLGQ93X8ieq9g9O
         LSguPjy5oadKH6x0v3Tc4LAqyTbmkdkw+3pyHxJHt4HnvnTisIOj4TPXZHFHun2E+0I5
         NwjfqKTyUrd5p8kaqZ87WWb72ZZiGYfrWWg72SWi+9YVDpiFCy86zAMrYh0hi+4peQuJ
         2nwA==
X-Gm-Message-State: AOAM533BFsMYf4YqifUzbmmGMDcpLaTpQj9nlDKM4y1mkvgjfF8kwhvS
        g5Zj+hO8lubqLPNShhgwRDY=
X-Google-Smtp-Source: ABdhPJxwZKFU0snSRdC6E+i9U80yIL7Tp/g26zas6rd/Pi1EDR2u8Vod6qRubnR9DTVQOQAo9tg/1w==
X-Received: by 2002:a63:5322:: with SMTP id h34mr4431634pgb.95.1606339713513;
        Wed, 25 Nov 2020 13:28:33 -0800 (PST)
Received: from localhost (61-68-227-232.tpgi.com.au. [61.68.227.232])
        by smtp.gmail.com with ESMTPSA id s5sm2860628pgc.15.2020.11.25.13.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 13:28:31 -0800 (PST)
Date:   Thu, 26 Nov 2020 08:28:28 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        "Paul E . McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 13/32] sched: Trivial forced-newidle balancer
Message-ID: <20201125212828.GA163610@balbir-desktop>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-14-joel@joelfernandes.org>
 <20201123043836.GG110669@balbir-desktop>
 <1de89fd3-fb5f-5aaa-8ea6-7a12d3307fa4@linux.intel.com>
 <20201123233508.GC8893@balbir-desktop>
 <2277bfa9-7f67-6b66-b2db-a2130993de53@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2277bfa9-7f67-6b66-b2db-a2130993de53@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 08:32:01AM +0800, Li, Aubrey wrote:
> On 2020/11/24 7:35, Balbir Singh wrote:
> > On Mon, Nov 23, 2020 at 11:07:27PM +0800, Li, Aubrey wrote:
> >> On 2020/11/23 12:38, Balbir Singh wrote:
> >>> On Tue, Nov 17, 2020 at 06:19:43PM -0500, Joel Fernandes (Google) wrote:
> >>>> From: Peter Zijlstra <peterz@infradead.org>
> >>>>
> >>>> When a sibling is forced-idle to match the core-cookie; search for
> >>>> matching tasks to fill the core.
> >>>>
> >>>> rcu_read_unlock() can incur an infrequent deadlock in
> >>>> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
> >>>>
> >>> ...
> >>>> +
> >>>> +		if (p->core_occupation > dst->idle->core_occupation)
> >>>> +			goto next;
> >>>> +
> >>>
> >>> I am unable to understand this check, a comment or clarification in the
> >>> changelog will help. I presume we are looking at either one or two cpus
> >>> to define the core_occupation and we expect to match it against the
> >>> destination CPU.
> >>
> >> IIUC, this check prevents a task from keeping jumping among the cores forever.
> >>
> >> For example, on a SMT2 platform:
> >> - core0 runs taskA and taskB, core_occupation is 2
> >> - core1 runs taskC, core_occupation is 1
> >>
> >> Without this check, taskB could ping-pong between core0 and core1 by core load
> >> balance.
> > 
> > But the comparison is p->core_occuption (as in tasks core occuptation,
> > not sure what that means, can a task have a core_occupation of > 1?)
> >
> 
> p->core_occupation is assigned to the core occupation in the last pick_next_task.
> (so yes, it can have a > 1 core_occupation).
>

Hmm.. I find that hard to interpret that. But I am happy to re-read the
code again.

Balbir Singh.
