Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD572885D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbgJIJQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731262AbgJIJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:16:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ED2C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 02:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y21hzAeH0iN3CCdZ7u60F0himStwk45E92eSH+vcx6I=; b=E7gdOdozrI2njdSPkwQhFu7otU
        UqkSfte/igxyDpt6+dcbY6NPnSTjrxm7HBZdtiPAsUlMHa1f+oYZfYO9h6EIHL0BnphanSlQn8Y8k
        jCtvKmKRZr2DsErTulTXJD2xkpW3ZeBNVeuT8sdgFD1hHm3mnH6VTrMIWFU16H9Q1c3YkxF2VAE/k
        BE48/hQnFihC7Egtib3aLJVEtiV3/IAl4bOpXxkF8Or9VlSnCwnVroyFZ933wxkLvYi1kSWFv1QzN
        +J5XFNSCRBA/GwERcaSnnS6YoTevsMiHra7/tBgX363tCNMkpZO6RSPyCX/eYs//WybOr50rHWBl6
        7VZRCziw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQoVW-0003Bn-DE; Fri, 09 Oct 2020 09:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C4A0300B22;
        Fri,  9 Oct 2020 11:16:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 463052019D2CA; Fri,  9 Oct 2020 11:16:07 +0200 (CEST)
Date:   Fri, 9 Oct 2020 11:16:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Will Deacon <will@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201009091607.GM2651@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 11:09:27AM +0200, Peter Zijlstra wrote:
> @@ -7046,6 +7059,10 @@ static u64 __perf_get_page_size(struct m
>  		return 0;
>  	}
>  
> +	page = pte_page(*pte);
> +	if (PageHuge(page))
> +		return page_size(compound_head(page));

Argh, this misses pte_unmap()..

> +
>  	pte_unmap(pte);
>  	return PAGE_SIZE;
>  }
