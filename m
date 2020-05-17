Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A61D68B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgEQPxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 11:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgEQPxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:53:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1608206F4;
        Sun, 17 May 2020 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589730802;
        bh=Ww47uegJtkmfCjYmAAngFSupZRGswQhi+92Gghy9g90=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=c9iyUSP1ulImt0PavWrCbKBSl3ZQUawyVE+nrSlcJJ63ZHfHo2cQSzlJ8+uoCj9a+
         HlwmMXmmpdex6YtTo4t0YLmhgZN/36EDb89sDwQhf5riXmOBoMcxzaQJTaDPOif3il
         FLo4n/pC7lD9kLtKVYXiXi1o/w/RklVPe9z2tAO0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A4F9A3520FBB; Sun, 17 May 2020 08:53:22 -0700 (PDT)
Date:   Sun, 17 May 2020 08:53:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>, stable@kernel.org
Subject: Re: [PATCH] tick/nohz: Narrow down noise while setting current
 task's tick dependency
Message-ID: <20200517155322.GQ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200515003429.4317-1-frederic@kernel.org>
 <20200516030718.GL2869@paulmck-ThinkPad-P72>
 <20200517133115.GA28573@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517133115.GA28573@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 03:31:16PM +0200, Frederic Weisbecker wrote:
> On Fri, May 15, 2020 at 08:07:18PM -0700, Paul E. McKenney wrote:
> > On Fri, May 15, 2020 at 02:34:29AM +0200, Frederic Weisbecker wrote:
> > > So far setting a tick dependency on any task, including current, used to
> > > trigger an IPI to all CPUs. That's of course suboptimal but it wasn't
> > > an issue as long as it was only used by posix-cpu-timers on nohz_full,
> > > a combo that nobody seemed to use in real life.
> > > 
> > > But RCU started to use task tick dependency on current task to fix
> > > stall issues on callbacks processing. These trigger regular and
> > > undesired system wide IPIs on nohz_full.
> > > 
> > > The fix is very easy while setting a tick dependency on the current
> > > task, only its CPU needs an IPI.
> > 
> > This passes moderate rcutorture testing.  If you want me to take it, please
> > let me know, and otherwise:
> > 
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> If you already have a pending urgent queue, I'd love you to take it.
> If not I can take it.

Nothing urgent yet in -rcu, so if you would like it in the next merge
window, please take it through your normal upstream path.

							Thanx, Paul
