Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747572AD7DE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgKJNm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730044AbgKJNm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:42:26 -0500
Received: from localhost (unknown [176.177.120.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFD320731;
        Tue, 10 Nov 2020 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605015746;
        bh=+NH93rVvGxyY03JD5Zll1bmvk3NHXkPunXz2z/0OIbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxvxfOWV6a5UejjfKLERU87WKn3CUEM2NFjGcYHbxaAjhddFiRfXTDFuHaTPCoEQx
         9TFU169KBmXbXHjw3OohlXeHEAalvbsdrPnaNHrbaVy+/8QFQQp7jQNabtZmcMkc9k
         crnf2QSeaRAs/wqDUPLo199JxRT+XBp+kQ0Gct1U=
Date:   Tue, 10 Nov 2020 14:42:23 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/7] static_call/x86: Add __static_call_returnl0()
Message-ID: <20201110134223.GB48886@lothringen>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-2-frederic@kernel.org>
 <20201110095515.GA2594@hirez.programming.kicks-ass.net>
 <20201110101307.GO2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110101307.GO2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:13:07AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 10, 2020 at 10:55:15AM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 10, 2020 at 01:56:03AM +0100, Frederic Weisbecker wrote:
> > 
> > > [fweisbec: s/disp16/data16, integrate into text_get_insn(), elaborate
> > >  comment on the resulting insn, emulate on int3 trap, provide validation,
> > >  uninline __static_call_return0() for HAVE_STATIC_CALL]
> 
> > Why did you add full emulation of this? The patch I send to you used the
> > text_poke_bp(.emulate) argument to have it emulate an actual call to the
> > out-of-line version of that function.
> > 
> > That should work fine and is a lot less code.
> 
> For reference; the below is what I send you. Actually doing the
> __static_call_return0() call while we poke the magic XOR instruction is
> much simpler.

Ok I'll get back to that. I'll just tweak a bit static_call_validate()
so that it is aware of that instruction.

Thanks.
