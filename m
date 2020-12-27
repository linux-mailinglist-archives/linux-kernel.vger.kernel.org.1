Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00E72E3323
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 23:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL0Wge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 17:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgL0Wge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 17:36:34 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E15C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 14:35:53 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 15so9928273oix.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 14:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fQaoGT1WsKurEcZ5FPrA2PwI+HJqjlmSQJREU5hdQWY=;
        b=Gt7nVgz64MDl4wbhJV2vv6JBpCJRURLqX5L6sYykirX4mfVoB676sz7tJyNaLA1UIU
         Y8zbODc434zb2EI15wm4ss3czRAAkrKckOxsqUwMfhqqB8KEtA9SCzdeo/5g421FFzld
         ZDIua8b3N8wsBB+9Aihlyn3HRq8cVNwfhn2FYDnQhgiS2BbQRl8KVbDspthojeH35tBb
         kN0tFaU9frv6tK6wSVceyenH6bPYtKtXFR/RggVd2wG6ckLk5heTzq8H76Ww7in9Wxil
         7+gYOflRN09msy6hfp9dnON2/rrPUtlnJkWgwdKaYQeroL94FwRPbZz5wAu2YdNjFxEb
         afQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fQaoGT1WsKurEcZ5FPrA2PwI+HJqjlmSQJREU5hdQWY=;
        b=jTjsJF7pV0LxWxju7gO/Lp4QgKHImq3CJjVix0xzuUNjoruZHUkRh0gcGfWcs1BDMY
         Vic/jyASf8c5XXTWd27U3PrmLHk0IColvylSqEK8ZvvMkciw5FZQlu9r0KOG0uPFi6E5
         1i7PPHCv61B1qykncVf1od2r4ijiey6regEY104icD7xCtp40xqnYhCCwKKR7bPK5QI8
         zP/Li9+1EytfscZLo8wBBzv93KtUOKtFXPRTpVjCv0BXkOQtbnfxkk1E0gLHKfkrnFX0
         gQYlJXXZhiFiet6OXH/xys5bCHuURRazRsCgGCO8c/WUxLgeV2nW8SqydVpkcQljXBxl
         ShlQ==
X-Gm-Message-State: AOAM53111Pw8HqY9NCILMMtPH22EO8uagKJI3mf6YCw1le27hl1Rxm+X
        rhwrMhxiv8MbjgRVQjvWrjchKg==
X-Google-Smtp-Source: ABdhPJyajmApFjlhCnz6/OC/AztgA380FMJdDzgi1exKgbUHJLGQ5ogHrqstpjRxBaO45jME0v5kXQ==
X-Received: by 2002:aca:578d:: with SMTP id l135mr10391114oib.105.1609108552617;
        Sun, 27 Dec 2020 14:35:52 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 59sm8820295oti.69.2020.12.27.14.35.49
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 27 Dec 2020 14:35:51 -0800 (PST)
Date:   Sun, 27 Dec 2020 14:35:32 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Damian Tometzki <linux@tometzki.de>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
In-Reply-To: <X+jvZchuTptrxkCH@fedora.tometzki.de>
Message-ID: <alpine.LSU.2.11.2012271418460.1091@eggly.anvils>
References: <alpine.LSU.2.11.2012231905300.5723@eggly.anvils> <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com> <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com> <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils> <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <X+jvZchuTptrxkCH@fedora.tometzki.de>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1843390995-1609108551=:1091"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1843390995-1609108551=:1091
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 27 Dec 2020, Damian Tometzki wrote:
> On Sun, 27. Dec 11:38, Linus Torvalds wrote:
> > On Sat, Dec 26, 2020 at 6:38 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > This patch (like its antecedents) moves the pte_unmap_unlock() from
> > > after do_fault_around()'s "check if the page fault is solved" into
> > > filemap_map_pages() itself (which apparently does not NULLify vmf->pt=
e
> > > after unmapping it, which is poor, but good for revealing this issue)=
=2E
> > > That looks cleaner, but of course there was a very good reason for it=
s
> > > original positioning.
> >=20
> > Good catch.
> >=20
> > > Maybe you want to change the ->map_pages prototype, to pass down the
> > > requested address too, so that it can report whether the requested
> > > address was resolved or not.  Or it could be left to __do_fault(),
> > > or even to a repeated fault; but those would be less efficient.
> >=20
> > Let's keep the old really odd "let's unlock in the caller" for now,
> > and minimize the changes.
> >=20
> > Adding a big big comment at the end of filemap_map_pages() to note the
> > odd delayed page table unlocking.
> >=20
> > Here's an updated patch that combines Kirill's original patch, his
> > additional incremental patch, and the fix for the pte lock oddity into
> > one thing.
> >=20
> > Does this finally pass your testing?

Yes, this one passes my testing on x86_64 and on i386.  But...

> >=20
> >                Linus
> Hello together,
>=20
> when i try to build this patch, i got the following error:
>=20
>  CC      arch/x86/kernel/cpu/mce/threshold.o
> mm/memory.c:3716:19: error: static declaration of =E2=80=98do_set_pmd=E2=
=80=99 follows non-static declaration
>  static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>                    ^~~~~~~~~~
> In file included from mm/memory.c:43:
> ./include/linux/mm.h:984:12: note: previous declaration of =E2=80=98do_se=
t_pmd=E2=80=99 was here
>  vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
>             ^~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:279: mm/memory.o] Error 1
> make[2]: *** [Makefile:1805: mm] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      arch/x86/kernel/cpu/mce/therm_throt.o

=2E.. Damian very helpfully reports that it does not build when
CONFIG_TRANSPARENT_HUGEPAGE is not set, since the "static " has
not been removed from the alternative definition of do_set_pmd().

And its BUILD_BUG() becomes invalid once it's globally available.
You don't like unnecessary BUG()s, and I don't like returning
success there: VM_FAULT_FALLBACK seems best.

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3713,10 +3713,9 @@ out:
 =09return ret;
 }
 #else
-static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 {
-=09BUILD_BUG();
-=09return 0;
+=09return VM_FAULT_FALLBACK;
 }
 #endif
=20

(I'm also a wee bit worried by filemap.c's +#include <asm/pgalloc.h>:
that's the kind of thing that might turn out not to work on some arch.)

Hugh
--0-1843390995-1609108551=:1091--
