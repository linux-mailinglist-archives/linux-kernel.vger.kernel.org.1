Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F263824046E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHJKDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 06:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgHJKDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 06:03:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA7020709;
        Mon, 10 Aug 2020 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597053781;
        bh=MT57Hgjt+4TNOlqLHmLLOrA+VG9mAo/OACm1sV/DPy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OftAx2pKJiF9w6M+Z3sn8bz6hlR5LQi9DiqUQ0YLN5MCcdeo0mPzM+Dan/tD3UU0k
         rDw/6TIlVlg4JDPKtUrC7qTL9u5qQjmEYmjeflVpAyy2GsvIWJbyk0ek/xxrIWULnv
         USIyVRd6J4vBuj3A7JRZazt1DuTVAyIahlbd4m6c=
Date:   Mon, 10 Aug 2020 12:03:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     peterz@infradead.org
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/24] seqlock: lockdep assert non-preemptibility on
 seqcount_t write
Message-ID: <20200810100312.GA2406292@kroah.com>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-9-a.darwish@linutronix.de>
 <20200808232122.GA176509@roeck-us.net>
 <20200809184251.GA94072@lx-t490>
 <20200810085954.GA1591892@kroah.com>
 <20200810094820.GO2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810094820.GO2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:48:20AM +0200, peterz@infradead.org wrote:
> On Mon, Aug 10, 2020 at 10:59:54AM +0200, Greg KH wrote:
> > On Sun, Aug 09, 2020 at 08:42:51PM +0200, Ahmed S. Darwish wrote:
> 
> > > @Peter, I think let's revert this one for now?
> > 
> > Please do, it's blowing up my local builds as well :(
> 
> There's a bunch of patches queued here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
> 
> That should fix it all, but I'm not exactly sure when the pull request
> for that will go out.

Before 5.9-rc1 hopefully?  :)
