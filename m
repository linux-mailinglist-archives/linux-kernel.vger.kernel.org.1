Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4225845D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 01:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHaXVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 19:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgHaXVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:21:31 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D42A2078B;
        Mon, 31 Aug 2020 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598916091;
        bh=K67KYwM93/LUPOUt+CVB+SxKRu4sFouQt0tEFmBotfY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZRvtcNDB4PT11KKs7GLKPPLkXGXlnTswB8GnQrOXRcozDIOLP05NFL9SombeodfCy
         b9Y1wtkW7eMPObr+xRYXCbEAn5/A17/CVupF3DeTvCAQqaAsl/V+VOumyPEVBFXVtk
         2dMxCxCXrtf57T6gEczXeMD0jZI3J9IeCnjXQKJ4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DC4B735230F1; Mon, 31 Aug 2020 16:21:30 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:21:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200831232130.GA28456@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831224911.GA13114@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 03:49:11PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> The task_blocks_on_rt_mutex() function uses rt_mutex_owner() to
> take a snapshot of the lock owner right up front.  At this point,
> the ->wait_lock is held, which at first glance prevents the owner
> from leaving.  Except that if there are not yet any waiters (that is,
> the low-order bit of ->owner is zero), rt_mutex_fastunlock() might
> locklessly clear the ->owner field.  And in that case, it looks like
> task_blocks_on_rt_mutex() will blithely continue using the ex-owner's
> task_struct structure, without anything that I can see that prevents
> the ex-owner from exiting.
> 
> What am I missing here?

One thing I missed is that the low-order bit of ->owner would already
be set by this point.

> The reason that I am looking into this is that locktorture scenario LOCK05
> hangs, and does so leaving the torture_rtmutex.waiters field equal to 0x1.
> This is of course a legal transitional state, but I would not expect it
> to persist for more than three minutes.  Yet it often does.
> 
> This leads me to believe that there is a way for an unlock to fail to wake
> up a task concurrently acquiring the lock.  This seems to be repaired
> by later lock acquisitions, and in fact setting the locktorture.stutter
> module parameter to zero avoids the hang.  Except that I first found the
> above apparently unprotected access to what was recently the owner task.
> 
> Thoughts?

Some breakage elsewhere, presumably...

							Thanx, Paul
