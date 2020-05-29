Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5914C1E8B56
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 00:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgE2W2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 18:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgE2W2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:28:30 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4829B20897;
        Fri, 29 May 2020 22:28:29 +0000 (UTC)
Date:   Fri, 29 May 2020 18:28:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        bigeasy@linutronix.de
Subject: Re: [PATCH 13/14] lockdep: Prepare for NMI IRQ state tracking
Message-ID: <20200529182827.64a5f58d@oasis.local.home>
In-Reply-To: <20200529222505.GW2483@worktop.programming.kicks-ass.net>
References: <20200529212728.795169701@infradead.org>
        <20200529213321.471984676@infradead.org>
        <20200529181401.1f01bdc5@oasis.local.home>
        <20200529222505.GW2483@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 00:25:05 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > > +	if (DEBUG_LOCKS_WARN_ON(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
> > >  		return;  
> 
> ^^ there's your regular recursion check.

Yes, but this is more of a "bug if it happens" than just "ignore it".

-- Steve
