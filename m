Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F304258432
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 00:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHaWtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 18:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgHaWtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:49:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D68A206FA;
        Mon, 31 Aug 2020 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598914151;
        bh=SyBMAWu0cxwQBtgnS4hDcUn+0EfPaKGKbNnucXwun6M=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=0+DZYU6EMhJ1Y8p0o3GA1lRGSjg1jPAY8Lq+56ef8CUleDX70cd3hlIU1k+0BThFQ
         3OPl269afza3IKo8hSHdfzm29E9lAH/Ha7lG1oYjKTvk88VzIK49MIFVovklJ05Pzb
         7d6/S/wGR76rnL++skJPfmPPE7JBaMpNf7VKv1eE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0DD8A35230F1; Mon, 31 Aug 2020 15:49:11 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:49:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Question on task_blocks_on_rt_mutex()
Message-ID: <20200831224911.GA13114@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The task_blocks_on_rt_mutex() function uses rt_mutex_owner() to
take a snapshot of the lock owner right up front.  At this point,
the ->wait_lock is held, which at first glance prevents the owner
from leaving.  Except that if there are not yet any waiters (that is,
the low-order bit of ->owner is zero), rt_mutex_fastunlock() might
locklessly clear the ->owner field.  And in that case, it looks like
task_blocks_on_rt_mutex() will blithely continue using the ex-owner's
task_struct structure, without anything that I can see that prevents
the ex-owner from exiting.

What am I missing here?

The reason that I am looking into this is that locktorture scenario LOCK05
hangs, and does so leaving the torture_rtmutex.waiters field equal to 0x1.
This is of course a legal transitional state, but I would not expect it
to persist for more than three minutes.  Yet it often does.

This leads me to believe that there is a way for an unlock to fail to wake
up a task concurrently acquiring the lock.  This seems to be repaired
by later lock acquisitions, and in fact setting the locktorture.stutter
module parameter to zero avoids the hang.  Except that I first found the
above apparently unprotected access to what was recently the owner task.

Thoughts?

							Thanx, Paul
