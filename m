Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20AF2EC15B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbhAFQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:43:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbhAFQnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:43:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6278423136;
        Wed,  6 Jan 2021 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951351;
        bh=wU5/hSQmjyU1JL5g7k1xb3fISw69WCPfgnVr0jjxhhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KB/Etz3uNVe37B1mwrZKRmCRVCoOi0NOKAGDgYEEc1nRvfVxtdcyKkSOIoxBgBaT0
         8UOHrPDR6ar9ObCfDBiKxsvrUzn7mcKzEgxV8rMYWcOj3iLEwrAaHXmqkqk0IJmW4l
         +M6yjKY+e8fnYyGUTmfmdiGaSplJCQ9hx9Agj32ETlf2GRPRrU+7Wz5nGBRVdcnc38
         BbzjPIY2I05ijo0F02pPQ3wce1nXTbnXlqx0kSXKAIQyficDWUo3pCY/8mSUYHn+6e
         XfENKLP1WB11W+8PNel4CsC2YxgAPfiz9lrSMLO6tf2R0UCUoH0KpX0BsZn9nszDth
         6Y5wgVZs60gjw==
Date:   Wed, 6 Jan 2021 16:42:26 +0000
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 0/4] arm64: ARMv8.5-A: MTE: Add async mode support
Message-ID: <20210106164225.GA1916@willie-the-truck>
References: <20210106115519.32222-1-vincenzo.frascino@arm.com>
 <9a78cd4f-838d-0410-62fa-16e4ab921681@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a78cd4f-838d-0410-62fa-16e4ab921681@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:35:29PM +0000, Vincenzo Frascino wrote:
> 
> On 1/6/21 11:55 AM, Vincenzo Frascino wrote:
> > This patchset implements the asynchronous mode support for ARMv8.5-A
> > Memory Tagging Extension (MTE), which is a debugging feature that allows
> > to detect with the help of the architecture the C and C++ programmatic
> > memory errors like buffer overflow, use-after-free, use-after-return, etc.
> > 
> > MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> > (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> > subset of its address space that is multiple of a 16 bytes granule. MTE
> > is based on a lock-key mechanism where the lock is the tag associated to
> > the physical memory and the key is the tag associated to the virtual
> > address.
> > When MTE is enabled and tags are set for ranges of address space of a task,
> > the PE will compare the tag related to the physical memory with the tag
> > related to the virtual address (tag check operation). Access to the memory
> > is granted only if the two tags match. In case of mismatch the PE will raise
> > an exception.
> > 
> > The exception can be handled synchronously or asynchronously. When the
> > asynchronous mode is enabled:
> >   - Upon fault the PE updates the TFSR_EL1 register.
> >   - The kernel detects the change during one of the following:
> >     - Context switching
> >     - Return to user/EL0
> >     - Kernel entry from EL1
> >     - Kernel exit to EL1
> >   - If the register has been updated by the PE the kernel clears it and
> >     reports the error.
> > 
> > The series contains as well an optimization to mte_assign_mem_tag_range().
> > 
> > The series is based on linux 5.11-rc2.
> > 
> > To simplify the testing a tree with the new patches on top has been made
> > available at [1].
> > 
> > [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> Will is not in arm anymore :( Sorry Will... I will fix this in v2.

If only you worked for payroll ;)

Will
