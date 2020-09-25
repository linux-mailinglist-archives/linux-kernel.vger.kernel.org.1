Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657CB277D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 03:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgIYBFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 21:05:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:62454 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgIYBFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 21:05:01 -0400
IronPort-SDR: QB75LTtqNeMAl9+FZcIWJWWMJA5+BIub92o3B62K9Jsha0WYuxmofKR92RLmz6oADntDTZmb2g
 +T3RcrrRv23A==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="222986176"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="222986176"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 18:05:00 -0700
IronPort-SDR: 8XkjjGirQDtRiVC9YuLvCH8qJ9Ft5By8CeYEY3492waNQvt7640TT0KQhgBfC60mLuPWroDb/3
 JTURhxEu+Kaw==
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="487220707"
Received: from ralfseng-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.47.148])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 18:04:54 -0700
Date:   Fri, 25 Sep 2020 04:04:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
Message-ID: <20200925010452.GB147464@linux.intel.com>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-22-jarkko.sakkinen@linux.intel.com>
 <20200924180407.GO5030@zn.tnic>
 <20200925003808.GB20333@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925003808.GB20333@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 05:38:10PM -0700, Sean Christopherson wrote:
> On Thu, Sep 24, 2020 at 08:04:07PM +0200, Borislav Petkov wrote:
> > On Tue, Sep 15, 2020 at 02:28:39PM +0300, Jarkko Sakkinen wrote:
> > > diff --git a/arch/x86/entry/vdso/vsgx_enter_enclave.S b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> > > new file mode 100644
> > > index 000000000000..adbd59d41517
> > > --- /dev/null
> > > +++ b/arch/x86/entry/vdso/vsgx_enter_enclave.S
> > 
> > Why not simply
> > 
> > arch/x86/entry/vdso/sgx.S
> > 
> > ?
> 
> I really like typing?

I fixed bunch of things. For that sentence I need feedback + for any
other possible changes please send a patch if required.

/Jarkko
