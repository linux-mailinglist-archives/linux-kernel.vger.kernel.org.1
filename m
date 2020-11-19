Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD32B93EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgKSNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:50:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:53096 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgKSNuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:50:15 -0500
IronPort-SDR: FgFUeljNEAmCDy7alrvVO3kOkFFU2xaJZqxfCW6bx0ewWqjcOV16FtIUnfyUjvrix3GRGnwYqM
 xbsv7JGlLDwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="150557261"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="150557261"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 05:50:14 -0800
IronPort-SDR: vMcfjx98HG2zGU8QaEtO01QdpGJaK+iXg4xFSAGPIoCn82SImejxHOZbkaIAIi2hK9zfsXBkLl
 lCkPaK7tJbyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="534783176"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2020 05:50:11 -0800
Date:   Thu, 19 Nov 2020 21:50:10 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        thomas.lendacky@amd.com, yazen.ghannam@amd.com, wei.huang2@amd.com
Subject: Re: [RFC PATCH v3] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20201119135010.GC112648@shbuild999.sh.intel.com>
References: <1603344083-100742-1-git-send-email-feng.tang@intel.com>
 <20201118191529.GN7472@zn.tnic>
 <20201119072055.GA112648@shbuild999.sh.intel.com>
 <20201119091815.GA3769@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119091815.GA3769@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:18:15AM +0100, Borislav Petkov wrote:
> On Thu, Nov 19, 2020 at 03:20:55PM +0800, Feng Tang wrote:
> > I just tried the patch on one Debian 9 and 2 Ubuntus (16.04 & 20.10) with
> > different gcc versions, and haven't reproduced it yet.
> 
> That's because you're testing in VMs and they have CPUID(4) which baremetal -
> where I am testing - doesn't and I get

That's really odd. I tried on 3 baremetal machines: one Skylake NUC device,
one Xeon E5-2699 and one Xeon E5-2680.

> parse_line: entry
> parse_line: skip comments
> parse_line: index/main leaf, func: 0x5588497d7300
> parse_line: sub 0, leafs: (nil)
> 			^^^^^^

Thanks for the debugging and root causing!

> for leafs for index 4 and thus this is a NUL ptr. And leaf 4 is the test
> range in cpuid.csv.
> 
> Which brings me to another important point: setup_platform_cpuid()
> should not blindly simply look at the two ranges 0 and 0x8000_0000
> but detect whether it is running on baremetal or on a hypervisor and
> depending on which, setup the respective ranges.
> 
> For example, guests would need to scan 0x4, in addition to the above.
> Centaur CPUs have CPUID in the ranges 0xc0000000 and so on.
> 
> But you don't have to implement all CPUID leafs and ranges - just your
> tool should be careful and first detect on what it runs and then scan
> the possible ranges.

Ok, will check more on this.

> And then exit gracefully when it encounters a range which it doesn't
> know and not segfault.

Yes, it needs to consider more possible errors.

> There could be another option which, when set, would go and scan the
> *whole* 32-bit CPUID range to find whether there are some CPUID ranges
> which are not known. Another option because the scan would potentially
> take long time and thus off by default. And so on.
> 
> Here's the patch I've cleaned up and fixed up so far, please continue
> with it.

Thanks! will go with this version.

- Feng

> Thx.
> 
> ---
> >From 244c34532d1596a0e3603683904497847bb26b1c Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Thu, 22 Oct 2020 13:21:23 +0800
> Subject: [PATCH] tools/x86: Add a kcpuid tool to show raw CPU features
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> End users frequently want to know what features their processor
> supports, independent of what the kernel supports.
> 
> /proc/cpuinfo is great. It is omnipresent and since it is provided by
> the kernel it is always as up to date as the kernel. But, it could be
> ambiguous about processor features which can be disabled by the kernel
> at boot-time or compile-time.
> 
> There are some user space tools showing more raw features, but they are
> not bound with kernel, and go with distros. Many end users are still
> using old distros with new kernels (upgraded by themselves), and may
> not upgrade the distros only to get a newer tool.
> 
> So here arise the need for a new tool, which
>   * shows raw CPU features read from the CPUID instruction
>   * will be easier to update compared to existing userspace
>     tooling (perhaps distributed like perf)
>   * inherits "modern" kernel development process, in contrast to some
>     of the existing userspace CPUID tools which are still being developed
>     without git and distributed in tarballs from non-https sites.
>   * Can produce output consistent with /proc/cpuinfo to make comparison
>     easier.
> 
> The CPUID leaf definitions are kept in an .csv file which allows for
> updating only that file to add support for new feature leafs.
> 
> This is based on prototype code from Borislav Petkov
> (http://sr71.net/~dave/intel/stupid-cpuid.c).
> 
>  [ bp: Massage, add #define _GNU_SOURCE to fix implicit declaration of
>    function ‘strcasestr' warning. ]
> 
> Originally-from: Borislav Petkov <bp@alien8.de>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/1603344083-100742-1-git-send-email-feng.tang@intel.com
> ---
>  tools/arch/x86/kcpuid/Makefile  |  24 ++
>  tools/arch/x86/kcpuid/cpuid.csv |  57 +++
>  tools/arch/x86/kcpuid/kcpuid.c  | 623 ++++++++++++++++++++++++++++++++
>  3 files changed, 704 insertions(+)
>  create mode 100644 tools/arch/x86/kcpuid/Makefile
>  create mode 100644 tools/arch/x86/kcpuid/cpuid.csv
>  create mode 100644 tools/arch/x86/kcpuid/kcpuid.c
