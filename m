Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B422300C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbhAVTNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbhAVTLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:11:43 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3108CC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 11:11:02 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g15so4519086pjd.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2ZB3udNCNHbkRemCu0DDwTLSpUFiqLQJxKRr0v+cOo=;
        b=ses9w6o7aiBd7blGwonVHgFbhSzEl6eTcbM/L+9Qtyi6O/vbP2jN12jBcn5McioGmO
         rwbdjfEhfPbSJRRPNUHCJ4P2cc85qzX0CJ370UxGejFEJQ22OMfOuTbvazPGhLkqnvnq
         +5o9Tadz2rAADWu/Fsu0veqlNRKXgXe8mF/yPY5uS177uSmgh9I9Ry3zUZ3uaH7vHCu1
         UCr69z53p8Vq1/Vej4su1g7pVBYeFMBa5wE68fwZdsEF/D5avzzf1wdGE1xNIpQxZXfH
         grmjueZLtivFR9L+oamWPaCcphjm84vm/vdCJlJLuLFLrkR22yEk/s8Mme3wots37Yti
         spDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2ZB3udNCNHbkRemCu0DDwTLSpUFiqLQJxKRr0v+cOo=;
        b=CE8UoHOqax4psnRelr3vhQxryp9FolzKcZFGtJRaZrs0TIXODUPRR9Cvf4VQ5BSsmu
         BFUGO2XIWetMl6Hs4L/VTV0Ri8TbKsv/6tWI0RBSnt/FnVVBZK6dyoiYKE+Oa/KOJXFF
         UXtF6UMj7R7RDqg+8ls6WEbjpub/C9jCO/yENzBkPYytRbbYS/zk1OJwvb3l05CdRCPS
         g0SO2D5E/BG1e8P27BCLQ9e82EX1vvM5ghSb+3SeQJGmxexjx46lC7RaRPDXse8GGc1S
         XUq1uKjISljmmrG9laTMSDsHBM2dm6y2DUt8ha6c7w0yQRQHFMrpoBgr2ov2Qs5YBPy3
         M/7A==
X-Gm-Message-State: AOAM530K3F7DMIYayKua5E5BNAOJEPa9dUIg2B5v+6cNycSEe41ESZQJ
        set1g04xiB7u/9bzbiA5bl36DYi4AsUa94lPg1GBDv/+0bND6A==
X-Google-Smtp-Source: ABdhPJzamJj7j9mtm+zwf/YTjuFIE6wBidb5TwLHbw7zfJYraZgGdvFI1QBxklpX5PAgO681Pq9f1DYgF9PZUe93Yak=
X-Received: by 2002:a17:90a:31c3:: with SMTP id j3mr6947403pjf.25.1611342661472;
 Fri, 22 Jan 2021 11:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20210120173612.20913-1-will@kernel.org> <20210120173612.20913-9-will@kernel.org>
 <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
 <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com>
 <20210121131101.GD22123@willie-the-truck> <CAKwvOdnmHH+sCqzdaAt_LYms_KULx5VpzmQZjSOy_Qyj0+hbgQ@mail.gmail.com>
 <20210121212832.GA23234@willie-the-truck>
In-Reply-To: <20210121212832.GA23234@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 22 Jan 2021 11:10:50 -0800
Message-ID: <CAKwvOdkYwZHdPj=UGmc2da_3iM7_EN22Vhj7vO2rJ_CAkLEPTg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] mm: Mark anonymous struct field of 'struct
 vm_fault' as 'const'
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 1:28 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jan 21, 2021 at 11:24:36AM -0800, Nick Desaulniers wrote:
> > On Thu, Jan 21, 2021 at 5:11 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Wed, Jan 20, 2021 at 11:02:06AM -0800, Linus Torvalds wrote:
> > > > On Wed, Jan 20, 2021 at 10:27 AM Nick Desaulniers
> > > > <ndesaulniers@google.com> wrote:
> > > > >
> > > > > Is there a difference between: [ const unnamed struct and individual const members ]
> > > >
> > > > Semantically? No.
> > > >
> > > > Syntactically the "group the const members together" is a lot cleaner,
> > > > imho. Not just from a "just a single const" standpoint, but from a
> > > > "code as documentation" standpoint.
> > > >
> > > > But I guess to avoid the clang issue, we could do the "mark individual
> > > > fields" thing.
> > >
> > > I'd prefer to wait until the bug against LLVM has been resolved before we
> > > try to work around anything. Although I couldn't find any other examples
> > > like this in the kernel, requiring all of the member fields to be marked as
> > > 'const' still feels pretty fragile to me; it's only a matter of time before
> > > new non-const fields get added, at which point the temptation for developers
> > > to remove 'const' from other fields when it gets in the way is pretty high.
> >
> > What's to stop a new non-const field from getting added outside the
> > const qualified anonymous struct?
> > What's to stop someone from removing const from the anonymous struct?
> > What's to stop a number of callers from manipulating the structure
> > temporarily before restoring it when returning by casting away the
> > const?
> >
> > Code review.
>
> Sure, but here we are cleaning up this stuff, so I think review only gets
> you so far. To me:
>
>         const struct {
>                 int     foo;
>                 long    bar;
>         };
>
> clearly says "don't modify fields of this struct", whereas:
>
>         struct {
>                 const int       foo;
>                 const long      bar;
>         };
>
> says "don't modify foo or bar, but add whatever you like on the end" and
> that's the slippery slope.

"but you could add additional non-const members on the end" for sure.
Though going back to

>> What's to stop a new non-const field from getting added outside the
> > const qualified anonymous struct?

my point with that is that the const anonymous struct is within a
non-const anonymous struct.

struct vm_fault {
  const {
    struct vm_area_struct *vma;
    gfp_t gfp_mask;
    pgoff_t pgoff;
    unsigned long address;
    // Your point is about new member additions here, IIUC
  };
  // My point: what's to stop someone from adding a new non-const member here?
  unsigned int flags;
  pmd_t *pmd;
  pud_t *pud;
  ...
  // or here?
};

The const anonymous struct will help prevent additions of non-const
members to the anonymous struct, sure; but if someone really wanted a
new non-const member in a `struct vm_fault` instance they're just
going to go around the const anonymous struct.  Or is there something
more I'm missing about the order of the members of struct vm_fault?

> So then we end up with the eye-sore of:
>
>         const struct {
>                 const int       foo;
>                 const long      bar;
>         };
>
> and maybe that's the right answer, but I'm just saying we should wait for
> clang to make up its mind first. It's not like this is a functional problem,
> and there are enough GCC users around that we're not exactly in a hurry.

Yeah, I mean I'm happy to whip something up for Clang, even though I
suspect it will get shot down in code review until there's more
guidance from standards bodies.  It doesn't hurt to try, and at least
have a patch "waiting in the wings" should we hear back from WG14 that
favors GCC's behavior.  Who knows, maybe the guidance will be that
WG21 should revisit this behavior for C++ to avoid divergence with C
(as g++ and gcc currently do).
-- 
Thanks,
~Nick Desaulniers
