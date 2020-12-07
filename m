Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B945A2D0D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgLGJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgLGJuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:50:21 -0500
X-Gm-Message-State: AOAM532ai4naxU/1Luce2cvd2DMPNQXUslqt3t+ztyTRcc7BmHFvtlMr
        f3V9hYwtGBfMdKOH/NEUg63ae97JKEaS+N1kR6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607334578;
        bh=tF9LVqDHFSzUcm14YYU2SnQMlWv94hqwGplrovgVOXw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GWz7RJVtBTUZftrvXnhDnRLT1XlY7x2haj8ZwfelLERql2hdELUqLfHLrREMg81/C
         HUn+U8b7q8sjVgJIn15Xn+2kif9Chi4lk1JMaB7Hp5jaPN8UgJOv4N2vVbX3AAVyTB
         052/156+bdO1zI5g7f067ck4stY1Jbr83dXr2q4luvdBOMdNVrQqV1tDER76lLWGyB
         +bVjyPXeJ0fhc32RVXXZGRJ/G10i6/YJaUWdsV2aL89+tAKJUlw/cBNBOUTV4ES77T
         RrmaoghqTNSZ7iRb+SjyyQk3P2hQRBL9r/6XzXJ/VctyKoIdiRyIOFitE6BhWwmxyi
         /o61fbvqunWHQ==
X-Google-Smtp-Source: ABdhPJxBxMf7u1AUfn0C3mEglSwdUupN+fWld7JT9VKmAq3LF/66Ep+lKE7U3PPPi2DFbTtSyD2t99FaVtzYJnMV3lI=
X-Received: by 2002:a9d:62c1:: with SMTP id z1mr12235365otk.108.1607334578148;
 Mon, 07 Dec 2020 01:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20201204014443.43329-1-liwei213@huawei.com> <20201204111347.GA844@willie-the-truck>
 <CAMj1kXGQ-CeYcbS-hc+Yy8DKHm2t-RYsLu4+7wOG1bWuJqkjGQ@mail.gmail.com>
 <390f5f441d99a832f4b2425b46f6d971@kernel.org> <20201207094215.GC1112728@linux.ibm.com>
In-Reply-To: <20201207094215.GC1112728@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Dec 2020 10:49:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFdtom+OBJ84he9C5eNw-KJ8zwW04WB0ab6Gp_DCiYkRg@mail.gmail.com>
Message-ID: <CAMj1kXFdtom+OBJ84he9C5eNw-KJ8zwW04WB0ab6Gp_DCiYkRg@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the memory
 reserved for the page map
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Wei Li <liwei213@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fengbaopeng2@hisilicon.com, butao@hisilicon.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 at 10:42, Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Dec 07, 2020 at 09:35:06AM +0000, Marc Zyngier wrote:
> > On 2020-12-07 09:09, Ard Biesheuvel wrote:
> > > (+ Marc)
> > >
> > > On Fri, 4 Dec 2020 at 12:14, Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
> > > > > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> > > > > do not free the reserved memory for the page map, decrease the section
> > > > > size can reduce the waste of reserved memory.
> > > > >
> > > > > Signed-off-by: Wei Li <liwei213@huawei.com>
> > > > > Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
> > > > > Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> > > > > ---
> > > > >  arch/arm64/include/asm/sparsemem.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> > > > > index 1f43fcc79738..8963bd3def28 100644
> > > > > --- a/arch/arm64/include/asm/sparsemem.h
> > > > > +++ b/arch/arm64/include/asm/sparsemem.h
> > > > > @@ -7,7 +7,7 @@
> > > > >
> > > > >  #ifdef CONFIG_SPARSEMEM
> > > > >  #define MAX_PHYSMEM_BITS     CONFIG_ARM64_PA_BITS
> > > > > -#define SECTION_SIZE_BITS    30
> > > > > +#define SECTION_SIZE_BITS    27
> > > >
> > > > We chose '30' to avoid running out of bits in the page flags. What
> > > > changed?
> > > >
> > > > With this patch, I can trigger:
> > > >
> > > > ./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds
> > > > SECTION_SIZE
> > > > #error Allocator MAX_ORDER exceeds SECTION_SIZE
> > > >
> > > > if I bump up NR_CPUS and NODES_SHIFT.
> > > >
> > >
> > > Does this mean we will run into problems with the GICv3 ITS LPI tables
> > > again if we are forced to reduce MAX_ORDER to fit inside
> > > SECTION_SIZE_BITS?
> >
> > Most probably. We are already massively constraint on platforms
> > such as TX1, and dividing the max allocatable range by 8 isn't
> > going to make it work any better...
>
> I don't think MAX_ORDER should shrink. Even if SECTION_SIZE_BITS is
> reduced it should accomodate the existing MAX_ORDER.
>
> My two pennies.
>

But include/linux/mmzone.h:1170 has this:

#if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
#error Allocator MAX_ORDER exceeds SECTION_SIZE
#endif

and Will managed to trigger it after applying this patch.
