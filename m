Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3907B2A2568
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgKBHjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:39:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37259 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgKBHjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:39:45 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kZURL-0006Ps-0q
        for linux-kernel@vger.kernel.org; Mon, 02 Nov 2020 07:39:43 +0000
Received: by mail-wr1-f72.google.com with SMTP id f11so6061877wro.15
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s+1/b9qrTJwvlCTSESTKicu6AFZDOR/Q7ls3jRHS758=;
        b=bfEZo0IEJIQQIXUdGumIGvTqp7UTzIM1CjJnJTaFPfUr9l5/6JEqfnnbUHEp7TOxiL
         AznLWNghFr4573iUB4T3GNxHd4j0pV1VyvPV9jvFHLLJV88CgW8J/FCLbIpZ6CVg19yH
         J8TxtNSvagM6XO9ae9NZfRnwSqn+PFvdK8ZCa802/q4NYj2geljG7B2UDEucfDG1kunj
         Wck9EvyWoD1T0zUlsbxsmNkHmH5wuv7ctzjHv+1rWZQS/SnW4rO0aC6PtZyS9fpmaweM
         5Yp80IBgUCHxEexJVqzQ+EE+4s8AaF4sb15p9Fbl+E9kQP66vUuh8npXaESVmGrwL/gw
         Kkew==
X-Gm-Message-State: AOAM532iFWRS+JooQqGycAtKFnlualypdA/eIS1b3g+zBtmzY8d8QhqP
        TL/IBHiVrmAUublbHOug6cAYJt8lXZXCbdMfKzyEei3q0Jeda0+vl0Dq43cBS/LmXpo+6MrzAMm
        YGa7g4a690Uomd7/z6glGuRSAlqcfEIj8Bh4KpR1HAQ==
X-Received: by 2002:adf:e384:: with SMTP id e4mr18510792wrm.227.1604302782670;
        Sun, 01 Nov 2020 23:39:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlDThJeOIu7/Cf7/zEUMHqVXLcpbgp0DCRYi/ok8CmBHN5LzhjERA9dQhxaCmkhgVBVWmLfQ==
X-Received: by 2002:adf:e384:: with SMTP id e4mr18510775wrm.227.1604302782469;
        Sun, 01 Nov 2020 23:39:42 -0800 (PST)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id s12sm14457032wmc.6.2020.11.01.23.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 23:39:41 -0800 (PST)
Date:   Mon, 2 Nov 2020 08:39:40 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep: possible irq lock inversion dependency detected
 (trig->leddev_list_lock)
Message-ID: <20201102073940.GB9930@xps-13-7390>
References: <20201101092614.GB3989@xps-13-7390>
 <20201101162838.GA24370@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101162838.GA24370@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 05:28:38PM +0100, Pavel Machek wrote:
> Hi!
> 
> > I'm getting the following lockdep splat (see below).
> > 
> > Apparently this warning starts to be reported after applying:
> > 
> >  e918188611f0 ("locking: More accurate annotations for read_lock()")
> > 
> > It looks like a false positive to me, but it made me think a bit and
> > IIUC there can be still a potential deadlock, even if the deadlock
> > scenario is a bit different than what lockdep is showing.
> > 
> > In the assumption that read-locks are recursive only in_interrupt()
> > context (as stated in e918188611f0), the following scenario can still
> > happen:
> > 
> >  CPU0                                     CPU1
> >  ----                                     ----
> >  read_lock(&trig->leddev_list_lock);
> >                                           write_lock(&trig->leddev_list_lock);
> >  <soft-irq>
> >  kbd_bh()
> >    -> read_lock(&trig->leddev_list_lock);
> > 
> >  *** DEADLOCK ***
> > 
> > The write-lock is waiting on CPU1 and the second read_lock() on CPU0
> > would be blocked by the write-lock *waiter* on CPU1 => deadlock.
> > 
> > In that case we could prevent this deadlock condition using a workqueue
> > to call kbd_propagate_led_state() instead of calling it directly from
> > kbd_bh() (even if lockdep would still report the false positive).
> 
> console.c is already using bh to delay work from
> interrupt. But... that should not be neccessary. led_trigger_event
> should already be callable from interrupt context, AFAICT.
> 
> Could this be resolved by doing the operations directly from keyboard
> interrupt?

As pointed out by Boqun this is not a deadlock condition, because the
read_lock() called from soft-irq context is recursive (I was missing
that in_interrupt() returns true also from soft-irq context).

But the initial lockdep warning was correct, so there is still a
potential deadlock condition between trig->leddev_list_lock and
host->lock. And I think this can be prevented simply by scheduling the
led triggering part in a separate work from ata_hsm_qs_complete(), so
that led_trigger_event() won't be called with host->lock held. I'll send
a patch soon to do that.

-Andrea
