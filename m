Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC52B6CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgKQSQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbgKQSQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:24 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBDA2462E;
        Tue, 17 Nov 2020 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605636983;
        bh=bJdr/mD1349bpsi/8SdoMbm6aRAfX1Fhc0M1fMX3eHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jsWp9mQI+gnrXYDq+btYXtY0Bi56lY0qGElok2GpRHn22S5fHmAO8dO72QA3EcMmJ
         IEMqNr23HbT4Ng+G0HcEK/t6mB5D1DJljhEnwr+I0LfmgK8imrHOuoQbBcok+y6iWp
         dtXb1B5gzHnjj7dJIkG9SiVJTrqOUaIss7UPMtFI=
Date:   Tue, 17 Nov 2020 20:16:14 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Dave Hansen <dave.hansen@intel.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        haitao.huang@intel.com, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com,
        mikko.ylinen@intel.com
Subject: Re: [PATCH v41 10/24] mm: Add 'mprotect' hook to struct
 vm_operations_struct
Message-ID: <20201117181614.GG8524@kernel.org>
References: <20201112220135.165028-1-jarkko@kernel.org>
 <20201112220135.165028-11-jarkko@kernel.org>
 <20201113102543.GK3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113102543.GK3371@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:25:43AM +0000, Mel Gorman wrote:
> On Fri, Nov 13, 2020 at 12:01:21AM +0200, Jarkko Sakkinen wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Background
> > ==========
> > 
> > 1. SGX enclave pages are populated with data by copying from normal memory
> >    via ioctl() (SGX_IOC_ENCLAVE_ADD_PAGES), which will be added later in
> >    this series.
> > 2. It is desirable to be able to restrict those normal memory data sources.
> >    For instance, to ensure that the source data is executable before
> >    copying data to an executable enclave page.
> > 3. Enclave page permissions are dynamic (just like normal permissions) and
> >    can be adjusted at runtime with mprotect().
> > 
> > This creates a problem because the original data source may have long since
> > vanished at the time when enclave page permissions are established (mmap()
> > or mprotect()).
> > 
> > The solution (elsewhere in this series) is to force enclaves creators to
> > declare their paging permission *intent* up front to the ioctl().  This
> > intent can be immediately compared to the source data???s mapping and
> > rejected if necessary.
> > 
> > The ???intent??? is also stashed off for later comparison with enclave
> > PTEs. This ensures that any future mmap()/mprotect() operations
> > performed by the enclave creator or done on behalf of the enclave
> > can be compared with the earlier declared permissions.
> > 
> > Problem
> > =======
> > 
> > There is an existing mmap() hook which allows SGX to perform this
> > permission comparison at mmap() time.  However, there is no corresponding
> > ->mprotect() hook.
> > 
> > Solution
> > ========
> > 
> > Add a vm_ops->mprotect() hook so that mprotect() operations which are
> > inconsistent with any page's stashed intent can be rejected by the driver.
> > 
> > Cc: linux-mm@kvack.org
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Acked-by: Jethro Beekman <jethro@fortanix.com> # v40
> > Acked-by: Dave Hansen <dave.hansen@intel.com> # v40
> > # Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thank you.

/Jarkko
