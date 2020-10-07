Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859F2285F4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgJGMg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:36:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF319C061755;
        Wed,  7 Oct 2020 05:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7xZSyQPWnxLgrh1E9TtQ37I9TBQZo5pqOmu3lCWY/iI=; b=m/UGZtLZn/vN4y9M1nZ2Zjl0b5
        r4S7hsMn5sTBt2bmtoc40cZm4Efl/3LvrLn+d4lq/R+BfXSr0QbkaUI09EE0yR0VInpGzv3o79/II
        uBhFyWyfkV9sNAlEmUsk8FsNl4rxtjMGElFM3s8f4URICAxq43ok4C/T1+sb24V4vYRihpMzlOrKN
        5r/6EMNqG84CGgm2bOjQyhA91w57Xu4lZsyPEq6pthgdsyKg+R04KH919HPs1obLNqsJGyQT13m3F
        Eaadx2Mxm9FWD9V4lc8SBdo56njL3PvNoxXbRWKanjehqpl+NgfGpELV3eXDObpuR9Y2m+0twAcAu
        Ri99tb6g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ8gg-0003hn-4Q; Wed, 07 Oct 2020 12:36:54 +0000
Date:   Wed, 7 Oct 2020 13:36:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] sparc: Check VMA range in sparc_validate_prot()
Message-ID: <20201007123654.GB11433@infradead.org>
References: <20201007073932.865218-1-jannh@google.com>
 <20201007073932.865218-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007073932.865218-2-jannh@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/arch/sparc/include/asm/mman.h
> @@ -60,31 +60,41 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr,
>  	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
>  		return 0;
>  	if (prot & PROT_ADI) {
> +		struct vm_area_struct *vma, *next;
> +

I'd split all the ADI logic into a separate, preferable out of line
helper.

> +			/* reached the end of the range without errors? */
> +			if (addr+len <= vma->vm_end)

missing whitespaces around the arithmetic operator.
