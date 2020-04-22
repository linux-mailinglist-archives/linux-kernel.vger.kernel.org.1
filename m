Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223111B48F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDVPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDVPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:42:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17447C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w7os9iLev/9dj2qAgL+949q1zGpOmKIk3i33sopb+WM=; b=Rg2aj+WZ7Wbxlfo/3Hh1nS1Dv4
        Lj+oJWA/iNq8lDrz4075SEyqxxQP06CwR55dudxI/xM/9OtSHU7TBTNWSMIsWAJo2v2nYHn1tyteA
        oDPK75TnebDxNQX9s6V/pIzLj7jUXVCBtobqO4fMKjmY5IEwy6MbbGGG/GpzDmjZNWFw2Kp4/lMtd
        tQe9o36pKOa1SNpSYyFSnShDmwgmF7WSNya9fgijcUVauXHmaeL4IHxo3IFUvQgVrhmrtiyppJHW+
        xU9zT2Sv3tw6PlrEdsGD5gCSKK4hMj6QNf/dEFNhzMDHuJ6BmdGsITBbBl9eDvpqjlyKSaWnh31/K
        uDeFuSBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRHW5-0003jE-D5; Wed, 22 Apr 2020 15:42:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A761030477A;
        Wed, 22 Apr 2020 17:42:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8851E286B71D5; Wed, 22 Apr 2020 17:42:23 +0200 (CEST)
Date:   Wed, 22 Apr 2020 17:42:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
Message-ID: <20200422154223.GO20730@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.988065598@infradead.org>
 <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
 <20200422132923.GK20730@hirez.programming.kicks-ass.net>
 <CAKfTPtBsFDt8JyxjD39B2YP+kCN9nXWZxnaJys9sz2CjWzd1Zw@mail.gmail.com>
 <20200422135921.GL20730@hirez.programming.kicks-ass.net>
 <20200422153820.GK9767@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422153820.GK9767@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:38:20PM +0200, Juri Lelli wrote:
> On 22/04/20 15:59, Peter Zijlstra wrote:

> > I should get back to proxy execution I suppose...
> 
> Huh, so you really think proxy exec should be default on for kernel
> mutexes...

We'll see, ideally yes, but even if not, then you have something to give
to people who run into trouble.

It would also allow a true idle time class, although I'm not sure we'd
actually want to go there.
