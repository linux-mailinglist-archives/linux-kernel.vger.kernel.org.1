Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043721BDC22
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD2M26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 08:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgD2M25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:28:57 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EFA62137B;
        Wed, 29 Apr 2020 12:28:56 +0000 (UTC)
Date:   Wed, 29 Apr 2020 08:28:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before
 text_poke()
Message-ID: <20200429082854.6e1796b5@oasis.local.home>
In-Reply-To: <20200429105941.GQ30814@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
        <20200429105941.GQ30814@suse.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 12:59:41 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> >   use_temporary_mm() {
> >     switch_mm_irqs_off() {
> >       load_new_mm_cr3() {
> >         write_cr3() <<--- Lock up!  
> 
> I don't see how it could lock up in write_cr3(), at least on bare-metal.
> What is the environment this happens, 32 or 64 bit, in a VM or
> bare-metal?

64 bit bare-metal. In fact, it wasn't reproducible on a VM (according
to Tzvetomir, who was just using a Fedora kernel). I only tried it on
bare-metal.

> 
> I think it is more likely that your lockup is actually a page-fault
> loop, where the #PF handler does not map the faulting address correctly.

Sounds reasonable.

> 
> But I have to look closer into how text_poke() works before I can say
> more.
> 
> Btw, in case it happens on x86-64, does it also happen without
> vmalloc-stacks?

Just tried it out with !CONFIG_VMAP_STACKS and it still locks up :-/

-- Steve
