Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C62F6728
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbhANRN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:13:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbhANRN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:13:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0B6123B1C;
        Thu, 14 Jan 2021 17:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610644397;
        bh=YkfYKFhD60r7aJ08iIlPNxpml5MZm6jxC/Z8z/gNDMc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZTq1MyWGIe6Fyk9JF8cyW43rupJUbRnm4wpLMSafbWdULnsbKNpqGspUCk9rhbWYq
         WddGCBZa0cwQS1BLgxpJX2uLVjzmA4PcKCpqrqRf9f0u351Y1iKP0D77Zn4a2k5lvs
         jnHXxJM5dV4gFXwMxFvGtnjgYzAiSSo3GQQrYpZo3Zyz6IBCXv33LVK/bRAKqz16VZ
         Tk7hd222VY+AwtHYU8tU9l+5Wgd3XEJoDjemUjdjpa+JrZwkGqHJo/jxX0BsWqWzYH
         hymp+cI0vEmDIMXSpwvXIFAssMsfUw5aNKTdI0uBvm+7lPdrhh0CxUNnzSrLClMFlD
         /se2L2QZZ5YWQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 72B7935225DC; Thu, 14 Jan 2021 09:13:17 -0800 (PST)
Date:   Thu, 14 Jan 2021 09:13:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, jiangshanlai@gmail.com,
        cai@redhat.com, vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH] sched/core: Print out straggler tasks in
 sched_cpu_dying()
Message-ID: <20210114171317.GJ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210113183141.11974-1-valentin.schneider@arm.com>
 <20210113220244.GC2743@paulmck-ThinkPad-P72>
 <jhjft34z84j.mognet@arm.com>
 <20210114003613.GD2743@paulmck-ThinkPad-P72>
 <jhjczy7ztw0.mognet@arm.com>
 <20210114152207.GI2743@paulmck-ThinkPad-P72>
 <jhj35z3o6qv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj35z3o6qv.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 03:52:56PM +0000, Valentin Schneider wrote:
> On 14/01/21 07:22, Paul E. McKenney wrote:
> > If someone can identify Lai's series to me, I would be happy to give it
> > a try as well.  All I see are workqueue-specific patches and patches
> > contributing to the discussion of possible fixes to the splats from
> > Peter's series.  (I figured that I would wait for the discussion to
> > converge a bit.)
> >
> 
> I was referring to
> 
> http://lore.kernel.org/r/20210111152638.2417-1-jiangshanlai@gmail.com
> 
> which I believe you already tested earlier version of.

Indeed I did, thank you for the clarification.

							Thanx, Paul
