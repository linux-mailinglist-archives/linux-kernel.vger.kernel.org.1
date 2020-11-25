Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F512C3B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKYIuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgKYIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:50:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3839CC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=03txFcJNBslvd+BNPT41sjaiOCJak/ukhem/Aa3k44s=; b=NVSFu2c4nKDCwGDr4/NGC2ACGz
        L84kIAdaNGXUW5AEvKiDHUZ8cBNV3oMk6zQvlJyJQiKXlq+f42+4yqSyVEZ2evwXwxrVImkU0tK4H
        NF7F6Q/ahTZ45tS61OXfjp9/ppLJk/RpHi2HNvWRr+cJ1qOAzPcJWZ3ob0MKXUn5gQQZU44YNZ8mI
        T8R+0pidXXkcCXdEsYszNzUbtGxhGkesgjDny5dWdEYI5SxDGQTYnIYWNCxG1UWdmXs3DqW7q11nA
        HTeRgstxZ7J5njStFp5MBt4XNMaf/veRc4Q0r+cIbE6Ui8DxQU8v7hbjRkCnhwhq1lxDwALUSA/dB
        vPbPPbqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khqUA-0006h9-LH; Wed, 25 Nov 2020 08:49:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA5A0301124;
        Wed, 25 Nov 2020 09:49:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4DE2209BAB21; Wed, 25 Nov 2020 09:49:08 +0100 (CET)
Date:   Wed, 25 Nov 2020 09:49:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
Subject: Re: [PATCH -tip 19/32] entry/idle: Enter and exit kernel protection
 during idle entry and exit
Message-ID: <20201125084908.GO2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-20-joel@joelfernandes.org>
 <20201124161335.GB3021@hirez.programming.kicks-ass.net>
 <20201124180343.GF1021337@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124180343.GF1021337@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 01:03:43PM -0500, Joel Fernandes wrote:
> On Tue, Nov 24, 2020 at 05:13:35PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 17, 2020 at 06:19:49PM -0500, Joel Fernandes (Google) wrote:

> > > +static inline void generic_idle_enter(void)
> > > +static inline void generic_idle_exit(void)

> > That naming is terrible..
> 
> Yeah sorry :-\. The naming I chose was to be aligned with the
> CONFIG_GENERIC_ENTRY naming. I am open to ideas on that.

entry_idle_{enter,exit}() ?

> > I'm confused.. arch_cpu_idle_{enter,exit}() weren't conveniently placed
> > for you?
> 
> The way this patch series works, it does not depend on arch code as much as
> possible. Since there are other arch that may need this patchset such as ARM,
> it may be better to keep it in the generic entry code.  Thoughts?

I didn't necessarily mean using those hooks, even placing your new hooks
right next to them would've covered the exact same code with less lines
modified.
