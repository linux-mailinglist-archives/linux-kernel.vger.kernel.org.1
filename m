Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609C62760AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIWTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIWTAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:00:53 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5F2208B6;
        Wed, 23 Sep 2020 19:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600887653;
        bh=q8SPyCYBoxajNHJ9kslUFkwc9l2D1wSjsod45ANj2AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QC5KzA8bb7fmb8EtS2jSwoE6+EShyG1IPvPuzi4k7j7kRPLEhrac+YlEfcgVfLskR
         pmSMMhCxArR+3ABTw55pgWSe66jcPErRQPyrBmiOgxWwd6BuBlb0EZZYxwE4i+PdKm
         HlW8vJv7W7Vvx+UTpPTezbtf4Ht1583gDmMjT3DA=
Date:   Wed, 23 Sep 2020 21:00:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 12/12] rcu: Nocb (de)activate through sysfs
Message-ID: <20200923190050.GA1026@lenoir>
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-13-frederic@kernel.org>
 <20200922002629.GS29330@paulmck-ThinkPad-P72>
 <20200923152745.GB31465@lenoir>
 <20200923154716.GP29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923154716.GP29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 08:47:16AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 23, 2020 at 05:27:46PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 21, 2020 at 05:26:29PM -0700, Paul E. McKenney wrote:
> > > On Mon, Sep 21, 2020 at 02:43:51PM +0200, Frederic Weisbecker wrote:
> > > > Not for merge.
> > > > 
> > > > Make nocb toggable for a given CPU using:
> > > > 	/sys/devices/system/cpu/cpu*/hotplug/nocb
> > > > 
> > > > This is only intended for those who want to test this patchset. The real
> > > > interfaces will be cpuset/isolation and rcutorture.
> > > 
> > > Excellent choice for testing in the near term!
> > > 
> > > How does rcutorture fare with this series if an additional kthread toggles
> > > offloading on and off continually?
> > 
> > So yeah that would be the plan: having something that randomly toggles
> > offloading from the RCU tests themselves. I'm not quite familiar with
> > rcutorture internals yet though.
> 
> If you supply a function that selects a CPU and does the toggle, I
> can quickly and easily wire it into rcutorture.  I of course have no
> objection to your learning to do this yourself, but the offer stands.

I gladly accept your proposal! This way I will integrate it in the set
and start testing.

The functions to call would be:

void rcu_nocb_cpu_offload(int cpu);
void rcu_nocb_cpu_deoffload(int cpu);


> 
> > > All questions and concerns aside, excellent progress and nice work!!!
> > 
> > Thanks! We are slowly making progress :)
> 
> Better than quickly failing to make progress, to be sure!  ;-)

;-)

Thanks a lot!
