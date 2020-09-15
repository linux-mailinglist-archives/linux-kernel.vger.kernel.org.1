Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2F269BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgIOCCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:02:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:57935 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgIOCCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:02:17 -0400
IronPort-SDR: mtWpU4FbjHtKRRTOIFmLcYysRCsfg5yo7FFY59XklTmAxPHr8Fnd5mk05iZsu/YOyrA0eiRs86
 DxLJyeN83HbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="156580196"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="156580196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 19:02:16 -0700
IronPort-SDR: N/Yz5aGcM6gsT2R3Poqs+0dJtTuuU+23RLSREefvakHjlB+NAFAaosxh7IeD8BOoc4ThbYgQNg
 42zOt3Ujv1Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="330979588"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2020 19:02:14 -0700
Date:   Tue, 15 Sep 2020 02:02:14 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v7 3/9] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Message-ID: <20200915020214.GA437862@otcwcpicx6.sc.intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-4-git-send-email-fenghua.yu@intel.com>
 <626fe21c-1f82-f4f8-e37b-32d91e7d557a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <626fe21c-1f82-f4f8-e37b-32d91e7d557a@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy,

On Sat, Sep 05, 2020 at 10:54:59AM -0700, Randy Dunlap wrote:
> Hi,
> 
> I'll add a few edits other than those that Borislav made.
> (nice review job, BP)
> 
> 
> On 8/27/20 8:06 AM, Fenghua Yu wrote:
> > From: Ashok Raj <ashok.raj@intel.com>
> > 
> > ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
> > features are a complicated stack with lots of interconnected pieces.
> > This documentation provides a big picture overview for all of the
> > features.
> > 
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> > diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
> > new file mode 100644
> > index 000000000000..6e7ac565e127
> > --- /dev/null
> > +++ b/Documentation/x86/sva.rst
> > @@ -0,0 +1,254 @@
> > +MMIO. This doesn't scale as the number of threads becomes quite large. The
> > +hardware also manages the queue depth for Shared Work Queues (SWQ), and
> > +consumers don't need to track queue depth. If there is no space to accept
> > +a command, the device will return an error indicating retry. Also
> > +submitting a command to an MMIO address that can't accept ENQCMD will
> > +return retry in response. In the new DMWr PCIe terminology, devices need to
> 
> so how does a submitter know whether a return of "retry" means no_space or
> invalid_for_this_device?

I will add "A user should check Deferrable Memory Write (DMWr) capability on
the device and only submits ENQCMD when the device supports it."

So the user doesn't need to distinguish "no space" and "invalid for this device"
errors.

All of your other comments will be addressed in the next version.

Thank you very much for your comments!

-Fenghua
