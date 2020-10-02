Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E3281842
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbgJBQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:47:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:56670 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388163AbgJBQrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:47:17 -0400
IronPort-SDR: Dcq2GnRugQboeaJHGud0NCBSho/kd2SmwWR+hcpSbj3CucPPN2zmQfKqo4hIa9Hs4MZFA+Yhmp
 JbQDC7JKjnXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="181151202"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="181151202"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 09:47:15 -0700
IronPort-SDR: QIXtnXIiO8sq5DQteA9UDuZY5NUF6shW++CcOMghdLJOhZwNmogwl0IZZ/CPBogwpyYMcBRahV
 YrozH8IdqJ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="342027071"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 02 Oct 2020 09:47:12 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 02 Oct 2020 19:47:12 +0300
Date:   Fri, 2 Oct 2020 19:47:12 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [drm/dp] 6509ca051a: PANIC:double_fault
Message-ID: <20201002164712.GD6112@intel.com>
References: <20200924143049.GJ28663@shao2-debian>
 <20200924164203.GL6112@intel.com>
 <90f391ac-e65c-c172-8fcb-ee1fe71de09a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90f391ac-e65c-c172-8fcb-ee1fe71de09a@intel.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 01:26:09PM +0800, Rong Chen wrote:
> 
> 
> On 9/25/20 12:42 AM, Ville Syrjälä wrote:
> > On Thu, Sep 24, 2020 at 10:30:49PM +0800, kernel test robot wrote:
> >> Greeting,
> >>
> >> FYI, we noticed the following commit (built with gcc-9):
> >>
> >> commit: 6509ca051abf4ff60d63732badcb2173a715f741 ("drm/dp: Add drm_dp_downstream_{min,max}_tmds_clock()")
> > That doesn't really do anything on its own. So can't see how it would
> > make anything blow up.
> 
> Hi Ville,
> 
> The issue is 100% reproducible, could you try the reproduce steps:
> 
> To reproduce:
> 
>          # build kernel
> 	cd linux
> 	cp config-5.9.0-rc4-00881-g6509ca051abf4 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email

Managed to find some Ubuntu machine where that would run.

$ time ./bin/lkp qemu -k ~/bzImage ~/job-script
...
[    0.000000] Linux version 5.9.0-rc4-00027-g6509ca051abf (...) (gcc (Gentoo 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.33.1 p2) 2.33.1) #2 SMP PREEMPT Fri Oct 2 19:24:28 EEST 2020
...
[   12.717392] Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
[   12.718889] ac.o: No PCI boards found.
[   12.719696] ac.o: For an ISA board you must supply memory and irq parameters.
[   12.721269] toshiba: not a supported Toshiba laptop
[   12.722779] random: get_random_u32 called from arch_rnd+0x1c/0x40 with crng_init=0
[   12.722784] random: get_random_u32 called from randomize_stack_top+0x35/0x50 with crng_init=0
[   12.722787] random: get_random_u32 called from arch_align_stack+0x35/0x50 with crng_init=0
...
real	11m35,352s
user	13m40,549s
sys	0m13,071s
$ echo $?
0

-- 
Ville Syrjälä
Intel
