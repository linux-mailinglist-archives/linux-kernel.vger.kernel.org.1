Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E822CA373
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbgLANHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:07:41 -0500
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:59745 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgLANHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:07:40 -0500
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 15503215CFB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:06:59 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id k5MwkmWb1dCH5k5MwkqqLg; Tue, 01 Dec 2020 06:06:59 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=MYVCRa3f c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=JfrnYn6hAAAA:8
 a=YWtRXzOXAAAA:8 a=olmuuQao6RMEz0gzl2QA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=1CNFftbPRP8L7MoqJWF3:22 a=XosyFl2cby_8ldcV-F0Q:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/jjSGUaq3fI4DbfKuYoM37LOgNCu1qQEZMKSfC94mCQ=; b=Ds9DFF8xGJGreZPv3GZx5HX/Ch
        taX9ghp2ZOeLSxAHkKBa1gdppeYzIu3A0enrQKhEy0ZEkqM3ori7sawAppJqcwsXjqlsdnJaBuMu2
        fxetayiLvyEwKh4DGUg7zmBGdiEYltBmbrn0jqigC80RianPzWiZF+69lNd5kSnAdB4lQwEBg4Hob
        cU18V3wH/vVo3cicQUAGXTvpWX6bfmHNeWbIaoR51o0FGryWHmGgRRCqEXdH9o3zU0n9xe8FGUGsy
        QaXDrnHNU/+ppzh57SufECIMv+JTc40JWq41M/Fy46Apco+5zsEvxnLp+hi1izgz6a1HAz1e67gYR
        Ei+6e08Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59838 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kk5Mv-0003Gj-QB; Tue, 01 Dec 2020 13:06:57 +0000
Date:   Tue, 1 Dec 2020 05:06:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org,
        mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
Message-ID: <20201201130657.GA232197@roeck-us.net>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.594122626@infradead.org>
 <20201130210003.GA40619@roeck-us.net>
 <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
 <yt9dh7p54u50.fsf@linux.ibm.com>
 <20201201125246.GV2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125246.GV2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kk5Mv-0003Gj-QB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:59838
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 6
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:52:46PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 12:56:27PM +0100, Sven Schnelle wrote:
> > Hi Peter,
> > 
> > Peter Zijlstra <peterz@infradead.org> writes:
> > 
> > > On Mon, Nov 30, 2020 at 01:00:03PM -0800, Guenter Roeck wrote:
> > >> On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
> > >> > We call arch_cpu_idle() with RCU disabled, but then use
> > >> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> > >> > 
> > >> > Switch all arch_cpu_idle() implementations to use
> > >> > raw_local_irq_{en,dis}able() and carefully manage the
> > >> > lockdep,rcu,tracing state like we do in entry.
> > >> > 
> > >> > (XXX: we really should change arch_cpu_idle() to not return with
> > >> > interrupts enabled)
> > >> > 
> > >> 
> > >> Has this patch been tested on s390 ? Reason for asking is that it causes
> > >> all my s390 emulations to crash. Reverting it fixes the problem.
> > >
> > > My understanding is that it changes the error on s390. Previously it
> > > would complain about the local_irq_enable() in arch_cpu_idle(), now it
> > > complains when taking an interrupt during idle.
> > 
> > I looked into adding the required functionality for s390, but the code
> > we would need to add to entry.S is rather large - as you noted we would
> > have to duplicate large portions of irqentry_enter() into our code.
> > Given that s390 was fine before that patch, can you revert it and submit
> > it again during the next merge window?
> 
> I'm not sure I understand how s390 was fine without it, let me consdier.
> Also, what's the status of ARM64, they do need this too.

For v5.10-rc6:

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 426 pass: 421 fail: 5
Failed tests:
	s390:defconfig:initrd
	s390:defconfig:virtio-blk-ccw:rootfs
	s390:defconfig:scsi[virtio-ccw]:rootfs
	s390:defconfig:virtio-pci:rootfs
	s390:defconfig:scsi[virtio-pci]:rootfs

At least with qemu all other tests/architectures are fine.
You can find the tested architectures at https://kerneltests.org/builders.

Guenter
