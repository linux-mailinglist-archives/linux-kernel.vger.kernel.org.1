Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61A27F1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgI3SyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:54:01 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A7DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:54:01 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e5so2936515ils.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTNb6k0KTUZX28SgX8/5ctYvSHWMCeVd2LxNdQK0xQ4=;
        b=mNVt7KwILbHTFKGN8sOmwybaVaBebXwgaoyhB8MY7W8UJSmfh8sYHOBYfD7qMeXpeq
         yHCgziCffMDqBY3VlGTYRmx99EMIRzHyzouWCV2ElzliV7zYyCK9F4aHtTe54od5qSvc
         hNsNXScsb5Pr9iUr5vlqdD5LI6T4v3gTcDMAFwT5XQevBh6GTq6RzNOPTKxCXH2ITh8S
         LgQwitquZXQP8QMrdxDhr4/OFAyviHNGvplWZpsZdaWHbbxannDN5sWcFeJojzYGBn6U
         mEk5Vqw/BILqfV49RJEwgQTD/tadT3zUg3/Wn2whqB2XV9LH5gXDf05cOh02o2ApdJSK
         1ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTNb6k0KTUZX28SgX8/5ctYvSHWMCeVd2LxNdQK0xQ4=;
        b=k9KYbCP3bATvwDVpoB+iRjrq7zLUxiZO/1PKLe2XXiijXf7ivYPtVzYjdBJ3j6OjBy
         ycMx5CRiUfDWaMFB3qlJPVuOBwX/YP0IJyOoCBKQh5956byjoi0oSDE9DmFW88gaRXGI
         4kuJ/f0jFl14efSdyuHZTN+S05j1hQ9aPuWfjOw8RGClhqJv/JH+LwbXOOMk56YbVqro
         n86UKqhBdhihtUfn984pL1z3Fm/cXt+P1aKZ4e3hmvLf9ckqeFaoFw+q4PrBS4trtO/x
         SlOSNqJFvt9YVoitREmuhgYCK9Phm0FXeETA95lsQ+PI6szirX2uoptTydoQbJtSkVCM
         /6Ug==
X-Gm-Message-State: AOAM530cd+wY0sY8aaVOhsemhVFqryi4RKD/OixNUn5caby7kc+jZPyl
        vJCJxfRBgnqd3r2m68WJUpV4MFHGGaLojyAFD2mqgg==
X-Google-Smtp-Source: ABdhPJy6gFwSvJfYUnaQReXTw7OFukqCdbfGFdk4FOB5w1igPVzF3wcyMnYrwZVkhHIYJcIv0oDqmukb8rucUACJtxE=
X-Received: by 2002:a92:cbcd:: with SMTP id s13mr3111986ilq.306.1601492040319;
 Wed, 30 Sep 2020 11:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com> <20200925212302.3979661-12-bgardon@google.com>
 <66db4185-d794-4b3e-89c2-c07f4f2b5f2a@redhat.com>
In-Reply-To: <66db4185-d794-4b3e-89c2-c07f4f2b5f2a@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 30 Sep 2020 11:53:49 -0700
Message-ID: <CANgfPd8A4VS0Mq-QR7wgzNDMd_UYwxja=Vn7oW0KMoce8RXVww@mail.gmail.com>
Subject: Re: [PATCH 11/22] kvm: mmu: Factor out allocating a new tdp_mmu_page
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

On Fri, Sep 25, 2020 at 5:22 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/09/20 23:22, Ben Gardon wrote:
> > Move the code to allocate a struct kvm_mmu_page for the TDP MMU out of the
> > root allocation code to support allocating a struct kvm_mmu_page for every
> > page of page table memory used by the TDP MMU, in the next commit.
> >
> > Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
> > machine. This series introduced no new failures.
> >
> > This series can be viewed in Gerrit at:
> >       https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538
>
> Maybe worth squashing into the earlier patch.
>
> Paolo
>

That sounds good to me. Definitely reduces churn in the series.
