Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEF5241964
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHKKGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 06:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbgHKKGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:06:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9362054F;
        Tue, 11 Aug 2020 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597140362;
        bh=XXVs6ePFSZqShwwG3cMttcMPTHSZIqfP8Uz26mv6Pdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEr9CXzoQihfJUhgjofTwCMp6TVICPkU1c2e0OxxhWAddaNvbhTLTxB1b9Tuh2++B
         GseBLbenKigDfanwSQYpgci6Dl3YbO9kJbyHVANBFsrzBd+SkgS/C6PDN+Y2ItxN5v
         wM2+We5831Zdo4GWJ4itQHBj3+BgGIjsHDuCkPZc=
Date:   Tue, 11 Aug 2020 12:06:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/24] seqlock: lockdep assert non-preemptibility on
 seqcount_t write
Message-ID: <20200811100613.GA148069@kroah.com>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
 <20200720155530.1173732-9-a.darwish@linutronix.de>
 <20200808232122.GA176509@roeck-us.net>
 <20200809184251.GA94072@lx-t490>
 <20200810085954.GA1591892@kroah.com>
 <87v9hqxolz.fsf@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9hqxolz.fsf@nanos>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 09:55:20PM +0200, Thomas Gleixner wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> > On Sun, Aug 09, 2020 at 08:42:51PM +0200, Ahmed S. Darwish wrote:
> >> On Sat, Aug 08, 2020 at 04:21:22PM -0700, Guenter Roeck wrote:
> >> > Reverting it fixes the problem. Is this being addressed ?
> >> >
> >> 
> >> @Peter, I think let's revert this one for now?
> >
> > Please do, it's blowing up my local builds as well :(
> 
> Peter and Ingo sorted the header mess last week and I just sent a pull
> request to Linus.

Thanks, that looks good and works for my build tests!

greg k-h
