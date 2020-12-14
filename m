Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE32D9B24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406101AbgLNPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbgLNPeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:34:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD8922B2C;
        Mon, 14 Dec 2020 15:33:36 +0000 (UTC)
Date:   Mon, 14 Dec 2020 10:33:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH] jump_label: Do not profile branch annotations
Message-ID: <20201214103335.3cb2d0bb@gandalf.local.home>
In-Reply-To: <20201214085206.GW3040@hirez.programming.kicks-ass.net>
References: <20201211163754.585174b9@gandalf.local.home>
        <20201214085206.GW3040@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 09:52:06 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Dec 11, 2020 at 04:37:54PM -0500, Steven Rostedt wrote:
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > While running my branch profiler that checks for incorrect "likely" and
> > "unlikely"s around the kernel, there's a large number of them that are
> > incorrect due to being "static_branches".
> > 
> > As static_branches are rather special, as they are likely or unlikely for
> > other reasons than normal annotations are used for, there's no reason to
> > have them be profiled.
> > 
> > Expose the "unlikely_notrace" and "likely_notrace" so that the
> > static_branch can use them, and have them be ignored by the branch
> > profilers.  
> 
> The less that abomination does the better ;-), I'll take it through tip
> then?

Sure, go ahead.

Thanks.

-- Steve
