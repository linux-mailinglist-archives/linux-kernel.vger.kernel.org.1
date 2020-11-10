Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EED2AD25E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgKJJYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKJJYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:24:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:24:08 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so2289553wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ieiicjOVe5riWnNrGnNnOrGqxp8ieWPyQM5kKffkvIM=;
        b=onpjg59Abm3k/FX1eLLE+4S8TaHOTOxJQpqlR1b9xO2ff40pv8k9S77fKMkdTIZLWo
         Bh04quAn5x4D2JXa07xkgK5jMzsHoH6lxOJSVSMfaNKgpiNR85WlPOvpeKq3x07s0gOE
         i6coaA1gTlFR2JR3uPkHuiGNlae1Ayeh+rpIWAImirMVVOho58G848Bx7tzkckBQdpen
         b/ByI6ZrBCQ1V05YD4/qQSoG6rwTFV67xgf1ogX4l+ClrYWbNxM9XTnmai5pjFCUA2rA
         VSinRm1J4g/2haCwW2bCDPJCsjEZUJBu5Yhp5pR/2Flo9QLXkUKG+6/CeHZscobnT22D
         oggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieiicjOVe5riWnNrGnNnOrGqxp8ieWPyQM5kKffkvIM=;
        b=Gn9H3rInXhcLobnf5C/KwDgGuox9r8i4qL25Az0ulezvfqJ1xU/7YP4ZQVcgyA+FPU
         DyBMRC2brw8ONbu0w0yh4VPdj2dz6NEBxXciswZNRTjQESpbYm9xGfPj9Rzgm3ZcjI02
         t9SA0ZheJ7a0rF7ZJitwfldi4rN2DRu7lvSU29R/NgLP2V2mew3UbzgxGIf6ZfVGJ5FC
         hnf7jnzCcMnBsPhM3M03CGhhe/J6Hlhafpk3NYccRFP5pqDYt9Qg7gIg0YLpuRO8OJVd
         somnNFQZPBlidBFb0EWtV8I0cKBczc4/vnar89ZG9MaUSPqFcMWM/owUC2aEGeSviR7+
         xkMA==
X-Gm-Message-State: AOAM532V2ujBjabCrBJJuB+yBjHaZ0NtnOj2h2J1SNt7ExXWx1IFAJRm
        Yi8R0GN17gKxEq8/KuF0U3fQgA==
X-Google-Smtp-Source: ABdhPJy1icaD3sfcujReiQX6aFmIuki+belXPIbhl5kdHjIfsFAhrckKgShoPSKl9gc1Eu8Xq4XXTA==
X-Received: by 2002:a1c:63c4:: with SMTP id x187mr3704674wmb.172.1605000246872;
        Tue, 10 Nov 2020 01:24:06 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:870:7715:aaa1:475e])
        by smtp.gmail.com with ESMTPSA id q17sm1248351wro.36.2020.11.10.01.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 01:24:05 -0800 (PST)
Date:   Tue, 10 Nov 2020 09:24:04 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Quentin Perret <qperret@google.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 17/24] kvm: arm64: Add __hyp_pa_symbol helper macro
Message-ID: <20201110092404.lduvqjpjzeea57vi@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-18-dbrazdil@google.com>
 <20201109165933.GA447754@google.com>
 <1951645a457232caeca323bec2af5408@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1951645a457232caeca323bec2af5408@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 06:10:05PM +0000, Marc Zyngier wrote:
> On 2020-11-09 16:59, Quentin Perret wrote:
> > Hey David,
> > 
> > On Monday 09 Nov 2020 at 11:32:26 (+0000), David Brazdil wrote:
> > > Add helper macro for computing the PA of a kernel symbol in nVHE hyp
> > > code. This will be useful for computing the PA of a PSCI CPU_ON entry
> > > point.
> > > 
> > > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/nvhe/psci.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c
> > > b/arch/arm64/kvm/hyp/nvhe/psci.c
> > > index b0b5df590ba5..7510b9e174e9 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/psci.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/psci.c
> > > @@ -20,6 +20,16 @@ s64 hyp_physvirt_offset;
> > > 
> > >  #define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
> > > 
> > > +#define __hyp_pa_symbol(sym)					\
> > > +	({							\
> > > +		extern char sym[];				\
> > > +		unsigned long kern_va;				\
> > > +								\
> > > +		asm volatile("ldr %0, =%1" : "=r" (kern_va)	\
> > > +					   : "S" (sym));	\
> > > +		kern_va - kimage_voffset;			\
> > > +	})
> > > +
> > 
> > Could this be simplified to __hyp_pa(hyp_symbol_addr(sym))? That would
> > avoid the dependency on kimage_voffset.

Ah, didn't see that one. Ok, removing this patch.

> 
> I'm going to move away from evaluating kimage_voffset at runtime anyway,
> see [1].

Awesome! One more dependency gone.

> 
> Thanks,
> 
>         M.
> 
> [1] https://lore.kernel.org/r/20201109175923.445945-1-maz@kernel.org
> -- 
> Jazz is not dead. It just smells funny...
