Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF60B2FE15C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhAUFCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:02:36 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49231 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388197AbhAUDvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 22:51:05 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L3oFGf023302;
        Thu, 21 Jan 2021 04:50:15 +0100
Date:   Thu, 21 Jan 2021 04:50:15 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210121035015.GA22837@1wt.eu>
References: <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
 <20210119171637.GA14704@1wt.eu>
 <20210119174358.GB14704@1wt.eu>
 <20210120120725.GB73692@C02TD0UTHF1T.local>
 <20210120124340.GA15935@1wt.eu>
 <20210120134511.GA77728@C02TD0UTHF1T.local>
 <20210120142500.GB15935@1wt.eu>
 <20210120145447.GC77728@C02TD0UTHF1T.local>
 <20210120150223.GC15935@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120150223.GC15935@1wt.eu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 04:02:23PM +0100, Willy Tarreau wrote:
> > ... and getting rid of the ARCH_WANT_* definitions (which are never
> > legitimate for userspace to set). That way, there's no risk that we
> > accidentally use a bogus syscall number in future. Where the kernel does
> > implement a syscall, it will have done whatever is necessary to expose
> > the corresponding __NR_<syscall> to userspace without userspace needing
> > to define anything.
> 
> I'm really willing to get rid of that crap, I hated it, I vaguely
> remember having gone through layers of glibc indirections when using
> the pre-processed asm/* and found this to be the only way to expose
> some of them. The fact that it's not needed for you is pretty much
> encouraging. I'll just retry on an older libc I've used a lot (2.18)
> to make sure I didn't overlook anything.

I've now retested and can confirm that the only reason I included them
by then was to have access to these (wrong) __NR_* definitions. Now with
the fixed syscalls these ones are not needed anymore and I indeed only
see the correct definitions, so I've removed these bogus definitions.

I've completed my cleanup and tests, I'll send an updated patch set
later today after I've carefully rediffed everything to synchronise
the in-kernel version with the out-of-tree one.

Cheers,
Willy
