Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C922CA39C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390915AbgLANT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390680AbgLANT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:19:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2851C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:19:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so2599680wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pffIlxOmfR0gBVuszJT4P2RM92yWm19L13Fi6KZxY80=;
        b=g8r5HIuJm61ScStvkO7mJrI+1nn38z/980CV6TzqHAnq/C/tMpn8R0PxPMpdICIKFz
         KItikUjWHc9uvevp/742fpTQlJp9GaHVv+u8IxeGH1Eb8zaqaeqs18N/qHN3tAIeTEJc
         5bJf9zmO5oXCMIOHPvTM2mV3Zv1N6PSLSx4WNifkn3wEzI5gDFJl0lMu8IyD+oq2rWnW
         b4H4Dxui2ENwK3LINaVISyu0Uu498hRHfGi7tEXFmE5oEZgj8RCFV/RP+vsy8sirzVOY
         Eq3m8ra9jGoB+/q/94NpjZJ89tvQ2zIj+da16hIfj48eqsD914RqpXmPGpGwlFLWG2CR
         ILYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pffIlxOmfR0gBVuszJT4P2RM92yWm19L13Fi6KZxY80=;
        b=OxnfptNiGV6Q7MgUKD01YeHuD1gt4SY1jov5DnDEnIne2iMYV46IiFVR3ocguXfa41
         rkIvlEvNdScFWhf9Cr6GN9Vzv41KaaqbZUC/43Ippm0FXTqECGicgYrArRAnz7Nj1Puu
         8hYENmXeeLCKRpvR1Pxps/8FUD2A6/bwqWTp2AcJvbkGdAf2p3InrNLrn8IQKYcpE9bP
         7cQcteq17icZecTrIqPk6d5O0XTKeq4Hevc9Jb4kKDCosb7so1U5+xsqwYJHWpils5Qu
         rO53gmZl9/pMsM+cTchlJzySg1wJTL0VV/dydcDV13IJCF/4VYHX1P9g7pnf1wph5dTD
         RDFw==
X-Gm-Message-State: AOAM5334gjCkaubFUUetTjgXBz5Rg734JwPqgrCG3+3jCTukdg4HolSj
        IHcVkc65aY4+A9vt/r0fuT2izQ==
X-Google-Smtp-Source: ABdhPJxNpkgurha25ZUu8Qo29Cw4yJ3wJ4kR79/690cFW6P+G6s4//zbglAbpD8RaDoVhiqxuedQsg==
X-Received: by 2002:adf:a549:: with SMTP id j9mr3894987wrb.199.1606828756387;
        Tue, 01 Dec 2020 05:19:16 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:7c5f:5ab5:ac1f:89ce])
        by smtp.gmail.com with ESMTPSA id d17sm3237705wro.62.2020.12.01.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:19:15 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:19:13 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH v3 06/23] kvm: arm64: Add kvm-arm.protected early kernel
 parameter
Message-ID: <20201201131913.u7m2eifvtus74dra@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-7-dbrazdil@google.com>
 <20201127163254.zxdrszlveaxhluwn@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127163254.zxdrszlveaxhluwn@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sudeep,

> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 526d65d8573a..06c89975c29c 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2259,6 +2259,11 @@
> >  			for all guests.
> >  			Default is 1 (enabled) if in 64-bit or 32-bit PAE mode.
> >  
> > +	kvm-arm.protected=
> > +			[KVM,ARM] Allow spawning protected guests whose state
> > +			is kept private from the host. Only valid for non-VHE.
> > +			Default is 0 (disabled).
> > +
> 
> Sorry for being pedantic. Can we reword this to say valid for
> !CONFIG_ARM64_VHE ? I read this as valid only for non-VHE hardware, it may
> be just me, but if you agree please update so that it doesn't give remote
> idea that it is not valid on VHE enabled hardware.
> 
> I was trying to run this on the hardware and was trying to understand the
> details on how to do that.

I see what you're saying, but !CONFIG_ARM64_VHE isn't accurate either. The
option makes sense if:
  1) all cores booted in EL2
     == is_hyp_mode_available()
  2) ID_AA64MMFR1_EL1.VH=0 or !CONFIG_ARM64_VHE
     == !is_kernel_in_hyp_mode()

The former feels implied for KVM, the latter could be 'Valid if the kernel
is running in EL1'? WDYT?

-David
