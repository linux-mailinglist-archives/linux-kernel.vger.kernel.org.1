Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FA72B94AF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgKSOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:32:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:46393 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgKSOcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:32:42 -0500
IronPort-SDR: +WJf2UhpNur9RgDJnmWZXRcjbzCB1kjXi7/VP20e2s/C8fCUP4cUaOAwqYp9NPfIErMH0YCkAs
 KSwaK0cMMNrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="189382828"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="189382828"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 06:32:41 -0800
IronPort-SDR: nN06MWhHMP+zpE6EN2l0/wEpVq1pu3x5J9r+z4fdJZkMcnWlgCsG0L2h9YxoqJka7xWk2CYLRw
 73q3sx9Pk1Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="534800729"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2020 06:32:38 -0800
Date:   Thu, 19 Nov 2020 22:32:37 +0800
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
Message-ID: <20201119143237.GA129558@shbuild999.sh.intel.com>
References: <1603344083-100742-1-git-send-email-feng.tang@intel.com>
 <20201118191529.GN7472@zn.tnic>
 <20201119072055.GA112648@shbuild999.sh.intel.com>
 <20201119091815.GA3769@zn.tnic>
 <20201119135010.GC112648@shbuild999.sh.intel.com>
 <20201119141512.GB3769@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119141512.GB3769@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:15:12PM +0100, Borislav Petkov wrote:
> On Thu, Nov 19, 2020 at 09:50:10PM +0800, Feng Tang wrote:
> > That's really odd. I tried on 3 baremetal machines: one Skylake NUC device,
> > one Xeon E5-2699 and one Xeon E5-2680.
> 
> Ah, sorry, not virt, virt is 0x4000_0000. Yeah, I remember now. It is
> function 4 which AMD doesn't implement and I'm running this on AMD:

Great! That's the trick :) I will be more careful with these special ranges
from different vendors.   

Thanks,
Feng

> $ cpuid -1r
> CPU:
>    0x00000000 0x00: eax=0x0000000d ebx=0x68747541 ecx=0x444d4163 edx=0x69746e65
>    0x00000001 0x00: eax=0x00800f82 ebx=0x0c100800 ecx=0x7ed8320b edx=0x178bfbff
>    0x00000002 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
>    0x00000003 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
> 
> <-- no function 4.
> 
>    0x00000005 0x00: eax=0x00000040 ebx=0x00000040 ecx=0x00000003 edx=0x00000011
>    ...
> 
> That's why.  :-)
> 
> Btw, there are other funny ranges on Intel:
> 
> ./cpuid -1r
> CPU:
>    0x20000000 0x00: eax=0x00000000 ebx=0x00000001 ecx=0x00000001 edx=0x00000000
> 
> That one has 2 bits set.
> 
>    0x80860000 0x00: eax=0x00000000 ebx=0x00000001 ecx=0x00000001 edx=0x00000000
>    0xc0000000 0x00: eax=0x00000000 ebx=0x00000001 ecx=0x00000001 edx=0x00000000
> 
> And those too.
> 
> Fun.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
