Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376782F8E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbhAPRpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbhAPRpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:45:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6CF6223E8;
        Sat, 16 Jan 2021 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610812139;
        bh=vVxVxDKMgBksZsJB4PnZLyS1CXxOzr58eu8XRjlxEcs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uXPlujWekrJP6tY1pw447bRdiFrLDxBhNh6f1mHMP/5bNM+1iYuVRbWtiuZfAZyk0
         qHJoAfrsXtVaLcElwokSvZ/m80es/06kw9mw+qM36CYFUniXl9Mj2QTspYicILqGMM
         a/5NI9P/UpHa/tVgPW1u0ywQsYm5XTjryZkKIlA94+EKbMhI1G+wvhflJ8zY/U0/ke
         GRLns7cllWaIymFCYYDyNMHaieTdROJzYoMMnxg7wMpsAEHhM33BSxMgWM54V+eSwK
         0XRKS+T+KhkyajRsu18hrxYTS/iqON2MlWPKEaDwlNbFXu/JAp9cTkru1kQmK80ISg
         vKeVroFmbwwwA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7C78F35225DC; Sat, 16 Jan 2021 07:48:59 -0800 (PST)
Date:   Sat, 16 Jan 2021 07:48:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH 0/8] sched: Fix hot-unplug regressions
Message-ID: <20210116154859.GR2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210116113033.608340773@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116113033.608340773@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 12:30:33PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> These patches (no longer 4), seems to fix all the hotplug regressions as per
> nearly a 100 18*SRCU-P runs over-night.

Nice!!!

> I did clean up the patches, so possibly I wrecked it again. I've started new
> runs and will again leave them running over-night.
> 
> Paul, if you could please also throw your monster machine at it.

Will do as soon as the tests I started yesterday complete, which should
be this afternoon, Pacific Time.

My thought is to do the full set of scenarios overnight, then try
hammering either SRCU-P and/or whatever else shows up in the overnight
test.  Seem reasonable?

							Thanx, Paul
