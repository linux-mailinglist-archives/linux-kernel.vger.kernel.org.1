Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD132B34F4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 13:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgKOMkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 07:40:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:13400 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgKOMkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:40:46 -0500
IronPort-SDR: BVBvEgN1gqBfisNbQJGaEX4DAixPV5VjzjQD65gueQNrqvSl5f2P3NIK/sC8NbDGrhkKaC3tcW
 /EyCWqH/l8Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="150495456"
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="150495456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 04:40:45 -0800
IronPort-SDR: J661xsZUvdjkP7WCoxBTOMElFRC1yI6sL+1JF4ZN2FKdX+1tQCwA+iwaPp+W9ZXo5fuQIuw3rY
 ZDuMMOUqIxyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="358138257"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2020 04:40:42 -0800
Date:   Sun, 15 Nov 2020 20:40:41 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, zhengjun.xing@intel.com
Subject: Re: [Fonts]  9522750c66:  fio.read_iops 7.5% improvement
Message-ID: <20201115124041.GA3793@shbuild999.sh.intel.com>
References: <20201112140625.GA21612@xsang-OptiPlex-9020>
 <X64r4X/By+0BTc6a@kroah.com>
 <20201114071916.GA71316@shbuild999.sh.intel.com>
 <X6/MyFRkEPGqnNtK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6/MyFRkEPGqnNtK@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 01:25:44PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 14, 2020 at 03:19:17PM +0800, Feng Tang wrote:
> > Hi Greg,
> > 
> > On Fri, Nov 13, 2020 at 07:46:57AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Nov 12, 2020 at 10:06:25PM +0800, kernel test robot wrote:
> > > > 
> > > > Greeting,
> > > > 
> > > > FYI, we noticed a 7.5% improvement of fio.read_iops due to commit:
> > > > 
> > > > 
> > > > commit: 9522750c66c689b739e151fcdf895420dc81efc0 ("Fonts: Replace discarded const qualifier")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > I strongly doubt this :)
> > 
> > We just double checked, the test was run 4 times and the result are
> > very stable.
> > 
> > The commit does looks irrelevant to fio test, and we just further
> > checked the System map of the 2 kernels, and many data's alignment
> > have been changed (systemmaps attached).
> > 
> > We have a hack debug patch to make data sections of each .o file to
> > be aligned, with that the fio result gap could be reduced from +7.5%
> > to +3.8%, so there is still some other factor affecting the benchmark,
> > which need more checking. And with the same debug method of forcing
> > data sections aligned, 2 other strange performance bumps[1][2] reported
> > by 0day could be recovered.
> > 
> > [1]. https://lore.kernel.org/lkml/20200205123216.GO12867@shao2-debian/
> > [2]. https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
> 
> That's really odd.  Why wouldn't .o sections be aligned already and how
> does that affect the real .ko files that are created from that?  What
> alignment are you forcing?

Our debug patch is hacky which enforce 16K aligned (to adapt other rules
in the linker script to make kernel boot), as below:

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1bf7e31..de5ddc8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -156,7 +156,9 @@ SECTIONS
	X86_ALIGN_RODATA_END
 
	/* Data */
-	.data : AT(ADDR(.data) - LOAD_OFFSET) {
+	.data : AT(ADDR(.data) - LOAD_OFFSET)
+	SUBALIGN(16384)
+	{
		/* Start of data section */
		_sdata = .;

And to make it boot, for our kernel config, we have to disable
CONFIG_DYNAMIC_DEBUG to avoid kernel panic.

> And also, what hardware is seeing this performance gains?  Something is
> fitting into a cache now that previously wasn't, and tracking that down
> seems like it would be very worthwhile as that is a non-trivial speedup
> that some developers take years to achieve with code changes.

It's a x86 server with 2S/48C/96T, and the fio parameters are:

	[global]
	bs=2M
	ioengine=mmap
	iodepth=32
	size=4473924266
	nr_files=1
	filesize=4473924266
	direct=0
	runtime=240
	invalidate=1
	fallocate=posix
	io_size=4473924266
	file_service_type=roundrobin
	random_distribution=random
	group_reporting
	pre_read=0

	time_based

	[task_0]
	rw=read
	directory=/fs/pmem0
	numjobs=24

	[task_1]
	rw=read
	directory=/fs/pmem1
	numjobs=24

And yes, we also think it's cacheline related, and we are further   
checking it. Actually we have 2 other similar strange performance
change checking ongoing:

https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
https://lore.kernel.org/lkml/20201004132838.GU393@shao2-debian/

So it may take some time. And to be frank, there have been quite
some old similar cases that we couldn't figure out the exact cause.

Thanks,
Feng

> thanks,
> 
> greg k-h
