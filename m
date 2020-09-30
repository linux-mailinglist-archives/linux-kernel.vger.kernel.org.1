Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B743F27EA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgI3Nfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3Nfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:35:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B28A206B7;
        Wed, 30 Sep 2020 13:35:54 +0000 (UTC)
Date:   Wed, 30 Sep 2020 09:35:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200930093552.3684aee1@gandalf.local.home>
In-Reply-To: <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
        <20200922153816.5883-4-john.ogness@linutronix.de>
        <20200923151129.GC6442@alley>
        <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk>
        <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk>
        <20200925082822.GL29288@alley>
        <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 10:06:24 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> True. But remember that printk is called from _everywhere_, with all
> sorts of locks held and/or preemption disabled or whatnot, and every
> cycle spent in printk makes those windows wider. Doubling the cost of
> every single printk by unconditionally doing vsnprintf() twice is a bad
> idea.

But the console output is usually magnitudes more expensive than the
vsnprintf(), would doing it twice really make a difference?

-- Steve
