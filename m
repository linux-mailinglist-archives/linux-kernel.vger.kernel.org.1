Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B85B27F25F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgI3TOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3TOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:14:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:14:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s19so1596533plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtmRfZ7y8nBNZ3PA43zzzW4qh+I9/h49G6sXpmz2rpo=;
        b=RzcblbmwjdEDwS4nVlBSnMeYV3oucKr0Yg2oihoPc3sry29WbbBSq36f1sb4sWZbq6
         ebT5bv5Ycd97yxBpVaAj3W8/6ZQVWRhO+mN7w+EBYZEx4OqARl4Q2oo0VjW/iB3YkaQ1
         atFsfdBYYXsREXf2viurdW2nYQPZFfnQ74QSDlWmQQAalk0TxDprocqWEXJ2bZTLVEot
         BiZs14l5Q3IFITEp+T/SBynaiuj+u3RmURydSqtCiOqG3uKCOwA9oG4EBluCCBTI9WZm
         9nEeh0DOMPoahkYsiNjJnntIjNbOCBnVKfQSMIGuj7u9v0CMu0EhIZr23TX/jI0kLT23
         +fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtmRfZ7y8nBNZ3PA43zzzW4qh+I9/h49G6sXpmz2rpo=;
        b=FTGMv2GoA5u8+CfdC1Fz6Gr9fLlN28+lhSME+HS4XR214gx0ukjf5o+kHEBM75kBDF
         /eekEJWTsDtd3eMirTL2ckt52n1odl7qrfh9zKYUsFX1wyWEv9a7Hz1u2gdcwSj1ye6H
         iLKn/NRRDYEI6hUn2ZKN0wi0WPEiGgOdbmr/KcxCc4oVDaXNajXbb0A5rYPCU44d8cLv
         16g0UCAFXzxrvJFj5GYMjvNrk4qM1wTJrP9kjwFZ/VTt+UjpwrQ/D+bNpCN18EOpZA7k
         ELjW1cJpSZO5lQbCeXURC5snuZkgKvrPfWrYbpCKH5eOLson4OBvPRQP6+YJGDxz3coN
         LDxg==
X-Gm-Message-State: AOAM532tZKP40AnYS2YLOb+UDaWOPueITXqPEYs3/5JZZcQO92Nxb6yM
        pNtqwYbUivc+DpZlWkBD4vsGvJjI1HSIZsT4go1XTQ==
X-Google-Smtp-Source: ABdhPJzOntIoiyRAtnDG+KFMbe3fKfTbXsa6TKpvGOhQQLo9Gn+F3/5shbQ2zsdKoG+RjMbkXw5xthlTIzDra5vGXeA=
X-Received: by 2002:a17:902:c151:b029:d2:42a6:2fb with SMTP id
 17-20020a170902c151b02900d242a602fbmr3811478plj.10.1601493256019; Wed, 30 Sep
 2020 12:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200922114311.38804-1-shuo.a.liu@intel.com> <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com> <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
 <20200930111612.GZ2628@hirez.programming.kicks-ass.net> <20200930161036.GY28786@gate.crashing.org>
 <20200930171346.GC2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20200930171346.GC2628@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 30 Sep 2020 12:14:03 -0700
Message-ID: <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com>
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shuo.a.liu@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 30, 2020 at 11:10:36AM -0500, Segher Boessenkool wrote:
>
> > Since this variable is a local register asm, on entry to the asm the
> > compiler guarantees that the value lives in the assigned register (the
> > "r8" hardware register in this case).  This all works completely fine.
> > This is the only guaranteed behaviour for local register asm (well,
> > together with analogous behaviour for outputs).
>
> Right, that's what they're trying to achieve. The hypervisor calling
> convention needs that variable in %r8 (which is somewhat unfortunate).
>
> AFAIK this is the first such use in the kernel, but at least the gcc-4.9
> (our oldest supported version) claims to support this.
>
> So now we need to know if clang will actually do this too..

Does clang support register local storage? Let's use godbolt.org to find out:
https://godbolt.org/z/YM45W5
Looks like yes. You can even check different GCC versions via the
dropdown in the top right.

The -ffixed-* flags are less well supported in Clang; they need to be
reimplemented on a per-backend basis. aarch64 is relatively well
supported, but other arches not so much IME.

Do we need register local storage here?

static inline long bar(unsigned long hcall_id)
{
  long result;
  asm volatile("movl %1, %%r8d\n\t"
  "vmcall\n\t"
    : "=a" (result)
    : "ir" (hcall_id)
    : );
  return result;
}
-- 
Thanks,
~Nick Desaulniers
