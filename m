Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793FD2ED303
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbhAGOsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbhAGOsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:48:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89D582158C;
        Thu,  7 Jan 2021 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610030877;
        bh=4GprV8duZGligEHdUJ/5ZiVI5TS+T71Sh11ApVa10bM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hYoXaKVNfEkh4E96OUbh01X3rHviFBRGiF6JXy7d0xRpgTxFmrWmV+voaZMKsRD2B
         H/AqwHOOfzqjHblQuh2Kr1oZ3Jwp5jo03G1vbVP8+G1pyH5W8zcalFbW0ReLtOhFEy
         UxgVyokCadaSqaRUKaUi7exs5uT4MUMLZFh0zr1QpfGl0ZmD8qROuChFnrU4qNyhPn
         Ui4ZMleZRxh9gEAeSxc7SernbYnuKQn20c3iBkP2+NjawQRo6qLLW830P0Hw5eJwJa
         8CeEOAxd1rThCOoi4c7fQKGoYNCWWmxi/7TmMh8svAS+KExJ9GWH5Hykt75aulSHpT
         e4TIlw/cS2vHQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4C51B3522584; Thu,  7 Jan 2021 06:47:57 -0800 (PST)
Date:   Thu, 7 Jan 2021 06:47:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list
 specifications
Message-ID: <20210107144757.GK2743@paulmck-ThinkPad-P72>
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
> isn't sane like that. Also, I should really add that randomization pass
> to the CPU enumeration :-)

Please don't!!!

							Thanx, Paul
