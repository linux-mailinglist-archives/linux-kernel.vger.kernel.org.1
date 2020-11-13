Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9C32B1A94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgKMMDr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Nov 2020 07:03:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2493 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKMLnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:43:07 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CXc4r5KLGzQkdP;
        Fri, 13 Nov 2020 19:41:48 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 13 Nov 2020 19:41:57 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 13 Nov 2020 19:41:56 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 13 Nov 2020 19:41:57 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Adrian Freund <adrian@freund.io>
Subject: RE: [PATCH v2 2/2] Documentation: scheduler: ask users to set
 sched_debug cmdline
Thread-Topic: [PATCH v2 2/2] Documentation: scheduler: ask users to set
 sched_debug cmdline
Thread-Index: AQHWuUQnwmkZrIjsyUK9Ffsjy9jnbanFaTeAgACF8nA=
Date:   Fri, 13 Nov 2020 11:41:57 +0000
Message-ID: <14dfc49fb03f401fa1c661e22bb6e4c1@hisilicon.com>
References: <20201112223129.26580-1-song.bao.hua@hisilicon.com>
 <20201112223129.26580-2-song.bao.hua@hisilicon.com>
 <jhj5z69xzi7.mognet@arm.com>
In-Reply-To: <jhj5z69xzi7.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.8]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
> Sent: Saturday, November 14, 2020 12:34 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: corbet@lwn.net; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> Linuxarm <linuxarm@huawei.com>; Ingo Molnar <mingo@redhat.com>; Peter
> Zijlstra <peterz@infradead.org>; Mel Gorman <mgorman@suse.de>; Adrian
> Freund <adrian@freund.io>
> Subject: Re: [PATCH v2 2/2] Documentation: scheduler: ask users to set
> sched_debug cmdline
> 
> 
> On 12/11/20 22:31, Barry Song wrote:
> > From: Valentin Schneider <valentin.schneider@arm.com>
> >
> > To print the schedule debug information, users need to set sched_debug
> > cmdline or enable it by sysfs entry.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Adrian Freund <adrian@freund.io>
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> FYI, forging SoB, or any 'tag' other than Suggested-by / Reported-by is
> frowned up. Now I do appreciate your effort to give me credit, but in this
> case you should've used Suggested-by.

As this part is actually your code, so I put an --author=" Valentin ..." in
git commit so that git can show you are the author. Actually I was not
sure if SoB was proper when I made it. My intention was only telling
people the code was from you :-)

> 
> Moreso, this really is a trivial change and doesn't deserve a separate
> patch, so I would say just squash that into patch 1, and add
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> to it :)

Cool, thanks.

> 
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  Documentation/scheduler/sched-domains.rst | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/scheduler/sched-domains.rst
> b/Documentation/scheduler/sched-domains.rst
> > index 55983b7e1098..8582fa5e9170 100644
> > --- a/Documentation/scheduler/sched-domains.rst
> > +++ b/Documentation/scheduler/sched-domains.rst
> > @@ -74,6 +74,8 @@ for a given topology level by creating a
> sched_domain_topology_level array and
> >  calling set_sched_topology() with this array as the parameter.
> >
> >  The sched-domains debugging infrastructure can be enabled by enabling
> > -CONFIG_SCHED_DEBUG. This enables an error checking parse of the sched
> domains
> > -which should catch most possible errors (described above). It also prints out
> > -the domain structure in a visual format.
> > +CONFIG_SCHED_DEBUG and adding 'sched_debug' to your cmdline. If you
> forgot to
> > +tweak your cmdline, you can also flip the /sys/kernel/debug/sched_debug
> > +knob. This enables an error checking parse of the sched domains which
> should
> > +catch most possible errors (described above). It also prints out the domain
> > +structure in a visual format.

Thanks
Barry

