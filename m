Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EED2B1BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKMN0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:26:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMN0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:26:55 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C643522240;
        Fri, 13 Nov 2020 13:26:53 +0000 (UTC)
Date:   Fri, 13 Nov 2020 08:26:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/3 v6] ftrace: Add access to function arguments for all
 callbacks
Message-ID: <20201113082652.61753e83@oasis.local.home>
In-Reply-To: <20201113080733.GZ2628@hirez.programming.kicks-ass.net>
References: <20201113020142.252688534@goodmis.org>
        <20201113080733.GZ2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 09:07:33 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 12, 2020 at 09:01:42PM -0500, Steven Rostedt wrote:
> > Steven Rostedt (VMware) (3):
> >       ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
> >       ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
> >       livepatch: Use the default ftrace_ops instead of REGS when ARGS is available  
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks Peter!

-- Steve
