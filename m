Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C999F2FEF81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbhAUPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:51:52 -0500
Received: from foss.arm.com ([217.140.110.172]:39772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387448AbhAUPoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:44:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C659D11D4;
        Thu, 21 Jan 2021 07:43:20 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2201A3F68F;
        Thu, 21 Jan 2021 07:43:20 -0800 (PST)
Date:   Thu, 21 Jan 2021 15:43:15 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 4/4] cpu/hotplug: Fix CPU down rollback
Message-ID: <20210121154314.GA439562@e120877-lin.cambridge.arm.com>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-5-git-send-email-vincent.donnefort@arm.com>
 <YAmWP1vbLYFgl82n@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAmWP1vbLYFgl82n@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 03:57:03PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 11, 2021 at 05:10:47PM +0000, vincent.donnefort@arm.com wrote:
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > After the AP brought itself down to CPUHP_TEARDOWN_CPU, the BP will finish
> > the job. The steps left are as followed:
> > 
> >    +--------------------+
> >    | CPUHP_TEARDOWN_CPU |  -> If fails state is CPUHP_TEARDOWN_CPU
> >    +--------------------+
> >    |   ATOMIC STATES    |  -> Cannot Fail
> >    +--------------------+
> >    |  CPUHP_BRINGUP_CPU |  -> Cannot fail
> >    +--------------------+
> >    |        ...         |
> >    |        ...         |  -> Can fail and rollback
> 
> These are the PREPARE/DEAD states, right? It would be _really_ daft for
> a DEAD notifier to fail. But yeah, I suppose that if it does, it will
> indeed end up in CPUHP_AP_ONLINE_IDLE.
> 
> Do we want to WARN when a DEAD notifier fails?
> 
> 

Indeed, I couldn't find a dead callback which can return an error. So I
suppose we could go for another strategy here, that would be to not allow
failure for the dead states (i.e states < BRINGUP_CPU when hotunplug). In
that case, the fail interface should probably disallow selecting those
states and a WARN here would be good.

-- 
Vincent
