Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDF72FF549
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAUUBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:01:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbhAUT5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:57:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9482A224B2;
        Thu, 21 Jan 2021 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611259015;
        bh=xRFtoH8ETucU1mVkARB8R7nIZSJDffjwdHq/w8EpcCQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BjF+pnobo2sBYiPFcK+n2sBIAvs0QmdzuR5FZ9URY5DJEBBs5HMFPdy3VuZQ5wDgK
         DFVZktvVNRjPtKgW2PVVMBgTgMSKXwctOdG7mBiyXvtZDpBnzsTahgPT6TzjhP9EHE
         EZcCa9clhNJ7TX7+cqmO7aaZJ7N0ohKI4dMIR7yY1UHgC7af46ZhSm/eYUsy9fhAdY
         VGm1A5fkOWJsvdNyrxMy1s5nvv/rDjFm/4+0MirTfZ4RAbSb66bcyBiIgUWu6oU3uo
         XH1MYYSMwccZQdpJDsEt+AXybx6ohX2h5QeTmYoFfMYzchEkhw4ZTkN73CRxVgpQ5V
         pfwHGoTs0xpAg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 34D4D35214EB; Thu, 21 Jan 2021 11:56:55 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:56:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH -v3 0/9] sched: Fix hot-unplug regression
Message-ID: <20210121195655.GT2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210121101702.402798862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121101702.402798862@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:17:02AM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Some cautious optimism lets me post v3 of these patches. They (knock on wood)
> fix the regression introduced by commit:
> 
>   1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")
> 
> These patches survived overnight runs for both me and Valentin, but I'll let it
> run for at least another 12 hours before committing these patches.
> 
> New in this version is patch #7.
> 
> Much thanks to Valentin for his continued support and debugging efforts.

Thank you all!!!  I have started testing these on top of -rcu.

							Thanx, Paul
