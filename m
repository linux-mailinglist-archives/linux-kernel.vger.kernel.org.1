Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB60E2B8DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKSIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:43:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgKSIni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:43:38 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB0B121D40;
        Thu, 19 Nov 2020 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605775417;
        bh=GP7AYcVUPOh23WPA8GgN0PDVztnolsPIrPEVVI5te+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eb+ZsPczYI4/ZTWJ1/Q2AcUm8GHpqDQx/GL0DRroxJ21DxSCs8FvI3bsNRDpe9l5d
         ZTolWybz/IOaLH16nVKrHQzGTDeq3Jt2pL0jNxBraTqf8n7w3H0500ZidhWubBaboI
         PMwX/cQlnkKaWH1Bklkfy2ZxglvurV7Uyp0NH4us=
Date:   Thu, 19 Nov 2020 09:44:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Cliff Whickman <cpw@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] misc/sgi-xp: Replace in_interrupt() usage
Message-ID: <X7YwZZgvk92Cghl7@kroah.com>
References: <20201119081354.836813-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119081354.836813-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:13:54AM +0100, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The usage of in_interrupt() in xpc_partition_disengaged() is clearly
> intended to avoid canceling the timeout timer when the function is invoked
> from the timer callback.
> 
> While in_interrupt() is deprecated and ill defined as it does not provide
> what the name suggests it catches the intended case.
> 
> Add an argument to xpc_partition_disengaged() which is true if called
> from timer and otherwise false.
> Use del_timer_sync() instead of del_singleshot_timer_sync() which is the
> same thing.
> 
> Note: This does not prevent reentrancy into the function as the function
> has no concurrency control and timer callback and regular task context
> callers can happen concurrently on different CPUs or the timer can
> interrupt the task context before it is able to cancel it.
> 
> While the only driver which is providing the arch_xpc_ops callbacks
> (xpc_uv) seems not to have a reentrancy problem and the only negative
> effect would be a double dev_info() entry in dmesg, the whole mechanism is
> conceptually broken.
> 
> But that's not subject of this cleanup endeavour and left as an exercise to
> the folks who might have interest to make that code fully correct.
> 
> [bigeasy: Add the argument, use del_timer_sync().]
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Cliff Whickman <cpw@sgi.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Robin Holt <robinmholt@gmail.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> ---
>  drivers/misc/sgi-xp/xpc.h           | 2 +-
>  drivers/misc/sgi-xp/xpc_main.c      | 8 ++++----
>  drivers/misc/sgi-xp/xpc_partition.c | 9 ++++-----
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/sgi-xp/xpc.h b/drivers/misc/sgi-xp/xpc.h
> index 71db60edff655..bbcf10ca3ab7f 100644
> --- a/drivers/misc/sgi-xp/xpc.h
> +++ b/drivers/misc/sgi-xp/xpc.h
> @@ -633,7 +633,7 @@ extern void *xpc_kmalloc_cacheline_aligned(size_t, gfp_t, void **);
>  extern int xpc_setup_rsvd_page(void);
>  extern void xpc_teardown_rsvd_page(void);
>  extern int xpc_identify_activate_IRQ_sender(void);
> -extern int xpc_partition_disengaged(struct xpc_partition *);
> +extern int xpc_partition_disengaged(struct xpc_partition *, bool from_timer);

These types of "flags" for functions are horrible as they do not
describe what is happening when you read the places the function is
called.

Instead, make it part of the function name itself:
	xpc_partition_disengaged_from_timer()
and then handle it that way, by using a shared static function with the
flag.

Otherwise this type of change just does not age well at all.

thanks,

greg k-h
