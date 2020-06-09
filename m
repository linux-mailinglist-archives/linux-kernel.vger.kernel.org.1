Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4F1F407E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgFIQR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 12:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFIQRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:17:55 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B75220760;
        Tue,  9 Jun 2020 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591719475;
        bh=kbiS3IeZLYDH4v02Cj0YwW8sa1nyhzC9CdnzZuDZIXk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qVwIGp2F4R1H4pQn658LdFIPwS+eh0qJs0YgEOdlL7KLAM38iIdg+E5Crz2MJ8SON
         9en1ANfFKe5gsIunlsh+UtbhydO51NNnmaxFLPEc0O+VLE/hLBct7+dazZIgM75oSy
         xcbzNm4UF6k9HvRohgYSCJdMEg9qxntdivKuITLo=
Message-ID: <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in
 double-enqueue
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ramon Fried <rfried.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Date:   Tue, 09 Jun 2020 11:17:53 -0500
In-Reply-To: <20200609154741.5kesuvl7txz4s3yu@linutronix.de>
References: <cover.1587675252.git.zanussi@kernel.org>
         <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
         <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
         <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
         <20200609154741.5kesuvl7txz4s3yu@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, 2020-06-09 at 17:47 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-04 15:51:14 [-0500], Tom Zanussi wrote:
> > > 
> > > Hi, This patch introduced a regression in our kernel
> > > (v4.19.124-rt53-rebase), It occurs when we're jumping to crush
> > > kernel
> > > using kexec, in the initialization of the emmc driver.
> > > I'm still debugging the root cause, but I thought of mentioning
> > > this
> > > in the mailing list if you have any idea why this could occur.
> > > The issue doesn't happen on normal boot, only when I specifically
> > > crash the kernel into the crash kernel.
> > > Thanks,
> > > Ramon.
> > 
> > I'm not very familiar with crashing the kernel into the crash
> > kernel. 
> > Can you explain in enough detail how to set things up to reproduce
> > this
> > and how to trigger it?  Does it happen every time? 
> > 
> > > From looking at the backtrace, it's hitting the WARN_ON() in the
> > 
> > cmpxchg() loop below, because TASKLET_STATE is just
> > TASKLET_STATE_CHAINED.
> > 
> > It seems that the only way to turn off TASKLET_STATE_CHAINED is via
> > this cmpxchg(), but TASKLET_STATE_RUN can be independently turned
> > off
> > elsewhere (tasklet_unlock() and tasklet_tryunlock()), so if that
> > happens and this loop is hit, you could loop until loops runs out
> > and
> > hit this warning.
> 
> But clearing TASKLET_STATE_RUN independently happens by the task,
> that
> set it / part of tasklet_schedule().
> tasklet_tryunlock() does a cmpxchg() with only the RUN bit so it
> won't
> work if the additional CHAINED bit is set.
> 
> The tasklet itself (which may run on another CPU) sets the RUN bit at
> the
> begin and clears it at the end via cmpxchg() together with the
> CHAINED
> bit. 
> 
> I've been staring at it for sometime and I don't see how this can
> happen.
> 

I did find a problem with the patch when configured as !SMP since in
that case the RUN flag is never set (will send a patch for that
shortly), but that wouldn't be the case here.

It would help to be able to reproduce it, but I haven't been able to
yet.

Tom

> Sebastian

