Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0532B6BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgKQRfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbgKQRfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:35:12 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87967241A7;
        Tue, 17 Nov 2020 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605634511;
        bh=tQu1pI1qjQaV4zwahQOtinSwn4c6fb37u09aK1UMb28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xBu6h+10hCW0N9FyzElLqNY/hAkR6G4ko2Kq4hPFjtXg2y+w/b45byJ5knV2Rnb/q
         /YLUV/cqcQ4ErJ5++H92YF2uoUoobm1t1vXqTb7a0cgO5TxYS2nklVNv5CuMk9a8qf
         dYH9DcU3NBw2xCh/XkwpxqgrW7+WvZCQjqpZjfco=
Date:   Tue, 17 Nov 2020 19:35:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Serge Ayoun <serge.ayoun@intel.com>, akpm@linux-foundation.org
Subject: Re: [PATCH v41 12/24] x86/sgx: Add SGX_IOC_ENCLAVE_CREATE
Message-ID: <20201117173506.GB8524@kernel.org>
References: <20201112220135.165028-13-jarkko@kernel.org>
 <20201115044044.11040-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115044044.11040-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 12:40:44PM +0800, Hillf Danton wrote:
> On Fri, 13 Nov 2020 00:01:23 +0200 Jarkko Sakkinen wrote:
> > 
> > +long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
> > +{
> > +	struct sgx_encl *encl = filep->private_data;
> > +	int ret;
> > +
> > +	if (test_and_set_bit(SGX_ENCL_IOCTL, &encl->flags))
> > +		return -EBUSY;
> 
> Looks like encl->ioctl_mutex is needed to exlusively serialize
> concurrent ioctl threads and make encl->flags free of the duty.
> Plus it can cut the confusing EBUSY in userspace as it is not
> a critical path in any form.

The reason it is there was lock juggling with sgx_encl_grow() [*].

Andd since you never should use these ioctl's in parallel so why not
explicitly signal it to the user space?

[*] https://lore.kernel.org/linux-sgx/20190827001128.25066-4-sean.j.christopherson@intel.com/

/Jarkko
