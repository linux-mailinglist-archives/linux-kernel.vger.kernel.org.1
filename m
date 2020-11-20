Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A522BAC03
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgKTOiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:38:06 -0500
Received: from foss.arm.com ([217.140.110.172]:50090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgKTOiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:38:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6025311D4;
        Fri, 20 Nov 2020 06:38:05 -0800 (PST)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80AD73F718;
        Fri, 20 Nov 2020 06:38:03 -0800 (PST)
Date:   Fri, 20 Nov 2020 15:37:55 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, ionela.voinescu@arm.com,
        qperret@google.com, viresh.kumar@linaro.org
Subject: Re: [RFC] Documentation/scheduler/schedutil.txt
Message-ID: <20201120143715.GA3456@e123083-lin>
References: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120075527.GB2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Looks like a nice summary to me.

On Fri, Nov 20, 2020 at 08:55:27AM +0100, Peter Zijlstra wrote:
> Hi,
> 
> I was recently asked to explain how schedutil works, the below write-up
> is the result of that and I figured we might as well stick it in the
> tree.
> 
> Not as a patch for easy reading and commenting.
> 
> ---
> 
> NOTE; all this assumes a linear relation between frequency and work capacity,
> we know this is flawed, but it is the best workable approximation.

If you replace frequency with performance level everywhere (CPPC style),
most of it should still work without that assumption. The assumption
might have be made in hw or fw instead though.

Morten
