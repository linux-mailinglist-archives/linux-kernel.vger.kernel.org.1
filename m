Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB526E078
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgIQQTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:19:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:12992 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgIQQRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:17:22 -0400
IronPort-SDR: RTUREFFOF6tKv20Wiws4Mf1zOM5WbFq4IwMfGcJCJA+lIgUi4jzMA2h4hXfqafJgGjDuTfmvDu
 Xl9YVQxBUVEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="221281505"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="221281505"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:03:39 -0700
IronPort-SDR: 4m382i1pxeXdUEc7xOvEVVYM45AdPaqhT5CI5uRaZ0eh5kk4YVsRF/Ip2NnOUn/C52nQw1FEb0
 iZsqxOtAkh1w==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="452367508"
Received: from sdompke-mobl.ger.corp.intel.com (HELO localhost) ([10.249.45.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 09:03:25 -0700
Date:   Thu, 17 Sep 2020 19:03:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jethro Beekman <jethro@fortanix.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Seth Moore <sethmo@google.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 13/24] x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES
Message-ID: <20200917160322.GG8530@linux.intel.com>
References: <20200915110522.893152-1-jarkko.sakkinen@linux.intel.com>
 <20200915110522.893152-14-jarkko.sakkinen@linux.intel.com>
 <op.0q2prldowjvjmi@mqcpg7oapc828.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0q2prldowjvjmi@mqcpg7oapc828.gar.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	for (c = 0 ; c < addp.length; c += PAGE_SIZE) {
> > +		if (signal_pending(current)) {
> > +			if (!c)
> > +				ret = -EINTR;
> > +
> > +			break;
> > +		}
> > +
> 
> Return -ERESTARTSYS so that kernel can restart this IOC when SA_RESTART is
> set?

Yes, this is quite obvious. I will change it, thank you.

/Jarkko
