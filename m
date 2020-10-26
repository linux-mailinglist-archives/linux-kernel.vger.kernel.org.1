Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90EB299C71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437131AbgJZX6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437084AbgJZX6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:58:40 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88F2D2087C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756719;
        bh=uLnVjN+bYvNodXPMnfZTZnXM5m0PwYS9okq64LRETLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RRO3TzgdvpmKVD3bbCDkGZZSR1+Fm8OK5aueWvEPYKjc7d8a93MtphTmsqbvyTiDV
         vFafi3oaHWEo+2qejFic18T+MDKTHSgZ5hWamXYCb2fVZsL+8d4q6JlAmQzfeoEiMv
         i3ZtXn1kgq7xiQy4KNuv/PVAp7RliU3VNVBzODwI=
Received: by mail-lj1-f173.google.com with SMTP id m16so12549720ljo.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:58:39 -0700 (PDT)
X-Gm-Message-State: AOAM531SEipI+OqsPXl+ZWvktHxWNg2u4VgTCGdA5XkArHZ/nYYAF/HB
        59Iju+mPR7BGl50GnOJWJ6bJTFaTAtYkyJXK5br7dQ==
X-Google-Smtp-Source: ABdhPJwmJw2aLpySxeErc3LeZpMLqKpmzVGi3onJZb+wqiiUEro4x2ppyNy4SmMvqM3k0DIOULzz/xDwNF+C9355huA=
X-Received: by 2002:a5d:6744:: with SMTP id l4mr20569606wrw.18.1603756716752;
 Mon, 26 Oct 2020 16:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201020061859.18385-1-kirill.shutemov@linux.intel.com>
 <CALCETrXn_ghtLK34jmKSSp5_SF6hh5GOfBLKdxXgp5ZTbN8uEA@mail.gmail.com> <20201026152910.happu7wic4qjxmp7@box>
In-Reply-To: <20201026152910.happu7wic4qjxmp7@box>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 26 Oct 2020 16:58:16 -0700
X-Gmail-Original-Message-ID: <CALCETrVmW7Xsh+GVfHAV_a7Ro1eySqH4_a-vbmYQb_Z5mykMsA@mail.gmail.com>
Message-ID: <CALCETrVmW7Xsh+GVfHAV_a7Ro1eySqH4_a-vbmYQb_Z5mykMsA@mail.gmail.com>
Subject: Re: [RFCv2 00/16] KVM protected memory extension
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 8:29 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Wed, Oct 21, 2020 at 11:20:56AM -0700, Andy Lutomirski wrote:
> > > On Oct 19, 2020, at 11:19 PM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > > For removing the userspace mapping, use a trick similar to what NUMA
> > > balancing does: convert memory that belongs to KVM memory slots to
> > > PROT_NONE: all existing entries converted to PROT_NONE with mprotect() and
> > > the newly faulted in pages get PROT_NONE from the updated vm_page_prot.
> > > The new VMA flag -- VM_KVM_PROTECTED -- indicates that the pages in the
> > > VMA must be treated in a special way in the GUP and fault paths. The flag
> > > allows GUP to return the page even though it is mapped with PROT_NONE, but
> > > only if the new GUP flag -- FOLL_KVM -- is specified. Any userspace access
> > > to the memory would result in SIGBUS. Any GUP access without FOLL_KVM
> > > would result in -EFAULT.
> > >
> >
> > I definitely like the direction this patchset is going in, and I think
> > that allowing KVM guests to have memory that is inaccessible to QEMU
> > is a great idea.
> >
> > I do wonder, though: do we really want to do this with these PROT_NONE
> > tricks, or should we actually come up with a way to have KVM guest map
> > memory that isn't mapped into QEMU's mm_struct at all?  As an example
> > of the latter, I mean something a bit like this:
> >
> > https://lkml.kernel.org/r/CALCETrUSUp_7svg8EHNTk3nQ0x9sdzMCU=h8G-Sy6=SODq5GHg@mail.gmail.com
> >
> > I don't mean to say that this is a requirement of any kind of
> > protected memory like this, but I do think we should understand the
> > tradeoffs, in terms of what a full implementation looks like, the
> > effort and time frames involved, and the maintenance burden of
> > supporting whatever gets merged going forward.
>
> I considered the PROT_NONE trick neat. Complete removing of the mapping
> from QEMU would require more changes into KVM and I'm not really familiar
> with it.

I think it's neat.  The big tradeoff I'm concerned about is that it
will likely become ABI once it lands.  That is, if this series lands,
then we will always have to support the case in which QEMU has a
special non-present mapping that is nonetheless reflected as present
in a guest.  This is a bizarre state of affairs, it may become
obsolete if a better API ever shows up, and it might end up placing
constraints on the Linux VM that we don't love going forward.

I don't think my proposal in the referenced thread above is that crazy
or that difficult to implement.  The basic idea is to have a way to
create an mm_struct that is not loaded in CR3 anywhere.  Instead, KVM
will reference it, much as it currently references QEMU's mm_struct,
to mirror mappings into the guest.  This means it would be safe to
have "protected" memory mapped into the special mm_struct because
nothing other than KVM will ever reference the PTEs.  But I think that
someone who really understands the KVM memory mapping code should
chime in.

>
> About tradeoffs: the trick interferes with AutoNUMA. I didn't put much
> thought into how we can get it work together. Need to look into it.
>
> Do you see other tradeoffs?
>
> --
>  Kirill A. Shutemov
