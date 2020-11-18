Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889C02B7BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgKRK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgKRK4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:56:47 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD81921D7E;
        Wed, 18 Nov 2020 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605697005;
        bh=lrD8ZRPLVKAEKZP/N1tGuQfXp42Hb/n9pE7MvPLL2Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QY3L9bRnf5NlR88sDiN7BAZ742+EwnJlntnk0o/2cm3eumjSR8MGEcj8VburV947Q
         FVOa12K0xaWGk3YNYimOC0cR07lwGwCUZoNFeTKQdiCIeVahNkCXPB9ZOm5QchuzLo
         s0UeVLdwu5VHL5C1JaZGpBgXn74mdeDWw8ImmHKQ=
Date:   Wed, 18 Nov 2020 11:57:31 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brice Goglin <brice.goglin@gmail.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
Message-ID: <X7T+G2J37M62glzi@kroah.com>
References: <20201006005736.GD6041@ranerica-svr.sc.intel.com>
 <20201006073744.GA6753@kroah.com>
 <20201007031447.GB27938@ranerica-svr.sc.intel.com>
 <20201007051546.GA47583@kroah.com>
 <7233394d-982b-72cd-ceb9-d81161bd826f@gmail.com>
 <X6zZaKt57Xl9NnuN@kroah.com>
 <d7ac96f2-10e8-209d-2903-1bbe8fc552f4@gmail.com>
 <X60TJ2u47WK3yY/y@kroah.com>
 <33efde37-562f-4c6a-72ba-2277533e3781@gmail.com>
 <ea20c2b8-18c8-ef76-4a16-15b7271333d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea20c2b8-18c8-ef76-4a16-15b7271333d1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:45:46AM +0100, Brice Goglin wrote:
> 
> Le 17/11/2020 à 16:55, Brice Goglin a écrit :
> > Le 12/11/2020 à 11:49, Greg Kroah-Hartman a écrit :
> >> On Thu, Nov 12, 2020 at 10:10:57AM +0100, Brice Goglin wrote:
> >>> Le 12/11/2020 à 07:42, Greg Kroah-Hartman a écrit :
> >>>> On Thu, Nov 12, 2020 at 07:19:48AM +0100, Brice Goglin wrote:
> >>>>> Hello
> >>>>>
> >>>>> Sorry for the late reply. As the first userspace consumer of this
> >>>>> interface [1], I can confirm that reading a single file to get the mask
> >>>>> would be better, at least for performance reason. On large platforms, we
> >>>>> already have to read thousands of sysfs files to get CPU topology and
> >>>>> cache information, I'd be happy not to read one more file per cpu.
> >>>>>
> >>>>> Reading these sysfs files is slow, and it does not scale well when
> >>>>> multiple processes read them in parallel.
> >>>> Really?  Where is the slowdown?  Would something like readfile() work
> >>>> better for you for that?
> >>>> 	https://lore.kernel.org/linux-api/20200704140250.423345-1-gregkh@linuxfoundation.org/
> >>> I guess readfile would improve the sequential case by avoiding syscalls
> >>> but it would not improve the parallel case since syscalls shouldn't have
> >>> any parallel issue?
> >> syscalls should not have parallel issues at all.
> >>
> >>> We've been watching the status of readfile() since it was posted on LKML
> >>> 6 months ago, but we were actually wondering if it would end up being
> >>> included at some point.
> >> It needs a solid reason to be merged.  My "test" benchmarks are fun to
> >> run, but I have yet to find a real need for it anywhere as the
> >> open/read/close syscall overhead seems to be lost in the noise on any
> >> real application workload that I can find.
> >>
> >> If you have a real need, and it reduces overhead and cpu usage, I'm more
> >> than willing to update the patchset and resubmit it.
> >>
> >>
> > Hello
> >
> > I updated hwloc to use readfile instead of open+read+close on all those
> > small sysfs/procfs files. Unfortunately the improvement is very small,
> > only a couple percents. On a 40 core server, our library starts in 38ms
> > instead of 39ms. I can't deploy your patches on larger machines, but I
> > tested our code on a copy of their sysfs files saved on a local disk :
> > For a 256-thread KNL, we go from 15ms to 14ms. For a 896-core SGI
> > machine, from 73ms to 71ms.
> 
> 
> Sorry, I forgot to update some codepaths to properly use readfile yesterday :/
> Here are updated and more precise numbers that show a non-negligible improvement.
> Again, we're measuring the entire hwloc topology discovery, which includes reading
> many sysfs file (improved thanks to readfile) and then building a hierarchy of
> objects describing the machine (not modified).
> 
> Server sysfs files (dual-socket x 20 cores x SMT-2)
> default  43.48ms +/-4.48
> readfile 42.15ms +/-4.58 => 3.1% better
> 1971 readfile calls => 674ns improvement per call
> 
> Knight Landing sysfs stored on local hard drive (64 cores x SMT-4)
> default  14.60ms +/-0.91
> readfile 13.63ms +/-1.05 => 6.6% better
> 2940 readfile calls => 329ns improvement per call
> 
> SGI Altix UV sysfs stored on local hard drive (56 sockets x 8 coeurs x SMT-2)
> default  69.12ms +/-1.40
> readfile 66.03ms +/-1.35 => 4.5% better
> 14525 readfile calls => 212ns improvement per call
> 
> I don't know why the first case (real sysfs files) gets a much
> higher standard deviation and higher improvement per readfile call.
> The other two cases match what microbenmarks say
> (about 200ns improvement per readfile call).

Thanks a lot for the detailed numbers.  I think 6.6% is the best that I
saw in my microbenchmarks as well.

While that would be great for a userspace task that does real work,
doing this type of thing is arguably, not "real work" :)

I'll keep the patch updated over time just for fun, but odds are it's
not going to get merged unless we have some userspace workload that
really needs it.

But, you pointing out the global kernfs mutex is an issue, that we
should work on resolving.  I've pointed someone at it already and maybe
we will have some results in a few weeks.

thanks,

greg k-h
