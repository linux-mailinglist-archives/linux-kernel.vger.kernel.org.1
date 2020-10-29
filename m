Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4A29F21E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgJ2Que (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgJ2QuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863B0C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:50:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t14so2843808pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cv4+7kQkXt9yP5NUmOCSvou0pMNFr/3DXVTAN8b/WEM=;
        b=qc8xa9Jh2cxQTu85posvdCUXHcib4h8McXwY33UoEM9VfJXZHpj/WlpziCO5xhl43Y
         M8P4fC8eostSJrpRNf2t5gjHMBYdyJJEQE2bgP+1qYA5o7qrhHj9+vOn2JXQxMWzQN2j
         1MZdzFF4jynxe0Gq3ozgtBeI/Dt6G0AjfQ3498iTUnFwSwzqDT0ngg0fdbf3zs5mfNaj
         v+SPH+n3zwEzjm2HCY+E1R+bPvQCYUDLmE5SbBMgF5+KsJn9QujEWnZSQOy5XEbDIGLI
         O0UTO74cdV1fvKKVuizRoUGGKCzLZwfN+3nJy23j70bJE5xSzPzfAkyYowGAYMslvOKH
         gaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cv4+7kQkXt9yP5NUmOCSvou0pMNFr/3DXVTAN8b/WEM=;
        b=aG7ExriTGCH/Hh1me8eaj1bGTxxwKjj9jTuom2TH5jFHgltQGmz/Tm4xONDGqJJnKt
         WWqjdiCnemci0vbp4nIpN0OzVESgXPlu55JWK8uT8RAm0HD35HnPMHckE4/CWHoCiJ3E
         Sgr4X8U49LYwlbbKpm6QbEKFX4nVoTNXY4/+UDksMo6sBdsNxbzLKMCkgEZ3VXHM6Jal
         YpxwdERDyNoHytWp03xmIjLam4r/LE30ER/cQN3vfXDMSzWiMrhAVXBSP8LjtguQ5xY8
         oA4/+EOOqFRgffMJ4FZa1TT3TgiAAWrUkQDWTEl5HbBNhrdlMwGz5Iq8NKmAdS9Gus8z
         c3HQ==
X-Gm-Message-State: AOAM530hFnaiVb3QzblQAnpqYOMlzSfvXTtztQI1fGXtfryimbDNYzPo
        il313IdqLn8Kg3+PBSNy+ixVc25ovDX2Y44czuYjEw==
X-Google-Smtp-Source: ABdhPJxTU/rzp1TefKplfy18pqc1JkvBEZnJsfu/L9uepwZvlwmx4AKDOFVR2PVE6mzQaGOzgOlQXDe1stDkXDsD0Uw=
X-Received: by 2002:a62:7695:0:b029:152:3ddd:24a3 with SMTP id
 r143-20020a6276950000b02901523ddd24a3mr4914942pfc.2.1603990224897; Thu, 29
 Oct 2020 09:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602535397.git.andreyknvl@google.com> <94dfda607f7f7a28a5df9ee68703922aa9a52a1e.1602535397.git.andreyknvl@google.com>
 <CACT4Y+YhWM0MhS8wVsAmFmpBf4A8yDTLuV-JXtFYr79FJ9GGrQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YhWM0MhS8wVsAmFmpBf4A8yDTLuV-JXtFYr79FJ9GGrQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 29 Oct 2020 17:50:13 +0100
Message-ID: <CAAeHK+wCO+J7D1_T89DG+jJrPLk3X9RsGFKxJGd0ZcUFjQT-9Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/40] arm64: mte: Add in-kernel MTE helpers
To:     Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 12:28 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>

[...]

> > +void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> > +{
> > +       void *ptr = addr;
> > +
> > +       if ((!system_supports_mte()) || (size == 0))
> > +               return addr;
> > +
> > +       /* Make sure that size is MTE granule aligned. */
> > +       WARN_ON(size & (MTE_GRANULE_SIZE - 1));
> > +
> > +       /* Make sure that the address is MTE granule aligned. */
> > +       WARN_ON((u64)addr & (MTE_GRANULE_SIZE - 1));
> > +
> > +       tag = 0xF0 | tag;
> > +       ptr = (void *)__tag_set(ptr, tag);
> > +
> > +       mte_assign_mem_tag_range(ptr, size);
>
> This function will be called on production hot paths. I think it makes
> sense to shave off some overheads here.
>
> The additional debug checks may be useful, so maybe we need an
> additional debug mode (debug of MTE/KASAN itself)?
>
> Do we ever call this when !system_supports_mte()? I think we wanted to
> have static_if's higher up the stack. Having additional checks
> scattered across lower-level functions is overhead for every
> malloc/free.
>
> Looking at how this is called from KASAN code.
> KASAN code already ensures addr/size are properly aligned. I think we
> should either remove the duplicate alignment checks, or do them only
> in the additional debugging mode.
> Does KASAN also ensure proper tag value (0xF0 mask)?
>
> KASAN wrapper is inlined in this patch:
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/3699
> but here we still have 2 non-inlined calls. The
> mte_assign_mem_tag_range is kinda inherent since it's in .S. But then
> I think this wrapper should be inlinable.
>
> Also, can we move mte_assign_mem_tag_range into inline asm in the
> header? This would avoid register spills around the call in
> malloc/free.
>
> The asm code seems to do the rounding of the size up at no additional
> cost (checks remaining size > 0, right?). I think it makes sense to
> document that as the contract and remove the additional round_up(size,
> KASAN_GRANULE_SIZE) in KASAN code.

These are all valid concerns. It would be great to have inline asm
mte_assign_mem_tag_range() implementation. We can also call it
directly from KASAN code without all these additional checks.

Perhaps it makes sense to include this change into the other series
that adds the production mode. And then squash if we decide to put
both changes into a single one.

Vincenzo, could you write a patch that adds inline asm
mte_assign_mem_tag_range() implementation?
