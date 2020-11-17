Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249DB2B6C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgKQRkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:41320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbgKQRkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:40:36 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE1F20678;
        Tue, 17 Nov 2020 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605634835;
        bh=7v9sOiWJSBJswZEHQezLiEVtUSNwGk8BDBNebit5y40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vab4QCCakxBJs3QKS3lJLfYKhqCa3SKpCsxSCL1ujG+r3UisMkKcVMVz/E7BRLlJm
         JFih+Brj4loymVSmu7Oo/FzGJgqMCiK/jmgnTZuGMiO8I7vVUaoJqAPLreub9AUJiU
         K1AZgIyzRw/+RLoC7B7ts0OfGnOOQWn/OLj/s+dY=
Date:   Tue, 17 Nov 2020 19:40:27 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v41 12/24] x86/sgx: Add SGX_IOC_ENCLAVE_CREATE
Message-ID: <20201117174027.GC8524@kernel.org>
References: <20201115044044.11040-1-hdanton@sina.com>
 <15c3349c-44dd-7057-395c-8fd8c674e87d@intel.com>
 <610d665e-564e-621d-4ecb-fbe5bfdf7133@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610d665e-564e-621d-4ecb-fbe5bfdf7133@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 04:34:23PM -0800, Dave Hansen wrote:
> On 11/16/20 9:54 AM, Dave Hansen wrote:
> >> ENCLS instructions must be serialized for a given enclave, but holding
> >> encl->lock for an entire ioctl() will result in deadlock due to an enclave
> >> triggering reclaim on itself.
> >>
> >> Building an enclave must also be serialized, i.e. userspace can't queue up
> >> EADD on multiple threads, because the order in which pages are added to an
> >> enclave affects the measurement.  In other words, rejecting the ioctl() as
> >> opposed to waiting on a lock is also desirable.
> > Sounds like we need should follow up with an add-on patch to get some of
> > that into a comment.
> 
> Jarkko, first of all, let's rename:
> 
> 	SGX_ENCL_IOCTL -> SGX_ENCL_IOCTL_LOCK
> 
> If it walks like a duck and quacks like a duck...
> 
> Sean had a good example of examples of how EADD could go wrong with
> multiple threads.  Were there more good examples we could stick in a
> changelog?  I seem to recall that there are more than a few SGX
> instructions don't even work in parallel and require software
> synchronization.  Could we get a list or at least a few more good examples?

It does not need a specific example. A cryptographic measurement
requires always a strict ordering. Any parallel use is a good example.


> I also think we should be much more assertive about multiple ioctl()
> callers:
> 
> 	/* Multi-threaded enclave management is invalid and unsafe: */
> 	if (test_and_set_bit(SGX_ENCL_IOCTL_LOCK, &encl->flags))
> 		return -EINVAL;
> 
> -EBUSY is saying "everything is OK, just busy, please try again later."
>  -EINVAL is saying, "userspace, you screwed up".

Yeah, it is invalid use of the API. I'll change it to -EINVAL.

> Also, does SGX_ENCL_IOCTL_LOCK provide serialization for anything other
> than the *hardware* instructions?  I couldn't find much, although:
> 
>         encl->attributes_mask |= SGX_ATTR_PROVISIONKEY;
> 
> seems to be lacking any other serialization.
> 
> sgx_encl_create() also seems like it has no other locking and relies on
> SGX_ENCL_IOCTL_LOCK for sanity.

Yeah, those ioctl's take advantage of the flag.

/Jarkko
