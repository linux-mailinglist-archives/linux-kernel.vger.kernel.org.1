Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEFE1F9AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 16:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgFOOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 10:53:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:56331 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730794AbgFOOxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:53:47 -0400
IronPort-SDR: KRkTTQpRPRnNfosc8UQgW3KrfRvn/lBBmEVSTkTKhBeNeg4uxmvomxGXylLzZEisvgSisEAJ3H
 8dWEsIe+MxPg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 07:53:46 -0700
IronPort-SDR: hBkuUtQL8+lhTWXLYi651EBCBrGOEnQVfzIuldPKgK9Hg1HqC5sQmkx3kq2cejv4s2HjL2N4xD
 LCQ6U6PgIXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="382567032"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 07:53:46 -0700
Date:   Mon, 15 Jun 2020 07:53:46 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 00/12] x86: tag application address space for devices
Message-ID: <20200615145345.GA13792@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <20200615075202.GI2497@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615075202.GI2497@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,
On Mon, Jun 15, 2020 at 09:52:02AM +0200, Peter Zijlstra wrote:
> On Fri, Jun 12, 2020 at 05:41:21PM -0700, Fenghua Yu wrote:
> 
> > This series only provides simple and basic support for ENQCMD and the MSR:
> > 1. Clean up type definitions (patch 1-3). These patches can be in a
> >    separate series.
> >    - Define "pasid" as "unsigned int" consistently (patch 1 and 2).
> >    - Define "flags" as "unsigned int"
> > 2. Explain different various technical terms used in the series (patch 4).
> > 3. Enumerate support for ENQCMD in the processor (patch 5).
> > 4. Handle FPU PASID state and the MSR during context switch (patches 6-7).
> > 5. Define "pasid" in mm_struct (patch 8).
> > 5. Clear PASID state for new mm and forked and cloned thread (patch 9-10).
> > 6. Allocate and free PASID for a process (patch 11).
> > 7. Fix up the PASID MSR in #GP handler when one thread in a process
> >    executes ENQCMD for the first time (patches 12).
> 
> If this is per mm, should not switch_mm() update the MSR ? I'm not
> seeing that, nor do I see it explained why not.

PASID value is per mm and all threads in a process have the same PASID
value in the MSR. However, the MSR is per thread and is context switched
by XSAVES/XRSTROS in patches 6-7.

Thanks.

-Fenghua
