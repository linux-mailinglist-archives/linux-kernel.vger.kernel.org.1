Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66430269512
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgINSjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:39:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:31604 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgINShR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:37:17 -0400
IronPort-SDR: 5lxc1RjIjBV+CGeJm3avEqJ7qF4o9XTb2Fzllo/M+cgSQ+pZfpQNxaz6jZRSz2JB8M6n8lWhSQ
 J0mHheu/LPuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="158427556"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="158427556"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 11:37:15 -0700
IronPort-SDR: e/dhGeM/ItpH4ZIYXtuXHtLqGxZdXvqTHP2RqlUNODU6NosrOaLvBXuJBici5oxhBNwzyjQiMa
 +dFWGGZNtLzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="330852067"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 14 Sep 2020 11:37:15 -0700
Date:   Mon, 14 Sep 2020 18:37:15 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
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
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v7 9/9] x86/mmu: Allocate/free PASID
Message-ID: <20200914183715.GA437309@otcwcpicx6.sc.intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-10-git-send-email-fenghua.yu@intel.com>
 <20200907111843.GC16029@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907111843.GC16029@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris,

On Mon, Sep 07, 2020 at 01:18:43PM +0200, Borislav Petkov wrote:
> On Thu, Aug 27, 2020 at 08:06:34AM -0700, Fenghua Yu wrote:
> > +		 */
> > +		xsave = &fpu->state.xsave;
> > +		xsave->header.xfeatures |= XFEATURE_MASK_PASID;
> > +		ppasid_state = get_xsave_addr(xsave, XFEATURE_PASID);
> > +		if (ppasid_state) {
> > +			/*
> > +			 * Only update the task's PASID state when it's
> > +			 * different from the mm's pasid.
> > +			 */
> > +			if (ppasid_state->pasid != pasid_state) {
> > +				/*
> > +				 * Invalid fpregs so that xrstors will pick up
> 							  ^^^^^^^
> 
> Not "xrstors" but the "state restoring" or so.

Fixed.

> > +				 * the PASID state.
> > +				 */
> > +				__fpu_invalidate_fpregs_state(fpu);
> > +				ppasid_state->pasid = pasid_state;
> > +			}
> 
> What happens if get_xsave_addr() returns NULL? A WARN_ONCE maybe?

get_xsave_addr() will not return NULL because xsave->header.xfeatures has
XFEATURE_MASK_PASID set. I will remove the unnecessary check "if (ppasid_state)"
to optimize the function and add a comment on why the check is unnecessary.

> Ok, done with review.

I addressed all of your comments and will send out the updated series soon.

Thank you very much for your review!

-Fenghua
