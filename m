Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB92C9526
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgLACY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgLACY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:24:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C69C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 18:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pgfrNp213PUqGJpsyhnVpIsJf+6NbYjx7aBpXnxJ518=; b=SyEnPcyYwWC9XFUMx9ImmuzGNH
        M6FVqe1DAzcUTh6aJ/7iDt7VVZrElY0TNucZLpWskIOwqJ6lp69e9c3k2xNp3yzXKq7e4DrRRZXlD
        AvcFu8F2iTwKb9gZdEt+qP6WCwbC+B269Xt/xd2CdFWLXiKFG954nPrSXCYp/UaXuLSOqLEUHVayk
        q0ydwJ2uiySMemCQJw7nvK576n5/6DQVg6MjAOOnrvZTDNwulgQ7gWda2U6vSJ9Mb2DtJleSVSyAg
        ip0W7/3Yma1+3z2SB9ggdGPHQMq78MgmZj4TJOcsyLKrmrSwlkwGbRFrsgHNbZqVAH5RO/q3Dk6uY
        lL7jNOAw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjvKu-0001qU-Q9; Tue, 01 Dec 2020 02:24:12 +0000
Date:   Tue, 1 Dec 2020 02:24:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: mapcount corruption regression
Message-ID: <20201201022412.GG4327@casper.infradead.org>
References: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4isen63tJ7q02rvVuu_Rm6QPdT0Bu-P_HJ2zePMySFNNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:20:25PM -0800, Dan Williams wrote:
> Kirill, Willy, compound page experts,
> 
> I am seeking some debug ideas about the following splat:
> 
> BUG: Bad page state in process lt-pmem-ns  pfn:121a12
> page:0000000051ef73f7 refcount:0 mapcount:-1024
> mapping:0000000000000000 index:0x0 pfn:0x121a12

Mapcount of -1024 is the signature of:

#define PG_guard        0x00000400

(the bits are inverted, so this turns into 0xfffffbff which is reported
as -1024)

I assume you have debug_pagealloc enabled?

> flags: 0x2ffff800000000()
> raw: 002ffff800000000 dead000000000100 0000000000000000 0000000000000000
> raw: 0000000000000000 ffff8a6914886b48 00000000fffffbff 0000000000000000
> page dumped because: nonzero mapcount
> [..]
> CPU: 26 PID: 6127 Comm: lt-pmem-ns Tainted: G           OE     5.10.0-rc4+ #450
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> Call Trace:
>  dump_stack+0x8b/0xb0
>  bad_page.cold+0x63/0x94
>  free_pcp_prepare+0x224/0x270
>  free_unref_page+0x18/0xd0
>  pud_free_pmd_page+0x146/0x160
>  ioremap_pud_range+0xe3/0x350
>  ioremap_page_range+0x108/0x160
>  __ioremap_caller.constprop.0+0x174/0x2b0
>  ? memremap+0x7a/0x110
>  memremap+0x7a/0x110
>  devm_memremap+0x53/0xa0
>  pmem_attach_disk+0x4ed/0x530 [nd_pmem]
> 
> It triggers on v5.10-rc4 not on v5.9, but the bisect comes up with an
> ambiguous result. I've run the bisect 3 times and landed on:
> 
> 032c7ed95817 Merge tag 'arm64-upstream' of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> 
> ...which does not touch anything near _mapcount. I suspect there is
> something unique about the build that lines up the corruption to
> happen or not happen.
> 
> The test is a simple namespace creation test that results in an
> memremap() / ioremap() over several gigabytes of memory capacity. The
> -1024 was interesting because that's the GUP_PIN_COUNTING_BIAS, but
> that's the _refcount, I did not see any questionable changes to how
> _mapcount is manipulated post v5.9. Problem should be reproducible by
> running:
> 
> make -j TESTS="pmem-ns" check
> 
> ...in qemu-kvm with some virtual pmem defined:
> 
> -object memory-backend-file,id=mem1,share,mem-path=${mem}1,size=$((mem_size+label_size))
> -device nvdimm,memdev=mem1,id=nv1,label-size=${label_size}
> 
> ...where ${mem}1 is a 128GB sparse file $mem_size is 127GB and
> $label_size is 128KB.
> 
