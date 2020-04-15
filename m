Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4E1AA25D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898260AbgDOMyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 08:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898252AbgDOMxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:53:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6408E20737;
        Wed, 15 Apr 2020 12:53:50 +0000 (UTC)
Date:   Wed, 15 Apr 2020 08:53:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415085348.5511a5fe@gandalf.local.home>
In-Reply-To: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Peter +Thomas ]

On Tue, 14 Apr 2020 19:20:01 -0700
John Stultz <john.stultz@linaro.org> wrote:

> Hey folks,
>   So recently I was looking at converting some drivers to be loadable
> modules instead of built-in only, and one of my patches just landed in
> -next and started getting build error reports.
> 
> It ends up, recently in the merge window, the driver I was converting
> to module switched a trace_*() function to trace_*_rcuidle() to fix a
> bug.  Now when building as a module, if tracing is configured on, it
> can't seem to find the trace_*_rcuidle() symbol.

Which modules need this.

Currently, Thomas and Peter are working on removing trace events from
places that don't have RCU enabled, or at least cleaning up the context
switches from user to kernel to interrupt.

-- Steve


> 
> This is because, as you are aware, we don't declare trace_*_rcuidle
> functions in modules - and haven't for quite some time:
>   https://lore.kernel.org/lkml/20120905062306.GA14756@leaf/
> 
> I wanted to better understand the background rationale for that patch,
> to understand if not exporting the rcu_idle_exit and rcu_idle_enter,
> calls was because they weren't used or if it was a more intentional
> decision to avoid allowing modules to use them.
> 
> Would it be reasonable to revisit that patch? Or is there some
> recommended alternative solution?
> 
> thanks
> -john

