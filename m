Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC162F1939
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbhAKPMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbhAKPMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:12:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3E1C225AC;
        Mon, 11 Jan 2021 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610377880;
        bh=zElW2sWDzyZfO6SBLVrf34EqGMQd6Z7qO+5MC7vj4DQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vFe9g/bHlzijbYHVoIv5uiWmx4S8FaXK6WLkvyWjRZCmkOdKVVlL3Pah5Oi4E7A1i
         I8fdi0P3cJlVRS4wA7PGkrcDNQ+tanNfZVy6Xw7L814rplAkMZgZhCwvT8rMUJu6+0
         gaHuzkG+21mIZehn6/y+vDx2e9+Wpupx2vCV49MN1DXlh+qB0BFfR9r54e1xsmxFYc
         LqqnevpjVH7r73AcntW71yyr2O2Pkq+IoPXmwsuybAoPGoVQbA8SRWFM01MtHyCgA5
         GYsTcoXpqmxlfjaCbL0Dp1ae6o3pFjPO6zChH/Fpld2GRN87krXEfXSzVmBADWyBsk
         X7EIrUGD9Hk2Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9392735226C6; Mon, 11 Jan 2021 07:11:20 -0800 (PST)
Date:   Mon, 11 Jan 2021 07:11:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, bristot@redhat.com, frederic@kernel.org
Subject: Re: lockdep splat in v5.11-rc1 involving console_sem and rq locks
Message-ID: <20210111151120.GD2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210105220115.GA27357@paulmck-ThinkPad-P72>
 <X/xj1HL8MuoFc7F+@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/xj1HL8MuoFc7F+@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 03:42:28PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 05, 2021 at 02:01:15PM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > The RUDE01 rcutorture scenario (and less often, the TASKS01 scenario)
> 
> Is:
> 
>   tools/testing/selftests/rcutorture/bin/kvm.sh --duration 10 --configs RUDE01 --allcpus
> 
> the right incantation?

I responded on IRC, but may as well make it official:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10 --configs '32*RUDE01' --trust-make

This assumes a 64-CPU box, hence for this two-CPU scenario "32*".  This
will run 32 concurrent instances of RUDE01, thus reproducing more quickly.

The "--trust-make" is important in your case to avoid clobbering your
tags files.

							Thanx, Paul
