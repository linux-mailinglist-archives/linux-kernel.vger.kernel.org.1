Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD130126E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 03:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhAWCvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 21:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbhAWCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:51:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900FEC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:50:35 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ke15so10367746ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPa2PKSw/waauVA8Bx+VsfrrtqVIeZc1qOYap+f8/h8=;
        b=lutH7D9nJBgo4rbYtUSB6hS+9wfbtY+nEM4MMtgPn44Qrhheaq58MP3jffbYUNQID9
         NajApLWOWDmfOGeyKaVnO9OvAnscmk5XUqQP0hrK9vgSeVNNES6YxoSSbKGRchjr5ntA
         L/2MxKQYSAtIXmsa1DUYNfo/bc9+FjxA7prFCXDZweGvetHM5T/QiGg1cr41Lb8e3GjV
         xiRp1GWPV01w6+ez8xXyvFvM6tEtR1nBqYAcZh6//lkLm778fmAjr4GDlEXsJ8L5d+Ua
         Mn+qbazSZTrixLw2ecrQ4kDxuPJNEYvPz3i50NO4rdbC044G5hI7h6SdlN7iCfyWYIni
         Y1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPa2PKSw/waauVA8Bx+VsfrrtqVIeZc1qOYap+f8/h8=;
        b=bmfIEf4oOf+WNKXF4gF17fB1LXQ4XZVRG4iTs0455HFmGVLebPLPtfnw3PwlDiSDmh
         eDA3xL0qjjJE+/EI2WlTWSxcsCI6VigLAFxmPilqQu9ef9zkov5CZ6ocf5ll3fRJrwLc
         Oi7U9DFZHR6gJZjJT9hU5qQ+Q86YrEbEW/JfM9AFCoI27TudnL/9RuuJTQlQiARUfy99
         rE2MFpFaW93eprGf7J2AADisY/ygXhAiq8QqgntYP+3E2QFnetCHDqcnikC9C/0HAj1g
         684mpinwqFDYKJsCq+jZ2itn+qDPflJRi3d1Q+TOzPlyde3m+8oHEVnl/+RCzMhwGX5N
         g2cw==
X-Gm-Message-State: AOAM533JYJU8pD0tiMmy1r/elxXJQH/yoEIzoD8Rfg7r2En/eHkWGU7t
        nFey/OciImbUHHeIou3kKNz9v/p0xRN4tjCv/ZCFvA==
X-Google-Smtp-Source: ABdhPJzYbgP11gnR687aBiDmT2sYOj5RkCXjsB8OhUTh383zDdb2dojruAGaljGsy3DoeTHwIarikIOs15J8u56JxZw=
X-Received: by 2002:a17:907:96a5:: with SMTP id hd37mr1187066ejc.541.1611370234300;
 Fri, 22 Jan 2021 18:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-14-pasha.tatashin@soleen.com> <012e19d9-97d6-805a-bfec-8c6e7104f852@arm.com>
In-Reply-To: <012e19d9-97d6-805a-bfec-8c6e7104f852@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 21:49:58 -0500
Message-ID: <CA+CK2bCz17hX9-iPQaas_PNyBgz0sMbJT9eczy549uw74zvh6g@mail.gmail.com>
Subject: Re: [PATCH v9 13/18] arm64: kexec: add expandable argument to
 relocation function
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 12:22 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Currently, kexec relocation function (arm64_relocate_new_kernel) accepts
> > the following arguments:
> >
> > head:         start of array that contains relocation information.
> > entry:                entry point for new kernel or purgatory.
> > dtb_mem:      first and only argument to entry.
>
> > The number of arguments cannot be easily expended, because this
> > function is also called from HVC_SOFT_RESTART, which preserves only
> > three arguments. And, also arm64_relocate_new_kernel is written in
> > assembly but called without stack, thus no place to move extra
> > arguments to free registers.
> >
> > Soon, we will need to pass more arguments: once we enable MMU we
> > will need to pass information about page tables.
>
>
> > Another benefit of allowing this function to accept more arguments, is that
> > kernel can actually accept up to 4 arguments (x0-x3), however currently
> > only one is used, but if in the future we will need for more (for example,
> > pass information about when previous kernel exited to have a precise
> > measurement in time spent in purgatory), we won't be easilty do that
> > if arm64_relocate_new_kernel can't accept more arguments.
>
> This is a niche debug hack.
> We really don't want an ABI with purgatory. I think the register values it gets were added
> early for compatibility with kexec_file_load().
>
>
> > So, add a new struct: kern_reloc_arg, and place it in kexec safe page (i.e
> > memory that is not overwritten during relocation).
> > Thus, make arm64_relocate_new_kernel to only take one argument, that
> > contains all the needed information.
>
> Do we really not have enough registers?
>
> The PCS[0] gives you 8 arguments. In this patch you use 6.
>
>
> If this is really about the hyp-stub abi, please state that.

Yes, this is a hypervisor abi limitation. I will improve the commit
log to state it clearly.

> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index cee3be586384..b1122eea627e 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -59,13 +60,35 @@ void machine_kexec_cleanup(struct kimage *kimage)
>
> >  int machine_kexec_post_load(struct kimage *kimage)
> >  {
> >       void *reloc_code = page_to_virt(kimage->control_code_page);
> > +     struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
> > +
> > +     if (!kern_reloc_arg)
> > +             return -ENOMEM;
> >
> >       memcpy(reloc_code, arm64_relocate_new_kernel,
> >              arm64_relocate_new_kernel_size);
> >       kimage->arch.kern_reloc = __pa(reloc_code);
> > +     kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
> > +     kern_reloc_arg->head = kimage->head;
> > +     kern_reloc_arg->entry_addr = kimage->start;
> > +     kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
>
> These kern_reloc_arg values are written via the cacheable linear map.
> They are read in arm64_relocate_new_kernel() where the MMU is disabled an all memory
> access are non-cacheable.
>
> To ensure you read the values you wrote, you must clean kern_reloc_arg to the PoC.

Thank you for catching this, I added:
 __flush_dcache_area(kern_reloc_arg, sizeof (struct kern_reloc_arg));
