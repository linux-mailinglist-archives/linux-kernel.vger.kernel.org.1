Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE727F50F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgI3WXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbgI3WXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:23:50 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B82BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:23:50 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y74so4234121iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stcuGU/AmuexDn/xDJU4W3SgmvykF2WxUHKZBjdx8/Q=;
        b=pB7B3hpbwzKCM8OLwFLMu657QencM4uNHvjZw2pf8j8HF9GyE4GLREYAIWJI8nVhVZ
         sTBV8LBK6dZr6t9MG5fmrIsc1R9KeV50VjzoFfjzFrqjcGmXvbKFi+V6YpFWGkNfuZ+7
         HYxsJT8/0LGMNo4ODcISOBKsB1tRFVeDKjWoOOo5GOv6HhDP8G41kzPTCmxNx9DBmURu
         kTQXB7BqeAoRY+/HIF7uDMajjEghf3uT9eSD3rB9AVQj3bvdrP/zKGRyhXKRhY6rKj4Z
         y+B3Ym97axaNjv4BO3MmGzmOKs2OrUf5OwCvGivIR4q2MNBWElHSj6n1M5Gwk4RhaRy4
         9cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stcuGU/AmuexDn/xDJU4W3SgmvykF2WxUHKZBjdx8/Q=;
        b=LwzIkZu8rdaPdJnxPEEBtVJCg2Ul6Ks1/ng6KxHRpg2Wz7vRSF0szCXlt823lpWd8j
         XrichKnj+tJ+qUNy9bLm8IxOxtxpHiCilW9RcGvEtA53NdumC2LrLuaNzuvmv74wITDo
         xedwny56B9rH4pqWDeJEhl47k2x3joEwgs3HaSrw/WZdkPutv7dnZLiqMRd46W8f8Sji
         5RzdWdVvrocx6RAzOCSzXs5jOi7iaf89sKYrwMuEGEomUXN7EH2S8UvZntQT9bcKJVuT
         TnYjviogWJmRVHOmQ/j7WqFht6f7JFzHOBHL6ZpF8MLL/sn91PD0mQlj7WtyJEaSVRZd
         +cmQ==
X-Gm-Message-State: AOAM531gzhJHSRT1TAFNb/OcWt18SXv+MI/Vjtm2fIIX21hMeUwNoZGj
        KwpxFsC0bERDzOmQsRtSLsD44TcZ8YDPvld/lx4RTw==
X-Google-Smtp-Source: ABdhPJw0s5dS3pBRaUkk/qRn8bsc/omxtWg+5h0+w6X5DYeRtzrIGMmq2LI5GLLwlzDTjlOJnkTCzRRbMIFCUkaybtY=
X-Received: by 2002:a05:6638:f07:: with SMTP id h7mr3619834jas.25.1601504629460;
 Wed, 30 Sep 2020 15:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200925212302.3979661-1-bgardon@google.com> <20200925212302.3979661-21-bgardon@google.com>
 <aa7752b0-d2d2-f387-602f-fbf3f0edf450@redhat.com>
In-Reply-To: <aa7752b0-d2d2-f387-602f-fbf3f0edf450@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 30 Sep 2020 15:23:38 -0700
Message-ID: <CANgfPd89WzcDV+DTxvkqfobCdCXHwtkFwpy90H4oNRftDOVrnA@mail.gmail.com>
Subject: Re: [PATCH 20/22] kvm: mmu: NX largepage recovery for TDP MMU
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

On Fri, Sep 25, 2020 at 6:15 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/09/20 23:23, Ben Gardon wrote:
> > +
> > +     if (!kvm->arch.tdp_mmu_enabled)
> > +             return err;
> > +
> > +     err = kvm_vm_create_worker_thread(kvm, kvm_nx_lpage_recovery_worker, 1,
> > +                     "kvm-nx-lpage-tdp-mmu-recovery",
> > +                     &kvm->arch.nx_lpage_tdp_mmu_recovery_thread);
>
> Any reason to have two threads?
>
> Paolo

At some point it felt cleaner. In this patch set NX reclaim is pretty
similar between the "shadow MMU" and TDP MMU so they don't really need
to be separate threads.

>
