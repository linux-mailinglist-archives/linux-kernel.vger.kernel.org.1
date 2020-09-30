Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1D427F51B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgI3W2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgI3W2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:28:02 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ACCC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:28:00 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z5so3994203ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkN3WnPe8Q74Bq/fxwpUdgVX4tK0nQ0EycCSxHmpFCc=;
        b=iltQRbF9ZGmvROU2UUfhSc5Lwtbxc8i7aFmLFsxPZMz4vcDQZZfI6qQPyDKVmhDWDM
         YiJ+x53+ELioQmMxs1iHvFgl9Z5UGCAhaUbX9kmaCpnLhKft0uWTDC01AupHysxVbdcd
         Y+CZfB+PbyV/xCeH1FuIugwjgPFzNYiTWQTjsJgTUSB1HiBtzLZeTzDJkvuO1AaxnxSz
         eFs0KI4T/4Cv/WdKKCabBHM7w+KNDNqR/4x9C5nVPYl5jfQzY1vKMZaYfVqAX3vzQyc3
         xkXy+OTieIwj1ZCiOwG2m9F3V+HA1LwDB3gcwFmhi8UvqucmbIUZwKzB/PHA4fy/kvpG
         OHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkN3WnPe8Q74Bq/fxwpUdgVX4tK0nQ0EycCSxHmpFCc=;
        b=avBT5k8jdUovOvRN3d6OEbBCe+UV4jXWAFtWaJOI209pPfUEED+33N4zerwzI+qopa
         2fw/ab6LlLzvEXga0POPfVYGjvnQOKZsxm91+cckgkd5T6FqOEfode3uomnNHfRWXilN
         CK5m49jrQ8X/tyEp+6J6XG/32gAxB8Mro8sVAQvnJPD7hIhUX46ZnLlN5sw74BukqRE4
         7Q8KDUmGa2MAGBis0Tgkr4Ysc9PqmZZOCtPRDVB9gzv7zc4WTAbe4OAFwRo4ECQ5fNMf
         XaWxW7glmYenv5U3QgfpN106zER2X2e9Q2UXe7Vj7+IFLRTZZuJdtreKkdSKdZUxIi/Y
         sAzw==
X-Gm-Message-State: AOAM532Qygi1ImuHiRJhlbqGPNIGlmFVv5otHBvs/P8H3TXrad1CmJWs
        9Qj8Bh9hjZu0vmO6EfK6ZVHP81zo+7eLLHo0Ola3UhMpZ7OJTA77
X-Google-Smtp-Source: ABdhPJzBNxsrt2nz+I/MkKIokvF9hK7rFYqdCRoU83A5pz3PHlgyss/IOLMeUM6A/j4dZualxzQHhQo0niv2zOO2cR4=
X-Received: by 2002:a92:cbcd:: with SMTP id s13mr84761ilq.306.1601504879965;
 Wed, 30 Sep 2020 15:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com> <20200925212302.3979661-21-bgardon@google.com>
 <20200930181556.GJ32672@linux.intel.com>
In-Reply-To: <20200930181556.GJ32672@linux.intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 30 Sep 2020 15:27:48 -0700
Message-ID: <CANgfPd-A0gvBxpjYo3L5vZcv6xaxG92zkBUiLJA8ddJ+B5NJuA@mail.gmail.com>
Subject: Re: [PATCH 20/22] kvm: mmu: NX largepage recovery for TDP MMU
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:16 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Sep 25, 2020 at 02:23:00PM -0700, Ben Gardon wrote:
> > +/*
> > + * Clear non-leaf SPTEs and free the page tables they point to, if those SPTEs
> > + * exist in order to allow execute access on a region that would otherwise be
> > + * mapped as a large page.
> > + */
> > +void kvm_tdp_mmu_recover_nx_lpages(struct kvm *kvm)
> > +{
> > +     struct kvm_mmu_page *sp;
> > +     bool flush;
> > +     int rcu_idx;
> > +     unsigned int ratio;
> > +     ulong to_zap;
> > +     u64 old_spte;
> > +
> > +     rcu_idx = srcu_read_lock(&kvm->srcu);
> > +     spin_lock(&kvm->mmu_lock);
> > +
> > +     ratio = READ_ONCE(nx_huge_pages_recovery_ratio);
> > +     to_zap = ratio ? DIV_ROUND_UP(kvm->stat.nx_lpage_splits, ratio) : 0;
>
> This is broken, and possibly related to Paolo's INIT_LIST_HEAD issue.  The TDP
> MMU never increments nx_lpage_splits, it instead has its own counter,
> tdp_mmu_lpage_disallowed_page_count.  Unless I'm missing something, to_zap is
> guaranteed to be zero and thus this is completely untested.

Good catch, I should write some NX reclaim selftests.

>
> I don't see any reason for a separate tdp_mmu_lpage_disallowed_page_count,
> a single VM can't have both a legacy MMU and a TDP MMU, so it's not like there
> will be collisions with other code incrementing nx_lpage_splits.   And the TDP
> MMU should be updating stats anyways.

A VM actually can have both the legacy MMU and TDP MMU, by design. The
legacy MMU handles nested. Eventually I'd like the TDP MMU to be
responsible for building nested shadow TDP tables, but haven't
implemented it.

>
> > +
> > +     while (to_zap &&
> > +            !list_empty(&kvm->arch.tdp_mmu_lpage_disallowed_pages)) {
> > +             /*
> > +              * We use a separate list instead of just using active_mmu_pages
> > +              * because the number of lpage_disallowed pages is expected to
> > +              * be relatively small compared to the total.
> > +              */
> > +             sp = list_first_entry(&kvm->arch.tdp_mmu_lpage_disallowed_pages,
> > +                                   struct kvm_mmu_page,
> > +                                   lpage_disallowed_link);
> > +
> > +             old_spte = *sp->parent_sptep;
> > +             *sp->parent_sptep = 0;
> > +
> > +             list_del(&sp->lpage_disallowed_link);
> > +             kvm->arch.tdp_mmu_lpage_disallowed_page_count--;
> > +
> > +             handle_changed_spte(kvm, kvm_mmu_page_as_id(sp), sp->gfn,
> > +                                 old_spte, 0, sp->role.level + 1);
> > +
> > +             flush = true;
> > +
> > +             if (!--to_zap || need_resched() ||
> > +                 spin_needbreak(&kvm->mmu_lock)) {
> > +                     flush = false;
> > +                     kvm_flush_remote_tlbs(kvm);
> > +                     if (to_zap)
> > +                             cond_resched_lock(&kvm->mmu_lock);
> > +             }
> > +     }
> > +
> > +     if (flush)
> > +             kvm_flush_remote_tlbs(kvm);
> > +
> > +     spin_unlock(&kvm->mmu_lock);
> > +     srcu_read_unlock(&kvm->srcu, rcu_idx);
> > +}
> > +
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
> > index 2ecb047211a6d..45ea2d44545db 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.h
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.h
> > @@ -43,4 +43,6 @@ void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
> >
> >  bool kvm_tdp_mmu_write_protect_gfn(struct kvm *kvm,
> >                                  struct kvm_memory_slot *slot, gfn_t gfn);
> > +
> > +void kvm_tdp_mmu_recover_nx_lpages(struct kvm *kvm);
> >  #endif /* __KVM_X86_MMU_TDP_MMU_H */
> > --
> > 2.28.0.709.gb0816b6eb0-goog
> >
