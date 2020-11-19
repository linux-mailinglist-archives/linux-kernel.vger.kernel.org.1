Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69652B983B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgKSQj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgKSQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:39:55 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29365C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:39:54 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so8845862ejk.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHCeV+0wASxa7xKuZTzPc3uHjiByPnCWQmQdnty1SfE=;
        b=K7bWQ0Zc34TB663V4lX0Qpf54I3JpW4/Qv0E3aCd2FzmNzPEhOljrgVnmphkmOB1dc
         a6SoyQVZUAEKpTTkmOmFxaWEbyIHfNU1t5s4H+FGnQfBh3yN4A0dv3Jjpn7D4gdQJdwO
         Ju3cHL9f6IDj08kfEWIO22b2kY0KCvZqLgRoc06QwAaZrdQx8LsgIRI/fXWLbGC17jXb
         HMMexFgaVR1tx6U/qzRdJJFqAt6ocD2O2c/l/aEEZF7tOOrDJWmaySSX9sKRw4Ov4wXs
         joWmgV0j3pVCynbuzQOj93EchianKE39W9JT+KbSmq6jMP9MZyZAwS+f/yKTtTxNhQj6
         GEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHCeV+0wASxa7xKuZTzPc3uHjiByPnCWQmQdnty1SfE=;
        b=ofM3MZjH5ufkWz3UJjgTxo77jmKK3rGJhSOODBXmNZYw23eY4e/h5Qklzlnucy5mkY
         g9sJQv0zdqe4NQRBOJTYyERssDgo6MfKy6NmEZCeX+wfeE7kbkrfjCQ5QineNJx08tLT
         7nJF81xAnCKS7PEqiSaEDEtPurz87A03xx6rBFk+FIKTclOELHMEG0evf5lAXCUZsNCM
         pQBOMUA5Oo5tk+WvMppOKjmtD1+l/XBZWOkMXje7OgD5DEv4U+U8OL1kMxIjfn4NcwH/
         v7AgrqloenNE/EZFmkJP3qwVMQqsSTrMM+VVBpqe75p1334E3df+1BCsN511ea+dEsKh
         I/Wg==
X-Gm-Message-State: AOAM532jN7AEMxBRntN4EkR4Ooqiu2v/YXx7z5+Hv/VvVjJN5wyYGqVy
        4aHgNdDtF5Sn4I2Pxodq9wZnS1riR+xLKoHStx4bHg==
X-Google-Smtp-Source: ABdhPJxohkqohF8Rold75mHYphEqgvgYH008wPvAAASt8psj0r6y3aoUKE/wT9nNKiSdXCRUmbbTz2P3mxtXYvrp7Oo=
X-Received: by 2002:a17:906:af8c:: with SMTP id mj12mr28777718ejb.85.1605803992789;
 Thu, 19 Nov 2020 08:39:52 -0800 (PST)
MIME-Version: 1.0
References: <20201119153901.53705-1-steven.price@arm.com> <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <b434977d-08d7-f753-f95c-81fc533cae0a@arm.com>
In-Reply-To: <b434977d-08d7-f753-f95c-81fc533cae0a@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 19 Nov 2020 16:39:41 +0000
Message-ID: <CAFEAcA_navHXiwJOwWas-TXdVhxY_kJjVNxHvDCY4ArizH_CQQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 at 15:57, Steven Price <steven.price@arm.com> wrote:
> On 19/11/2020 15:45, Peter Maydell wrote:
> > I'm a bit dubious about requring the VMM to map the guest memory
> > PROT_MTE unless somebody's done at least a sketch of the design
> > for how this would work on the QEMU side. Currently QEMU just
> > assumes the guest memory is guest memory and it can access it
> > without special precautions...
>
> I agree this needs some investigation - I'm hoping Haibo will be able to
> provide some feedback here as he has been looking at the QEMU support.
> However the VMM is likely going to require some significant changes to
> ensure that migration doesn't break, so either way there's work to be done.
>
> Fundamentally most memory will need a mapping with PROT_MTE just so the
> VMM can get at the tags for migration purposes, so QEMU is going to have
> to learn how to treat guest memory specially if it wants to be able to
> enable MTE for both itself and the guest.

If the only reason the VMM needs tag access is for migration it
feels like there must be a nicer way to do it than by
requiring it to map the whole of the guest address space twice
(once for normal use and once to get the tags)...

Anyway, maybe "must map PROT_MTE" is workable, but it seems
a bit premature to fix the kernel ABI as working that way
until we are at least reasonably sure that it is the right
design.

thanks
-- PMM
