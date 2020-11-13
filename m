Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F712B1901
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKMKZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:25:51 -0500
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:43349 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgKMKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:25:51 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 277FFBAED0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 10:25:49 +0000 (GMT)
Received: (qmail 5515 invoked from network); 13 Nov 2020 10:25:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Nov 2020 10:25:48 -0000
Date:   Fri, 13 Nov 2020 10:25:43 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jarkko Sakkinen <jarkko@kernel.org>
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
Message-ID: <20201113102543.GK3371@techsingularity.net>
References: <20201112220135.165028-1-jarkko@kernel.org>
 <20201112220135.165028-11-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201112220135.165028-11-jarkko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:01:21AM +0200, Jarkko Sakkinen wrote:
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
> intent can be immediately compared to the source data???s mapping and
> rejected if necessary.
> 
> The ???intent??? is also stashed off for later comparison with enclave
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
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Jethro Beekman <jethro@fortanix.com> # v40
> Acked-by: Dave Hansen <dave.hansen@intel.com> # v40
> # Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
