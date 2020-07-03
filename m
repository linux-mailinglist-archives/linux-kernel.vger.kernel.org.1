Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C222C213062
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 02:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGCAMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 20:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGCAMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:12:24 -0400
Received: from localhost (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCCF20772;
        Fri,  3 Jul 2020 00:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593735143;
        bh=WS+4Jtb8oKnOh/+J4eJZfroFhwbdunk5YRezs14kUj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0gmpmSRdGEmlDIoSMAJA1MIoT7pgCSEprj3os4mzKCgTkD/IA5sIrh/7UlVH1RVcM
         1lM768Ye6imd78NEmcFhKP5ofPiVNmDuD4S9hudw5HEQzA3D99vscnRn6mc27OUAql
         LF71SdfzWDkn7SrUn/ygUM3U75TNViQhLreUp7zc=
Date:   Fri, 3 Jul 2020 02:12:20 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH 10/10] timer: Lower base clock forwarding threshold
Message-ID: <20200703001219.GD27417@lenoir>
References: <20200702133219.GA27417@lenoir>
 <87zh8irltc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh8irltc.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:14:23PM +0200, Thomas Gleixner wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> > On Thu, Jul 02, 2020 at 03:21:35PM +0200, Thomas Gleixner wrote:
> > The following part:
> >
> >> >      * Also while executing timers, base->clk is 1 offset ahead
> >> >      * of jiffies to avoid endless requeuing to current jffies.
> >> >      */
> >
> > relates to situation when (long)(jnow - base->clk) < 0
> 
> This still is inconsistent with your changelog:

Right.

> 
> > There is no apparent reason for not forwarding base->clk when it's 2
> > jiffies late
> 
> Let's do the math:
> 
>  jiffies = 4
>  base->clk = 2
> 
>  4 - 2 = 2
> 
> which means it is forwarded when it's 2 jiffies late with the original
> code, because 2 < 2.
> 
> The reason for this < 2 is historical and goes back to the oddities of
> the original timer wheel before the big rewrite.

Ok. And is it still needed today or can we now forward even with a 1 delta?
