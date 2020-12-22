Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BC82DBBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLPHbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPHbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:31:55 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E4C061793
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:31:15 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id p5so21679794iln.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 23:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxbJsrPQVjcYsOqxMB6gXGw7OMWAgfnXofakRmQtRbY=;
        b=uw/Zw2YI1wKeJ2T4QgYeS5JCHtbF9+9rosX7jQjI3u4V5OJT1KUebD3cKcYtCvIpXj
         upfERyDIpm0iddCOumOzpKFt8Xkodnzm7jZMJhamz6OlVEdqx8koaXCSLLMzIkUMfbJ8
         REAbROXcmrx8WqE/U+OVwNt2+ytd4sUUYOt2MqxPl+MgBB7qDzRcaCMbxrdcfEE8bn5m
         iSQ3raVoKtTYLpA5ULikEubq4d07x5bUqOjLU1UcPxptdy/x9NBa3PKhbXxH6LtVERzN
         qbVC0JgdkxEuB/FvkEGds055Su7d1rqJ8n6o3X2g9zxwIGwL/NUSDbHuA44L92oUHyA/
         pIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxbJsrPQVjcYsOqxMB6gXGw7OMWAgfnXofakRmQtRbY=;
        b=IDt8e6ao6RD2WmvNUkZZrmYjPVtd/SsBc7VLwXYERqxVOEWX92OPmcgJbhy3IdR1xC
         rypJa/sQXUfgkDro98VElbFoa3u5rNmoHAPr+uGEYvbobDg2Yts5cJW2LRxI9/3s+giy
         EchOO8VhpizbsMLFbIy+ve2D3Fv5Je0OMeKX2KU7/iBnSvV6EZQgg6i9scn9dYo2bT15
         zDtRsA7LqlCG9PLcFqeWy44XdtUkhiL/aljZm5Jk/PlkwUY4wWqhl5yIeRlGfRjt3PgX
         QvTJz2/WhbJtRQ1gieG36CWHKF7reiUP9YFe2L1c1+oM4xO1U7TeoLlgar69eZ5RTXrY
         ISZw==
X-Gm-Message-State: AOAM5324HGXRohF/DFvkESFtOnvrCPmhsXBquvCfRJLdit5lciEnLl1/
        +mvCcyN8AV19ddYECOh6HnxCopOB3d1LU5/JeGZU
X-Google-Smtp-Source: ABdhPJxp95wXQdfJnpif5WRy/t9lTWv3k313/hB7QF+tXpjF7vW/SIZLzag6mtokYq0YxQeUXoaFucjG6kVLJT2bVL0=
X-Received: by 2002:a05:6e02:12cc:: with SMTP id i12mr35597537ilm.23.1608103874249;
 Tue, 15 Dec 2020 23:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20201119153901.53705-1-steven.price@arm.com> <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com> <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com> <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
In-Reply-To: <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
From:   Haibo Xu <haibo.xu@linaro.org>
Date:   Wed, 16 Dec 2020 15:31:02 +0800
Message-ID: <CAJc+Z1EzaUjbQ0o8BSF_+PQy_KnwPp1NqO+94RMphvaUu=dnug@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
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

On Mon, 7 Dec 2020 at 22:48, Steven Price <steven.price@arm.com> wrote:
>
> On 04/12/2020 08:25, Haibo Xu wrote:
> > On Fri, 20 Nov 2020 at 17:51, Steven Price <steven.price@arm.com> wrote:
> >>
> >> On 19/11/2020 19:11, Marc Zyngier wrote:
> >>> On 2020-11-19 18:42, Andrew Jones wrote:
> >>>> On Thu, Nov 19, 2020 at 03:45:40PM +0000, Peter Maydell wrote:
> >>>>> On Thu, 19 Nov 2020 at 15:39, Steven Price <steven.price@arm.com> wrote:
> >>>>>> This series adds support for Arm's Memory Tagging Extension (MTE) to
> >>>>>> KVM, allowing KVM guests to make use of it. This builds on the
> >>>>> existing
> >>>>>> user space support already in v5.10-rc1, see [1] for an overview.
> >>>>>
> >>>>>> The change to require the VMM to map all guest memory PROT_MTE is
> >>>>>> significant as it means that the VMM has to deal with the MTE tags
> >>>>> even
> >>>>>> if it doesn't care about them (e.g. for virtual devices or if the VMM
> >>>>>> doesn't support migration). Also unfortunately because the VMM can
> >>>>>> change the memory layout at any time the check for PROT_MTE/VM_MTE has
> >>>>>> to be done very late (at the point of faulting pages into stage 2).
> >>>>>
> >>>>> I'm a bit dubious about requring the VMM to map the guest memory
> >>>>> PROT_MTE unless somebody's done at least a sketch of the design
> >>>>> for how this would work on the QEMU side. Currently QEMU just
> >>>>> assumes the guest memory is guest memory and it can access it
> >>>>> without special precautions...
> >>>>>
> >>>>
> >>>> There are two statements being made here:
> >>>>
> >>>> 1) Requiring the use of PROT_MTE when mapping guest memory may not fit
> >>>>     QEMU well.
> >>>>
> >>>> 2) New KVM features should be accompanied with supporting QEMU code in
> >>>>     order to prove that the APIs make sense.
> >>>>
> >>>> I strongly agree with (2). While kvmtool supports some quick testing, it
> >>>> doesn't support migration. We must test all new features with a migration
> >>>> supporting VMM.
> >>>>
> >>>> I'm not sure about (1). I don't feel like it should be a major problem,
> >>>> but (2).
> >>
> >> (1) seems to be contentious whichever way we go. Either PROT_MTE isn't
> >> required in which case it's easy to accidentally screw up migration, or
> >> it is required in which case it's difficult to handle normal guest
> >> memory from the VMM. I get the impression that probably I should go back
> >> to the previous approach - sorry for the distraction with this change.
> >>
> >> (2) isn't something I'm trying to skip, but I'm limited in what I can do
> >> myself so would appreciate help here. Haibo is looking into this.
> >>
> >
> > Hi Steven,
> >
> > Sorry for the later reply!
> >
> > I have finished the POC for the MTE migration support with the assumption
> > that all the memory is mapped with PROT_MTE. But I got stuck in the test
> > with a FVP setup. Previously, I successfully compiled a test case to verify
> > the basic function of MTE in a guest. But these days, the re-compiled test
> > can't be executed by the guest(very weird). The short plan to verify
> > the migration
> > is to set the MTE tags on one page in the guest, and try to dump the migrated
> > memory contents.
>
> Hi Haibo,
>
> Sounds like you are making good progress - thanks for the update. Have
> you thought about how the PROT_MTE mappings might work if QEMU itself
> were to use MTE? My worry is that we end up with MTE in a guest
> preventing QEMU from using MTE itself (because of the PROT_MTE
> mappings). I'm hoping QEMU can wrap its use of guest memory in a
> sequence which disables tag checking (something similar will be needed
> for the "protected VM" use case anyway), but this isn't something I've
> looked into.
>
> > I will update the status later next week!
>
> Great, I look forward to hearing how it goes.

Hi Steve,

I have finished verifying the POC on a FVP setup, and the MTE test case can
be migrated from one VM to another successfully. Since the test case is very
simple which just maps one page with MTE enabled and does some memory
access, so I can't say it's OK for other cases.

BTW, I noticed that you have sent out patch set v6 which mentions that mapping
all the guest memory with PROT_MTE was not feasible. So what's the plan for the
next step? Will new KVM APIs which can facilitate the tag store and recover be
available?

Regards,
Haibo

>
> Thanks,
>
> Steve
