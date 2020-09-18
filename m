Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D257270202
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIRQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:22:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:30056 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRQWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:22:15 -0400
IronPort-SDR: emwWflsj0S8TURxGTMpYNn1JcP01tKz6wuGzM5llOrd95H1g/IagyHtPAqQaGNIMdCZDrLtTML
 09Tf09QsUV5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="224142956"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="224142956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 09:22:13 -0700
IronPort-SDR: xi6E08IvoZBUkpZ1Z7pbYXExv9ngdCp9u1d4BqY/0BPBMX91LZEW3Bh9HS2MOnDppXEf4rEDIs
 WOfjiggeoaBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="289391730"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2020 09:22:13 -0700
Date:   Fri, 18 Sep 2020 16:22:12 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
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
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v8 3/9] Documentation/x86: Add documentation for SVA
 (Shared Virtual Addressing)
Message-ID: <20200918162212.GA444227@otcwcpicx6.sc.intel.com>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
 <20200917075338.GC31960@zn.tnic>
 <20200917145609.GB91028@otc-nc-03>
 <20200917171849.GO31960@zn.tnic>
 <20200917172239.GB92038@otc-nc-03>
 <20200917173041.GQ31960@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917173041.GQ31960@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:30:41PM +0200, Borislav Petkov wrote:
> On Thu, Sep 17, 2020 at 10:22:39AM -0700, Raj, Ashok wrote:
> > s/translation again/translation
> 
> Ok, last one. Now stop looking at that text because you'll find more.
> 
> :-)))

Thank you very much for taking care of the series, Boris!

I tested the tip:x86/pasid branch and everything works fine by my tests.
I'll enable more tests for the branch.

-Fenghua
