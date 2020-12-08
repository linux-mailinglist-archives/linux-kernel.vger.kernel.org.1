Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738762D2891
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgLHKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgLHKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:11:49 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC9BC06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 02:11:03 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so16359279ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 02:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rI1cpmvfLJH6kTfoQBqKr4p1uRHaWCiCfbric7yc3oU=;
        b=dNIn3iZoh8mC1iMR2GHayG7Dmsey5468YPYG+bQp3mApwT3AV55v0utWeiH+FyfOPR
         xMzkRjQWCES+3urWzSrFaYw3Wb6CLk5ZYExO6M73Lcy3/BC+b6jefT8+jvqDEii1lF2x
         vLurTuwD53UxyuzGI1GPvxsdl68S2a/LtEPPN7Gs/868QIsRj0XslCX+xuiE+nbV5Tla
         mTC7TIWsxh8cmM/gR8PwhCMnjYpfVmc8R4cgbR0llcidfH9fN949wv7Mw6p/CPkvu8Xn
         nzfXCWhuaFRIpnfL7YveIUN2mlKKVclIhlKIkbtMa1MTRZqAb8Aj0Jw0eqyfvg3BgYtd
         xQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rI1cpmvfLJH6kTfoQBqKr4p1uRHaWCiCfbric7yc3oU=;
        b=DGMJrMoXuwsHbYJoOAUE2mbvqXueZnByibMaB0PapHlQZNnswVp4aOBh1aGqfRsZ2k
         LNBpXD0q57X8ulqYn0PKbU5EgglxgKDAcJJczH3hmoFB62v9aCAVfcCwkpBqpDFR8c9Z
         JNDdGszkvVspDk66wpG763sX/6LjHpeGO+ImJJA/BFB4OI9KnxR/Dshi3Z/ndFZyNiQv
         xVIG7G4oSRnS71h2jCz4eySaLBXQbPS1WpQvsLSs/RSvgcNORrVl8AjFpO5v7K44gETV
         TughsvbNqTqHhQxvZ9H0TfJvp5x6pQ2XdcCY0pRSDfIHHvPZW/7GcewOtwJz2nqEbvfD
         h2dQ==
X-Gm-Message-State: AOAM531Kz6kOrfWrarwPZFTGBpTeYXq+O8ZYFvKVX3tEnhVuind6EXky
        Mj6sQTEXJU31sQ41ELC/fz2OBc+NBIdZl0eAMLss
X-Google-Smtp-Source: ABdhPJzzChXpGASUFHrcW55NeZaQFkmopErMJ5BvtCk7RK4Qi9bfAbL4Z4qf2qaNh1ATuEArKZuiqRpucQGGwd3Fp0s=
X-Received: by 2002:a02:c608:: with SMTP id i8mr25590358jan.125.1607422263337;
 Tue, 08 Dec 2020 02:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20201119153901.53705-1-steven.price@arm.com> <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com> <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com> <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com> <CAJc+Z1FRJR5LHw-xZvPpeYF6+v+ZOcLt99X41xOMAbFmB2DJ2A@mail.gmail.com>
 <b77efceaec433dd98fdf2cd535a9cf40@kernel.org>
In-Reply-To: <b77efceaec433dd98fdf2cd535a9cf40@kernel.org>
From:   Haibo Xu <haibo.xu@linaro.org>
Date:   Tue, 8 Dec 2020 18:10:51 +0800
Message-ID: <CAJc+Z1EafkLezXv=+1aPbaXo9uWpcB77iM32M70oyP6zEzacjw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Marc Zyngier <maz@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 18:01, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-12-08 09:51, Haibo Xu wrote:
> > On Mon, 7 Dec 2020 at 22:48, Steven Price <steven.price@arm.com> wrote:
> >>
>
> [...]
>
> >> Sounds like you are making good progress - thanks for the update. Have
> >> you thought about how the PROT_MTE mappings might work if QEMU itself
> >> were to use MTE? My worry is that we end up with MTE in a guest
> >> preventing QEMU from using MTE itself (because of the PROT_MTE
> >> mappings). I'm hoping QEMU can wrap its use of guest memory in a
> >> sequence which disables tag checking (something similar will be needed
> >> for the "protected VM" use case anyway), but this isn't something I've
> >> looked into.
> >
> > As far as I can see, to map all the guest memory with PROT_MTE in VMM
> > is a little weird, and lots of APIs have to be changed to include this
> > flag.
> > IMHO, it would be better if the KVM can provide new APIs to load/store
> > the
> > guest memory tag which may make it easier to enable the Qemu migration
> > support.
>
> On what granularity? To what storage? How do you plan to synchronise
> this
> with the dirty-log interface?

The Qemu would migrate page by page, and if one page has been migrated but
becomes dirty again, the migration process would re-send this dirty page.
The current MTE migration POC codes would try to send the page tags just after
the page data, if one page becomes dirty again, the page data and the tags would
be re-sent.

>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
