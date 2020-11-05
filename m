Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70582A82F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgKEQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKEQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:04:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7010C0613CF;
        Thu,  5 Nov 2020 08:04:40 -0800 (PST)
Received: from zn.tnic (p200300ec2f0ee5006c78cd15f1739a31.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:e500:6c78:cd15:f173:9a31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0EE661EC03A0;
        Thu,  5 Nov 2020 17:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604592279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzsXHWOTotG9TSv9RImL2IoAhUNP7oiQrY5qi5tuMzg=;
        b=TTyCVstWqebTE3827G5LtgKLGpokNNaaiDLK72NkKv8n4FR4eGLhoqG67GosMAQP+nAxyu
        8FHp+h1yYv1jkvGiKjeYd2WFJhZ9ElQ6sGBygTGjiO1EcfEqVqwPfxSoh9C/vSE+6N3Tqh
        a7tj641Cq/hxAICh/LzykJUSICAenIw=
Date:   Thu, 5 Nov 2020 17:04:24 +0100
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
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v40 10/24] mm: Add 'mprotect' hook to struct
 vm_operations_struct
Message-ID: <20201105160424.GC25636@zn.tnic>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
 <20201104145430.300542-11-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104145430.300542-11-jarkko.sakkinen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 04:54:16PM +0200, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Background
> ==========
> 
> 1. SGX enclave pages are populated with data by copying from normal memory
>    via ioctl() (SGX_IOC_ENCLAVE_ADD_PAGES), which will be added later in
>    this series.
> 2. It is desirable to be able to restrict those normal memory data sources.
>    For instance, to ensure that the source data is executable before
>    copying data to an executable enclave page.
> 3. Enclave page permissions are dynamic (just like normal permissions) and
>    can be adjusted at runtime with mprotect().
> 
> This creates a problem because the original data source may have long since
> vanished at the time when enclave page permissions are established (mmap()
> or mprotect()).
> 
> The solution (elsewhere in this series) is to force enclaves creators to
> declare their paging permission *intent* up front to the ioctl().  This
> intent can me immediately compared to the source data’s mapping and
> rejected if necessary.
> 
> The “intent” is also stashed off for later comparison with enclave
> PTEs. This ensures that any future mmap()/mprotect() operations
> performed by the enclave creator or done on behalf of the enclave
> can be compared with the earlier declared permissions.
> 
> Problem
> =======
> 
> There is an existing mmap() hook which allows SGX to perform this
> permission comparison at mmap() time.  However, there is no corresponding
> ->mprotect() hook.
> 
> Solution
> ========
> 
> Add a vm_ops->mprotect() hook so that mprotect() operations which are
> inconsistent with any page's stashed intent can be rejected by the driver.
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

This needs an ACK from an mm person.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
