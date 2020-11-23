Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFCB2C0680
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 13:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbgKWMba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 07:31:30 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:52125 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbgKWMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 07:31:14 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 23 Nov 2020 21:31:12 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.121 with ESMTP; 23 Nov 2020 21:31:12 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 23 Nov 2020 21:29:38 +0900
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
Subject: Re: [RFC] Dept(Dependency Tracker) Implementation
Message-ID: <20201123122938.GA10265@X58A-UD3R>
References: <20201111050559.GA24438@X58A-UD3R>
 <20201123110527.GB9464@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123110527.GB9464@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 08:05:27PM +0900, Byungchul Park wrote:
> Hi,
> 
> This patchset is too nasty to get reviewed in detail for now.

I worked Dept against mainline v5.9.

Thanks,
Byungchul

> This have:
> 
>    1. applying Dept to spinlock/mutex/rwlock/completion
>    2. assigning custom keys or disable maps to avoid false positives
> 
> This doesn't have yet (but will be done):
> 
>    1. proc interfaces e.g. to see dependecies the tool has built,
>    2. applying Dept to rw semaphore and the like,
>    3. applying Dept to lock_page()/unlock_page(),
>    4. assigning custom keys to more places properly,
>    5. replace all manual Lockdep annotations,
>    (and so on..)
> 
> But I decided to share it to let others able to test how it works and
> someone who wants to see the detail able to check the code. The most
> important thing I'd like to show is what exactly a deadlock detection
> tool should do.
> 
> Turn on CONFIG_DEPT to test it. Feel free to leave any questions if you
> have.
> 
> Thanks,
> Byungchul
