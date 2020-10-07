Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9216828616D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgJGOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgJGOnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:43:23 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E0C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 07:43:23 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u8so3363343ejg.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yaN1rjyLrPsyFHJUcCMRII0CnG4UdUmiNrPeZE3+a2o=;
        b=nkOVjFaap1/yZl4CUDg4K4Ox8KSB9wy9sJrCPdFITMcuwfROhxDXnBr9RlyK9JOwM1
         VEAi9SVibNPsv71oy6nhtbqsusqW+/QiwUIyumUUh6zDmPusa/d38voD+N5QCxtT+5f/
         nCjBDNyPjCzVz7ySiHW+pDlThvHFopXt0tucDzNe3e51j5RFzbT8e7VerZ/62jYKjCVh
         y0cBmyibSPFBSvmMxoM2VWww8R5ehMlVAvmJbE7YH+sLVtXF2ZcP8ulxgyDu8nOH9oZW
         KiircQAwFxmSIXUj/e/0IYDv/uPIpHIPSX+blkBd56Qpag2B3btDwunrD7oqikY7az1J
         /dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaN1rjyLrPsyFHJUcCMRII0CnG4UdUmiNrPeZE3+a2o=;
        b=L/Ld79XQd4htr9WHqxMc7c+DrM/58zb72E+uVxAH9XNvrCx3ZI4Nf1OcY81SBUAr09
         eIDsDo5rhwl0IL8dP9e5hbxqkQrCtu7SZ29a8jOFQWFkfeRiYN+o+7YMjFxbH1zn7wqb
         QH36v1mfgsPTlBl5uZ9/WgRtVzd+u4X3Avq/LZl84PyzEI0NffR9uZ32ZnOLfjbAL+Jr
         j6rY0wEbG49/XmEGIww7s1jNIJfGpTNJukOI79T9vmm7c62gSgP/wVrWfvNy78ddsmlb
         R90IvMOCyWuFALzRyMk2Sp3940iv2HBmdNY7INTjyhH0HtnShy6a3DoQOmim+1IGu8Pi
         wz4g==
X-Gm-Message-State: AOAM530YVOUxeo2CVvNrcqb+DmeyETHB8/H+mr82EKbX3YWsLZREf1JM
        F2gNyfujJbiCrdCEMsT/F+Am6QRb1a/AW50Ifk9CdYkFmXtiXHY8
X-Google-Smtp-Source: ABdhPJzcK0C/z7p/R/rO2dkoBnGMVzKrffZV6M0+dNfgCx+3Vi4jT221WFvbiB0KTziaharLk7wRJUaJVTHbRe80EQQ=
X-Received: by 2002:a17:906:33c8:: with SMTP id w8mr3659464eja.233.1602081801820;
 Wed, 07 Oct 2020 07:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201007073932.865218-1-jannh@google.com> <20201007123544.GA11433@infradead.org>
In-Reply-To: <20201007123544.GA11433@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 7 Oct 2020 16:42:55 +0200
Message-ID: <CAG48ez3kjTeVtQcjQerYYRs7sX5qq3O7SU-FEaYLNXisFmAeOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock
 and with length
To:     Christoph Hellwig <hch@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 2:35 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Oct 07, 2020 at 09:39:31AM +0200, Jann Horn wrote:
> > diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> > index 078608ec2e92..b1fabb97d138 100644
> > --- a/arch/powerpc/kernel/syscalls.c
> > +++ b/arch/powerpc/kernel/syscalls.c
> > @@ -43,7 +43,7 @@ static inline long do_mmap2(unsigned long addr, size_t len,
> >  {
> >       long ret = -EINVAL;
> >
> > -     if (!arch_validate_prot(prot, addr))
> > +     if (!arch_validate_prot(prot, addr, len))
>
> This call isn't under mmap lock.  I also find it rather weird as the
> generic code only calls arch_validate_prot from mprotect, only powerpc
> also calls it from mmap.
>
> This seems to go back to commit ef3d3246a0d0
> ("powerpc/mm: Add Strong Access Ordering support")

I'm _guessing_ the idea in the generic case might be that mmap()
doesn't check unknown bits in the protection flags, and therefore
maybe people wanted to avoid adding new error cases that could be
caused by random high bits being set? So while the mprotect() case
checks the flags and refuses unknown values, the mmap() code just lets
the architecture figure out which bits are actually valid to set (via
arch_calc_vm_prot_bits()) and silently ignores the rest?

And powerpc apparently decided that they do want to error out on bogus
prot values passed to their version of mmap(), and in exchange, assume
in arch_calc_vm_prot_bits() that the protection bits are valid?

powerpc's arch_validate_prot() doesn't actually need the mmap lock, so
I think this is fine-ish for now (as in, while the code is a bit
unclean, I don't think I'm making it worse, and I don't think it's
actually buggy). In theory, we could move the arch_validate_prot()
call over into the mmap guts, where we're holding the lock, and gate
it on the architecture or on some feature CONFIG that powerpc can
activate in its Kconfig. But I'm not sure whether that'd be helping or
making things worse, so when I sent this patch, I deliberately left
the powerpc stuff as-is.
