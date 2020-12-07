Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73762D131C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgLGOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLGOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:08:32 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A76C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t9JVtccZhruRcOGLugVXjQEElN6m7omXSawwFB3XZqg=; b=YPXhzdGBczbaTjlixmnO9s9wlv
        rNwjUS1kr/3tEJ1vK+63966fadOQSfK/LXA+40SM5u/SONyL9/1aFYa8r2ak7dlYClA36XAkD7lT9
        7vrduVZxr8yt3gs2P1ZzeQV7+Hc+XHDLae6g2D/IcCp3rzYD3fn2K4fxW3w8vilbnuJZhRsn35Wih
        /4/jrB+ExzGJuxburIlzlbUUcDPdg96F8RWKkfwWtsL7yI00Nuxh7MQw+OelXEnFNo2jz0Ar/g0gg
        +bQbXjUssjWOZIzKmpAJ/y0IdBX8f78csfn7Rn5WzygtEMSLaBffMv/yMEoDY+rDEAW5PO3QcPgtd
        BeMQncNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmHAq-0001hW-G5; Mon, 07 Dec 2020 14:07:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E0C1301478;
        Mon,  7 Dec 2020 15:07:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7CDA20815F13; Mon,  7 Dec 2020 15:07:30 +0100 (CET)
Date:   Mon, 7 Dec 2020 15:07:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>
Subject: Re: [PATCH -tip v1 0/3] seqlock: assorted cleanups
Message-ID: <20201207140730.GO3040@hirez.programming.kicks-ass.net>
References: <20201206162143.14387-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206162143.14387-1-a.darwish@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 05:21:40PM +0100, Ahmed S. Darwish wrote:
> Ahmed S. Darwish (3):
>   Documentation: seqlock: s/LOCKTYPE/LOCKNAME/g
>   seqlock: Prefix internal seqcount_t-only macros with a "do_"
>   seqlock: kernel-doc: Specify when preemption is automatically altered

Thanks!
