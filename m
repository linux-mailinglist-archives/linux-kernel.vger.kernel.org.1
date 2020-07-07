Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86C521650A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 06:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGGEFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 00:05:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:40822 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGGEFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:05:03 -0400
IronPort-SDR: to0nG9j4mER0gmtDK4pM3GpY9uPcvyzFbFgCeEvLAcG73RML5sZt+IekfXGgy9TGtQ7BcLm0Km
 cbXk82DfGbjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="145635551"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="145635551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 21:05:03 -0700
IronPort-SDR: THpUsrgwUYlnI/X4OKRrQkntW4jwxt/RY4lDo8NxvYoxTyRudtwZkEym0sBhd3+72X+GhwYliT
 +dzhcWqODgKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="268077692"
Received: from apiccion-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.45.178])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2020 21:04:49 -0700
Date:   Tue, 7 Jul 2020 07:04:48 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jethro Beekman <jethro@fortanix.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Seth Moore <sethmo@google.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v34 12/24] x86/sgx: Add SGX_IOC_ENCLAVE_CREATE
Message-ID: <20200707040448.GD143804@linux.intel.com>
References: <20200707030204.126021-1-jarkko.sakkinen@linux.intel.com>
 <20200707030204.126021-13-jarkko.sakkinen@linux.intel.com>
 <20200707032915.GC5208@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707032915.GC5208@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 08:29:15PM -0700, Sean Christopherson wrote:
> On Tue, Jul 07, 2020 at 06:01:52AM +0300, Jarkko Sakkinen wrote:
> > +long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> > +{
> > +	struct sgx_encl *encl = filep->private_data;
> > +	int ret, encl_flags;
> > +
> > +	encl_flags = atomic_fetch_or(SGX_ENCL_IOCTL, &encl->flags);
> > +	if (encl_flags & SGX_ENCL_IOCTL)
> > +		return -EBUSY;
> 
> As called out in my belated feedback, SGX_ENCL_DEAD needs to be checked
> here to prevent invoking ENCLS operations on a dead enclave.  If you're
> splitting hairs, the check could technically be deferred until the next
> patch, "Add SGX_IOC_ENCLAVE_ADD_PAGES", which is the first usage of
> sgx_encl_destroy() from an ioctl(), but that seems a bit gratuitous.

This is already fixed in v35.

/Jarkko
