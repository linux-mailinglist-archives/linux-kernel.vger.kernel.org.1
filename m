Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC35F26E9A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 01:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgIQXxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 19:53:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:46021 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIQXxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 19:53:24 -0400
IronPort-SDR: 7UPBVnYBqnil0lHPd+4+kK5kmHQaV6PEwSQYcOi1j1OReOeviEDXINvW5nhC3rglB60Xn+km4B
 T+agYHtd3+Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="160744470"
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="160744470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 16:53:20 -0700
IronPort-SDR: Nr+0mGubviR84swXz/m+U+I6g2bFEXpFYPMqMU7WZWTG1kByWVYLJaKP8s9IKEEkHsHSW/00G0
 uzHsiXwh/nQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,272,1596524400"; 
   d="scan'208";a="332358452"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2020 16:53:18 -0700
Date:   Thu, 17 Sep 2020 23:53:17 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/9] x86: tag application address space for devices
Message-ID: <20200917235317.GA443277@otcwcpicx6.sc.intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <20200916080510.GA32552@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916080510.GA32552@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joerg,

On Wed, Sep 16, 2020 at 10:06:02AM +0200, Joerg Roedel wrote:
> On Tue, Sep 15, 2020 at 09:30:04AM -0700, Fenghua Yu wrote:
> > Ashok Raj (1):
> >   Documentation/x86: Add documentation for SVA (Shared Virtual
> >     Addressing)
> > 
> > Fenghua Yu (7):
> >   drm, iommu: Change type of pasid to u32
> >   iommu/vt-d: Change flags type to unsigned int in binding mm
> >   x86/cpufeatures: Enumerate ENQCMD and ENQCMDS instructions
> >   x86/msr-index: Define IA32_PASID MSR
> >   mm: Define pasid in mm
> >   x86/cpufeatures: Mark ENQCMD as disabled when configured out
> >   x86/mmu: Allocate/free PASID
> > 
> > Yu-cheng Yu (1):
> >   x86/fpu/xstate: Add supervisor PASID state for ENQCMD feature
> 
> For the IOMMU bits:
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>

Thank you!

-Fenghua
