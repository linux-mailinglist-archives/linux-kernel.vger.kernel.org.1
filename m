Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D572F6BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 21:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbhANUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 15:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbhANUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 15:10:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D969C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:09:59 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a188so4008064pfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 12:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iB3Jw2esdANcXXH44eCvOPFepBca1nOJGZGOnewNohA=;
        b=lcbZ3BC5P4onmRMYQ9hVh1BhepJnL5kj7yeaJnlqQJci2AhhD1uTyOtCSGG7iYVnH9
         zbJtF1PW43ulgDUYMEtMSkSXlBmPDuw0wXuSjZqlD8oZvPfetlNRcYRkNokRTsW3YJAC
         fWkpDS4G9qlMGD4taq4KMbrtifDbnv35KGEHA1GboksETpRQZHyF8b+sJ89+PEhudn8U
         SLQeGGdall+yZDICyOE3k6fGcJV8IXsQzxJZna0mPNqa7Qz8QdBmtbH6rohR8YAiafdJ
         cvVM80mIC64CxX6Dx2JKBcNVWLRmuqrqo5zghfxmRsnEUOll/H56kCb4Zk649Q+bHkeO
         Eaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iB3Jw2esdANcXXH44eCvOPFepBca1nOJGZGOnewNohA=;
        b=dCTgq5AivwgbjXizw4SYFdd/rmeGpCjTYBRzCCSjH57JRDL+vaWagqKOYjL0+17cDV
         LMOrKV3I2Jzr9VarYtB2MuJQQvQtsEo3H/a+kq5O2C78jhn6VY49gucicgDJsOozEj1j
         phQLQ1xSNobcY7MWgZUw2ZF1tGFj6jchQHD7avlg73maGYT7MjXxX+fH6XyjPTZzYnCb
         TDQ+fm1xFabK+UnIBH2uXea3YI+WuUWltdEvq4y4txFOe4+7EoMDCkL566+7Ose07ofE
         WDeI+elnd/KOgWSaZom9BVf3QP6WqSWcRAwwyA+vcOLYmGV8jFgg1qxmCjyL6ukptfaY
         vO8w==
X-Gm-Message-State: AOAM530I/GgUvykP485mtD9P2BzELlZOoti0CkeyBnCzJ0XvTjk8ETbG
        gVea4JxgJy2pirGVRMPcTmtN7+tBNPRUoOFiNgPGOV5xGGO+Pg==
X-Google-Smtp-Source: ABdhPJxdMZ11aeWYCth9RA14e3mnlFGCx9jVnSpd7hRCxYaZPBNfFDyacpfxrLMLEc0a6oFlcupomXmnJU7N7G73aak=
X-Received: by 2002:a63:1142:: with SMTP id 2mr9162380pgr.263.1610654998210;
 Thu, 14 Jan 2021 12:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20210114175934.13070-1-will@kernel.org> <20210114175934.13070-5-will@kernel.org>
 <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
 <20210114190021.GB13135@willie-the-truck> <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
 <20210114194129.GA13314@willie-the-truck>
In-Reply-To: <20210114194129.GA13314@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 14 Jan 2021 12:09:47 -0800
Message-ID: <CAKwvOd=8-Ff+bC82pUMUHtZyKWm_1g7AKEO12GJ-kOTQ=0PXkw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:41 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jan 14, 2021 at 11:09:01AM -0800, Linus Torvalds wrote:
> > On Thu, Jan 14, 2021 at 11:00 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > I tried that initially, but I found that I had to make all of the
> > > members const to get it to work, at which point the anonymous struct
> > > wasn't really adding anything. Did I just botch the syntax?
> >
> > I'm not sure what you tried. But this stupid test-case sure works for m=
e:
> >
> >     struct hello {
> >         const struct {
> >                 unsigned long address;
> >         };
> >         unsigned int flags;
> >     };
> >
> >     extern int fn(struct hello *);
> >
> >     int test(void)
> >     {
> >         struct hello a =3D {
> >                 .address =3D 1,
> >         };
> >         a.flags =3D 0;
> >         return fn(&a);
> >     }
> >
> > and because "address" is in that unnamed constant struct, you can only
> > set it within that initializer, and cannot do
> >
> >         a.address =3D 0;
> >
> > without an error (the way you _can_ do "a.flags =3D 0").
> >
> > I don't see naming the struct making a difference - apart from forcing
> > that big rename patch, of course.
> >
> > But maybe we're talking about different issues?
>
> Urgh...
>
> We _are_ both on the same page, and your reply above had me thinking I've
> lost the plot, so I went back to the start. Check out v5.11-rc3 and apply
> this patch:
>
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecdf8a8cd6ae..1eb950865450 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -514,11 +514,14 @@ static inline bool fault_flag_allow_retry_first(uns=
igned int flags)
>   * pgoff should be used in favour of virtual_address, if possible.
>   */
>  struct vm_fault {
> -       struct vm_area_struct *vma;     /* Target VMA */
> +       const struct {
> +               struct vm_area_struct *vma;     /* Target VMA */
> +               gfp_t gfp_mask;                 /* gfp mask to be used fo=
r allocations */
> +               pgoff_t pgoff;                  /* Logical page offset ba=
sed on vma */
> +               unsigned long address;          /* Faulting virtual addre=
ss */
> +       };
> +
>         unsigned int flags;             /* FAULT_FLAG_xxx flags */
> -       gfp_t gfp_mask;                 /* gfp mask to be used for alloca=
tions */
> -       pgoff_t pgoff;                  /* Logical page offset based on v=
ma */
> -       unsigned long address;          /* Faulting virtual address */
>         pmd_t *pmd;                     /* Pointer to pmd entry matching
>                                          * the 'address' */
>         pud_t *pud;                     /* Pointer to pud entry matching
>
>
> Sure enough, an arm64 defconfig builds perfectly alright with that change=
,
> but it really shouldn't. I'm using clang 11.0.5, so I had another go with
> GCC 9.2.1 and bang:
>
> mm/filemap.c: In function =E2=80=98filemap_map_pages=E2=80=99:
> mm/filemap.c:2963:16: error: assignment of member =E2=80=98address=E2=80=
=99 in read-only object
>  2963 |   vmf->address +=3D (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>       |                ^~
> make[1]: *** [scripts/Makefile.build:279: mm/filemap.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1805: mm] Error 2
> make: *** Waiting for unfinished jobs....
>
> Nick -- any clue what's happening here? We would like that const anonymou=
s
> struct to behave like a const struct member, as the alternative (naming t=
he
> thing) results in a lot of refactoring churn.

Weird, looks like a bug to me in Clang, filed
https://bugs.llvm.org/show_bug.cgi?id=3D48755.
--=20
Thanks,
~Nick Desaulniers
