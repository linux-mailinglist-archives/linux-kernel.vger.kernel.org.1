Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A501E6CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 22:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407388AbgE1Usr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 16:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407348AbgE1Usk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:48:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46AB2074B;
        Thu, 28 May 2020 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590698919;
        bh=4fnkVfztzwaZ5WRZ7qB4s8yjom+u7iqPNg1Zcum8IY0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Gwx7O4M7zP12amtu+Uzm7jflbCnb5ioiOaPF9cmR6l4femba0+os+4LSLoYFQ4VU3
         oYwLZw7rT2aXmRGPlW8Qa59da0ixArfuJp3EmGYwGnCHkJwrkbj1Sz07AP0DZXWTeA
         GRf7/3c4k+Hpk/30TeVKtKkPKr3MiXNNL9I8rhnA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BC5F635229BA; Thu, 28 May 2020 13:48:39 -0700 (PDT)
Date:   Thu, 28 May 2020 13:48:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, bp@alien8.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: WARNING: suspicious RCU usage in idtentry_exit
Message-ID: <20200528204839.GR2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000840d4d05a6850c73@google.com>
 <87wo4wnpzb.fsf@nanos.tec.linutronix.de>
 <20200528161143.GF2869@paulmck-ThinkPad-P72>
 <878shbols9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878shbols9.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:19:02PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Thu, May 28, 2020 at 03:33:44PM +0200, Thomas Gleixner wrote:
> >> syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com> writes:
> >> Weird. I have no idea how that thing is an EQS here.
> >
> > No argument on the "Weird" part!  ;-)
> >
> > Is this a NO_HZ_FULL=y kernel?
> 
> No, it has only NO_HZ_IDLE.
> 
>   https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10

OK, from the .config, another suggestion is to build the kernel
with CONFIG_RCU_EQS_DEBUG=y.  This still requires that this issue be
reproduced, but it might catch the problem earlier.

> > If so, one possibility is that the call
> > to rcu_user_exit() went missing somehow.  If not, then RCU should have
> > been watching userspace execution.
> >
> > Again, the only thing I can think of (should this prove to be
> > reproducible) is the rcu_dyntick trace event.
> 
> :)
> 
> Thanks,
> 
>         tglx

							Thanx, Paul
