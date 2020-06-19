Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424A420031E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgFSIAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 04:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730830AbgFSIAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:00:35 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB31C206D7;
        Fri, 19 Jun 2020 08:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592553635;
        bh=FgWt8SPb4Du2ZpFmVRFLGteouMfOd6TM8Ed9GBB4zyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTRiWZFgHuUY5Yp2fSRTZj85Dv3B+lsaSSJWAlJ4zTGoQuHRmpM51+AOGsz2sbFYQ
         9NEycOpbm2Dht8X/iy1/cRyPfIf+7u0KmbqSE+vdt/H3jEhOfTxg1dHz1KXdxYgOV1
         qcBMWA8/Jq8HoLgya6SVzVaAcum1iuD5HeYNlGz0=
Date:   Fri, 19 Jun 2020 09:00:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/debug_vm_pgtable: Fix build failure with powerpc 8xx
Message-ID: <20200619080029.GA6500@willie-the-truck>
References: <6ca8c972e6c920dc4ae0d4affbed9703afa4d010.1592490570.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca8c972e6c920dc4ae0d4affbed9703afa4d010.1592490570.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:31:29PM +0000, Christophe Leroy wrote:
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index e45623016aea..61ab16fb2e36 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -246,13 +246,13 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
>  static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
>  				   unsigned long vaddr)
>  {
> -	pte_t pte = READ_ONCE(*ptep);
> +	pte_t pte = ptep_get(ptep);
>  
>  	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>  	set_pte_at(mm, vaddr, ptep, pte);
>  	barrier();
>  	pte_clear(mm, vaddr, ptep);
> -	pte = READ_ONCE(*ptep);
> +	pte = ptep_get(ptep);
>  	WARN_ON(!pte_none(pte));
>  }

Acked-by: Will Deacon <will@kernel.org>

I wonder if there's a way to do this with coccinelle in one big go (but the
resulting diff would obviously need manual inspection)?

Will
