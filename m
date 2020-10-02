Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2743281F2B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJBXjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:39:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:53746 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBXjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:39:52 -0400
IronPort-SDR: CRMK1g0voJTNPlR63RKVQlMtC8CvxUtMuuMEfsmwKlqq085/+iDfgkxBSMkeFUW42uYtQawzsN
 UYkxFQI1vYsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="247850581"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="247850581"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 16:39:50 -0700
IronPort-SDR: uGlsOMjW08igrL9io/X7cVHfNeTw0Gr2xT2d3o6xM/qhSgkFsGu1TUetCHA0kOagRDU2BoSNqF
 1ffa9cmvl6yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="295501013"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2020 16:39:50 -0700
Date:   Fri, 2 Oct 2020 16:41:52 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Message-ID: <20201002234152.GA3698@ranerica-svr.sc.intel.com>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <20201002201931.2826-3-ricardo.neri-calderon@linux.intel.com>
 <20201002203452.GE17436@zn.tnic>
 <20201002210231.GA3222@ranerica-svr.sc.intel.com>
 <20201002210306.GF17436@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002210306.GF17436@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 11:03:06PM +0200, Borislav Petkov wrote:
> On Fri, Oct 02, 2020 at 02:02:31PM -0700, Ricardo Neri wrote:
> > What about patches 1 and 3? Should I resubmit the series with only
> > those?
> 
> Why would you need to resubmit? They're good to go as is, AFAICT.

Thanks for clarifying Boris. Just wanted to check if there was any
action required from me regarding patches 1 & 3.

Thanks and BR,
Ricardo
