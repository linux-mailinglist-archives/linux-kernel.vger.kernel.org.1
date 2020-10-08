Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972A2287A95
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbgJHRHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbgJHRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:07:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB59C061755;
        Thu,  8 Oct 2020 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lFsuL5fiQpUDvhtt5fozsfGKqdT49zToyfpYwey6+xI=; b=ASKAd2B6AXXo8EQU0anUauThTY
        Xs+INzR/+2gmCusmIBzQSVkXzjRKpTmstSXY5ttvhN1QTl2AXy9LEtpPVxoi5ctQMsksLObnipIKR
        JJ9M7p5XBoKp3LJ/YzwaPHYoUUcfJbOjyIaZaM5Zy37IykTNcmhaJEtbXUiFC64OpmOLiRctr/G+S
        laVoV9oi2zAnTe0evHAULLd7iAmewSPZAtfyKWURzxixSSF8ZhVjnNmuzgdenLd7dreBwyXYeHko1
        7nxkhrlPnebM33Ltu4ijPaB6AFx/VeQMI8AKbgGFXSNKq5uzKQv11TLgovBrkdzGE2AY7JDw3ytYI
        jd6yuvwA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQZO4-0007Q1-5u; Thu, 08 Oct 2020 17:07:28 +0000
Date:   Thu, 8 Oct 2020 18:07:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
Message-ID: <20201008170728.GK20115@casper.infradead.org>
References: <20201008165408.38228-1-toiwoton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008165408.38228-1-toiwoton@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 07:54:08PM +0300, Topi Miettinen wrote:
> +3   Additionally enable full randomization of memory mappings created
> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
> +    mappings is random, but the mappings are created in predictable
> +    places within the VMA and in sequential order. With 3, new VMAs
> +    are created to fully randomize the mappings. Also mremap(...,
> +    MREMAP_MAYMOVE) will move the mappings even if not necessary.
> +
> +    On 32 bit systems this may cause problems due to increased VM
> +    fragmentation if the address space gets crowded.

On all systems, it will reduce performance and increase memory usage due
to less efficient use of page tables and inability to merge adjacent VMAs
with compatible attributes.

> +	if ((flags & MREMAP_MAYMOVE) && randomize_va_space >= 3) {
> +		/*
> +		 * Caller is happy with a different address, so let's
> +		 * move even if not necessary!
> +		 */
> +		new_addr = arch_mmap_rnd();
> +
> +		ret = mremap_to(addr, old_len, new_addr, new_len,
> +				&locked, flags, &uf, &uf_unmap_early,
> +				&uf_unmap);
> +		goto out;
> +	}
> +
> +

Overly enthusiastic newline
