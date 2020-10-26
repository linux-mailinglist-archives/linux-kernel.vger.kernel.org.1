Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861C42993D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787852AbgJZRbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:31:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1776217AbgJZRbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:31:11 -0400
Date:   Mon, 26 Oct 2020 18:31:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603733468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QV3FYqGCsnxmOC4xUQgDmTFEdUZLKcpDfcLiTasvEd0=;
        b=VUw+KyhQar04G1nUAnp4mxqdbZxdgyUKKHgbosjtFoqg2KpLg6wFzQWd5L3KOV8CIVZvOS
        cKfUghHftMO6Se7ySFUCEZ2CSVgw4oIt6Bs3WP0EuzuJOYiiPs+i430dBIPjR5iN41Ozu2
        i8Cv1yS0mfuayUiuBYBCJxbsXBeGtGIE20/gMMvF0Msf5znyRj/NWe3GIOIAJmYwMVLW7W
        MCe/eFlxx1lxElApQKBc7m1X3rkSNo+RD6gAyquX9AXumJN89DpQ33zwqnbs+KqLIuf/5X
        fTU0dIscTSlMw1Rj2go3p+O7LjADXRZeS3P3N6x3whdTh2gyVZw/tx1owseU3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603733468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QV3FYqGCsnxmOC4xUQgDmTFEdUZLKcpDfcLiTasvEd0=;
        b=90VFu1I1B4FyN+ygRu0tkuV7Jcqu3Wz9LoJhFUXVq7dFYHgu86pTpxH9cWi0FUtcZYSzV2
        s96/F1HZPHh1riAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: kvm+nouveau induced lockdep  gripe
Message-ID: <20201026173107.quylcy6fgjvrqat6@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
 <20201023090108.5lunh4vqfpkllmap@linutronix.de>
 <20201024022236.19608-1-hdanton@sina.com>
 <20201024050000.8104-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201024050000.8104-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-24 13:00:00 [+0800], Hillf Danton wrote:
> 
> Hmm...curious how that word went into your mind. And when?
> > [   30.457363]
> >                other info that might help us debug this:
> > [   30.457369]  Possible unsafe locking scenario:
> > 
> > [   30.457375]        CPU0
> > [   30.457378]        ----
> > [   30.457381]   lock(&mgr->vm_lock);
> > [   30.457386]   <Interrupt>
> > [   30.457389]     lock(&mgr->vm_lock);
> > [   30.457394]
> >                 *** DEADLOCK ***
> > 
> > <snips 999 lockdep lines and zillion ATOMIC_SLEEP gripes>

The backtrace contained the "normal" vm_lock. What should follow is the
backtrace of the in-softirq usage.

> 
> Dunno if blocking softint is a right cure.
> 
> --- a/drivers/gpu/drm/drm_vma_manager.c
> +++ b/drivers/gpu/drm/drm_vma_manager.c
> @@ -229,6 +229,7 @@ EXPORT_SYMBOL(drm_vma_offset_add);
>  void drm_vma_offset_remove(struct drm_vma_offset_manager *mgr,
>  			   struct drm_vma_offset_node *node)
>  {
> +	local_bh_disable();

There is write_lock_bh(). However changing only one will produce the
same backtrace somewhere else unless all other users already run BH
disabled region.

>  	write_lock(&mgr->vm_lock);
>  
>  	if (drm_mm_node_allocated(&node->vm_node)) {

Sebastian
