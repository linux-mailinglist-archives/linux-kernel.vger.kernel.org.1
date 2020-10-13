Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F331528D530
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbgJMUFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:05:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35700 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgJMUFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:05:35 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kSQXz-0000Ge-6Z; Tue, 13 Oct 2020 20:05:23 +0000
Date:   Tue, 13 Oct 2020 22:05:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
Message-ID: <20201013200521.5dplf5ohey64qmcx@wittgenstein>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
 <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de>
 <20201009132815.5afulu5poh5ti57m@wittgenstein>
 <20201010071914.GA135401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201010071914.GA135401@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 12:19:14AM -0700, Andrei Vagin wrote:
> On Fri, Oct 09, 2020 at 03:28:15PM +0200, Christian Brauner wrote:
> > On Thu, Oct 08, 2020 at 07:39:42AM +0200, Michael Weiß wrote:
> > > getboottime64() provides the time stamp of system boot. In case of
> > > time namespaces, the offset to the boot time stamp was not applied
> > > earlier. However, getboottime64 is used e.g., in /proc/stat to print
> > > the system boot time to userspace. In container runtimes which utilize
> > > time namespaces to virtualize boottime of a container, this leaks
> > > information about the host system boot time.
> > > 
> > > Therefore, we make getboottime64() to respect the time namespace offset
> > > for boottime by subtracting the boottime offset.
> > > 
> > > Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> > > ---
> > >  kernel/time/timekeeping.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > > index 4c47f388a83f..67530cdb389e 100644
> > > --- a/kernel/time/timekeeping.c
> > > +++ b/kernel/time/timekeeping.c
> > > @@ -17,6 +17,7 @@
> > >  #include <linux/clocksource.h>
> > >  #include <linux/jiffies.h>
> > >  #include <linux/time.h>
> > > +#include <linux/time_namespace.h>
> > >  #include <linux/tick.h>
> > >  #include <linux/stop_machine.h>
> > >  #include <linux/pvclock_gtod.h>
> > > @@ -2154,6 +2155,8 @@ void getboottime64(struct timespec64 *ts)
> > >  {
> > >  	struct timekeeper *tk = &tk_core.timekeeper;
> > >  	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
> > > +	/* shift boot time stamp according to the timens offset */
> > > +	t = timens_ktime_to_host(CLOCK_BOOTTIME, t);
> > 
> > Note that getbootime64() is mostly used in net/sunrpc and I don't know
> > if this change has any security implications for them.
> 
> I would prefer to not patch kernel internal functions if they are used
> not only to expose time to the userspace.
> 
> I think when kernel developers sees the getboottime64 function, they
> will expect that it returns the real time of kernel boot. They will
> not expect that it is aware of time namespaces and a returned time will
> depend on a task in which context it will be called.
> 
> IMHO, as a minimum, we need to update the documentation for this function or
> even adjust a function name.
> 
> And I think we need to consider an option to not change getbootime64 and
> apply a timens offset right in the show_stat(fs/proc/stat.c) function.

This is why I asked about this since I assumed this would break
someone's use-case. :)

In any case, if I understand correctly then we want the same thing: just
change fs/proc/stat.c i.e. have a a specific helper that applies the
correct offset.

Christian
