Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF1270206
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIRQXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRQXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:23:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8578A2100A;
        Fri, 18 Sep 2020 16:23:18 +0000 (UTC)
Date:   Fri, 18 Sep 2020 12:23:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>, mingo@redhat.com,
        mhiramat@kernel.org, mbenes@suse.cz, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH] ftrace: Fix missing synchronize_rcu() removing
 trampoline from kallsyms
Message-ID: <20200918122316.1307b05c@gandalf.local.home>
In-Reply-To: <20200911132624.GK1362448@hirez.programming.kicks-ass.net>
References: <20200901091617.31837-1-adrian.hunter@intel.com>
        <20200911114132.GH1362448@hirez.programming.kicks-ass.net>
        <ba8eaca9-c207-f1b1-9cf7-e2765533645c@intel.com>
        <20200911132624.GK1362448@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 15:26:24 +0200
peterz@infradead.org wrote:

>  
> > Doesn't that mean removing the symbol while the trampoline is potentially
> > still in use?  
> 
> Hurm.. potentially yes. OK, lets do this first.

OK, I queued this up to be tested and sent out for urgent.

-- Steve
