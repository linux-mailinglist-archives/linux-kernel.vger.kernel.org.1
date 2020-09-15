Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1FF26A290
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgIOJzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:55:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:34257 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgIOJzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:55:01 -0400
IronPort-SDR: hHPoaJypTFROMVwntuhF7ruQP4JP0LJinEhwu/xGRFy9lRfFmbl97vV35wNFBC1SBgVOrBqmrg
 8i+uoNqDuKVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="244062205"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="244062205"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 02:55:00 -0700
IronPort-SDR: zQJaXsQln+sNppTrVF/B/u1d6N38+rSgtA/O37T/HevUjbnaGzGdsZlQ95uiF9atQTTMQgW3/9
 hrjUN4WImqpg==
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="482707224"
Received: from blank-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.208])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 02:54:52 -0700
Date:   Tue, 15 Sep 2020 12:54:50 +0300
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
Subject: Re: [PATCH v37 13/24] x86/sgx: Add SGX_IOC_ENCLAVE_ADD_PAGES
Message-ID: <20200915095450.GH3612@linux.intel.com>
References: <20200911124019.42178-1-jarkko.sakkinen@linux.intel.com>
 <20200911124019.42178-14-jarkko.sakkinen@linux.intel.com>
 <op.0qwyftihwjvjmi@mqcpg7oapc828.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.0qwyftihwjvjmi@mqcpg7oapc828.gar.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 09:56:03PM -0500, Haitao Huang wrote:
> 
> On Fri, 11 Sep 2020 07:40:08 -0500, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> ...
> 
> > +/**
> > + * sgx_ioc_enclave_add_pages() - The handler for
> > %SGX_IOC_ENCLAVE_ADD_PAGES
> > + * @encl:       an enclave pointer
> > + * @arg:	a user pointer to a struct sgx_enclave_add_pages instance
> > + *
> > + * Add one or more pages to an uninitialized enclave, and optionally
> > extend the
> > + * measurement with the contents of the page. The SECINFO and
> > measurement mask
> > + * are applied to all pages.
> > + *
> > + * A SECINFO for a TCS is required to always contain zero permissions
> > because
> > + * CPU silently zeros them. Allowing anything else would cause a
> > mismatch in
> > + * the measurement.
> > + *
> > + * mmap()'s protection bits are capped by the page permissions. For
> > each page
> > + * address, the maximum protection bits are computed with the following
> > + * heuristics:
> > + *
> > + * 1. A regular page: PROT_R, PROT_W and PROT_X match the SECINFO
> > permissions.
> > + * 2. A TCS page: PROT_R | PROT_W.
> > + *
> > + * mmap() is not allowed to surpass the minimum of the maximum
> > protection bits
> > + * within the given address range.
> > + *
> > + * If ENCLS opcode fails, that effectively means that EPC has been
> > invalidated.
> > + * When this happens the enclave is destroyed and -EIO is returned to
> > the
> > + * caller.
> > + *
> > + * Return:
> > + *   length of the data processed on success,
> > + *   -EACCES if an executable source page is located in a noexec
> > partition,
> > + *   -EIO if either ENCLS[EADD] or ENCLS[EEXTEND] fails
> > + *   -errno otherwise
> > + */
> > +static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void
> > __user *arg)
> > +{
> > +	struct sgx_enclave_add_pages addp;
> > +	struct sgx_secinfo secinfo;
> > +	unsigned long c;
> > +	int ret;
> > +
> > +	if ((atomic_read(&encl->flags) & SGX_ENCL_INITIALIZED) ||
> > +	    !(atomic_read(&encl->flags) & SGX_ENCL_CREATED))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(&addp, arg, sizeof(addp)))
> > +		return -EFAULT;
> > +
> > +	if (!IS_ALIGNED(addp.offset, PAGE_SIZE) ||
> > +	    !IS_ALIGNED(addp.src, PAGE_SIZE))
> > +		return -EINVAL;
> > +
> > +	if (!(access_ok(addp.src, PAGE_SIZE)))
> > +		return -EFAULT;
> > +
> > +	if (addp.length & (PAGE_SIZE - 1))
> > +		return -EINVAL;
> > +
> > +	if (addp.offset + addp.length - PAGE_SIZE >= encl->size)
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(&secinfo, (void __user *)addp.secinfo,
> > +			   sizeof(secinfo)))
> > +		return -EFAULT;
> > +
> > +	if (sgx_validate_secinfo(&secinfo))
> > +		return -EINVAL;
> > +
> > +	for (c = 0 ; c < addp.length; c += PAGE_SIZE) {
> > +		if (c == SGX_MAX_ADD_PAGES_LENGTH || signal_pending(current)) {
> > +			ret = c;
> > +			break;
> > +		}
> > +
> > +		if (need_resched())
> > +			cond_resched();
> > +
> > +		ret = sgx_encl_add_page(encl, addp.src + c, addp.offset + c,
> > +					addp.length - c, &secinfo, addp.flags);
> 
> no need passing addp.length - c?

True, it is cruft from the past.

I'll remove.

> 
> > +		if (ret)
> > +			break;
> 
> Some error cases here are fatal and should be passed back to user space so
> that it would not retry.

I don't comprehend this. 'ret' is passed to the user space.

> > +	}
> > +
> > +	if (copy_to_user(arg, &addp, sizeof(addp)))
> > +		return -EFAULT;
> 
> This copy no longer needed?

True, it is cruft from the past.

I'll remove.

> > +	return c;
> > +}
> > +
> 
> Thanks
> Haitao

Thanks for the comments.

/Jarkko
