Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B954B248BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHRQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:44:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:21979 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgHRQoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:44:02 -0400
IronPort-SDR: X6lIl8RhRVELAgfJiM7jWo/U4xtjM8W//PJZv8CyPcBT+ekwrd8bCSvbnrhPgetZ0CPbUwuEvT
 Mb8oMk290LlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="219260080"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="219260080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 09:44:01 -0700
IronPort-SDR: Lc8c/BFanHB/cWj0PCxNLhuy/ld9Iurt4gycRy1DgnxQg2PKNiDHY9aojoalC7SWp5JATFMSKJ
 3AJ6ULnZIoUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="336673333"
Received: from ribnhajh-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.113])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2020 09:43:54 -0700
Date:   Tue, 18 Aug 2020 19:43:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nathaniel McCallum <npmccallum@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        chenalexchen@google.com, Conrad Parker <conradparker@google.com>,
        cyhanish@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Neil Horman <nhorman@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Subject: Re: [PATCH v36 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
Message-ID: <20200818164353.GH137138@linux.intel.com>
References: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com>
 <20200716135303.276442-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepOqRfUafSv_qjUv-jW_6n8G7kZ9yh-2z_Z9sjL_2zqNCg@mail.gmail.com>
 <20200810222317.GG14724@linux.intel.com>
 <20200818145234.GC132200@linux.intel.com>
 <20200818150627.GD132200@linux.intel.com>
 <CAOASepNxu0YtSPjXynLaVgyt-S0uSad8HVrNgMNWf+Z7iamPvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOASepNxu0YtSPjXynLaVgyt-S0uSad8HVrNgMNWf+Z7iamPvQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:15:32AM -0400, Nathaniel McCallum wrote:
> That seems like overkill to me. I'm just asking for one additional mov
> instruction. :)

I started to consider eBPF since the complexity and constraints of the
callback look like an overkill and without doubt will be a burden to
maintain.

/Jarkko
