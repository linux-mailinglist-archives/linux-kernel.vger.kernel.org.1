Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F4F26FCC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIRMot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:44:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgIRMos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:44:48 -0400
Received: from zn.tnic (p200300ec2f0c260019740fa9eb38b2dc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2600:1974:fa9:eb38:b2dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CBF51EC032C;
        Fri, 18 Sep 2020 14:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600433087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0lmOLysLQ+g/n9VuSWmaXFxfGPTJZgJcmn67WgVbx/0=;
        b=rPJL6Xtb1kMyeFqMJKaVO0B5d0L5tzpJQdZHLU2aujxhAVKH09FIHwaIIArrPPZM0hHf9D
        /1BBOeITxJ1GZoZg4Q7tkg29RGdIP+JAbER8a3gQrAyaniZ+merMb+jT44LOvOFEKBb1x4
        zp1O8L+0fhq+F074E/orFhvOhKmWI3o=
Date:   Fri, 18 Sep 2020 14:44:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 10/24] mm: Add vm_ops->mprotect()
Message-ID: <20200918124445.GE6585@zn.tnic>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-11-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915112842.897265-11-jarkko.sakkinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 02:28:28PM +0300, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add vm_ops()->mprotect() for additional constraints for a VMA.
> 
> Intel Software Guard eXtensions (SGX) will use this callback to add two
> constraints:
> 
> 1. Verify that the address range does not have holes: each page address
>    must be filled with an enclave page.
> 2. Verify that VMA permissions won't surpass the permissions of any enclave
>    page within the address range. Enclave cryptographically sealed
>    permissions for each page address that set the upper limit for possible
>    VMA permissions. Not respecting this can cause #GP's to be emitted.
> 
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Acked-by: Jethro Beekman <jethro@fortanix.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/linux/mm.h | 3 +++
>  mm/mprotect.c      | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Needs an ACK from an mm person.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
