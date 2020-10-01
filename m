Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCDB27FAEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgJAH6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:58:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:49486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgJAH6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:58:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601539132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFOZ4vohVI5xfvSkGqOUdfbw08X7CG9XNwmsC0KbS2I=;
        b=X7dmrdhhiV2cJX4C/yH8sCDHnt/O/eqUFLfBYBW1fA0VKwECHytlfH1nc3hNTPDZbP81WK
        HA5dejsOG1lL1z3vSh3yhv4IdLaYFaQYFSFoAHvQRMeg0mL8BC6RfJbkrd4PlaIfdYjmOO
        NWw4x9NKUCXUeMFfTbr0o9qOGoCCapY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B67F3ABC1;
        Thu,  1 Oct 2020 07:58:52 +0000 (UTC)
Date:   Thu, 1 Oct 2020 09:58:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20201001075852.GD17717@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
 <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk>
 <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk>
 <20200925082822.GL29288@alley>
 <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk>
 <20200930093552.3684aee1@gandalf.local.home>
 <de1b6e44-bbd7-6264-d354-4f9d76bd2870@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de1b6e44-bbd7-6264-d354-4f9d76bd2870@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-10-01 09:15:39, Rasmus Villemoes wrote:
> On 30/09/2020 15.35, Steven Rostedt wrote:
> > On Wed, 30 Sep 2020 10:06:24 +0200
> > Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> > 
> >> True. But remember that printk is called from _everywhere_, with all
> >> sorts of locks held and/or preemption disabled or whatnot, and every
> >> cycle spent in printk makes those windows wider. Doubling the cost of
> >> every single printk by unconditionally doing vsnprintf() twice is a bad
> >> idea.
> > 
> > But the console output is usually magnitudes more expensive than the
> > vsnprintf(), would doing it twice really make a difference?
> 
> AFAIU, not every message gets printed to the console directly - syslog(2):
> 
>    /proc/sys/kernel/printk
>        /proc/sys/kernel/printk is a writable file containing four
> integer val‐
>        ues that influence kernel printk() behavior when  printing  or
> logging
>        error messages.  The four values are:
> 
>        console_loglevel
>               Only  messages  with  a  log level lower than this value
> will be
>               printed to the console.  The default value  for  this
> field  is
>               DEFAULT_CONSOLE_LOGLEVEL  (7),  but it is set to 4 if the
> kernel
>               command line contains the word "quiet",
> 
> So the normal state of things is that you don't pay the cost of printing
> to the console for all the pr_debug (ok, they may be compiled out or
> run-time disabled depending on DYNAMIC_DEBUG etc.), nor info, notice,
> warn. For those messages that are not directly written to the console,
> the vsnprintf() is a large part of the cost (not exactly half, of
> course, so doubling is an exaggeration, but whether it's 70% or 100%
> doesn't really matter).
> 
> I'm not at all concerned about pr_err and above becoming more expensive,
> they are rare. But random drivers are filled with random pr_info in
> random contexts - just a small selection from dmesg -x shows these
> really important things:
> 
> kern  :info  : [ 4631.338105] ax88179_178a 3-13.2.3.3:1.0 eth0: ax88179
> - Link status is: 1
> kern  :info  : [ 4642.218100] ax88179_178a 3-13.2.3.3:1.0 eth0: ax88179
> - Link status is: 0
> kern  :info  : [ 4643.882038] ax88179_178a 3-13.2.3.3:1.0 eth0: ax88179
> - Link status is: 1
> kern  :info  : [ 4667.562011] ax88179_178a 3-13.2.3.3:1.0 eth0: ax88179
> - Link status is: 0
> ...
> kern  :info  : [ 9149.215456] [drm] ring test on 1 succeeded in 1 usecs
> kern  :info  : [ 9149.215459] [drm] ring test on 2 succeeded in 1 usecs
> kern  :info  : [ 9149.215466] [drm] ring test on 3 succeeded in 4 usecs
> 
> and if I'm reading the code correctly, the former is even an example of
> something that happens in irq context.

As I already wrote. We might optimize this when it causes real
life problems. And trace_printk() is a better choice for performance
sensitive debugging.

Best Regards,
Petr
