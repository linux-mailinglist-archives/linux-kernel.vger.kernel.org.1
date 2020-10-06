Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3732854A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgJFWfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgJFWfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:35:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDAC0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 15:35:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g7so181472iov.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swHb/KR/ZWp6i2rbsmi7Thg0YMjjYF8TV8HVF7qu0sI=;
        b=RPmCEgOgY2e63BA92hfU543iiUc4nOFxZjZgWswSWW5Zl053YNAOb4JqEQZ0Tw3nIh
         FDwiB5NTupvmRf7pBHuqAb8KroEmqOx9ebKKq1nYfW5T9qIm7gUKATt/G5R9Hx7+xObT
         S8ol3nj1pjrymArRfKVK1gysBNOSFRv/TUAjXPR/NstVX+cIss8xRuZ/AcoHoQryfn0w
         p+GeSeA/pHYtvS0BYIEuUDirs947eJ9TqbPYX28IxgE6Yq/DrE6vqS9R2ieotCpohIc7
         88oOVhEEWrJIeWTp248NzDbbrI6pqXowouvdNJFrjLVEpZGh0f9TxH329DO7/l4CvoPf
         r2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swHb/KR/ZWp6i2rbsmi7Thg0YMjjYF8TV8HVF7qu0sI=;
        b=Kf5W5Fq/4qdyR0oPTMZVWtyaivDyWtnH0cuR1QZzEnYrlytEd29s2myg3iMqHjL/6z
         VHQbwt1sdc5kq5jSQ6/LYBI9fKCoX7lwO8bTeDXvQRAl/cmuVsqkwZZ4BcNOtZV8rFSD
         LsPV0s8UazTBHZNRXvczOVuYDEPslSTtm3Y0ldOpJFCbWXJxd3ftAJO7J7cz1LIlTKhk
         We35RmCHUB05TvPtWWHvkhQCNgAB8EkjqCaaGCBdPF6whnfW6L1qmrNnCGtqNG2Xh+Uc
         qExpTGIoGR3QYswzArwBFMrsMbs/H7MzLP4kt4O1RZG2NyXHXPsQ0JN70EJPTtucv8QD
         e6rg==
X-Gm-Message-State: AOAM532GwJuavbhG69tZY60nLkX77adSfAQ3ZNQeqh6Bl4wqu7qHZiXN
        HA1kCVdbycO0HKdlLIB15rzt6kg5QSVBdi0+lmctCg==
X-Google-Smtp-Source: ABdhPJzZtsfzLJ0PBRXSodzK0OLo+z1vC92GbQNipRPOl4l5FLb+2JtH9bJpv0BdtZIUy2Apw91mZ90yM7gFQ/uHZKs=
X-Received: by 2002:a6b:1646:: with SMTP id 67mr25486iow.189.1602023719577;
 Tue, 06 Oct 2020 15:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com> <20200925212302.3979661-11-bgardon@google.com>
 <20200930163740.GD32672@linux.intel.com> <b123d506-fa33-db3f-1166-4b0ec1d6dc1e@redhat.com>
In-Reply-To: <b123d506-fa33-db3f-1166-4b0ec1d6dc1e@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 6 Oct 2020 15:35:08 -0700
Message-ID: <CANgfPd9LmFfZisR3oXKZ7xSeTRi7GyDr+VWf0dE9U4y6_icmTA@mail.gmail.com>
Subject: Re: [PATCH 10/22] kvm: mmu: Add TDP MMU PF handler
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
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

On Wed, Sep 30, 2020 at 10:38 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 30/09/20 18:37, Sean Christopherson wrote:
> >> +    ret = page_fault_handle_target_level(vcpu, write, map_writable,
> >> +                                         as_id, &iter, pfn, prefault);
> >> +
> >> +    /* If emulating, flush this vcpu's TLB. */
> > Why?  It's obvious _what_ the code is doing, the comment should explain _why_.
> >
> >> +    if (ret == RET_PF_EMULATE)
> >> +            kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> >> +
> >> +    return ret;
> >> +}
>
> In particular it seems to be only needed in this case...
>
> +       /*
> +        * If the page fault was caused by a write but the page is write
> +        * protected, emulation is needed. If the emulation was skipped,
> +        * the vCPU would have the same fault again.
> +        */
> +       if ((make_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) && write)
> +               ret = RET_PF_EMULATE;
> +
>
> ... corresponding to this code in mmu.c
>
>         if (set_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) {
>                 if (write_fault)
>                         ret = RET_PF_EMULATE;
>                 kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
>         }
>
> So it should indeed be better to make the code in
> page_fault_handle_target_level look the same as mmu/mmu.c.

That's an excellent point. I've made an effort to make them more
similar. I think this difference arose from the synchronization
changes I was working back from, but this will be much more elegant in
either case.

>
> Paolo
>
