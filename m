Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3D29501B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502656AbgJUPo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502648AbgJUPo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:44:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA262177B;
        Wed, 21 Oct 2020 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603295096;
        bh=sX00NmwGKUkl2c3BWbnzn7oThe8HOgZFYccGHfGfiuc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=w8ec6R2QZsWzSsOAYPohChg6UJU6+FF6mNR/3wAr5ukO+OX8RhIWc0CtSvoIEZ7eV
         m1M3Hr9v+p2FxveVo3SSMlTD9VxNUtFRmjpU1yR/uK9zV6aFKOV7EGZfCWYBFwmKqy
         9GOCpCj3pLK7oTM8E/ObrMjYfnJAQkZvnn+n1ZGI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 76594352287B; Wed, 21 Oct 2020 08:44:56 -0700 (PDT)
Date:   Wed, 21 Oct 2020 08:44:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zong Li <zong.li@sifive.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, vincent.whitchurch@axis.com,
        tglx@linutronix.de, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, guoren@kernel.org, atishp@atishpatra.org,
        mhiramat@kernel.org, greentime.hu@sifive.com,
        colin.king@canonical.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] stop_machine: Mark functions as notrace
Message-ID: <20201021154456.GM3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201021073839.43935-1-zong.li@sifive.com>
 <20201021101216.4d840e15@gandalf.local.home>
 <20201021101522.3d1f3865@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021101522.3d1f3865@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:15:22AM -0400, Steven Rostedt wrote:
> On Wed, 21 Oct 2020 10:12:16 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > Fixes: 4ecf0a43e729 ("processor: get rid of cpu_relax_yield")
> > > Fixes: 366237e7b083 ("stop_machine: Provide RCU quiescent state in
> > > multi_cpu_stop()")  
> > 
> > I really do not like to add "notrace" to core functions because a single
> > architecture has issues with it. Why does RISCV have problems with these
> > functions but no other architecture does?
> > 
> > NACK from me until it is shown that these are issues for a broader set of
> > architectures.
> 
> After looking at the two above fixes, I take back my NACK ;-)
> 
> One of them duplicates an already notraced function, so that looks fine.
> The other makes a static function global, which could cause issues as well.
> 
> After further review:
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

If someone else would like to take this:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

Or let me know if you would like me to take it, target v5.11.

							Thanx, Paul
