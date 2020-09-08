Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73851261FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgIHUG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgIHPUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:20:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0E2C0619ED;
        Tue,  8 Sep 2020 08:14:33 -0700 (PDT)
Date:   Tue, 8 Sep 2020 17:12:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599577950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lIVgIxTyroQddql8kti9o3VE5bSiFWAwUPsPZehXs9o=;
        b=sXhlasBHEKGmjbmZDMHbFD7Rsy2wjwblXmS7YU8lQi9EA9XqAewbLsZRFGt8nkjLTQXw8m
        zvObdrZX72xqJ9q18VgC85vQRLzqaFJWuwz2NhTol9lsNMd5XUs2iHQyUndQPPfwe1ObYU
        4hS0AhQaQjpwUDgEH4gdT/S5SMvdRK7QZIVkFX+y2/qH6NR7/iikQiqvY4tovuObzBVRfP
        kU0j8vopuU9FkdMMkglSKe6aGOTRAbB+uqo3DB9QfD3RY04TkasmbP7xnB82T2Y2Fb/3lA
        gJ5riSIi14Cl5GEhKWbT681B2G48wMlt4t2OKPPt5uXsePgIv+Zsq+1OyjmJjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599577950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lIVgIxTyroQddql8kti9o3VE5bSiFWAwUPsPZehXs9o=;
        b=kxjaxt2dIjBlb5FiPBRsluID3bgNmV1B32kw3B0tymfXnJyo4JFDg6Dp5xE6ZrD035G1Al
        trsnmHCEmRg6jCAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: v5.9-rc3-rt3 boot time networking lockdep splat
Message-ID: <20200908151229.g24j4n4fderlm2pe@linutronix.de>
References: <20200902155557.h2wl2qpfn2rwsofw@linutronix.de>
 <46a2b89ec8d953a4be18c7389c7d8c66310a7ff0.camel@gmx.de>
 <b989e196a8b9cceda35152de9202d7a67ca32196.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b989e196a8b9cceda35152de9202d7a67ca32196.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-05 07:19:10 [+0200], Mike Galbraith wrote:
> Lappy, which does not use bridge, boots clean... but lock leakage
> pretty darn quickly inspires lockdep to craps its drawers.
> 
> [  209.001111] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> [  209.001113] turning off the locking correctness validator.
> [  209.001114] CPU: 2 PID: 3773 Comm: Socket Thread Tainted: G S        I E     5.9.0.gc70672d-rt3-rt #8
> [  209.001117] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.47 11/22/2017
> [  209.001118] Call Trace:
> [  209.001123]  dump_stack+0x77/0x9b
> [  209.001129]  validate_chain+0xf60/0x1230

I have no idea how to debug this based on this report. Can you narrow
it down to something?

Is Lappy new, got a new something or has a new config switch? I'm just
curious if this something or something that was always there but
remained undetected.
(Your other report was about something that was previously always "broken".)

Sebastian
