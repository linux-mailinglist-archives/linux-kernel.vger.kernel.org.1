Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D866288A15
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbgJINzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbgJINzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:55:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00539C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 06:55:54 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2CDBD63E; Fri,  9 Oct 2020 09:55:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2CDBD63E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1602251754;
        bh=EvWh/sK89rBqiusgud0y7S4S1jC5DcDYAD+jwDtI2CI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r0wKJC1UbWwApSm0pnMO9aJHhJ3078epkYPBek9yLoY1uAxefX6+UJxvX1dy8M3BP
         ohvyO4DHTMqkfm+yPQNdeSDfiedYJB0u1Bo9bfNsGVoYRYxbOQCr/bIAKM7Kzd75b4
         09TTO8BRUlXcoxjBtGvcAT76RnSKjUwC1Gha9ZZ4=
Date:   Fri, 9 Oct 2020 09:55:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
Message-ID: <20201009135554.GE15719@fieldses.org>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
 <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de>
 <20201009132815.5afulu5poh5ti57m@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009132815.5afulu5poh5ti57m@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:28:15PM +0200, Christian Brauner wrote:
> On Thu, Oct 08, 2020 at 07:39:42AM +0200, Michael Weiß wrote:
> > getboottime64() provides the time stamp of system boot. In case of
> > time namespaces,

Huh, I didn't know there were time namespaces.

> > the offset to the boot time stamp was not applied
> > earlier. However, getboottime64 is used e.g., in /proc/stat to print
> > the system boot time to userspace. In container runtimes which utilize
> > time namespaces to virtualize boottime of a container, this leaks
> > information about the host system boot time.
> > 
> > Therefore, we make getboottime64() to respect the time namespace offset
> > for boottime by subtracting the boottime offset.
> > 
> > Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> > ---
> >  kernel/time/timekeeping.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 4c47f388a83f..67530cdb389e 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/clocksource.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/time.h>
> > +#include <linux/time_namespace.h>
> >  #include <linux/tick.h>
> >  #include <linux/stop_machine.h>
> >  #include <linux/pvclock_gtod.h>
> > @@ -2154,6 +2155,8 @@ void getboottime64(struct timespec64 *ts)
> >  {
> >  	struct timekeeper *tk = &tk_core.timekeeper;
> >  	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
> > +	/* shift boot time stamp according to the timens offset */
> > +	t = timens_ktime_to_host(CLOCK_BOOTTIME, t);
> 
> Note that getbootime64() is mostly used in net/sunrpc and I don't know
> if this change has any security implications for them.
> 
> Hey, Trond, Anna, Bruce, and Chuck this virtualizes boottime according
> to the time namespace of the caller, i.e. a container can e.g. reset
> it's boottime when started. This is already possible. The series here
> fixes a bug where /proc/stat's btime field is not virtualized but since
> this changes getboottime64() this would also apply to sunrpc's
> timekeeping. Is that ok or does sunrpc rely on the hosts's boot time,
> i.e. the time in the initial time namespace?

Looking at how it's used in net/sunrpc/cache.c....  All it's doing is
comparing times which have all been calculated relative to the time
returned by getboottime64().  So it doesn't really matter what
getboottime64() is, as long as it's always the same.

So, I don't think this should change behavior of the sunrpc code at all.

--b.
