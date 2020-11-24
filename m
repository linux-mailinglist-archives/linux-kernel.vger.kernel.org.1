Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FAA2C1FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgKXIRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730447AbgKXIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:17:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E5AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZyExhNch12p/Hcf7krqTIV0ABzoKgV0CWL75KJBPvXE=; b=VYsntT46dXn0wMY+icj6UFPlZ1
        sUZkxMaH3PWgi/+2vRcVnqUMHNpuPwEW5qS6ltRzAqShDF5qwf09asI0ENY08G7ugxgXoVhiaeYw/
        /4S+O9IoPDT8Rr3LwB/gFZatuOnOF4hoUnFsgbwRCT9S644y26gIsd2UvcCBGnG4HZsm02AZHXH+3
        sLeedJWHZA8ToXSJmG4GCtWmY6ZgAGQwbXvP9+9WlplaRTZK4NFtaDgSBQXiPfS0ymBgCNj31d/1d
        /B9HQTB64cnslpVo0BhrbR7n4S1p4StFQuOFa5AnmX3TX3TsLGYT4x1jZ/RbdCkFrmiVEh6yA91f9
        QqHXwaoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khTUq-00034C-15; Tue, 24 Nov 2020 08:16:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D464030280E;
        Tue, 24 Nov 2020 09:16:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE4B924C2AFCE; Tue, 24 Nov 2020 09:16:17 +0100 (CET)
Date:   Tue, 24 Nov 2020 09:16:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
Subject: Re: [PATCH -tip 04/32] sched: Core-wide rq->lock
Message-ID: <20201124081617.GT3021@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-5-joel@joelfernandes.org>
 <20201122091152.GB110669@balbir-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201122091152.GB110669@balbir-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 08:11:52PM +1100, Balbir Singh wrote:
> On Tue, Nov 17, 2020 at 06:19:34PM -0500, Joel Fernandes (Google) wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Introduce the basic infrastructure to have a core wide rq->lock.
> >
> 
> Reading through the patch, it seems like all the CPUs have to be
> running with sched core enabled/disabled? Is it possible to have some
> cores with core sched disabled?

Yep, patch even says so:

 + * XXX entirely possible to selectively enable cores, don't bother for now.

> I don't see a strong use case for it,
> but I am wondering if the design will fall apart if that assumption is
> broken?

The use-case I have is not using stop-machine. That is, stopping a whole
core at a time, instead of the whole sodding machine. It's on the todo
list *somewhere*....


