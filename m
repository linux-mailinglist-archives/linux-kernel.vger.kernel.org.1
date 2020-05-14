Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3931D4152
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgENWtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 18:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgENWtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:49:15 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF4ED20709;
        Thu, 14 May 2020 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589496555;
        bh=2x2Ujz7VHOzikXbLX1adBO5wcVnnvE/Q1xNwgIXhZ+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oU6UtzuR7g9P17xnxg9EKR2vFAw+1l6sXOfg0Ei2AVVrF3w2oZqrC2NK7fm88UcGT
         0xlpVT1MnNvBBe1xWNksUyQOY4RQwywZxY5zK3ew2xn++RP8p3thtyajq35qmVPpGs
         oBkwr3rI4x43LDCCJAzV276pH8a1GZ4yekzGS+co=
Date:   Fri, 15 May 2020 00:49:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 07/10] rcu: Temporarily assume that nohz full CPUs might
 not be NOCB
Message-ID: <20200514224912.GB4071@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-8-frederic@kernel.org>
 <20200513182527.GU2869@paulmck-ThinkPad-P72>
 <20200513230827.GC18303@lenoir>
 <20200514155032.GN2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514155032.GN2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:50:32AM -0700, Paul E. McKenney wrote:
> On Thu, May 14, 2020 at 01:08:28AM +0200, Frederic Weisbecker wrote:
> > On Wed, May 13, 2020 at 11:25:27AM -0700, Paul E. McKenney wrote:
> > > On Wed, May 13, 2020 at 06:47:11PM +0200, Frederic Weisbecker wrote:
> > > > So far nohz_full CPUs had to be nocb. This requirement may change
> > > > temporarily as we are working on preparing RCU to be able to toggle the
> > > > nocb state of a CPU. Once that is done and nohz_full can be toggled as
> > > > well dynamically, we'll restore that initial requirement.
> > > 
> > > Would it simplify anything to make the CPU exit nohz_full first and
> > > then exit rcu_nocb and vice versa in the other direction?  That way the
> > > assumption about nohz_full CPUs always being rcu_nocb could remain while
> > > still allowing runtime changes to both states.
> > 
> > That's the future plan but for now nohz_full can't even be exited yet.
> > RCU is unlucky enough to be chosen as the starting point of this whole work :-)
> 
> But testing could still start with CPUs marked rcu_nocb but not marked
> nohz_full, right?

Ah! That makes sense indeed. I should indeed restrict de-offloading to CPUs
that are not nohz_full.

> I must confess that I am a bit concerned about the increase in state space.

Yeah good point!

> Fair point, but I am also concerned about the welfare of the people
> working on it.  ;-)

Fair enough! :-)
