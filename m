Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86C12B24F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKMTzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgKMTzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:55:37 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3312076B;
        Fri, 13 Nov 2020 19:55:35 +0000 (UTC)
Date:   Fri, 13 Nov 2020 19:55:33 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, sudeep.holla@arm.com,
        will@kernel.org, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: abort counter_read_on_cpu() when irqs_disabled()
Message-ID: <20201113195532.GA20519@gaia>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
 <20201113155328.4194-1-ionela.voinescu@arm.com>
 <20201113160234.GB44988@C02TD0UTHF1T.local>
 <20201113165843.GA6973@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113165843.GA6973@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:58:43PM +0000, Ionela Voinescu wrote:
> On Friday 13 Nov 2020 at 16:02:34 (+0000), Mark Rutland wrote:
> > On Fri, Nov 13, 2020 at 03:53:28PM +0000, Ionela Voinescu wrote:
> > > Given that smp_call_function_single() can deadlock when interrupts are
> > > disabled, abort the SMP call if irqs_disabled(). This scenario is
> > > currently not possible given the function's uses, but safeguard this for
> > > potential future uses.
> > 
> > Sorry to contradict earlier feedback, but I think this is preferable
> > as-is, since smp_call_function_single() will
> > WARN_ON_ONCE(irqs_disabled())), but this will silently mask any dodgy
> > usage.
> 
> Probably it only contradicts the chosen implementation.
> 
> > If we want a separate check here, I reckon we should wrap it with a
> > WARN_ON_ONCE(), and only relax that if/when we have a legitimate case
> > for calling this with IRQs disabled.
> > 
> 
> That's fair. I'll replace the condition below with:
> 
> 	if (!cpu_has_amu_feat(cpu))
> 		return -EOPNOTSUPP;
> 
> 	if (WARN_ON_ONCE(irqs_disabled())
> 		return -EPERM;

Works for me. Thanks.

-- 
Catalin
