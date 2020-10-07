Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966352865E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgJGR2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgJGR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:28:41 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B61C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 10:28:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u6so3191115iow.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gzog+3s7evIu2Oc1rtwTUl+9x6mD7V8+jB/FerDJf6g=;
        b=nX/4Q/YGjmebBLp4gLg8J2yprcJQilHAS6qA1FHs5eLbDhe6iwzEYvpmsJs/PP94Kp
         GCzwHPrwqADg8+WqzbUbeFeB4eX4KHZvo0buxluUokPbtybLhx8dhFMWlcQAd4CKe10t
         26nG5444aSaobp5nO22ausRmcHQy//aglJ0fRKo9ARJvEW1Yrw8Ky7WccdZpsJuYm3e/
         xQS3dc0ny8dD/YDLaIBmKmsuC02TSE/s94jTazNbKJ4VAxjuvrFEJSzCQ/Eg9TGtG3ES
         0m7EI+PaTupmbB5L+0UtEw9R9srPbyfyOmGMXNBfZhOTPadOU/ZYwAIGwrkLzEgvL1mu
         hmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gzog+3s7evIu2Oc1rtwTUl+9x6mD7V8+jB/FerDJf6g=;
        b=t9jdUsffsm/5WO/sEk77k69KUNKe2K2iLminz84a2xb78t8HuRydICtrsO2Ok316QG
         EyhWe1q6amK60nKM8LGVeoh4EnljN9CKk6Li43EGV3/esI27jteiwVYj/f1FNHE7i1W5
         Bi+CxZYHe12xo0O8rN7vOr66zuA3CPHabzH+bTI5lT6k81OhB1isud2TUZQuolRHRobY
         VwcioN9YxGlSi8ZYWxOclkH5g3iXtu8d1xWvucuBzOnLYcSjZtZvuHbl0kef/NPh7v2G
         sLL1TRuv9iwZFZI8QAKPc4WQx2idhUcuXqjvLXgGINJEGT1Uh5kRlxe6jJrtBIQq1nju
         /OAw==
X-Gm-Message-State: AOAM533SMILGQ61mIZrD+H6BbPOThmXlOiUbZ7QnacWp7cm0ALSVLrKT
        GvNwTNnd3cYLhfliJ16f/asmefXgZrOSKATxJZkPZQ==
X-Google-Smtp-Source: ABdhPJx+5QZ/4AZZSBIqs4Xz/+pawpkCt8kkhCfoEeqQkigGdJRmMdYgOotYq/Tj/ADhEivC6xDJq+FADqbvmAySDHU=
X-Received: by 2002:a02:2ac1:: with SMTP id w184mr3827019jaw.44.1602091720153;
 Wed, 07 Oct 2020 10:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com> <20200925212302.3979661-19-bgardon@google.com>
 <44822999-f5dc-6116-db12-a41f5bd80dd8@redhat.com> <CANgfPd_dQ19sZz2wzSfz7-RzdbQrfP6cYJLpSYbyNyQW6Uf09Q@mail.gmail.com>
 <5dc72eec-a4bd-f31a-f439-cdf8c5b48c05@redhat.com>
In-Reply-To: <5dc72eec-a4bd-f31a-f439-cdf8c5b48c05@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 7 Oct 2020 10:28:29 -0700
Message-ID: <CANgfPd8Nzi2Cb3cvh5nFoaXTPbfm7Y77e4iM6-zOp5Qa3wNJBw@mail.gmail.com>
Subject: Re: [PATCH 18/22] kvm: mmu: Support disabling dirty logging for the
 tdp MMU
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
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

On Wed, Oct 7, 2020 at 10:21 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/10/20 18:30, Ben Gardon wrote:
> >> I'm starting to wonder if another iterator like
> >> for_each_tdp_leaf_pte_root would be clearer, since this idiom repeats
> >> itself quite often.  The tdp_iter_next_leaf function would be easily
> >> implemented as
> >>
> >>         while (likely(iter->valid) &&
> >>                (!is_shadow_present_pte(iter.old_spte) ||
> >>                 is_last_spte(iter.old_spte, iter.level))
> >>                 tdp_iter_next(iter);
> > Do you see a substantial efficiency difference between adding a
> > tdp_iter_next_leaf and building on for_each_tdp_pte_using_root with
> > something like:
> >
> > #define for_each_tdp_leaf_pte_using_root(_iter, _root, _start, _end)    \
> >         for_each_tdp_pte_using_root(_iter, _root, _start, _end)         \
> >                 if (!is_shadow_present_pte(_iter.old_spte) ||           \
> >                     !is_last_spte(_iter.old_spte, _iter.level))         \
> >                         continue;                                       \
> >                 else
> >
> > I agree that putting those checks in a wrapper makes the code more concise.
> >
>
> No, that would be just another way to write the same thing.  That said,
> making the iteration API more complicated also has disadvantages because
> if get a Cartesian explosion of changes.

I wouldn't be too worried about that. The only things I ever found
worth making an iterator case for were:
Every SPTE
Every present SPTE
Every present leaf SPTE

And really there aren't many cases that use the middle one.

>
> Regarding the naming, I'm leaning towards
>
>     tdp_root_for_each_pte
>     tdp_vcpu_for_each_pte
>
> which is shorter than the version with "using" and still clarifies that
> "root" and "vcpu" are the thing that the iteration works on.

That sounds good to me. I agree it's similarly clear.

>
> Paolo
>
