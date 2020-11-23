Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6D2C0CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgKWOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731465AbgKWOGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:06:31 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F15C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:06:31 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so18782015wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IxKEwJIDkWFWdLOduLQqDMMWI7xU0QNpLG1mKFM02rs=;
        b=g1MeLxRcCLz0WGoi9c0wXjonCBJEJvpXP/SuuinED277DcmBiGSo2ylfvxgPK3Orb+
         IYbF3XUU1Ry9h065YjZh92o2p7ljYo7nRpGMl0NkF6iNLrOo4dNp7jFtk7+h1KYROio6
         dAxhhpaqX/xzThbEqRueM08mFje9M58Ra+GSHt65xzOt0bMHVh7G6P31qfA2PxqShp9b
         zSw6PaOQOTFPpyu3AqjyDhx68FUUk9vKOIWqA3xeHxHo6E4dgNZ0AHmDyBjYJYGmepqa
         wYx8HgdyBTzgzR766Br+hcqgXXDJPuosGuOfGsLkwPI8cC/s6Y4oOTMeBqv0VSEOgnNE
         LGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IxKEwJIDkWFWdLOduLQqDMMWI7xU0QNpLG1mKFM02rs=;
        b=INvJrQuMHxFcM/2NDGgazdYj8fAiuvhOnXSmg5eeedxqkRFhvEZJuCxEJGCEscr30W
         /BDzksDlwtrmmhkBJAiqrdQkxosmtKHr1xUYgtTQ7MquF6aIXuUVDr1KMsshMa3XKhVr
         TEcJCTwzjuJjgTrE2YMipAeyHtrx5BcNlsW/v5oEZsK6vFVI2ZNH8zVUWBiNWkcIGSR9
         CG8Z3VNFl7h/q/PATUJb+cZ9Kz1GS1Z2rM7IUNh+ALrehKf9pKdOpR5NVNUw6JcM4LMO
         eDHyK63z/zfGVzJsA2EqP2yurL7IJd9ViiM+JieNZxDoPihucQksAobLCdNVQSlZx99U
         TPDg==
X-Gm-Message-State: AOAM531qwzgvjnKHlLgXFPHdeuyK6w0h+sb5gJIHMxmHmZCuPTLKslmJ
        KVHz8TQaGci1BCT2DNj2/L7bCg==
X-Google-Smtp-Source: ABdhPJyw1pQaZQIURVIYntzJptazAHx7LZxvhh9s3DKAS6T2mBaDh+IRdAi2bZY6JoIkWxVe9MjV5w==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr30790889wrx.196.1606140390020;
        Mon, 23 Nov 2020 06:06:30 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id l14sm12976982wmi.33.2020.11.23.06.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:06:29 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:06:25 +0000
From:   Quentin Perret <qperret@google.com>
To:     David Brazdil <dbrazdil@google.com>
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
        android-kvm@google.com
Subject: Re: [RFC PATCH 02/27] KVM: arm64: Link position-independent string
 routines into .hyp.text
Message-ID: <20201123140625.GC490744@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-3-qperret@google.com>
 <20201123123425.uzfuk3pmwgzuijwn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123123425.uzfuk3pmwgzuijwn@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 Nov 2020 at 12:34:25 (+0000), David Brazdil wrote:
> On Tue, Nov 17, 2020 at 06:15:42PM +0000, 'Quentin Perret' via kernel-team wrote:
> > diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> > index 8539f34d7538..dd8ccc9efb6a 100644
> > --- a/arch/arm64/kernel/image-vars.h
> > +++ b/arch/arm64/kernel/image-vars.h
> > @@ -105,6 +105,17 @@ KVM_NVHE_ALIAS(__stop___kvm_ex_table);
> >  /* Array containing bases of nVHE per-CPU memory regions. */
> >  KVM_NVHE_ALIAS(kvm_arm_hyp_percpu_base);
> >  
> > +/* Position-independent library routines */
> > +__kvm_nvhe_clear_page			= __kvm_nvhe___pi_clear_page;
> > +__kvm_nvhe_copy_page			= __kvm_nvhe___pi_copy_page;
> > +__kvm_nvhe_memcpy			= __kvm_nvhe___pi_memcpy;
> > +__kvm_nvhe_memset			= __kvm_nvhe___pi_memset;
> > +
> > +#ifdef CONFIG_KASAN
> > +__kvm_nvhe___memcpy			= __kvm_nvhe___pi_memcpy;
> > +__kvm_nvhe___memset			= __kvm_nvhe___pi_memset;
> > +#endif
> > +
> >  #endif /* CONFIG_KVM */
> 
> Nit: Would be good to use the kvm_nvhe_sym() helper for the namespacing.
> And feel free to define something like KVM_NVHE_ALIAS for PI in hyp-image.h.

Ack, that'd be much nicer, I'll fix it up for v2.

Thanks,
Quentin
