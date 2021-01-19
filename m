Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620982FBD66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbhASRTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:19:02 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49183 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391308AbhASRRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:17:44 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10JHGbOp014707;
        Tue, 19 Jan 2021 18:16:37 +0100
Date:   Tue, 19 Jan 2021 18:16:37 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210119171637.GA14704@1wt.eu>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119170238.GA5603@C02TD0UTHF1T.local>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Jan 19, 2021 at 05:02:38PM +0000, Mark Rutland wrote:
> > I can't spot from the report above the original C file that was attempted
> > to be built, it makes me think we tried to compile directly the .h file.
> 
> That was the inline snippet in
> tools/testing/selftests/rcutorture/bin/mkinitrd.sh:
> 
> | #ifndef NOLIBC
> | #include <unistd.h>
> | #include <sys/time.h>
> | #endif
> | 
> | volatile unsigned long delaycount;
> | 
> | int main(int argc, int argv[])
> | {
> |         int i;
> |         struct timeval tv;
> |         struct timeval tvb;
> | 
> |         for (;;) {
> |                 sleep(1);
> |                 /* Need some userspace time. */
> |                 if (gettimeofday(&tvb, NULL))
> |                         continue;
> |                 do {
> |                         for (i = 0; i < 1000 * 100; i++)
> |                                 delaycount = i * i;
> |                         if (gettimeofday(&tv, NULL))
> |                                 break;
> |                         tv.tv_sec -= tvb.tv_sec;
> |                         if (tv.tv_sec > 1)
> |                                 break;
> |                         tv.tv_usec += tv.tv_sec * 1000 * 1000;
> |                         tv.tv_usec -= tvb.tv_usec;
> |                 } while (tv.tv_usec < 1000);
> |         }
> |         return 0;
> | }
> 
> ... which gets written to a file called init.c, and then built with:
> 
> | ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
> |         -nostdlib -include ../../../../include/nolibc/nolibc.h \
> |         -lgcc -s -static -Os -o init init.c

OK I'll retry this, thank you!

> I was building natively on an arm64 box:
> 
> | ./tools/testing/selftests/rcutorture/bin/kvm.sh \
> |         --cpus 250 --trust-make --configs "TREE03" \
> |         --kmake-arg "CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64"
> 
> > Having it run through sh -x would help me try to locate the root cause or
> > possibly even attempt to reproduce it.
> 
> I ran with sh -x, but it didn't log the compiler invocation; hopefully
> the above is sufficient?

I guess so, yes. I'm pretty sure I'll come back with new questions
soon :-)

Thanks,
Willy
