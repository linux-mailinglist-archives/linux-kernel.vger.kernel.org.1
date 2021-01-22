Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A75301099
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 00:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbhAVTjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbhAVT20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:28:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96EFD23AF8;
        Fri, 22 Jan 2021 19:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611343664;
        bh=kFNnYuWFfaff4kSnuH47UjTnPiizLDg/mNMwPFIhGTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bV4hOK6u/cF7GPBpwKGoWBpojgOj+ogtuxSRA5pHaf2cgRN8w8vKOvjTt3L6cvqo6
         8yIQjT+cygqZIHbw2S7Zr/c02xO7YanBfhzz9Ke0+QUIsqK/bjRPnon4LudQSN+cT4
         rFjzZhYWoRev2TlzvCrJSYHePRzVas5IAfn9/2+aekQ47wVFPYB0VIRI1u+utHH+xZ
         +Z8cFKYh77oij/MZ4v0JRvoRcDfbISDOEmjX2HIZcN5TlLyKAF3N6uwhMaWBO185UZ
         J7dkOsthQmkya7oh7RUxilvhFhQ/t4jqeE3RtwO82CuJ7NrAq4OPVUM+N0NgcfW8YS
         CUImWuXg9S/TA==
Date:   Fri, 22 Jan 2021 19:27:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
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
Subject: Re: [PATCH v4 8/8] mm: Mark anonymous struct field of 'struct
 vm_fault' as 'const'
Message-ID: <20210122192739.GC25471@willie-the-truck>
References: <20210120173612.20913-1-will@kernel.org>
 <20210120173612.20913-9-will@kernel.org>
 <CAKwvOd=B+tMi7-82Q8hEYnQ+BzkLDygOhMh6cQ2L+3SaL+F4tQ@mail.gmail.com>
 <CAHk-=wiOecmzTXoc6hbTmYdBCyhkmOpAHeMVXmJ_DEGgjPfZ5Q@mail.gmail.com>
 <20210121131101.GD22123@willie-the-truck>
 <CAKwvOdnmHH+sCqzdaAt_LYms_KULx5VpzmQZjSOy_Qyj0+hbgQ@mail.gmail.com>
 <20210121212832.GA23234@willie-the-truck>
 <CAKwvOdkYwZHdPj=UGmc2da_3iM7_EN22Vhj7vO2rJ_CAkLEPTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkYwZHdPj=UGmc2da_3iM7_EN22Vhj7vO2rJ_CAkLEPTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nick,

On Fri, Jan 22, 2021 at 11:10:50AM -0800, Nick Desaulniers wrote:
> On Thu, Jan 21, 2021 at 1:28 PM Will Deacon <will@kernel.org> wrote:
> > On Thu, Jan 21, 2021 at 11:24:36AM -0800, Nick Desaulniers wrote:
> > > On Thu, Jan 21, 2021 at 5:11 AM Will Deacon <will@kernel.org> wrote:
> > Sure, but here we are cleaning up this stuff, so I think review only gets
> > you so far. To me:
> >
> >         const struct {
> >                 int     foo;
> >                 long    bar;
> >         };
> >
> > clearly says "don't modify fields of this struct", whereas:
> >
> >         struct {
> >                 const int       foo;
> >                 const long      bar;
> >         };
> >
> > says "don't modify foo or bar, but add whatever you like on the end" and
> > that's the slippery slope.
> 
> "but you could add additional non-const members on the end" for sure.
> Though going back to
> 
> >> What's to stop a new non-const field from getting added outside the
> > > const qualified anonymous struct?
> 
> my point with that is that the const anonymous struct is within a
> non-const anonymous struct.
> 
> struct vm_fault {
>   const {
>     struct vm_area_struct *vma;
>     gfp_t gfp_mask;
>     pgoff_t pgoff;
>     unsigned long address;
>     // Your point is about new member additions here, IIUC
>   };
>   // My point: what's to stop someone from adding a new non-const member here?
>   unsigned int flags;
>   pmd_t *pmd;
>   pud_t *pud;
>   ...
>   // or here?
> };
> 
> The const anonymous struct will help prevent additions of non-const
> members to the anonymous struct, sure; but if someone really wanted a
> new non-const member in a `struct vm_fault` instance they're just
> going to go around the const anonymous struct.  Or is there something
> more I'm missing about the order of the members of struct vm_fault?

All I was trying to say is that, given a struct with a mixture of const and
non-const members, I would be less hesitant to remove 'const' from one of
the members if it helped me get something else done. Having the 'const' on
the struct itself, however, would deter me because at that point its clear
that you're not supposed to be modifying this stuff. That's the difference
between the "Your point" and "My point" lines above.

But honestly, I can't say I particularly enjoy arguing about these
idiosyncracies; I'd just rather wait for the dust to settle with clang
before we add code to deal with that outcome.

> > So then we end up with the eye-sore of:
> >
> >         const struct {
> >                 const int       foo;
> >                 const long      bar;
> >         };
> >
> > and maybe that's the right answer, but I'm just saying we should wait for
> > clang to make up its mind first. It's not like this is a functional problem,
> > and there are enough GCC users around that we're not exactly in a hurry.
> 
> Yeah, I mean I'm happy to whip something up for Clang, even though I
> suspect it will get shot down in code review until there's more
> guidance from standards bodies.  It doesn't hurt to try, and at least
> have a patch "waiting in the wings" should we hear back from WG14 that
> favors GCC's behavior.  Who knows, maybe the guidance will be that
> WG21 should revisit this behavior for C++ to avoid divergence with C
> (as g++ and gcc currently do).

I mean, a warning doesn't seem controversial to me, especially as opinions
certainly seem to be divided about what the right behaviour should be here.

Will
