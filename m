Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15126A5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIONKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgIONFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:05:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A930020684;
        Tue, 15 Sep 2020 13:05:22 +0000 (UTC)
Date:   Tue, 15 Sep 2020 09:05:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing: Make the space reserved for the pid wider
Message-ID: <20200915090520.2047abe8@gandalf.local.home>
In-Reply-To: <20200915104648.hac2ljgzrqc7z244@linutronix.de>
References: <20200904082331.dcdkrr3bkn3e4qlg@linutronix.de>
        <20200915104648.hac2ljgzrqc7z244@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 12:46:48 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-09-04 10:23:31 [+0200], To linux-kernel@vger.kernel.org wrote:
> > For 64bit CONFIG_BASE_SMALL=0 systems PID_MAX_LIMIT is set by default to
> > 4194304. During boot the kernel sets a new value based on number of CPUs
> > but no lower than 32768. It is 1024 per CPU so with 128 CPUs the default
> > becomes 131072 which needs six digits. 
> > This value can be increased during run time but must not exceed the
> > initial upper limit.
> > 
> > Systemd sometime after v241 sets it to the upper limit during boot. The
> > result is that when the pid exceeds five digits, the trace output is a
> > little hard to read because it is no longer properly padded (same like
> > on big iron with 98+ CPUs).
> > 
> > Increase the pid padding to seven digits.  
> 
> ping
> 

Hi Sebastian,

I'm still buried in email from my PTO, with lots of patches I need to
review and apply (or comment on). And I'm also behind in internal work
affairs. I'm not ignoring this, just taking some time to get to it :-/

-- Steve
