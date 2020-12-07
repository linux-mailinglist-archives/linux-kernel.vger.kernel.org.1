Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E482D0CA9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgLGJJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgLGJJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:09:55 -0500
X-Gm-Message-State: AOAM530nHokhKR8eObaFxQXK+h6exLOLPkdP94xbHpANhKlUs8yqWl5h
        avsDJdLK69Evh1j0hd5YArgEhwdlhXlPDcCVzTU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607332158;
        bh=zeXLUbD69DJQRxwchh1DPhqWxvriQVslIApvnQjzLYo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fjU/RNO5aHHNlPYZVX2DRu34mv2SubeizvQVnooBZSudvI0DQoSLOuvMjUT3/s2So
         yu/0PLexNza5xiZqHYfs1djfhNgZ7FqZMngqCcXuWXpzMoHu/OkJswa3oE/OpkFjfb
         w4WQHncqstL3vqOPzW6Q0J7PrCV8zckQG8ocEStd6hOVyVKec1YQeroU9tZkV+9enk
         HM+3VPzG6Bh9/AvelLSfKvBIABoowRWbruW3wQzsBvCKnohtWPeBbqzXB+udUwTEKV
         F+mUSKV6UqVtZKbeLwSKoC02t2S4/ms4/+Tyf7KFLjIT0jFER8F5YVrNNxTMFKEjbC
         nqSU/tCcPnYpw==
X-Google-Smtp-Source: ABdhPJxwjkwJV5u54bL3hRS5pTJFBF76tgxwRV6F4pNLnBO+C+fIStqXN7jkJxjGvaI9WN4XMqSBJmy5Et3U9WuxvVg=
X-Received: by 2002:aca:b809:: with SMTP id i9mr11682796oif.174.1607332157482;
 Mon, 07 Dec 2020 01:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20201204014443.43329-1-liwei213@huawei.com> <20201204111347.GA844@willie-the-truck>
In-Reply-To: <20201204111347.GA844@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Dec 2020 10:09:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGQ-CeYcbS-hc+Yy8DKHm2t-RYsLu4+7wOG1bWuJqkjGQ@mail.gmail.com>
Message-ID: <CAMj1kXGQ-CeYcbS-hc+Yy8DKHm2t-RYsLu4+7wOG1bWuJqkjGQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the memory
 reserved for the page map
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Wei Li <liwei213@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, fengbaopeng2@hisilicon.com,
        butao@hisilicon.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Marc)

On Fri, 4 Dec 2020 at 12:14, Will Deacon <will@kernel.org> wrote:
>
> On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
> > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> > do not free the reserved memory for the page map, decrease the section
> > size can reduce the waste of reserved memory.
> >
> > Signed-off-by: Wei Li <liwei213@huawei.com>
> > Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
> > Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> > ---
> >  arch/arm64/include/asm/sparsemem.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> > index 1f43fcc79738..8963bd3def28 100644
> > --- a/arch/arm64/include/asm/sparsemem.h
> > +++ b/arch/arm64/include/asm/sparsemem.h
> > @@ -7,7 +7,7 @@
> >
> >  #ifdef CONFIG_SPARSEMEM
> >  #define MAX_PHYSMEM_BITS     CONFIG_ARM64_PA_BITS
> > -#define SECTION_SIZE_BITS    30
> > +#define SECTION_SIZE_BITS    27
>
> We chose '30' to avoid running out of bits in the page flags. What changed?
>
> With this patch, I can trigger:
>
> ./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds SECTION_SIZE
> #error Allocator MAX_ORDER exceeds SECTION_SIZE
>
> if I bump up NR_CPUS and NODES_SHIFT.
>

Does this mean we will run into problems with the GICv3 ITS LPI tables
again if we are forced to reduce MAX_ORDER to fit inside
SECTION_SIZE_BITS?
