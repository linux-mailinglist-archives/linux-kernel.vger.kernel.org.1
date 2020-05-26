Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5696F1B63FE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgDWSrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 14:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgDWSrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:47:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED3C09B043;
        Thu, 23 Apr 2020 11:47:23 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRgsX-0003Hz-KU; Thu, 23 Apr 2020 20:47:17 +0200
Date:   Thu, 23 Apr 2020 20:47:17 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was
 Re: [ANNOUNCE] v5.4.28-rt19)
Message-ID: <20200423184717.w3c6eymkic5wnlix@linutronix.de>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
 <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
 <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
 <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
 <20200423090601.2439e64f@gandalf.local.home>
 <20200423143437.3d82c3ea@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423143437.3d82c3ea@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-23 14:34:37 [-0400], Steven Rostedt wrote:
> On Thu, 23 Apr 2020 09:06:01 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > BTW, I haven't released a new 5.4-rt because the default one is triggering
> > a large latency somewhere, and makes my tests fail. I'm trying to dig into
> > the cause when I get time.
> 
> Figured it out. Seems that starting with 5.4-rt, PREEMPT_RT now depends on
> CONFIG_EXPERT, which I didn't have set, and PREEMPT_RT was disabled when
> using my default config.
> 
> Had to add CONFIG_EXPERT to my default config to make it work again.

Yes, this changed upstream.

> Starting the tests over....
> 
> -- Steve

Sebastian
