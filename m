Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93A2C4157
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgKYNnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgKYNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:43:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C8C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CXjJBBQ509MLNGRCW6YegSHGZPRzXtIgnFrJbQeTLDg=; b=n+767GOpL38zFly8/odSqqLSuc
        WKrZ63sg+Iz63A3vJoVwiJ8sfA3EgoUSVs/35q5sPyoIdYYU16sX+R+n3VZxv/JsrQNDF3JtWz5Pa
        5s3fVTy+t+TiVZKpRPx/px/3q+L+1jPJsDwcunHIzNHq0tzqUWpeXaJADyJ5ptO1RxO3OnH3SZ25S
        QZtmI95KW8Fc9QEkxx8MIy0jJMsbivDnrmZ/rZQ5s9Y/XIfb3e7H5YGFb2mkezyiNXlcAAXiEqBjk
        nqRWp7qarVDmOHPRxYHqDXjWVAxIFuLf2A68K5RWmfOKSfzk2qHZiZ4VPJ5UkgDBCcteHVXchmCnI
        t2FnXaaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khv4C-0007xr-2H; Wed, 25 Nov 2020 13:42:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3178B3012DF;
        Wed, 25 Nov 2020 14:42:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0EDC200DF1C9; Wed, 25 Nov 2020 14:42:37 +0100 (CET)
Date:   Wed, 25 Nov 2020 14:42:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Subject: Re: [PATCH -tip 26/32] sched: Add a second-level tag for nested
 CGroup usecase
Message-ID: <20201125134237.GZ2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-27-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117232003.3580179-27-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 06:19:56PM -0500, Joel Fernandes (Google) wrote:
> From: Josh Don <joshdon@google.com>
> 
> Google has a usecase where the first level tag to tag a CGroup is not
> sufficient. So, a patch is carried for years where a second tag is added which
> is writeable by unprivileged users.
> 
> Google uses DAC controls to make the 'tag' possible to set only by root while
> the second-level 'color' can be changed by anyone. The actual names that
> Google uses is different, but the concept is the same.
> 
> The hierarchy looks like:
> 
> Root group
>    / \
>   A   B    (These are created by the root daemon - borglet).
>  / \   \
> C   D   E  (These are created by AppEngine within the container).
> 
> The reason why Google has two parts is that AppEngine wants to allow a subset of
> subcgroups within a parent tagged cgroup sharing execution. Think of these
> subcgroups belong to the same customer or project. Because these subcgroups are
> created by AppEngine, they are not tracked by borglet (the root daemon),
> therefore borglet won't have a chance to set a color for them. That's where
> 'color' file comes from. Color could be set by AppEngine, and once set, the
> normal tasks within the subcgroup would not be able to overwrite it. This is
> enforced by promoting the permission of the color file in cgroupfs.

Why can't the above work by setting 'tag' (that's a terrible name, why
does that still live) in CDE? Have the most specific tag live. Same with
that thread stuff.

All this API stuff here is a complete and utter trainwreck. Please just
delete the patches and start over. Hint: if you use stop_machine(),
you're doing it wrong.

At best you now have the requirements sorted.
