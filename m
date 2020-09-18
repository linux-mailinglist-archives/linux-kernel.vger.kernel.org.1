Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D2226FC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIRMUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:20:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:32713 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRMUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:20:39 -0400
IronPort-SDR: nHFyFrVsCQjWUdLTDEZrGRiuGHcOYHThmV2kyWH1X6PgV5eqORvd62HYALoyu7+8NxEDtzI7QB
 8+fICJU2D6VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157308566"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="157308566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 05:20:38 -0700
IronPort-SDR: 26rsxlzkUjoyWfUmXaZhnh2gPThhOxPT3/XeacRReQtDQdLNBYTz63w2ET9nCxMHSQdAgMNpPF
 yUmCSzt3mRiA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484182929"
Received: from dlos-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.212])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 05:20:31 -0700
Date:   Fri, 18 Sep 2020 15:20:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Seth Moore <sethmo@google.com>,
        Darren Kenny <darren.kenny@oracle.com>,
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
Message-ID: <20200918122029.GA27028@linux.intel.com>
References: <20200915110522.893152-1-jarkko.sakkinen@linux.intel.com>
 <20200915110522.893152-14-jarkko.sakkinen@linux.intel.com>
 <op.0q2prldowjvjmi@mqcpg7oapc828.gar.corp.intel.com>
 <20200917160206.GF8530@linux.intel.com>
 <op.0q3pw0stwjvjmi@mqcpg7oapc828.gar.corp.intel.com>
 <20200918020940.GA14678@sjchrist-ice>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918020940.GA14678@sjchrist-ice>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:09:40PM -0700, Sean Christopherson wrote:
> On Thu, Sep 17, 2020 at 01:35:10PM -0500, Haitao Huang wrote:
> > On Thu, 17 Sep 2020 11:02:06 -0500, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > > 
> > > Right, I do get the OOM case but wouldn't in that case the reasonable
> > > thing to do destroy the enclave that is not even running? I mean that
> > > means that we are globally out of EPC.
> > > 
> > 
> > I would say it could be a policy, but not the only one. If it does not make
> > much difference to kernel, IMHO we should  not set it in stone now.
> > Debugging is also huge benefit to me.
> 
> Agreed, an EPC cgroup is the proper way to define/enforce what happens when
> there is EPC pressure.  E.g. if process A is consuming 99% of the EPC, then
> it doesn't make sense to unconditionally kill enclaves from process B.  If
> the admin wants to give process A priority, so be it, but such a decision
> shouldn't be baked into the kernel.
> 
> This series obviously doesn't provide an EPC cgroup, but that doesn't mean
> we can't make decisions that will play nice with a cgroup in the future.

Here's the core issue why the API "as is used to be" does not work:

	if (ret == -EIO) {
		mutex_lock(&encl->lock);
		sgx_encl_destroy(encl);
		mutex_unlock(&encl->lock);
	}

It would be better to instead whitelist *when* the enclave is preserved.

	if (ret != -ENOMEM) {
		mutex_lock(&encl->lock);
		sgx_encl_destroy(encl);
		mutex_unlock(&encl->lock);
	}

That is the information we *deterministically* want to know. Otherwise,
we will live in ultimate chaos.

Only this way can caller know when there are means to continue, and when
to quit. I.e. the code is whitelisting wrong way around currently.

/Jarkko
