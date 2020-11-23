Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC52C0557
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgKWMQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:16:15 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:58108 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727941AbgKWMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:16:15 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 23 Nov 2020 21:16:13 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 23 Nov 2020 21:16:13 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 23 Nov 2020 21:14:39 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: Re: [RFC] Dept(Dependency Tracker) Report Example
Message-ID: <20201123121439.GD9464@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201123111332.GC9464@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123111332.GC9464@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 08:13:32PM +0900, Byungchul Park wrote:
> [    0.995081] ===================================================
> [    0.995619] Dept: Circular dependency has been detected.
> [    0.995816] 5.9.0+ #8 Tainted: G        W        
> [    0.996493] ---------------------------------------------------
> [    0.996493] summary
> [    0.996493] ---------------------------------------------------
> [    0.996493] *** AA DEADLOCK ***
> [    0.996493] 
> [    0.996493] context A
> [    0.996493]     [S] __mutex_lock(&dev->mutex:0)
> [    0.996493]     [W] __mutex_lock(&dev->mutex:0)
> [    0.996493]     [E] __mutex_unlock(&dev->mutex:0)
> [    0.996493] 
> [    0.996493] [S]: start of the event context
> [    0.996493] [W]: the wait blocked
> [    0.996493] [E]: the event not reachable

Let me explain what [S], [W] and [E] mean using example:

1. In the case of typical locks:

   if condition a
      lock(&a);		<- [S] start of the event context for the event, unlock(&a)
			   [W] wait as well
      ...
      unlock(&a);	<- [E] event to someone who has been waiting lock &a to
			       be released
   else
      lock(&b);		<- [S] start of the event context for the event, unlock(&b)
			   [W] wait as well
      ...
      unlock(&b);	<- [E] event to someone who has been waiting lock &b to
			       be released

2. In the case of general wait and event:

   THREAD 1
      trigger_the_event_context_to_go();
      ...
      wait_for_something(&c); <- [W] wait
         store_timestamp();

   THREAD 2
      notice_someone_triggered_me();
      ...

      (somewhere can see the timestamp of wait_for_something(&c) in THREAD 1)
      <- [S] start of the event context for the event, do_something(&c)

      ...
      do_something(&c); <- [E] event the wait is waiting for in THREAD 1

Thanks,
Byungchul

