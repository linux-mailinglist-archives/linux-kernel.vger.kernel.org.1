Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55F32D0EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgLGLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgLGLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:15:38 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77338C0613D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:14:58 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 11so12080308oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDa/bzky3vYFC4xxSuOCp3ghimMh4GECLA5nY8N/fUQ=;
        b=hx+OgTRg5lMLP/kziSxsNaPlM9h2bc2RfQU1/rtzHESa+ND7aVRNCI71QM0YImfqD0
         Yo7+sxC3NskWKOJ5qtEaRy2IkavFgsVP3/elyHZ54eLjZ8ivjJEFr9e1y4ZbnrR+PluY
         jU+fxcy5C4KfEcCdZ4ldf+gfP4A4lNdwAGts4GanpY6rH8TLvlhbeziXFP3AURCQkk6o
         qxxaLHefzbURt+R16gnQNPuw2WmUkWUwSLLEjU11anroQQoRnhfat/5vzTKg/ecIuDIk
         tbkw0HoB/eycgrorYAdbZg16XToNfwuGPO3grCwFsE3nEnA1CrxjrY9Y+OcPpzc2fxh+
         R36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDa/bzky3vYFC4xxSuOCp3ghimMh4GECLA5nY8N/fUQ=;
        b=mAt4x0ECPNQvTUVLZSWBX0lMnPUUhpO2ZWCsG/PwuwehfAYxIU4Ud1YjXncd4bhQf6
         6DzWApk19Zv11mywtGFDBy51G4DRDp6/am+/sjdO4b6fck+0KFQkHM7rfsA0qRbnhcEe
         xe1zfLf1+JBsf1atKbiuzUVYYXOdjdDg4CJXcJJyHH9Ud0SkTO8fzxxn7uAtvIa3rRDa
         yV+34ol59KmcHjpcwHXZ6l+jJGTXHFhTGcj0OO0D+aTD1Y2s3tYYND270jbHGOB1uwNZ
         uK96Mz6CBo0U0JTyZtUZHdBc8chEi+GyPfBjI1IyraW0dfdyHcd4W3O2w0ZdOLsoPnSF
         WYrg==
X-Gm-Message-State: AOAM531kdEbyQAVyIqWmZldBxZxiDY2dNIDVSvJDeqMSpxQmBcGvSNBc
        RpN+dG9FmLKNMn2v2OS284zTE/knwCADNL9vSUfr+g==
X-Google-Smtp-Source: ABdhPJwk058/GoMNmNv+Cj4Gd61prkxnZJl7VLyI6OsONWjVjNF7OnNL2pO01+T+Vs49sYtWvkNtfDJkxu+1vSquZbE=
X-Received: by 2002:a05:6830:117:: with SMTP id i23mr12717618otp.365.1607339697581;
 Mon, 07 Dec 2020 03:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com> <20201117181607.1761516-17-qperret@google.com>
 <CA+EHjTyJnZ8e=AN7H_k+oZb0VTWAgMicMY8Rqe2Di_3A87hm0A@mail.gmail.com>
 <X8p5kLSIq2MoQZ24@google.com> <20201207102002.GA3825@willie-the-truck> <20201207110528.GA18365@C02TD0UTHF1T.local>
In-Reply-To: <20201207110528.GA18365@C02TD0UTHF1T.local>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 7 Dec 2020 11:14:21 +0000
Message-ID: <CA+EHjTwp7Kndg7-qT=Q0V-wOK+EuUf_K_efMfFe-qo-4dY91Bw@mail.gmail.com>
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        Android KVM <android-kvm@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 11:05 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Dec 07, 2020 at 10:20:03AM +0000, Will Deacon wrote:
> > On Fri, Dec 04, 2020 at 06:01:52PM +0000, Quentin Perret wrote:
> > > On Thursday 03 Dec 2020 at 12:57:33 (+0000), Fuad Tabba wrote:
> > > <snip>
> > > > > +SYM_FUNC_START(__kvm_init_switch_pgd)
> > > > > +       /* Turn the MMU off */
> > > > > +       pre_disable_mmu_workaround
> > > > > +       mrs     x2, sctlr_el2
> > > > > +       bic     x3, x2, #SCTLR_ELx_M
> > > > > +       msr     sctlr_el2, x3
> > > > > +       isb
> > > > > +
> > > > > +       tlbi    alle2
> > > > > +
> > > > > +       /* Install the new pgtables */
> > > > > +       ldr     x3, [x0, #NVHE_INIT_PGD_PA]
> > > > > +       phys_to_ttbr x4, x3
> > > > > +alternative_if ARM64_HAS_CNP
> > > > > +       orr     x4, x4, #TTBR_CNP_BIT
> > > > > +alternative_else_nop_endif
> > > > > +       msr     ttbr0_el2, x4
> > > > > +
> > > > > +       /* Set the new stack pointer */
> > > > > +       ldr     x0, [x0, #NVHE_INIT_STACK_HYP_VA]
> > > > > +       mov     sp, x0
> > > > > +
> > > > > +       /* And turn the MMU back on! */
> > > > > +       dsb     nsh
> > > > > +       isb
> > > > > +       msr     sctlr_el2, x2
> > > > > +       isb
> > > > > +       ret     x1
> > > > > +SYM_FUNC_END(__kvm_init_switch_pgd)
> > > > > +
> > > >
> > > > Should the instruction cache be flushed here (ic iallu), to discard
> > > > speculatively fetched instructions?
> > >
> > > Hmm, Will? Thoughts?
> >
> > The I-cache is physically tagged, so not sure what invalidation would
> > achieve here. Fuad -- what do you think could go wrong specifically?
>
> While the MMU is off, instruction fetches can be made from the PoC
> rather than the PoU, so where instructions have been modified/copied and
> not cleaned to the PoC, it's possible to fetch stale copies into the
> I-caches. The physical tag doesn't prevent that.
>
> In the regular CPU boot paths, __enabble_mmu() has an IC IALLU after
> enabling the MMU to ensure that we get rid of anything stale (e.g. so
> secondaries don't miss ftrace patching, which is only cleaned to the
> PoU).
>
> That might not be a problem here, if things are suitably padded and
> never dynamically patched, but if so it's probably worth a comment.
>
> Fuad, is that the sort of thing you were considering, or did you have
> additional concerns?

No other concerns. Thanks Mark.
/fuad
