Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E0D2EC573
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbhAFVEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:04:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:49215 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbhAFVEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:04:49 -0500
IronPort-SDR: ywjl1Huv6Qc4FASp0E/XuIuhO438Ym57gejReJ6BasWx2QBTlvmBYqE5rquU6zhZsDwzwTcq/E
 wTfPkgC9zBuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="241413126"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="241413126"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 13:04:07 -0800
IronPort-SDR: NfpCknYYu5WmTKgIWW28XFArek/3xVp1Y1pSf2H3YFL6dbehLhDzQB/D2aPne6GMG8S9ELbSpF
 ybLSKS3fsz5Q==
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="346776914"
Received: from pthatich-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.142.206])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 13:04:07 -0800
Date:   Wed, 6 Jan 2021 13:04:06 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: fix movdir64b() sparse warning
Message-ID: <20210106210406.4gqdxhuvrjki5v6h@intel.com>
References: <160996560236.3973505.14624475570488164641.stgit@djiang5-desk3.ch.intel.com>
 <CAPcyv4jYeJ48eY5-PxjkARizjQWqsSZuG=63+d526f7sjLK_tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jYeJ48eY5-PxjkARizjQWqsSZuG=63+d526f7sjLK_tQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-06 12:59:35, Dan Williams wrote:
> On Wed, Jan 6, 2021 at 12:40 PM Dave Jiang <dave.jiang@intel.com> wrote:
> >
> > Add missing __iomem anotation to address sparse warning.
> 
> s/anotation/annotation/
> 
> >
> > "sparse warnings: (new ones prefixed by >>)"
> >    drivers/dma/idxd/submit.c: note: in included file (through include/linux/io.h, include/linux/pci.h):
> > >> arch/x86/include/asm/io.h:422:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dst @@     got void [noderef] __iomem *dst @@
> >    arch/x86/include/asm/io.h:422:27: sparse:     expected void *dst
> >    arch/x86/include/asm/io.h:422:27: sparse:     got void [noderef] __iomem *dst
> 
> The sparse spew is somewhat interesting, but what would be more
> helpful is explain the why. I.e. that existing and future users expect
> to be passing an __iomem annotated pointer to this routine because...
> <reasons go here>. Otherwise someone (reviewer / future git blame
> user) might reasonably ask, "well, why is the driver passing an
> __iomem annotated pointer in the first instance?".
> 
> To Ben's point you might also duplicate part of the comment from
> movdir64b and say:
> 
> "Recall, from the comment in movdir64b @__dst  must be supplied as an
> lvalue because this tells the compiler what the object is (its size)
> the instruction accesses. I.e., not the pointers but what they point
> to, thus the deref'ing '*'."

Thanks for pasting this, I missed that. It still doesn't make sense to me why
the compiler needs to know this. I guess it makes sense to the rest of you.

> 
> With clarified changelog for both you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
