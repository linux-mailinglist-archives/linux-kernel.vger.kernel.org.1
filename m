Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E373287313
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgJHLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHLDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:03:14 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9362215A4;
        Thu,  8 Oct 2020 11:03:10 +0000 (UTC)
Date:   Thu, 8 Oct 2020 12:03:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jann Horn <jannh@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock
 and with length
Message-ID: <20201008110307.GH7661@gaia>
References: <20201007073932.865218-1-jannh@google.com>
 <20201007123544.GA11433@infradead.org>
 <CAG48ez3kjTeVtQcjQerYYRs7sX5qq3O7SU-FEaYLNXisFmAeOg@mail.gmail.com>
 <87o8ld0zwt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8ld0zwt.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 09:34:26PM +1100, Michael Ellerman wrote:
> Jann Horn <jannh@google.com> writes:
> > So while the mprotect() case
> > checks the flags and refuses unknown values, the mmap() code just lets
> > the architecture figure out which bits are actually valid to set (via
> > arch_calc_vm_prot_bits()) and silently ignores the rest?
> >
> > And powerpc apparently decided that they do want to error out on bogus
> > prot values passed to their version of mmap(), and in exchange, assume
> > in arch_calc_vm_prot_bits() that the protection bits are valid?
> 
> I don't think we really decided that, it just happened by accident and
> no one noticed/complained.
> 
> Seems userspace is pretty well behaved when it comes to passing prot
> values to mmap().

It's not necessarily about well behaved but whether it can have security
implications. On arm64, if the underlying memory does not support MTE
(say some DAX mmap) but we still allow PROT_MTE driven by user, it will
lead to an SError which brings the whole machine down.

Not sure whether ADI has similar requirements but at least for arm64 we
addressed the mmap() case as well (see my other email on the details; I
think the approach would work on SPARC as well).

-- 
Catalin
