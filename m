Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0E02D0FD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgLGL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLGL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:59:03 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7592C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:58:16 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w206so9408082wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QXhe9B9BJ7USSO3oeUBj7EmOBzDk/2v+2B7jxK6gtbg=;
        b=iG24RCKl+ygINMY1nAhD2uNc0qaaBKZsFX4Z6upKoDJg/x3GJI96vsDzaMEFbfuZf0
         RaTxdFpfJr4kAP+kSAXP6Hg0yTMoOYnEHeQi5akZjbVsdYl9ibGfpOcHF6hyfP6xE8jH
         CJFt7ZcPKyrT7z/9Ex7CR5+ExOVXAHf3DjZLIHCDWefWBzFiCrJ2Zfn5TzK1e3SroR9i
         M7R1jgzQvggjuPkSRMjMrwr8NXriK+ITjyd11nJMWqGln9M4L9U5Q3pTJ1f+6Pk+4gad
         s1xZ6Mej5NQI2e6fN1kNAmVQrYMIn4gvKSxbeFIrznGNlGAaVeDl+dEWZT44ZzqVD985
         EUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXhe9B9BJ7USSO3oeUBj7EmOBzDk/2v+2B7jxK6gtbg=;
        b=sq1j6QiyCXv20ONaD2yVdPv9eDmKbl+Ak0EJ/B/XZg15ImqAM3B8fPL1EaoTJXIJ/x
         7wy11OI0yLKY6445OD5HXv5qjJGvJtnXJBbGD9Uos4a70FO31y+PsLbm3Ibl50ZkKde0
         i4J/HbsJ7Jnb1P5fveWnsfl1XfVUb3V2l5/T3DinCKThCdTvNN/z2qt71l7Vf19cVaDR
         neGw6VmK4NL+/4DSrlXn/ELcX55PwCwak+NhkXJLNtKxYk1cJJhl1ptUFy1vU/G/QW2J
         +pwU6qH+EHWEGwJuzpkFr4ybUpOcSxBY2pT+iUAogHyaFVlGHV0qRjYE6TX2RZtR4p4u
         Bm3A==
X-Gm-Message-State: AOAM533MnUezh47zNup/tZuV07TxR5EhcKKOY8hukXGJ+XwKfninfTBB
        iObzcEiTLl430IYeVx9Eci9/kA==
X-Google-Smtp-Source: ABdhPJwUzWSoIPl5fmIEWseyZa8uAixbFQ83VDcWjXlOYrOt9eUmIZlDTJNHwBtOScO5fPv4OfgRrw==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr10925592wma.184.1607342295377;
        Mon, 07 Dec 2020 03:58:15 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id m21sm13730406wml.13.2020.12.07.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 03:58:14 -0800 (PST)
Date:   Mon, 7 Dec 2020 11:58:11 +0000
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
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
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
Message-ID: <X84Y07kbeSL4xcNJ@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
 <CA+EHjTyJnZ8e=AN7H_k+oZb0VTWAgMicMY8Rqe2Di_3A87hm0A@mail.gmail.com>
 <X8p5kLSIq2MoQZ24@google.com>
 <CA+EHjTxW_z-P8bK7gCjGv2eBCAHFsvE873Gr2KyVq5-+_Mdv=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxW_z-P8bK7gCjGv2eBCAHFsvE873Gr2KyVq5-+_Mdv=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 Dec 2020 at 11:16:05 (+0000), Fuad Tabba wrote:
> On Fri, Dec 4, 2020 at 6:01 PM Quentin Perret <qperret@google.com> wrote:
> >
> > On Thursday 03 Dec 2020 at 12:57:33 (+0000), Fuad Tabba wrote:
> > <snip>
> > > > +int hyp_create_idmap(void);
> > > > +int hyp_map_vectors(void);
> > > > +int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
> > > > +int hyp_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
> > > > +int hyp_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> > > > +int __hyp_create_mappings(unsigned long start, unsigned long size,
> > > > +                         unsigned long phys, unsigned long prot);
> > > > +unsigned long __hyp_create_private_mapping(phys_addr_t phys, size_t size,
> > > > +                                          unsigned long prot);
> > > > +
> > >
> > > nit: I also thought that the hyp_create_mappings function names are a
> > > bit confusing, since there's the create_hyp_mappings functions which
> > > use the aforementioned *hyp_pgtable.
> >
> > Sure, happy to re-name those (and hyp_pgtable above). Any suggestions?
> 
> Perhaps something to indicate that these are temporary, tmp_ or
> bootstrap_ maybe?

Hmm, the thing is these are temporary only in protected mode, they're
permanent otherwise :/

Perhaps I could prefix the protected pgtable (and associated functions)
with 'pkvm_' or so? Marc, any preferences?

Thanks,
Quentin
