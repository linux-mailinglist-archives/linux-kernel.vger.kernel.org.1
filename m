Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF212F6B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbhANTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:42:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbhANTmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:42:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3987F239EF;
        Thu, 14 Jan 2021 19:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610653295;
        bh=j72ES8sG143mJE4qoXOz2HxLviBlz2SE24DDEx8XP0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTupvysEJQdFamE1YxFEmpRUIuOtDSMco9l+VnAqtDreicebY/e5TFTBV9T5lPwJ+
         6W98Bz9ewmb/e7mc6z4cmTGMvJcALkWW4pn/lVbGNshU51fDceDJu4+NDs5qAvnbAe
         8Q5ISSNEjsp8luCkE7n0yHHwg/NVITpnY62NAYheMibO6W3ZZZpOaJ1q/a2GO5hiMI
         OtadQ5JviuBgoZEv46qUSwHKJtrMv4lr9Roo1oP/94omk3v5kzX5ks27TPQg3anIkz
         aflwvl5gc9Ezt6aWY2gqecU5AmLW5R2yS+PCkuE//tZGOHmaq5EKszKubPvzUJcJTj
         PV2DQLD3R1zxg==
Date:   Thu, 14 Jan 2021 19:41:29 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        ndesaulniers@google.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
Message-ID: <20210114194129.GA13314@willie-the-truck>
References: <20210114175934.13070-1-will@kernel.org>
 <20210114175934.13070-5-will@kernel.org>
 <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
 <20210114190021.GB13135@willie-the-truck>
 <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjdJmL22+zk3_rWAfEJJCf=oDxiJ530qk-WNk_Ji0qhxw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 11:09:01AM -0800, Linus Torvalds wrote:
> On Thu, Jan 14, 2021 at 11:00 AM Will Deacon <will@kernel.org> wrote:
> >
> > I tried that initially, but I found that I had to make all of the
> > members const to get it to work, at which point the anonymous struct
> > wasn't really adding anything. Did I just botch the syntax?
> 
> I'm not sure what you tried. But this stupid test-case sure works for me:
> 
>     struct hello {
>         const struct {
>                 unsigned long address;
>         };
>         unsigned int flags;
>     };
> 
>     extern int fn(struct hello *);
> 
>     int test(void)
>     {
>         struct hello a = {
>                 .address = 1,
>         };
>         a.flags = 0;
>         return fn(&a);
>     }
> 
> and because "address" is in that unnamed constant struct, you can only
> set it within that initializer, and cannot do
> 
>         a.address = 0;
> 
> without an error (the way you _can_ do "a.flags = 0").
> 
> I don't see naming the struct making a difference - apart from forcing
> that big rename patch, of course.
> 
> But maybe we're talking about different issues?

Urgh...

We _are_ both on the same page, and your reply above had me thinking I've
lost the plot, so I went back to the start. Check out v5.11-rc3 and apply
this patch:


diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..1eb950865450 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -514,11 +514,14 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
  * pgoff should be used in favour of virtual_address, if possible.
  */
 struct vm_fault {
-       struct vm_area_struct *vma;     /* Target VMA */
+       const struct {
+               struct vm_area_struct *vma;     /* Target VMA */
+               gfp_t gfp_mask;                 /* gfp mask to be used for allocations */
+               pgoff_t pgoff;                  /* Logical page offset based on vma */
+               unsigned long address;          /* Faulting virtual address */
+       };
+
        unsigned int flags;             /* FAULT_FLAG_xxx flags */
-       gfp_t gfp_mask;                 /* gfp mask to be used for allocations */
-       pgoff_t pgoff;                  /* Logical page offset based on vma */
-       unsigned long address;          /* Faulting virtual address */
        pmd_t *pmd;                     /* Pointer to pmd entry matching
                                         * the 'address' */
        pud_t *pud;                     /* Pointer to pud entry matching


Sure enough, an arm64 defconfig builds perfectly alright with that change,
but it really shouldn't. I'm using clang 11.0.5, so I had another go with
GCC 9.2.1 and bang:

mm/filemap.c: In function ‘filemap_map_pages’:
mm/filemap.c:2963:16: error: assignment of member ‘address’ in read-only object
 2963 |   vmf->address += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
      |                ^~
make[1]: *** [scripts/Makefile.build:279: mm/filemap.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1805: mm] Error 2
make: *** Waiting for unfinished jobs....

Nick -- any clue what's happening here? We would like that const anonymous
struct to behave like a const struct member, as the alternative (naming the
thing) results in a lot of refactoring churn.

Cheers,

Will
