Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC57227214
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 00:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgGTWTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 18:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgGTWTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:19:46 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8CD20773;
        Mon, 20 Jul 2020 22:19:45 +0000 (UTC)
Date:   Mon, 20 Jul 2020 18:19:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, sfr@canb.auug.org.au
Subject: Re: [tip:sched/fifo 44/45] ERROR: modpost: "sched_setscheduler"
 undefined!
Message-ID: <20200720181943.7d8efc65@oasis.local.home>
In-Reply-To: <20200720214918.GM5523@worktop.programming.kicks-ass.net>
References: <202006192249.AYnVBGCH%lkp@intel.com>
        <20200709124505.GT597537@hirez.programming.kicks-ass.net>
        <20200709115818.36a956a4@oasis.local.home>
        <20200720214918.GM5523@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 23:49:18 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Steve, would this work for you, or would you prefer renaming the
> parameters as well?
> 

Yeah, that's fine. You don't have any sched_fifo_high() ?

Sometimes I see what the numbers are at prio 98.

Not a big deal, as I seldom do that, and I'm probably the only one
doing it. I can live with patching the kernel to do that test.

-- Steve
