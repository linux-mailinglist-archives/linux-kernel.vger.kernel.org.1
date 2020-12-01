Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF02C95D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgLADhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:37:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbgLADhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:37:31 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39B720725;
        Tue,  1 Dec 2020 03:36:49 +0000 (UTC)
Date:   Mon, 30 Nov 2020 22:36:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 2/3] clear_warn_once: bind a timer to written reset
 value
Message-ID: <20201130223647.71f8e621@oasis.local.home>
In-Reply-To: <20201130171759.GA26693@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
        <20201126063029.2030-3-paul.gortmaker@windriver.com>
        <20201130112024.34bcbbd1@gandalf.local.home>
        <20201130171759.GA26693@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 12:17:59 -0500
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> > Anyway, would there ever be a need to have it cleared in less than 1 minute
> > intervals?  
> 
> I don't think so - as I said in another follow up from last week:
> 
> https://lore.kernel.org/lkml/20201127174316.GA11748@windriver.com/
> 
> I'd also indicated in the above that I'd be fine with adding a minimum
> of 1m if people feel better about that.  Also maybe moving the units to
> minutes instead of seconds helps implicitly convey the intended use
> better -- i.e. "don't be smashing on this every second" -- maybe that
> was your point as well - and I'd agree with that.

That was my second point. That is, why would anyone care about a
resolution in seconds for this?

-- Steve
