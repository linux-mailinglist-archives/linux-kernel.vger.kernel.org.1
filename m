Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4C1C9988
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgEGSph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 14:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGSph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:45:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92ED520870;
        Thu,  7 May 2020 18:45:35 +0000 (UTC)
Date:   Thu, 7 May 2020 14:45:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
Message-ID: <20200507144534.09abd685@gandalf.local.home>
In-Reply-To: <f0e6f50e910238366b1d8f398c91d3066baac7cf.camel@perches.com>
References: <20200507110625.37254-1-yanaijie@huawei.com>
        <jhjpnbg6lkf.mognet@arm.com>
        <20200507132828.1af39b80@gandalf.local.home>
        <20200507133024.18dbe349@gandalf.local.home>
        <f0e6f50e910238366b1d8f398c91d3066baac7cf.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 May 2020 10:55:33 -0700
Joe Perches <joe@perches.com> wrote:

> > If anything, we can teach people to try to understand their fixes, to see
> > if something is really a fix or not. Blindly accepting changes like this,
> > is no different than blindly submitting patches because some tool says its
> > an issue.  
> 
> <shrug>
> 
> Most people seem to prefer bool returns with apparent bool constants
> even though true and false are enumerator constants (int) of 1 and 0
> in the kernel.
> 
> from include/linux/stddef.h:
> 
> enum {
> 	false	= 0,
> 	true	= 1
> };

Sure, do that for new code, but we don't need these patches popping up for
current code. That is, it's a preference not a bug.

-- Steve
