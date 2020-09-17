Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD2D26E59E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIQTzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:55:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:4470 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbgIQPEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:04:02 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 11:04:01 EDT
IronPort-SDR: NXySNJAsmhYt1sU7dSKvJLRAjvceAGiMhh+hXu7rPGxCIRYAqlbYmUoNK+cE98XlodDOWnnKh6
 gEt/6lgbmL5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="221260494"
X-IronPort-AV: E=Sophos;i="5.77,437,1596524400"; 
   d="scan'208";a="221260494"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 07:56:11 -0700
IronPort-SDR: QyFN85vOPnvWLorCFQzvTxleVhmEHePss429B5h+XJrYHl5eD0jZQ5fwuyoYb4Rx7BJtflaqaU
 TMdD1NUCff9Q==
X-IronPort-AV: E=Sophos;i="5.77,437,1596524400"; 
   d="scan'208";a="332182841"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 07:56:11 -0700
Date:   Thu, 17 Sep 2020 07:56:09 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v8 3/9] Documentation/x86: Add documentation for SVA
 (Shared Virtual Addressing)
Message-ID: <20200917145609.GB91028@otc-nc-03>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
 <20200917075338.GC31960@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917075338.GC31960@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Thu, Sep 17, 2020 at 09:53:38AM +0200, Borislav Petkov wrote:
> On Tue, Sep 15, 2020 at 09:30:07AM -0700, Fenghua Yu wrote:
> > +Background
> > +==========
> > +
> > +Shared Virtual Addressing (SVA) allows the processor and device to use the
> > +same virtual addresses avoiding the need for software to translate virtual
> > +addresses to physical addresses. SVA is what PCIe calls Shared Virtual
> > +Memory (SVM).
> > +
> > +In addition to the convenience of using application virtual addresses
> > +by the device, it also doesn't require pinning pages for DMA.
> > +PCIe Address Translation Services (ATS) along with Page Request Interface
> > +(PRI) allow devices to function much the same way as the CPU handling
> > +application page-faults. For more information please refer to the PCIe
> > +specification Chapter 10: ATS Specification.
> > +
> > +Use of SVA requires IOMMU support in the platform. IOMMU also is required
> > +to support PCIe features ATS and PRI. ATS allows devices to cache
> > +translations for virtual addresses. The IOMMU driver uses the mmu_notifier()
> > +support to keep the device TLB cache and the CPU cache in sync. PRI allows
> > +the device to request paging the virtual address by using the CPU page tables
> > +before accessing the address.
> 
> That still reads funny, the "the device to request paging the virtual
> address" part. Do you mean that per chance here:
> 
> "Before the device can access that address, the device uses the PRI in
> order to request the virtual address to be paged in into the CPU page
> tables."
> 
Agree, this reads a bit funny.

Just tweaked it a bit: 

"When ATS lookup fails for a virtual address, device should use PRI in
order to request the virtual address to be paged into the CPU page tables.
The device must use ATS again in order the fetch the translation again
before use"

Cheers,
Ashok
