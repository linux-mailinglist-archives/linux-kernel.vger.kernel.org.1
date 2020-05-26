Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FF1B63DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgDWSek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 14:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbgDWSek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:34:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AEFD2071C;
        Thu, 23 Apr 2020 18:34:39 +0000 (UTC)
Date:   Thu, 23 Apr 2020 14:34:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was
 Re: [ANNOUNCE] v5.4.28-rt19)
Message-ID: <20200423143437.3d82c3ea@gandalf.local.home>
In-Reply-To: <20200423090601.2439e64f@gandalf.local.home>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
        <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
        <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
        <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
        <20200423090601.2439e64f@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 09:06:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> BTW, I haven't released a new 5.4-rt because the default one is triggering
> a large latency somewhere, and makes my tests fail. I'm trying to dig into
> the cause when I get time.

Figured it out. Seems that starting with 5.4-rt, PREEMPT_RT now depends on
CONFIG_EXPERT, which I didn't have set, and PREEMPT_RT was disabled when
using my default config.

Had to add CONFIG_EXPERT to my default config to make it work again.

Starting the tests over....

-- Steve
