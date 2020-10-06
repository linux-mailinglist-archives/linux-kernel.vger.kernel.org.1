Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FB8284E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJFOuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgJFOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601995849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uj4fUmkMtECUINnHHFprDJjft1rwsVhT/Z+2WgldeIA=;
        b=UQpjBoggaIqpKHxu2OzIVFTOS0UtWIXRRvXC2FEnSTuL8QPE2Nek9lMhChK5izQAKdHEAv
        9X9tQ4zfVP4q0c7dwUJxYskZIx6nxD7BVvr4xZZqTLxyg8lcKaV4F/xSGo4rrM3wqE8aVO
        mmi2lmweg8+rHna09hKR+6h+lZ+QImw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-Dt0049KtNfiY7SkLBrAYgg-1; Tue, 06 Oct 2020 10:50:48 -0400
X-MC-Unique: Dt0049KtNfiY7SkLBrAYgg-1
Received: by mail-wm1-f69.google.com with SMTP id i9so788730wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 07:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Uj4fUmkMtECUINnHHFprDJjft1rwsVhT/Z+2WgldeIA=;
        b=J+f5plICLAyb/ca/19GYFYCfQmsExm+vOQIgnPUVMC8Ta77ikx4FlOgdpnAHta5Yp9
         VMpUi/Frpy2Az0/z7Yn1wWPXjCug6Rx4uDwmldQq2IQUzffoP2Z5G5bGe8WzTxClHAvc
         B7MbBNM79E7cYwFbTZD08NueqK4NUBEIyymAleHwVuJheX5I6P/i6HtNAo8bliEasnHf
         Tku1di6JOq0Nys3PAfc90xeNE4ji9sPhGHvUHNJG6uVGEKp1N4ZT2ei7QY3KkLupVyk2
         A1PacL/eWX9++VZ63tLupiNEdWrZAMdcJz+BWYJlIgJgloMDDb2Uig4BkoZ0hXld9QcE
         ph3w==
X-Gm-Message-State: AOAM530jZvuw1Qo/pPsvXceEp1E8ThoLhNYyLncfNIWtlWgcz1k2V6IM
        LS5hpXXbq4Us4D0umXaXl56Ka9riY/vsxPfqAA18mdWy39jbHnaHg3W3Fk1D6AvM/Wx17r4bqTD
        v4IOv9T1HFwaZUUp/cKOS7Oqz
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr5275237wrw.379.1601995846884;
        Tue, 06 Oct 2020 07:50:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGD6vp5cGlUUCcdlPKU2NANyZGSalCQXuWaV8QSkc2Oo+MbMqEiVgxHozlkw+obNtWwzYCTg==
X-Received: by 2002:a5d:69cd:: with SMTP id s13mr5275210wrw.379.1601995846617;
        Tue, 06 Oct 2020 07:50:46 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u17sm5647192wri.45.2020.10.06.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 07:50:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>, pbonzini@redhat.com
Subject: Re: [PATCH v4] kvm,x86: Exit to user space in case page fault error
In-Reply-To: <20201006141501.GC5306@redhat.com>
References: <20201002153854.GC3119@redhat.com> <20201002183036.GB24460@linux.intel.com> <20201002192734.GD3119@redhat.com> <20201002194517.GD24460@linux.intel.com> <20201002200214.GB10232@redhat.com> <20201002211314.GE24460@linux.intel.com> <20201005153318.GA4302@redhat.com> <20201005161620.GC11938@linux.intel.com> <20201006134629.GB5306@redhat.com> <877ds38n6r.fsf@vitty.brq.redhat.com> <20201006141501.GC5306@redhat.com>
Date:   Tue, 06 Oct 2020 16:50:44 +0200
Message-ID: <874kn78l2z.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Oct 06, 2020 at 04:05:16PM +0200, Vitaly Kuznetsov wrote:
>> Vivek Goyal <vgoyal@redhat.com> writes:
>> 
>> > A. Just exit to user space with -EFAULT (using kvm request) and don't
>> >    wait for the accessing task to run on vcpu again. 
>> 
>> What if we also save the required information (RIP, GFN, ...) in the
>> guest along with the APF token
>
> Can you elaborate a bit more on this. You mean save GFN on stack before
> it starts waiting for PAGE_READY event?

When PAGE_NOT_PRESENT event is injected as #PF (for now) in the guest
kernel gets all the registers of the userspace process (except for CR2
which is replaced with a token). In case it is not trivial to extract
accessed GFN from this data we can extend the shared APF structure and
add it there, KVM has it when it queues APF.

>
>> so in case of -EFAULT we can just 'crash'
>> the guest and the required information can easily be obtained from
>> kdump? This will solve the debugging problem even for TDX/SEV-ES (if
>> kdump is possible there).
>
> Just saving additional info in guest will not help because there might
> be many tasks waiting and you don't know which GFN is problematic one.

But KVM knows which token caused the -EFAULT when we exit to userspace
(and we can pass this information to it) so to debug the situation you
take this token and then explore the kdump searching for what's
associated with this exact token.

-- 
Vitaly

