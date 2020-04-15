Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC11AB3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 00:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbgDOWxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 18:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgDOWx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:53:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA09E2076D;
        Wed, 15 Apr 2020 22:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586991207;
        bh=yl475YVYDILBuq3bu3pLRld5CucNEC2lEKdSnQlC/Z0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LzBvYbO1eouBLoFT26Mv6YHCIPiavEunbKu2Ti97vTdv1Hi4ym5Gwosh6NWyXjkCf
         sFXVZ2/TDmcqvoyCkhWHtChpYplbG1Eb/gc+nHAWFHxaNc4+SXlvY1A4HcdjFbQvG4
         nbYGWJTLyViZF2s1Djd1HDNNP+X/XfFWMfzjbCIY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BE2103522AD1; Wed, 15 Apr 2020 15:53:26 -0700 (PDT)
Date:   Wed, 15 Apr 2020 15:53:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415225326.GF17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home>
 <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home>
 <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
 <20200415164116.40564f2c@gandalf.local.home>
 <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
 <20200415174918.154a86d0@gandalf.local.home>
 <20200415220459.GE17661@paulmck-ThinkPad-P72>
 <20200415224214.GP2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415224214.GP2483@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 12:42:14AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 15, 2020 at 03:04:59PM -0700, Paul E. McKenney wrote:
> > 
> > My guess is that invoking rcu_irq_enter() and rcu_irq_exit() around every
> > potential call into module code out of the PM code is a non-starter,
> > but I cannot prove that either way.
> 
> Isn't that exactly what cpu_pm_notify() is doing?

Right you are!  Problem solved, then?

							Thanx, Paul
