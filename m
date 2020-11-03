Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3CC2A37AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgKCAUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKCAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:20:12 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33268C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 16:20:12 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so10534750qtb.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+iYT1BpWw5n5fXn+eYkFl/oF1ufzUhPoP4Cqb3lWk8M=;
        b=D3anKR8xCSa+GzjpVwDqC8S02uGvlj/AAxoa2NI9pBuXKmStXMCt1BalYTwBcQxQlz
         aWGaX+XsY1TBDGCOqh/8Zt8BPEOrGlUzKTqHqUWKWtOWTUQQeUwCnb8kgw3h49az/Ei/
         J07Ssh2FUS3+85jHWamJUT27NhWEQWyy07WBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+iYT1BpWw5n5fXn+eYkFl/oF1ufzUhPoP4Cqb3lWk8M=;
        b=j0CFYKSVTz4HajkGi08DIsdy19hIy4VK0WjBGz/7nQtjFuhPIbzh+6Rd6X9VsPum0s
         JY4j502CnLZMU1lGIOf01BFjJXoo2v4KdL9sfIbIzerdlXpv3tBAXRxXs45tdVQ3uFsx
         nS2qJ38ZAkTTeQ9rGHSK9UtgIPC2UlCJp7sc7BMDJkxDc/V5EuONBNP6tVwTfOI5TNa8
         dsk2hn+TcXdzGQwk5jxXbePd8JB6Dnzc5aTzZla/dq6Wc0jay3BmX1vHwRdauhjKGAMj
         PEvzWLDLDzokOk/PX+V9bNxjsaI8iB2lQIDHiCeZzcQn+6QFnJXD2HJ0Tg1kMGRQRSkp
         12CA==
X-Gm-Message-State: AOAM530Hkc3UR4jZ5/tbwVLsGwDDiH+8fPvioEHOttRvPWIYW+PVrn0S
        fCFQi30QdAGi2G5HnB8DXZEKtg==
X-Google-Smtp-Source: ABdhPJxj5q7dLRJqGrusrF94RqmsfG/cVYPeyiBWXAHKwk8Amr74Fb2uD95Wl7xfV/Rk5DyWPMQa+g==
X-Received: by 2002:ac8:74c9:: with SMTP id j9mr5793552qtr.208.1604362811410;
        Mon, 02 Nov 2020 16:20:11 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k134sm4262179qke.111.2020.11.02.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 16:20:10 -0800 (PST)
Date:   Mon, 2 Nov 2020 19:20:10 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Randy Dunlap <rdunlap@infradead.org>
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v8 -tip 13/26] kernel/entry: Add support for core-wide
 protection of kernel-mode
Message-ID: <20201103002010.GC595952@google.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-14-joel@joelfernandes.org>
 <13fac0b7-37cb-7313-efb6-ebe166121f8f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fac0b7-37cb-7313-efb6-ebe166121f8f@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 08:41:04PM -0700, Randy Dunlap wrote:
> On 10/19/20 6:43 PM, Joel Fernandes (Google) wrote:
> > 
> > ---
> >   .../admin-guide/kernel-parameters.txt         |   7 +
> >   include/linux/entry-common.h                  |   2 +-
> >   include/linux/sched.h                         |  12 +
> >   kernel/entry/common.c                         |  25 +-
> >   kernel/sched/core.c                           | 229 ++++++++++++++++++
> >   kernel/sched/sched.h                          |   3 +
> >   6 files changed, 275 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 3236427e2215..48567110f709 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4678,6 +4678,13 @@
> >   	sbni=		[NET] Granch SBNI12 leased line adapter
> > +	sched_core_protect_kernel=
> 
> Needs a list of possible values after '=', along with telling us
> what the default value/setting is.

Ok, I made it the following:

        sched_core_protect_kernel=
                        [SCHED_CORE] Pause SMT siblings of a core running in
                        user mode, if at least one of the siblings of the core
                        is running in kernel mode. This is to guarantee that
                        kernel data is not leaked to tasks which are not trusted
                        by the kernel. A value of 0 disables protection, 1
                        enables protection. The default is 1.

thanks,

 - Joel


> > +			[SCHED_CORE] Pause SMT siblings of a core running in
> > +			user mode, if at least one of the siblings of the core
> > +			is running in kernel mode. This is to guarantee that
> > +			kernel data is not leaked to tasks which are not trusted
> > +			by the kernel.
> > +
> 
> 
> thanks.
