Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EEB26E63F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIQUIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgIQUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:07:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14FC06121E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:38:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so4921479eja.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+b0O517ldbb+t6DutGlM1XoVon6vr3TwPQwR3jd7P0=;
        b=XYGdm3VzSu1b5q3lCyekLEwJmh7CrUGMUfamVPR2SOSC4xIaOvIzmhaixBSzh202c2
         9C3eKpiqIqy51peJCd0sR9JxbaI2EeH2YYnNbSN1hs3AIi7ILXnhZuUPHg7l58a4RjBI
         elvhV+zEjYO4GKIfaR+CmTsrQlh0hPDTEZYNWK22sjx7oyPI1ZO07yoGmNae7luWrAT8
         iHDozT2by8UTE2UekU67QAeIthsGTrr6G+NtPeT1jdiTbaINK5U6PIHC+t47fRGVtEeT
         JpFmT8XckMnHTlz5HWGTZbTxeHlGzRt+ZfKkUYjXoRV9Jp2KFaD95pNHQfbYlDXq0cy+
         08lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+b0O517ldbb+t6DutGlM1XoVon6vr3TwPQwR3jd7P0=;
        b=aS39117At7+lJ/CHUES3OqntjrJQq6IFNXB7FW2WkxWl8huhI1lZ0BD1/z0V2AebTj
         /c3HP6oev9CfQWkvS+tk3hHqIWsQibkIicAw2oYp0/qu4Ni8oxNQvKVmNu3MSfpC6nNo
         +4Y1CleD+s7CuIYNjL4WT2hIf6C84ObOAtvOLkB3cX4VfGiegXZr1EdqHD+aJ0LWJzHw
         6+SsGNuO7js02dIBREtT8kD2jki8pH+/Yv2/BZlK7wqBNMlGJMaRuHKH2iA5Ebg/oVyK
         /2RuXAh5KWonmhgXQ3r92zQKYVBqWuQn9FYBRXj3XvPhqxsFSpSWSJB8UIGlzRT9WDP+
         aGJQ==
X-Gm-Message-State: AOAM533hw45ql2/RqEY6UnV6LGo6KpQTIufgxXv4VKdmuYuIb8s0JZFi
        7TegI/m2WegurFBCY9zzHRGRW8ngJjJQCV1Ukiw9rw==
X-Google-Smtp-Source: ABdhPJy7yu6Km6a38mN3GdGLu09s238LFgYU4fwo7ejzyWFZtvJzXiJLCjECL7tq17b1in9Q1rg5CV8AKVGEICf3k10=
X-Received: by 2002:a17:906:3e08:: with SMTP id k8mr31842574eji.480.1600371527850;
 Thu, 17 Sep 2020 12:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200902125935.20646-1-graf@amazon.com> <20200902125935.20646-2-graf@amazon.com>
 <CAAAPnDFGD8+5KBCLKERrH0hajHEwU9UdEEGqp3RZu3Lws+5rmw@mail.gmail.com> <186ccace-2fad-3db3-0848-cd272b1a64ba@amazon.com>
In-Reply-To: <186ccace-2fad-3db3-0848-cd272b1a64ba@amazon.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Thu, 17 Sep 2020 12:38:36 -0700
Message-ID: <CAAAPnDFxR8yeB0sq4ZMRoZRO4QycZsBiKzaShGwMWE_0RM6Aow@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] KVM: x86: Deflect unknown MSR accesses to user space
To:     Alexander Graf <graf@amazon.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        kvm list <kvm@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +The "reason" field specifies why the MSR trap occurred. User space will only
> >> +receive MSR exit traps when a particular reason was requested during through
> >> +ENABLE_CAP. Currently valid exit reasons are:
> >> +
> >> +       KVM_MSR_EXIT_REASON_INVAL - access to invalid MSRs or reserved bits
> >
> >
> > Can we also have ENOENT?
> >          KVM_MSR_EXIT_REASON_ENOENT - Unknown MSR
>
> I tried to add that at first, but it gets tricky really fast. Why should
> user space have a vested interest in differentiating between "MSR is not
> implemented" and "MSR is guarded by a CPUID flag and thus not handled"
> or "MSR is guarded by a CAP"?
>
> The more details we reveal, the more likely we're to break ABI
> compatibility.
>

I don't suspect we will ever have a stable ABI here, whether we split
the two error values or not.  But there could be value in it.
Consider an MSR that raises #GP if any bit in the high dword is set.
KVM version 0 knows nothing about this MSR, but KVM version 1
implements it properly.  Assuming ignore_msrs=0 and error codes:
EINVAL (invalid argument, should raise a #GP) and ENOTSUP (seems like
a better name than ENOENT, Unknown MSR).

With Just EINVAL: KVM version 0 will always exit to userspace if
EINVAL is requested (it needs help). KVM version 1 will exit to
userspace only for illegal accesses if EINVAL is requested (but it
doesn't really need help).
With EINVAL and ENOTSUP: KVM version 0 will always exit to userspace
if ENOTSUP is requested (it needs help). KVM version 1 will not exit
to userspace if ENOTSUP is requested.

If you want to implement ignore_msrs in userspace it seems much easier
with the second approach, and I think all you'd have to do is return
-ENOTSUP from kvm_msr_ignored_check() instead of returning 1.
