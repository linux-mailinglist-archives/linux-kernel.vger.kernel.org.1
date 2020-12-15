Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107092DAE84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgLOOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:06:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbgLOOGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:06:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E021F224D2;
        Tue, 15 Dec 2020 14:05:21 +0000 (UTC)
Date:   Tue, 15 Dec 2020 09:05:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Orivej Desh <c@orivej.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: sched: exporting linux-rt migrate_disable for ZFS
Message-ID: <20201215090520.609b76dc@gandalf.local.home>
In-Reply-To: <6307cab9d73d88b16e1e87ddb273a7b27d3e51f6.camel@gmx.de>
References: <20201208212841.694b3022@orivej.orivej.org>
        <20201214123302.w2bem7tlb664jdvx@linutronix.de>
        <6307cab9d73d88b16e1e87ddb273a7b27d3e51f6.camel@gmx.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 04:19:23 +0100
Mike Galbraith <efault@gmx.de> wrote:

> From 859a31c5ec958326dd046f4e41f6fa0db0ce98c3 Mon Sep 17 00:00:00 2001
> From: Steven Rostedt <srostedt@redhat.com>
> Date: Mon, 16 Apr 2012 21:51:54 -0400
> Subject: rt: Make migrate_disable/enable() and __rt_mutex_init non-GPL only
> 
> Modules that load on the normal vanilla kernel should also load on
> an -rt kernel as well. This does not mean we condone non-GPL modules,
> we are only being consistent.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Yep,

Back in the day (like in 2005), we said that -rt should strive to work
wherever vanilla Linux works. Thus, if we add a symbol that replaces a non
GPL symbol, we need to keep that symbol non GPL.

-- Steve
