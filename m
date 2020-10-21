Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E3229508C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444395AbgJUQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732713AbgJUQQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:16:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166152087D;
        Wed, 21 Oct 2020 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603296965;
        bh=R3htHAUwTw2drbNzQ1tbMbw6mnrT0mqJBt46dxSNaEY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RT7ZgELOw7eMhqDeQtFTjzqiw0zuhkvzLqZoTqj+QasAdbFk+JDwVaZDAPQnie92L
         Vliz67QD5LqJ5cU8UdeIRXEArkbeqP5ylqFDmFWd7LFEOpdZcmBRWZ8yG3BTvg7pv+
         gppuCZY1eC5kQ8ed2WGy5gbw3SNEBp8Bgz2wYOiI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AA796352287B; Wed, 21 Oct 2020 09:16:04 -0700 (PDT)
Date:   Wed, 21 Oct 2020 09:16:04 -0700
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
Message-ID: <20201021161604.GN3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201021073839.43935-1-zong.li@sifive.com>
 <20201021101216.4d840e15@gandalf.local.home>
 <20201021101522.3d1f3865@gandalf.local.home>
 <20201021154456.GM3249@paulmck-ThinkPad-P72>
 <20201021115451.44424566@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021115451.44424566@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 11:54:51AM -0400, Steven Rostedt wrote:
> On Wed, 21 Oct 2020 08:44:56 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Or let me know if you would like me to take it, target v5.11.
> 
> I'm not sure if these can wait, as I believe they are fixing a regression
> with RISCV function tracing.
> 
> Probably best to have them go through the RISCV tree.

Works for me!

							Thanx, Paul
