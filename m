Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841702FBD36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390657AbhASRIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:08:14 -0500
Received: from foss.arm.com ([217.140.110.172]:40530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731808AbhASRDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:03:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D5A3D6E;
        Tue, 19 Jan 2021 09:02:45 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C2DF3F66E;
        Tue, 19 Jan 2021 09:02:44 -0800 (PST)
Date:   Tue, 19 Jan 2021 17:02:38 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210119170238.GA5603@C02TD0UTHF1T.local>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119161901.GA14667@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Tue, Jan 19, 2021 at 05:19:01PM +0100, Willy Tarreau wrote:
> On Tue, Jan 19, 2021 at 07:31:47AM -0800, Paul E. McKenney wrote:
> > Some people are having trouble running rcutorture on ARMv8.  They
> > get things like this from the nolibc build of initrd:
> > 
> > https://paste.debian.net/1181762/
> > 
> > The nolibc.h file says this:
> > 
> > /* Some archs (at least aarch64) don't expose the regular syscalls anymore by
> >  * default, either because they have an "_at" replacement, or because there are
> >  * more modern alternatives. For now we'd rather still use them.
> >  */
> > 
> > Are these build failures expected behavior on ARMv8?
> 
> No, I don't think so. I'm regularly building my own init using this,
> and it works on various platforms including aarch64, while it makes
> use of a number of such syscalls.
> 
> From what I'm seeing, this seems to happen each time in such a construct:
> 
>     #if defined(__NR_new_name)
>          use __NR_new_name
>     #else
>          use __NR_old_name
>     #endif
> 
> with the error appearing on old_name. So I guess that we're rather facing a
> case where a number of such __NR_* entries are not defined because presumably
> one include file might be missing (probably from a recent change of headers
> dependency).
> 
> I can't spot from the report above the original C file that was attempted
> to be built, it makes me think we tried to compile directly the .h file.

That was the inline snippet in
tools/testing/selftests/rcutorture/bin/mkinitrd.sh:

| #ifndef NOLIBC
| #include <unistd.h>
| #include <sys/time.h>
| #endif
| 
| volatile unsigned long delaycount;
| 
| int main(int argc, int argv[])
| {
|         int i;
|         struct timeval tv;
|         struct timeval tvb;
| 
|         for (;;) {
|                 sleep(1);
|                 /* Need some userspace time. */
|                 if (gettimeofday(&tvb, NULL))
|                         continue;
|                 do {
|                         for (i = 0; i < 1000 * 100; i++)
|                                 delaycount = i * i;
|                         if (gettimeofday(&tv, NULL))
|                                 break;
|                         tv.tv_sec -= tvb.tv_sec;
|                         if (tv.tv_sec > 1)
|                                 break;
|                         tv.tv_usec += tv.tv_sec * 1000 * 1000;
|                         tv.tv_usec -= tvb.tv_usec;
|                 } while (tv.tv_usec < 1000);
|         }
|         return 0;
| }

... which gets written to a file called init.c, and then built with:

| ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
|         -nostdlib -include ../../../../include/nolibc/nolibc.h \
|         -lgcc -s -static -Os -o init init.c

I was building natively on an arm64 box:

| ./tools/testing/selftests/rcutorture/bin/kvm.sh \
|         --cpus 250 --trust-make --configs "TREE03" \
|         --kmake-arg "CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64"

> Having it run through sh -x would help me try to locate the root cause or
> possibly even attempt to reproduce it.

I ran with sh -x, but it didn't log the compiler invocation; hopefully
the above is sufficient?

Thanks,
Mark.
