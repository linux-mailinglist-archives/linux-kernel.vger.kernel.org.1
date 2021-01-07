Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D02ED336
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbhAGPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbhAGPGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:06:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E968322B2B;
        Thu,  7 Jan 2021 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610031950;
        bh=QVBe+8xawnGxSu90TwsMGxNaWxKPCzC1iEicL95XcVg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sALm77uDwhTnLwzNgG2IAGY0QipoBSlHduiLeV4XfCU9Yq4gLmQSyBH9grBPbnsy/
         CNGKTXVxSTktK2ztsJbdqWs0Hi+/PUxsh0LpeEiQGrTAk9HkzGExj+yclOaABMJyEi
         rXSmXB/J0p2bL6C8RKEV2xHoBhFLfbwFZUSJgz9jOBsbUXH5JXPBArl3dAO6d2qqv6
         iW2Ti7eI0ZmpgFmybuQzjxcHzGbUqX6DfrExIGbTBDMWpoRE0VXCzEN1PB3RIuRjB7
         G2/k9tI++wpOX539PqN0YXJCDaPCSYtLNNsQ5fPVhBECFwf5jbcdcBxnJlhY7dcemt
         9VeA+jrwkKUlA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AB6E83522589; Thu,  7 Jan 2021 07:05:50 -0800 (PST)
Date:   Thu, 7 Jan 2021 07:05:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list
 specifications
Message-ID: <20210107150550.GA12121@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
 <20210106004956.11961-4-paulmck@kernel.org>
 <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
 <CAAH8bW9jfSeYe+d6feQUTKuqwKr_U0aCGPZEiBh6Hp=KT2iPrA@mail.gmail.com>
 <X/cYR474/PiTvjfC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/cYR474/PiTvjfC@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 03:18:47PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 06, 2021 at 01:16:50PM -0800, Yury Norov wrote:
> > On Wed, Jan 6, 2021 at 1:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Aside from the comments Yury made, on how all this is better in
> > > bitmap_parselist(), how about doing s/last/N/ here? For me something
> > > like: "4-N" reads much saner than "4-last".
> > >
> > > Also, it might make sense to teach all this about core/node topology,
> > > but that's going to be messy. Imagine something like "Core1-CoreN" or
> > > "Nore1-NodeN" to mean the mask all/{Core,Node}0.
> > 
> > If you just want to teach bitmap_parselist() to "s/Core0/0-4",  I think
> > it's doable if we add a hook to a proper subsystem in bitmap_parselist().
> > 
> > > And that is another feature that seems to be missing from parselist,
> > > all/except.
> > 
> > We already support groups in a range. I think it partially covers the
> > proposed all/except.
> > 
> > Can you share examples on what you miss?
> 
> The obvious one is the "all/Core0" example above, which would be
> equivalent to "Core1-CoreN".
> 
> Another case that I don't think we can do today is something like, give
> me SMT0 of each core.
> 
> I don't really see the use of the ranges thing, CPU enumeration just
> isn't sane like that.

Ranges are useful on many systems.  Users of systems with insane CPU
enumeration are of course free to provide comma-separated lists of
numbers for their cpumask boot parameters, avoiding use of minus signs.

							Thanx, Paul
