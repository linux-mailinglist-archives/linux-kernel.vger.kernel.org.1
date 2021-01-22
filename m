Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19C2300F58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbhAVVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbhAVVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:54:04 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA86C06178B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:53:22 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id g3so9758652ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CPWITUo+/eP9ETNQd4OsSoK0U6TCxj0r5SMKqUz0Nw=;
        b=EdKLye9FO1WxidyFZOfPLK+SDmnrcZ6RUgsPQCQcizQz+f1pQmRoWjI3h/HD9HNQJk
         xUc8FfvxKxkdTuPJzF4hTGYudt4sZbY8KGxX/FbTpxQM9kMoQPPVAHZZUnLLYWv/PIjd
         +TokG5V34YJrwP6HoCUer03h2aw92ohcxZqoFChAzqFUSBCmCoHmOZN9ZW0PIxinCjO1
         Fm2zWrZcuCCaUqiSSeQF6qrJh50IMz4ObnZwgwGzBI2FICSG9teOFwTErb25kndIhdTK
         zuaMwDuDeeyFNCI2CxZx3QJ+Qc2vQVmJFtfyYdZDBZuoS5NZ40fMrwvImVw71mqD9Oji
         Y1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CPWITUo+/eP9ETNQd4OsSoK0U6TCxj0r5SMKqUz0Nw=;
        b=Yil9znLYsRjh214IAdiZxnn9qHSrwqNW+zWOqV68/JvYuzYRrUvOiWRWKYOpgTiWUC
         QxRlnNyzX33nsqIUOCh4CTEChZ8k+cUWGVW0YWD/D+txgb7T7hoAUNuhEZcOOEvFhLXw
         FRK8w5y+ao9707ZetrNV/mOqOI1KY0bCeav28ySbeU8Sa6pY3f4RnC0j+enYX6R87EzP
         s9K9fGhFZrbXMARwjVCcY+LXyCdqBZScvrU8HHHiYJFcMCD4BHUbfg0fjJA9Y00S2SxK
         Gw22ohLROzc8CZprWryAIYIWF1hKkeZBbC7kvtLEdZReGhkwxGTN6auPfo5FMBOV8zl4
         6TbA==
X-Gm-Message-State: AOAM532Ald3GFrTiTnyncvWbPs/lfSQiJxpR/sgGw1dzbILyrFHATU34
        tuaC3OGXW4i+aTQw8DRZwEZpglbh6sO5vjsF6+F7fB+M9KD2QA==
X-Google-Smtp-Source: ABdhPJwRuqlxp1D1eQU4p//nwmF76HmUcMvAFR5HgT61SNcSei74aW4bFuULOnfaN7MlUUFVunC4rCNCl9NBYH1wy9g=
X-Received: by 2002:a17:907:20aa:: with SMTP id pw10mr892158ejb.314.1611352401292;
 Fri, 22 Jan 2021 13:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-4-pasha.tatashin@soleen.com> <c857d4aa-e8ec-81f6-bdea-dff6513c52dc@arm.com>
In-Reply-To: <c857d4aa-e8ec-81f6-bdea-dff6513c52dc@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 16:52:45 -0500
Message-ID: <CA+CK2bC506GE0P86Be3vFTjX8_-4JYfCRC8gGoe7BvJ2b6rASA@mail.gmail.com>
Subject: Re: [PATCH v9 03/18] arm64: trans_pgd: make trans_pgd_map_page generic
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I am working on an updated version of this patch series. We had back
and forth discussion on the list and off the list about MMU-enabled
series. So, I decided to sync the last series I had with the current
mainline. Address your last comments (those that I can address), and
send it again, so we can take a fresh look. I will reply to some of
your comments, as I address them in the synced version of my series.

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > kexec is going to use a different allocator, so make
>
> > trans_pgd_map_page to accept allocator as an argument, and also
> > kexec is going to use a different map protection, so also pass
> > it via argument.
>
> This trans_pgd_map_page() used to be create_single_mapping() It creates page tables that
> map one page: the relocation code.
>
> Why do you need a different pgprot? Surely PAGE_KERNEL_EXEC is exactly what you want.

For hibernate case yes, but for MMU enabled kexec case, PAGE_KERNEL is
used, because it is used to copy data segments.

> > diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> > index 23153c13d1ce..ad5194ad178d 100644
> > --- a/arch/arm64/include/asm/trans_pgd.h
> > +++ b/arch/arm64/include/asm/trans_pgd.h
> > @@ -12,10 +12,24 @@
> >  #include <linux/types.h>
> >  #include <asm/pgtable-types.h>
> >
> > +/*
> > + * trans_alloc_page
> > + *   - Allocator that should return exactly one zeroed page, if this
> > + *    allocator fails, trans_pgd returns -ENOMEM error.
>
> trans_pgd is what you pass in to trans_pgd_map_page() or trans_pgd_create_copy().
> Do you mean what those functions return?

I meant to say trans_pgd_*, but I will change the comment to
explicitly say trans_pgd_map_page() and trans_pgd_create_copy() will
return -ENOMEM.

>
>
> > + *
> > + * trans_alloc_arg
> > + *   - Passed to trans_alloc_page as an argument
> > + */
>
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 3d6f0fd73591..607bb1fbc349 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -195,6 +200,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
> >                                unsigned long dst_addr,
> >                                phys_addr_t *phys_dst_addr)
> >  {
> > +     struct trans_pgd_info trans_info = {
> > +             .trans_alloc_page       = hibernate_page_alloc,
> > +             .trans_alloc_arg        = (void *)GFP_ATOMIC,
> > +     };
>
> As you need another copy of this in the next patch, is it worth declaring this globally
> and making it const?

I think it is alright to have it on the stack instead of permanently
using the data section for this. Plus, we will have a different one
for the kexec case, so having this globally available will make it
strange.

>
>
> > diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
> > index d20e48520cef..275a79935d7e 100644
> > --- a/arch/arm64/mm/trans_pgd.c
> > +++ b/arch/arm64/mm/trans_pgd.c
> > @@ -180,8 +185,18 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> >       return rc;
> >  }
> >
> > -int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
> > -                    pgprot_t pgprot)
> > +/*
> > + * Add map entry to trans_pgd for a base-size page at PTE level.
> > + * info:     contains allocator and its argument
> > + * trans_pgd:        page table in which new map is added.
> > + * page:     page to be mapped.
>
> > + * dst_addr: new VA address for the pages
>
> ~s/pages/page/
>
> This thing only maps one page.

Sure, I will change that.

Thank you,
Pasha
