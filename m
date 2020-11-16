Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA442B4C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgKPRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgKPRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:18:56 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:18:55 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n129so18196139iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TGTIGhjMQCzdRC1qL+Tjn0zwFlpwC81CuIBiUlB138=;
        b=rIgrQq9mueQo4weL/7e43IKH29YmODpAX0sFAUnVfHmNmikiqZLDbv7eAVmE2lS6rw
         yXgu5nb8NNVT1QYSyz/w2eXNdTH/lsQDfUkfjkGHEe96BQzK5b71qUzS6FQYnSdl8ZTG
         f2UnhsqXScG5I9KusBWpeffSnflQxl8zYAtYsfoYQhPJpHj2ZFOlw4mmM67if0pCHzYv
         bN8kVdulQZ94zme4N3VNx2IjaAAVa9OwQleWJ0I1Sm55JTtSC9/hwgNsmM0l7l2htXX2
         rV05V8A+UfmWcDvfJLZM0VIFWNYNU6VtiYQ/lEGo3XK9UY0g+qlZaqRjvnsx+5vR9bur
         avyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TGTIGhjMQCzdRC1qL+Tjn0zwFlpwC81CuIBiUlB138=;
        b=QrsieOkGw7vTPOnaXqNbrlBLn5vF6GjocIeTN+mxQK2KczQCKx70MFsKgRhDCSkBbl
         eN7ns+HCE43H64DkaDD5vtglbJJtMckPryIUIe6ikFkeo1Xa6QUIdSdW0ARVse/9PmFr
         I3IvgONvT3PKxwLhR44cajg1W8nqXsDCHC5B1PMufoPXgt/27sq4dBf07N2g0vvBETrb
         VDmPC1wTtkyf0RIUqhIZ7gF87Vb3hqmlMe3HkaRIGQtemlMvvffyN82xoiW8VV6GQEbk
         DmUxqwqNzdLyzzysvrcyJX40u/9t/nWDy4XdJ1QUeQ0uEKFLikB/BzQdBPRzhuyGKndV
         rcZQ==
X-Gm-Message-State: AOAM531nEzTVIS4hnRpR6hHZ2dKY5u9sB2eEraT3RvObVN9V4G8Q85Xr
        V6Hg+5jEUE1LOhQ3Qdo8PeoA2Ys6t+umnzMYde/oqg==
X-Google-Smtp-Source: ABdhPJxGPQFt1yPt1OHZpYJ/vlQAWO1ufdYwaeUlzc84ydCZXaTNgaaYFY4tKZJb+j0j3bu8p7PgRjz/bHiSOG/bu5w=
X-Received: by 2002:a02:cd15:: with SMTP id g21mr425945jaq.25.1605547134406;
 Mon, 16 Nov 2020 09:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20201111185337.1237383-1-bgardon@google.com> <6c4a78e8-8237-b604-d047-b1ea010cf655@redhat.com>
In-Reply-To: <6c4a78e8-8237-b604-d047-b1ea010cf655@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 16 Nov 2020 09:18:43 -0800
Message-ID: <CANgfPd_TWSostyT_Xjaew7yn1aC0f-L+4Wi1vEF43VbVj4te-g@mail.gmail.com>
Subject: Re: [PATCH] kvm: x86/mmu: Fix is_tdp_mmu_check when using PAE
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Jim Mattson <jmattson@google.com>,
        Zdenek Kaspar <zkaspar82@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:58 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/11/20 19:53, Ben Gardon wrote:
> > When PAE is in use, the root_hpa will not have a shadow page assoicated
> > with it. In this case the kernel will crash with a NULL pointer
> > dereference. Add checks to ensure is_tdp_mmu_root works as intended even
> > when using PAE.
> >
> > Tested: compiles
> >
> > Fixes: 02c00b3a2f7e ("kvm: x86/mmu: Allocate and free TDP MMU roots")
> > Reported-by: Zdenek Kaspar <zkaspar82@gmail.com>
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >   arch/x86/kvm/mmu/tdp_mmu.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 27e381c9da6c..13013f4d98ad 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -49,8 +49,18 @@ bool is_tdp_mmu_root(struct kvm *kvm, hpa_t hpa)
> >   {
> >       struct kvm_mmu_page *sp;
> >
> > +     if (WARN_ON(!VALID_PAGE(hpa)))
> > +             return false;
> > +
> >       sp = to_shadow_page(hpa);
> >
> > +     /*
> > +      * If this VM is being run with PAE, the TDP MMU will not be enabled
> > +      * and the root HPA will not have a shadow page associated with it.
> > +      */
> > +     if (!sp)
> > +             return false;
> > +
> >       return sp->tdp_mmu_page && sp->root_count;
> >   }
> >
> >
>
> If this was just PAE, it would be easier to test "if (shadow_root_level
>  >= PT64_ROOT_4LEVEL)"---and more correct too, because using the
> page_private of __pa(vcpu->arch.mmu->pae_root) is a bit untidy; we
> should only use page_private for pages that we know have a shadow page.
>
> In Jamie's case however, it is x86_64 (so kvm_mmu_get_tdp_level(vcpu) ==
> 4 and therefore the "if (shadow_root_level >= PT64_ROOT_4LEVEL)" would
> be true) but without EPT.  In that case we go through
>
>         vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->lm_root);
>
> but lm_root is allocated with get_zeroed_page and therefore
> to_shadow_page is NULL.
>
> I am thinking of testing simply "if (tdp_enabled)" so that we can see if
> there are other cases with to_shadow_page(hpa) == NULL and we don't
> sweep them under the rug.  Or test "if (tdp_enabled)" and also WARN if
> !sp.  What do you think?

That sounds good to me. I see you already mailed out a modified
version of this change, so I'll go review it.
Thanks!

>
> Paolo
>
