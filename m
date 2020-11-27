Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A627C2C6222
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgK0Jo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:44:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgK0Jo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:44:26 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5919121D81;
        Fri, 27 Nov 2020 09:44:24 +0000 (UTC)
Date:   Fri, 27 Nov 2020 09:44:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        steven.price@arm.com, gerald.schaefer@linux.ibm.com,
        vgupta@synopsys.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 1/2] mm/debug_vm_pgtable/basic: Add validation for
 dirtiness after write protect
Message-ID: <20201127094421.GA25070@gaia>
References: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
 <1606453584-15399-2-git-send-email-anshuman.khandual@arm.com>
 <a6f79aba-9f9f-326f-5d73-6e0175f554ab@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6f79aba-9f9f-326f-5d73-6e0175f554ab@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 09:22:24AM +0100, Christophe Leroy wrote:
> Le 27/11/2020 à 06:06, Anshuman Khandual a écrit :
> > This adds validation tests for dirtiness after write protect conversion for
> > each page table level. This is important for platforms such as arm64 that
> > removes the hardware dirty bit while making it an write protected one. This
> > also fixes pxx_wrprotect() related typos in the documentation file.
> 
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index c05d9dcf7891..a5be11210597 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -70,6 +70,7 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
> >   	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
> >   	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
> >   	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
> > +	WARN_ON(pte_dirty(pte_wrprotect(pte)));
> 
> Wondering what you are testing here exactly.
> 
> Do you expect that if PTE has the dirty bit, it gets cleared by pte_wrprotect() ?
> 
> Powerpc doesn't do that, it only clears the RW bit but the dirty bit remains
> if it is set, until you call pte_mkclean() explicitely.

Arm64 has an unusual way of setting a hardware dirty "bit", it actually
clears the PTE_RDONLY bit. The pte_wrprotect() sets the PTE_RDONLY bit
back and we can lose the dirty information. Will found this and posted
patches to fix the arm64 pte_wprotect() to set a software PTE_DIRTY if
!PTE_RDONLY (we do this for ptep_set_wrprotect() already). My concern
was that we may inadvertently make a fresh/clean pte dirty with such
change, hence the suggestion for the test.

That said, I think we also need a test in the other direction,
pte_wrprotect() should preserve any dirty information:

	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));

If pte_mkwrite() makes a pte truly writable and potentially dirty, we
could also add a test as below. However, I think that's valid for arm64,
other architectures with a separate hardware dirty bit would fail this:

	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkwrite(pte))));

-- 
Catalin
