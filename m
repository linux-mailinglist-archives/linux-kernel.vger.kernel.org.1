Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1163C2D0ED0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgLGLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgLGLRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:17:22 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B307C0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:16:42 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id q20so1333677oos.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 03:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwG4TWcUm8pF7K4oTU7GITdAxYvneLQVCWtOQ4qnITI=;
        b=QzOPfJq6brPlWLhOGjRL7CH5U88bsg77NcVAzpg5l0Il+t1OSzHatKcSMZtU/Qooaz
         2aD8GmiRxXaUJ69wI3iyGydzWttl++3k/Eoe53ram5v0yjl2Ntz7ciqb3P5qUNgKtOyY
         ADreSu/REA/g5CL4IeqKcy3rqq5gE5PtMde5x57Ak+XQLiOCbUA/ZqHfSkXD4DiZLo03
         /r6eIMfz7bNYd1k0ANwqMFrV6uoTJ9OOF410RAIAPS2/ay34T9BMyPOC9gSbdM6P89On
         WPexdJ978FYCsGLdPRVglor7xKP8qZkl05v+9/4DHwYk7G4cTMmaz8U/F/Mh2pVveW8h
         dGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwG4TWcUm8pF7K4oTU7GITdAxYvneLQVCWtOQ4qnITI=;
        b=LibFpulvFod7QyvDcU7CUN+eJFdAduQs9O4H6VXh9Cuf1/UWm+hrW7CQF7Ur8VOFCk
         p1CpxHGZ4GrjxLF8yMT2ZsYOMojNoH4VEXr6rjIY6D8o/sBtWVyF02xioFnyNiEXE43a
         s+6ta3Vei7EM2zdjBJd5iKUMx2jBIGyKtKNyiZ/JK/emZEkoZWh/DTpwO69ridr2sGgh
         IIGAOeMCBls5W7JKmUE0EQHvOCin+21t/yN+CpJqVKlEsmN1Zg4Fv/2PjCLz79EfE2Ax
         Rze21Ugcn5ShN8qX76l0rxrpO4gPrxwJdrTYA3OU56C8cIbQi6F30Rp6VJtd0H2jet0o
         gjbA==
X-Gm-Message-State: AOAM531pcKT6pFK505YBy2ePRcGbeH+/zfJ6LQnl5sLiLOcg3BnX19NI
        HerBgVFbVl1SRMHU813tdpVtcWtI4ibtH7eNGDLveg==
X-Google-Smtp-Source: ABdhPJx9cbeSJ9V8Q7wlwxkuuRV1vY2gzAVhPdoz+VDDikcfYemu9rYcUksyIX7Bh/NZiRc8uaGfU+Ix0O6LwVqYwWY=
X-Received: by 2002:a4a:9e02:: with SMTP id t2mr12368409ook.42.1607339801572;
 Mon, 07 Dec 2020 03:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com> <20201117181607.1761516-17-qperret@google.com>
 <CA+EHjTyJnZ8e=AN7H_k+oZb0VTWAgMicMY8Rqe2Di_3A87hm0A@mail.gmail.com> <X8p5kLSIq2MoQZ24@google.com>
In-Reply-To: <X8p5kLSIq2MoQZ24@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 7 Dec 2020 11:16:05 +0000
Message-ID: <CA+EHjTxW_z-P8bK7gCjGv2eBCAHFsvE873Gr2KyVq5-+_Mdv=g@mail.gmail.com>
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        Android KVM <android-kvm@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 6:01 PM Quentin Perret <qperret@google.com> wrote:
>
> On Thursday 03 Dec 2020 at 12:57:33 (+0000), Fuad Tabba wrote:
> <snip>
> > > +int hyp_create_idmap(void);
> > > +int hyp_map_vectors(void);
> > > +int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
> > > +int hyp_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
> > > +int hyp_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> > > +int __hyp_create_mappings(unsigned long start, unsigned long size,
> > > +                         unsigned long phys, unsigned long prot);
> > > +unsigned long __hyp_create_private_mapping(phys_addr_t phys, size_t size,
> > > +                                          unsigned long prot);
> > > +
> >
> > nit: I also thought that the hyp_create_mappings function names are a
> > bit confusing, since there's the create_hyp_mappings functions which
> > use the aforementioned *hyp_pgtable.
>
> Sure, happy to re-name those (and hyp_pgtable above). Any suggestions?

Perhaps something to indicate that these are temporary, tmp_ or
bootstrap_ maybe?

Cheers,
/fuad
