Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6CB26E34C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgIQSKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:10:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:25199 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgIQRaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:30:55 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 13:30:53 EDT
IronPort-SDR: dVC2EB4KFrksVxj7y3cdAvKK8ITdpQqY/jAw1O+8Yi8uL8Jx67lkWU7AgKh3N5PX+knsXRSPRv
 hpiQm0MYZk5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="244584975"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="244584975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:22:42 -0700
IronPort-SDR: d8KguAnRbfpRkGIt60HaTbUnGHuynchkWUobyiJR18CSUF98cdcJxOFmZoRAW0SG2N2WbH/LV+
 f1X/BFqPAyzw==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="339503224"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 10:22:41 -0700
Date:   Thu, 17 Sep 2020 10:22:39 -0700
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
Message-ID: <20200917172239.GB92038@otc-nc-03>
References: <1600187413-163670-1-git-send-email-fenghua.yu@intel.com>
 <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
 <20200917075338.GC31960@zn.tnic>
 <20200917145609.GB91028@otc-nc-03>
 <20200917171849.GO31960@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917171849.GO31960@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Boris.

multiple "again" makes it funny again :-)


On Thu, Sep 17, 2020 at 07:18:49PM +0200, Borislav Petkov wrote:
> On Thu, Sep 17, 2020 at 07:56:09AM -0700, Raj, Ashok wrote:
> > Just tweaked it a bit: 
> > 
> > "When ATS lookup fails for a virtual address, device should use PRI in
> > order to request the virtual address to be paged into the CPU page tables.
> > The device must use ATS again in order the fetch the translation again

s/translation again/translation

> > before use"
> 
> Thanks, amended.
> 


