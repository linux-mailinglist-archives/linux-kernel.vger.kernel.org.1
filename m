Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E761A274F34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgIWCpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:45:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:39590 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgIWCpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:45:36 -0400
IronPort-SDR: lbmKAppA/wrKddoXD/KpUVdEXZvEu+QNUFVFbYIHZG4u7OaafSsEh/W45n0AhM+JK/tS/L2dbe
 2JGa7wSLhyqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="148519947"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="148519947"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 19:45:34 -0700
IronPort-SDR: edeD7pcbQkqzGUw16GNubCkD5zODZXm9cLryrTx55fwp96MKt3obBu1Q+fWTVDBb/IzFDbzrxz
 ZUFZBtrb3zxw==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="486237118"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 19:45:31 -0700
Date:   Wed, 23 Sep 2020 10:45:29 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200923024529.GA15894@shbuild999.sh.intel.com>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200922201024.GS22660@zn.tnic>
 <20200922221523.GA1185357@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922221523.GA1185357@rani.riverdale.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arvind,

On Tue, Sep 22, 2020 at 06:15:23PM -0400, Arvind Sankar wrote:
> On Tue, Sep 22, 2020 at 10:10:24PM +0200, Borislav Petkov wrote:
> > + AMD folks.
> > 
> > On Tue, Sep 22, 2020 at 01:27:50PM +0800, Feng Tang wrote:
> > > End users frequently want to know what features their processor
> > > supports, independent of what the kernel supports.
> > > 
> > > /proc/cpuinfo is great. It is omnipresent and since it is provided by
> > > the kernel it is always as up to date as the kernel. But, it could be
> > > ambiguous about processor features which can be disabled by the kernel
> > > at boot-time or compile-time.
> > > 
> > > There are some user space tools showing more raw features, but they are
> > > not bound with kernel, and go with distros. Many end users are still
> > > using old distros with new kernels (upgraded by themselves), and may
> > > not upgrade the distros only to get a newer tool.
> > > 
> > > So here arise the need for a new tool, which
> > >   * Shows raw cpu features got from running cpuid
> > >   * Be easier to obtain updates for compared to existing userspace
> > >     tooling (perhaps distributed like perf)
> > >   * Inherits "modern" kernel development process, in contrast to some
> > >     of the existing userspace cpuid tools which are still being developed
> > >     without git and distributed in tarballs from non-https sites.
> > >   * Can produce output consistent with /proc/cpuinfo to make comparison
> > >     easier.
> 
> Rather than a tool, would additional file(s) in, say,
> /sys/devices/system/cpu/cpu<n> be nicer? They could show the raw CPUID
> features, one file per leaf or sub-leaf, maybe even along with whether
> they were disabled at boot-time.

My thought is we already have in-kernel powerful /proc/cpuinfo, while 
a user space tool could be more flexible for text parsing/layout, and
show different info on user's demand/options.

> > >   * Be in-kernel, could leverage kernel enabling, and even
> > >     theoretically consume arch/x86/boot/cpustr.h so it could pick up
> > >     new features directly from one-line X86_FEATURE_* definitions.
> 
> That's arch/x86/include/asm/cpufeatures.h right -- cpustr.h is generated
> from that. The table there already has comments which could be extracted
> as the one-line description.

Thanks for the hint! I found the comments in cpufeatures.h is much better
than what I extraced from SDM :), which I should use instead.

One other thing as Boris has mentioned, cpu feature is mixture of raw
silicon features and kernel software ones. Also, cpufeatures.h only
contains shows ont-bit boolean flag, while cpuid has multiple-bits field
containing numbers.

Thanks,
Feng


