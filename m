Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B630462B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394631AbhAZSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394240AbhAZSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:12:51 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752FAC061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:12:10 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y19so35482179iov.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSLkqaRoVm6yeDTrGmTw5BG5webL7ABwa4ZtzF48Lw0=;
        b=TaCC6sgV4Z826UrstI0juYphlr/8XPwKScM9AZx97dSox07gB1oxYPB8HOzkSrGJmi
         5CeyVkK2r6i+O3qP5bt/tbBhgY6CtX7zNug/Nhrc5xc9aqyv0R6fjjXs7/azfGwUpPr4
         F+JOpBUmRy2uXQDN3wtq8lLCJPyC/jpJEFmOyqgePURdGhbxn84NGlD3UhxNIadCnZdh
         dduz9m5N74xhpcdnmCVj3jOFFnrH071rz65BgrrdeeNWu1dDCMOeUA6AuxVmw8Ntj28A
         mjvaRADWfQsBFS0JkfyRmKL+MQFnlZS4Ul0h9w8i/xanFqFL4FtN7s/XOoDSTJrvmGTb
         by4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSLkqaRoVm6yeDTrGmTw5BG5webL7ABwa4ZtzF48Lw0=;
        b=ugyctyUvyIU/QuQp8aTzGS5lbdcfegP95ixlbadiyhVwLMErlCUdHLqDutTafPeRM4
         FxXBUheKTI+bbPibtdnZ7BZ/lzAJ8NVr42Ur9o7WEA2UrqBn51XDHtPoEusuBr472lho
         EMunLdS5rf1ee30v0TPmxqL7H1bfsPL4jpVQaiH9/ly2r8TrYBJSa0cvtdN4cR4yIRPe
         SIuQl3OHB9oy0Y6vTjMTzuiFu8gdycnW0cDfjmQZ7+N17wh5BBiu+sMqVgCtsVc8O1gx
         ORmnyyurzn0Fk3vRwQiqJUX5cu389z5CCjV/ZdyfZujfu7dzqv1KNtIYvkFn3/gZjSQr
         3WPQ==
X-Gm-Message-State: AOAM531MirSoZMw3z9HAG1qf5PmYkkQCRQ4NquQCVBNrBDh6Y7+FeJQr
        xkwp4EtPA3fachnWbOWOX/r+/GpvGC+TqrkL8++LtA==
X-Google-Smtp-Source: ABdhPJyAV3dnQJ4r9O8EExkIedoJK+Ruxm3ZMF2B2k22boeDb7rVKjPd1Hfb9Zf6iv6tm1Z1JurKr2LHvR+SXMPx5IY=
X-Received: by 2002:a05:6e02:108e:: with SMTP id r14mr5594834ilj.285.1611684729603;
 Tue, 26 Jan 2021 10:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com> <20210112181041.356734-16-bgardon@google.com>
 <YAjIddUuw/SZ+7ut@google.com> <460d38b9-d920-9339-1293-5900d242db37@redhat.com>
 <CANgfPd_WvXP=mOnxFR8BY=WnbR5Gn8RpK7aR_mOrdDiCh4VEeQ@mail.gmail.com> <fae0e326-cfd4-bf5d-97b5-ae632fb2de34@redhat.com>
In-Reply-To: <fae0e326-cfd4-bf5d-97b5-ae632fb2de34@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 26 Jan 2021 10:11:58 -0800
Message-ID: <CANgfPd_TOpc_cinPwAyH-0WajRM1nZvn9q6s70jno5LFf2vsdQ@mail.gmail.com>
Subject: Re: [PATCH 15/24] kvm: mmu: Wrap mmu_lock cond_resched and needbreak
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
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

On Tue, Jan 26, 2021 at 9:55 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 26/01/21 18:47, Ben Gardon wrote:
> > Enough that it motivated me to implement this more complex union
> > scheme. While the difference was pronounced in the dirty log perf test
> > microbenchmark, it's an open question as to whether it would matter in
> > practice.
>
> I'll look at getting some numbers if it's just the dirty log perf test.
>   Did you see anything in the profile pointing specifically at rwlock?

When I did a strict replacement I found ~10% worse memory population
performance.
Running dirty_log_perf_test -v 96 -b 3g -i 5 with the TDP MMU
disabled, I got 119 sec to populate memory as the baseline and 134 sec
with an earlier version of this series which just replaced the
spinlock with an rwlock. I believe this difference is statistically
significant, but didn't run multiple trials.
I didn't take notes when profiling, but I'm pretty sure the rwlock
slowpath showed up a lot. This was a very high contention scenario, so
it's probably not indicative of real-world performance.
In the slow path, the rwlock is certainly slower than a spin lock.

If the real impact doesn't seem too large, I'd be very happy to just
replace the spinlock.

>
> Paolo
>
