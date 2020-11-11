Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98B12AF0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgKKMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKKMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:32:26 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F725C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 04:32:26 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so2149365wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 04:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XtEuYJqpVWdYVZAacuVpb6hyxFgTbQMkbAIhltpNKL8=;
        b=Ja7qkn/lq9oiqwC27+zkFQJeArO4GLvWWzlfFEwQ4TlruRJR5FzFVktlan4lAT8uhT
         GTABF5yUj9gP5jOMJ9b5esYLbeH5VjnSC//QJghLJYlz73VNRELC20/ketIza7Dr2R8U
         cCkGoBD7R6CNx1xup45TuhqV+reaJnR2Cd0zcdo6OcHKd6Sxt4z0Np1Bu6C2Z5LKmWKV
         5UgF385H5RiSnyWytK9qT7kC4gPbObKUnFyLIn3MFhVEWNO4irXz27rtFMVJsspRyhBJ
         1uT0ZDHMKlz9yGFhLJjHKc+kpshuA1VbkZOaClTXU0YlDhhMESkMLX080Wqtp0Qw9iIF
         DR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XtEuYJqpVWdYVZAacuVpb6hyxFgTbQMkbAIhltpNKL8=;
        b=N9YlOwdMaEpzPiuEaw4V59QLW3rEfFA+nB4678gNl71QBsOBcCGvi1ccwQ7z5z7G0H
         IX1dr+CeZNPsQHuV6QxtdgQwK6tPoaGcNBFmlFbQZSnbkoXz1SB9qaHJqA9eNRWglE2p
         QPZmA41xRQy2QrstSUKaQgQGQsgam4HtENvtUO/s8hB/rWdx/WvuNtxysguc8CxcnnzU
         40dSYJBJ+7XodMbQDZIw/FgdMBs1yXpGsS7WVUzIBi6i7frCsQcIFMjbR8owwKMdOnoV
         FH4G6rIe9CU1ifu1Ao70BhQ1wvx8AF7XAQ02o+iHn9ANuvDSN2lu6LsTf8nt6KsNWmcI
         +kCQ==
X-Gm-Message-State: AOAM530581KBBF30bj/O0iBt0BNmnDJJ2ugvGflkEbuTE5bjLkpN47UY
        o6vdfs+2pb0TyC6/so4sfZoRhA==
X-Google-Smtp-Source: ABdhPJyMdXM5aicXN5Ib33YGeRQlcphSIsMKmTWL4A6/3D5qrbO5zhbeG85AQYouCaWcr+Nk5zMANQ==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr3911891wmj.77.1605097945020;
        Wed, 11 Nov 2020 04:32:25 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:2595:ed05:1717:fe6e])
        by smtp.gmail.com with ESMTPSA id q16sm2414688wrn.13.2020.11.11.04.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:32:23 -0800 (PST)
Date:   Wed, 11 Nov 2020 12:32:22 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 06/24] kvm: arm64: Support per_cpu_ptr in nVHE hyp code
Message-ID: <20201111123222.ooevu6nryu3ncphv@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-7-dbrazdil@google.com>
 <f28c9a67759cb04157e888b3a71b2ce2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f28c9a67759cb04157e888b3a71b2ce2@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +	cpu_base_array = kern_hyp_va(&kvm_arm_hyp_percpu_base[0]);
> 
> There is no guarantee that this will not generate a PC relative
> addressing, resulting in kern_hyp_va() being applied twice.
> 
> Consider using hyp_symbol_addr() instead, which always does the right
> by forcing a PC relative addressing and not subsequently mangling
> the address.
> 
> > +	this_cpu_base = kern_hyp_va(cpu_base_array[cpu]);
> > +	return this_cpu_base - (unsigned long)&__per_cpu_start;
> 
> And this is the opposite case: if the compiler generates an absolute
> address, you're toast. Yes, this is just as unlikely, but hey...
> Same remedy should apply.

Good point, and I'll probably keep forgetting about this in the future. Now
that all .hyp.text is only executed under hyp page tables, should we start
thinking about fixing up the relocations?
