Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75691E9148
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgE3MrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 08:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728979AbgE3MrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 08:47:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B61920723;
        Sat, 30 May 2020 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590842823;
        bh=SNVHubkjqsXWme6MofNRkSL8I0AFskBuc7UccpcCAJ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qLwu1GqiJBYoskPR5lcmjmRlo0/0F7HCygZQ83uA87g5pk+ExOKdPuZJGNMzWJUy4
         Hn3t4bdyKKxu2FzeuTj6+EWjrjUEGDg0oEZl4iCVEsrLBaimuOMGnpnp9NmHL4dOAC
         0uSNVZjMsFbXbn46yfRkYWLqVNGHGUH/SbY3bGrs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2328D3522801; Sat, 30 May 2020 05:47:03 -0700 (PDT)
Date:   Sat, 30 May 2020 05:47:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rcu@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] refperf: work around 64-bit division
Message-ID: <20200530124703.GJ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200529201600.493808-1-arnd@arndb.de>
 <20200530035230.GA2019114@ubuntu-s3-xlarge-x86>
 <CAK8P3a3UB2M7Wv8BZx3-ASbsvxD3KHbHCCQ_04xTLPwkEB6twQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3UB2M7Wv8BZx3-ASbsvxD3KHbHCCQ_04xTLPwkEB6twQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 10:01:36AM +0200, Arnd Bergmann wrote:
> On Sat, May 30, 2020 at 5:52 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Fri, May 29, 2020 at 10:15:51PM +0200, Arnd Bergmann wrote:
> > >       strcat(buf, "Threads\tTime(ns)\n");
> > >
> > >       for (exp = 0; exp < nruns; exp++) {
> > > +             u64 avg;
> > > +             u32 rem;
> > > +
> > >               if (errexit)
> > >                       break;
> > > -             sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
> > > +
> > > +             avg = div_s64_rem(result_avg[exp], 1000, &rem);
> >
> > Shouldn't this be div_u64_rem? result_avg is u64.
> 
> Yes, you are right. Actually that would be an important optimization
> since div_u64_rem() optimizes for constant divisors while div_s64_rem
> uses the slow path.
> 
> > > +             sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, avg, rem);
> >
> > Would %03u be the better specifier since rem is u32?
> 
> Yes, though this makes no difference in practice.
> 
> Paul, should I send a fixup for these two, or do you prefer to just
> edit it in place?

I will apply it with Randy's Ack, thank you all!

							Thanx, Paul
