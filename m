Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0F2CB62A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbgLBIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbgLBIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:04:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 00:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I9YqoBqZdo2yNL9L6VBPasis06QJ+cyQJi6cfgD3c70=; b=M7GckDuPVgHHRIzu8mgLCW78Qg
        vFCRV0LVEl7pIIENGSO8Z8tP59hGmkRN+gT8/xLR1sYNMmtsm2n6OUruaStL3ghGwFwJgWjRMfO2y
        0dJk1S+SrkkE8oTi0lSIShcyt/8WYzyPa0jrS1J3TlenBrzOqcQMQJjA026I8IGEtd4g5knd/oIpV
        9vb6x+mulO2OKpoyK1GZwMwI4VgMLipC07UBLDTHL9O/nUm8dlXKj5BAEAH5rDoSF1nVhbYjkeaXR
        ivQM5NubSMixD97tZLBLyNVdYFg7fodnJcAFi6dMJpdp9Gn13veYKOIS99WeM9uZ4mCANY28chtNL
        KVPfDOCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkN5Y-0004CJ-Uc; Wed, 02 Dec 2020 08:02:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C37B0305815;
        Wed,  2 Dec 2020 09:02:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A97512C83017E; Wed,  2 Dec 2020 09:02:11 +0100 (CET)
Date:   Wed, 2 Dec 2020 09:02:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>, chris.hyser@oracle.com,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Oleg Rombakh <olegrom@google.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -tip 26/32] sched: Add a second-level tag for nested
 CGroup usecase
Message-ID: <20201202080211.GD3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-27-joel@joelfernandes.org>
 <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
 <CABk29Nv7+nD1oU9iBhAFAuFoiPM5i7eCOtuG7vuQVcE8+Va=nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nv7+nD1oU9iBhAFAuFoiPM5i7eCOtuG7vuQVcE8+Va=nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:18:00PM -0800, Josh Don wrote:
> Hey Peter,
> 
> On Wed, Nov 25, 2020 at 5:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Why can't the above work by setting 'tag' (that's a terrible name, why
> > does that still live) in CDE? Have the most specific tag live. Same with
> > that thread stuff.
> 
> The motivation is to allow an unprivileged user the ability to
> configure the trust hierarchy in a way that otherwise wouldn't be
> possible for a given cgroup hierarchy.  For example given a cookie'd
> hierarchy such as:
> 
>       A
>    /  |  |   \
> B  C  D  E
> 
> the user might only want subsets of {B, C, D, E} to share.  For
> instance, the user might only want {B,C} and {D, E} to share.  One way
> to solve this would be to allow the user to write the group cookie
> directly.  However, this interface would need to be restricted to
> privileged users, since otherwise the cookie could be configured to
> share with any arbitrary cgroup.  The purpose of the 'color' field is
> to expose a portion of the cookie that can be modified by a
> non-privileged user in order to achieve this sharing goal.
> 
> If this doesn't seem like a useful case, I'm happy to drop this patch
> from the series to unblock it.

Well, the traditional cgroup way of doing that would be to:

         A
	/ \
       T1 T2
      / \
     B   C

And tag T1 if you want B,C to share.

So me the color thing reads like an end-run around the cgroup hierarchy.
