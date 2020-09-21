Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD762725F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgIUNoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgIUNn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:43:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1E1C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:43:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so12820453wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PKSAlhSQ9Eh6fSSb1EiKiqDta1PeLzDdGDQlo2aRDw4=;
        b=PBzsm4CksVIWOwAwH9jC9VQ6MVHjGCDUXFV+y2ttxej8Xuexc6+aKCDyieHrP+XQ6r
         YXLZHVgtFM8leGT+Gsel61/uWf0Zz/wLwz3EmVcnWB/uk9xw8cvoNZaosyrBcTp6czSn
         /b4Kqxzo8vqQjA0Gd0WuUt4yNtDcFnoQJXKIHUnGTRPNaWBYlmiRZZkRM40+F6e2Kd1O
         Oxp/yRU5neltD3kropbYH+zuooXNi8ijWFjVPt38BkmsMGO6oVGBF6Y9lsgGrSZvGwyz
         8KC52eHwemtmteuByjnIXT6hLwiRh0KKiS6+e8vHDDy7qRkjVf0IOiYsgsfzk2x+eQys
         xQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PKSAlhSQ9Eh6fSSb1EiKiqDta1PeLzDdGDQlo2aRDw4=;
        b=GtlbL5fj5gJruznFLgBNaDzjHcMm93WFYiX5m5wKRB1nZqz2kjVzET9ItX1zMoFByl
         zWbV0P/18Uy7Cn8puuFGtmi6165cX9MrXzJ6yLcWdT11w4ZdAZz2LYQt3nMaamQNuMCl
         KuBy19NPHtooEOaRosIESWr0HFs/PEDu0gLtsuicsA9VQ42fKSmgc5eiUluTpXPA75QR
         kZYeDNKKIz0GO2BPcv3aBKEZOTjTeGodEgK+2rHzRrRGsHDhVBe14V7JCds1G/WoaB5e
         h3lOKjlwMe5XqvvMZJBZCVyHK6GcTm2WxpQKWlZVIS3Rg+NbSvkwiIfcA99x9MCD0vhF
         q+QA==
X-Gm-Message-State: AOAM532x7dO8dR3AnGNp5TTzvyKjBRhdchSLYvN87FgMgSdZ+gLTE2qE
        dBtYe61VAuljyTgTAAXliWKEMw==
X-Google-Smtp-Source: ABdhPJz+M60dQM2XcDdmSU16x2fFPZSTR+TQAMTpZYcbvWrpRI6wunJ1bR4T+xWDSV5N+1CvR8M6oA==
X-Received: by 2002:adf:cf01:: with SMTP id o1mr53523006wrj.421.1600695837833;
        Mon, 21 Sep 2020 06:43:57 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:e5b6:fa6a:5f89:97d3])
        by smtp.gmail.com with ESMTPSA id q4sm20497820wru.65.2020.09.21.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 06:43:57 -0700 (PDT)
Date:   Mon, 21 Sep 2020 14:43:55 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v3 04/11] kvm: arm64: Remove __hyp_this_cpu_read
Message-ID: <20200921134355.5lzma3qzyiexxepd@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-5-dbrazdil@google.com>
 <20200918090029.GC30834@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918090029.GC30834@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> > +static inline unsigned long __hyp_my_cpu_offset(void)
> > +{
> > +	unsigned long off;
> > +
> > +	/*
> > +	 * We want to allow caching the value, so avoid using volatile and
> > +	 * instead use a fake stack read to hazard against barrier().
> > +	 */
> 
> I don't think we need to copy/paste the comment...
> 
> > +	asm("mrs %0, tpidr_el2" : "=r" (off) :
> > +		"Q" (*(const unsigned long *)current_stack_pointer));
> 
> ... especially given that we're not preemptible at EL2 with nVHE, maybe
> we don't need to play this trick at all because we're always going to be
> on the same CPU. So we could actually just do:
> 
> 	return read_sysreg(tpidr_el2);
> 
> which is much better, and the comment should say something to that effect.

I must be misinterpreting the comment. I understood that it enables the compiler
optimizing multiple reads of TPIDR by avoiding 'asm volatile' (signaling that
the value does not change between reads). So what exactly does it do?

read_sysreg expands to 'asm volatile' but I have no problem with priotizing
readability over a micro-optimization.

> > +#if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
> > +#define __my_cpu_offset __hyp_my_cpu_offset()
> 
> Why would VHE code need to use this? Especially in light of my preemption
> comments above, shouldn't it now be using __kern_my_cpu_offset()?

During v2 review Andrew Scull pointed out we can avoid alternatives on VHE code
by using __hyp_my_cpu_offset for it as well. Obviously if __hyp_my_cpu_offset
becomes nVHE-specific, we can always move VHE back to __kern. This was just
about saving a few cycles during boot.

David
