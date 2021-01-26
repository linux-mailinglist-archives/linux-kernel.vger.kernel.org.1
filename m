Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760A3304FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhA0D03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhAZVHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:07:54 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CCBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:07:14 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u17so36680546iow.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXltbeb08aCLv/IaAmMXa5/LJl/de149+mTZ0cnXywo=;
        b=DsTWBbWHcrIG9y6GeohkpNGVKY+cFZ1VjRR4+ukLSPPSSIvvVs1zd4QvHjD4UN0lWH
         nD4q16OAQLiKH9et9QRK4zu/uv1tLgOBIrBJfFub+OHPmmlnZmvSiWDdZawBPgNDpSIM
         TsLGIAideJ0EZE5LST9CPrMpOkrWtN2QkxcEqXTeREBTyrsSDZxz+847TOiGQWfds03b
         MY1+sDF/Jgaojxj1VxlNtoKcdLEoNdF80VSuwJ9aUBmq1aEhtLXUuAYHdmiTcWUxLc3M
         htpO1EYRPZz85zGWO1mQ2jYL9fsRPBLJXVtucvbSzlQocRqSApgRghjEtJkvca4rWSFM
         0Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXltbeb08aCLv/IaAmMXa5/LJl/de149+mTZ0cnXywo=;
        b=o/oZrwkddcO8IvHfB+HmqnWbAsTXO5e/WDwXNT6pIjviC8bT7w+TaCYaTSBZW51pM6
         p4Usl8S9zPbJj7+USqB//tXFMXvqJ/2u/wiasahUrQptOq6kZHLV6q7P/lVWRNOWK2XY
         ecVP/qaaMNNc92dpL/UJfpoSdQ/lKCVIzCRWBTX6Z1BgsKb3r7rrxQsMzEO5huxKKYN6
         OqsfNMZVTmmZHHWtHac2vcV9HzZgM9hl0CzLIem4daNeJ7buZSlp2oETnpAJBczjybKM
         2mFNA9Zl97TUb3atAnC3ipsppcvxr8gvdDLcIM7ihiMcWXo47zWypUqQ7Bmgm29un07a
         GrlQ==
X-Gm-Message-State: AOAM5328vdcuKg1PTeQaxkYq0dF48Rs3O4KpdviCYRQeXbzHKOSs27BN
        Kl/w57mmwot71SPmSrCPttlu0gVtSoyT652hZlabEg==
X-Google-Smtp-Source: ABdhPJzdqrymF1yVhInjyCzYnkPoM9IF6RHa4r+wjRngK3JafTpx6MY+C8nP6uxewMUQmitEdGAyvgQs1DUk4YUYgD8=
X-Received: by 2002:a92:cbce:: with SMTP id s14mr1159461ilq.306.1611695233297;
 Tue, 26 Jan 2021 13:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20210112181041.356734-1-bgardon@google.com> <20210112181041.356734-20-bgardon@google.com>
 <14147680-740d-6e7f-e00d-aa7698fd2ba6@redhat.com>
In-Reply-To: <14147680-740d-6e7f-e00d-aa7698fd2ba6@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 26 Jan 2021 13:07:01 -0800
Message-ID: <CANgfPd9ok+QUxgp2E_adj+BGRhhrDoFoFndb7+fXiGBggXd2qg@mail.gmail.com>
Subject: Re: [PATCH 19/24] kvm: x86/mmu: Protect tdp_mmu_pages with a lock
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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

On Tue, Jan 26, 2021 at 5:37 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/01/21 19:10, Ben Gardon wrote:
> > +      *  May be acquired under the MMU lock in read mode or non-overlapping
> > +      *  with the MMU lock.
> > +      */
> > +     spinlock_t tdp_mmu_pages_lock;
>
> Is this correct?  My understanding is that:
>
> - you can take tdp_mmu_pages_lock from a shared MMU lock critical section
>
> - you don't need to take tdp_mmu_pages_lock from an exclusive MMU lock
> critical section, because you can't be concurrent with a shared critical
> section
>
> - but then, you can't take tdp_mmu_pages_lock outside the MMU lock,
> because you could have
>
>     write_lock(mmu_lock)
>                                       spin_lock(tdp_mmu_pages_lock)
>     do tdp_mmu_pages_lock stuff  !!!  do tdp_mmu_pages_lock stuff
>     write_unlock(mmu_lock)
>                                       spin_unlock(tdp_mmu_pages_lock)
>

You're absolutely right, that would cause a problem. I'll amend the
comment to specify that the lock should only be held under the mmu
lock in read mode.

> Paolo
>
