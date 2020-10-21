Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD9294D46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441259AbgJUNOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:14:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40646 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394984AbgJUNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:14:52 -0400
Date:   Wed, 21 Oct 2020 15:14:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603286090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Czg2HNrvkXECyRUyeO7gbFsTR+MJhHElUjxoU1+ut3g=;
        b=XCJTJ8kl3vSGWBKRw89J9IPc5sUydM3Qt9zzkeDxXzSvxkesCH1oCEsdVoUknuf244WTtG
        Hpxi05Tp50PNhtc4CaK8dsxkih1oxMTabgpUAcqB6xkDErxf+AVBdQOFYD7gwtP+qbovZL
        tRYbHUgvzt+jX5Koc4T5xNT3zqH+GqVGH1XxAck3cUFs5aFbLQUWfPbF6CeYCpbSZDwmTc
        3DdSu3Zg3w5JvyXexFgIt0e6JD+MhG95xiMGDtsmyfSiMdqImy24gHR8OOlbgqJifiSJfw
        sPzPCQV2HiYn0iMSqXpePW4P/c1h2rE8pSEtt1zUkoe7nKFHIJFW/QXDqNGEhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603286090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Czg2HNrvkXECyRUyeO7gbFsTR+MJhHElUjxoU1+ut3g=;
        b=zLuIHnqobGPBluqPXpBrLRZFhf2WJLjh+AMC60mCKeriJ61i62TxuIrJuOJQ4X2JrtMdot
        H7RvGGy/Lq8u/vDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt18
Message-ID: <20201021131449.qlwjiq2l6embaii3@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-21 14:53:27 [+0200], To Thomas Gleixner wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.9.1-rt18 patch set. 
> 
> Changes since v5.9.1-rt17:
> 
>   - Update the migrate-disable series by Peter Zijlstra to v3. Include
>     also fixes discussed in the thread.
> 
>   - UP builds did not boot since the replace of the migrate-disable
>     code. Reported by Christian Egger. Fixed as a part of v3 by Peter
>     Zijlstra.
> 
>   - Rebase the printk code on top of the ringer buffer designed for
>     printk which was merged in the v5.10 merge window. Patches by John
>     Ogness.
> 
> Known issues
>      - It has been pointed out that due to changes to the printk code the
>        internal buffer representation changed. This is only an issue if tools
>        like `crash' are used to extract the printk buffer from a kernel memory
>        image.
> 
> The delta patch against v5.9.1-rt17 is appended below and can be found here:
>  
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/incr/patch-5.9.1-rt17-rt18.patch.xz
> 
> You can get this release via the git tree at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.9.1-rt18
> 
> The RT patch against v5.9.1 can be found here:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patch-5.9.1-rt18.patch.xz
> 
> The split quilt queue is available at:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.9/older/patches-5.9.1-rt18.tar.xz
> 

The attached diff was too large and the mail was dropped. It is
available at
	https://git.kernel.org/rt/linux-rt-devel/d/v5.9.1-rt18/v5.9.1-rt17

Sebastian
