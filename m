Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ED430048E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbhAVNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:50:44 -0500
Received: from foss.arm.com ([217.140.110.172]:48634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbhAVNub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:50:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 462E611B3;
        Fri, 22 Jan 2021 05:49:46 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 275593F66E;
        Fri, 22 Jan 2021 05:49:45 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:49:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCHv2] lockdep: report broken irq restoration
Message-ID: <20210122134942.GB31304@C02TD0UTHF1T.local>
References: <20210111153707.10071-1-mark.rutland@arm.com>
 <20210122110625.GA29868@C02TD0UTHF1T.local>
 <YArSGwEI0xqBncrv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YArSGwEI0xqBncrv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 02:24:43PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 22, 2021 at 11:06:25AM +0000, Mark Rutland wrote:
> > Hi all,
> > 
> > Any thoughts on this? I'd like to get this in soon if we could as it'll
> > help to flush out any remaining issues that are liable to get in the way
> > of planned rework for arm64 and x86.
> 
> Ah, I actually have it queued, I'll try and push it out to locking/core
> later today.

Thanks! I hadn't thought to check your queue; sorry for the noise.

Now I can forget all about this. ;)

Mark.
