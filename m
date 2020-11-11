Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08C42AF26D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKKNpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgKKNpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:45:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F57C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:45:30 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so2571674wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aN9UhE4DLqxeGNvPkzfZsJS2+DLJT4pT+KyGFIkUBxM=;
        b=n6ILGBo/Vse8JvnguXnl3tQYuKcQPOHhQNVXLdZ4gvmWMzEEBVmfuLXBmmzVAt+SGg
         +QMI3ZLjDTF/wfhpjLJfsVSNgTmmQTsOGzhYpn9Ws4AljBWYwc/IsR4l5Gcq3jaQDw+e
         iRMgY2QF6TIkJqwhqwBToAbDeBVpTZ/2lZDjpLLUjmKdtfG0mnuTIeLCCQQ3jTsmrG6R
         n8JolcURVbOgUM4scyPuTbf25B7l0b/AaaNVYfMVXoVu/tzv2XU3i8iAIXzOGTrCgdP1
         QLfIxzUzm0a0P43i4ha4vQqOO3zjnKRLeQJrbA4Jo3LcpMmnu6ZdpYb9Awa0jOdXolG8
         fqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aN9UhE4DLqxeGNvPkzfZsJS2+DLJT4pT+KyGFIkUBxM=;
        b=ess5VFNeaoL4koaLM0GD84B61V5XZIWG21+TYaH/JcIDmm+QZCVi1abB6EgkD/AgQM
         zHyYwOYmNgUBwcvGD4f8c3Mt2FA8UgxUH92ZaPVsok/A4jBwvZZVGttm7ZU3WHOjjcbM
         FGHG2wru/FZj2/byIkVKVKSbVHPM15pR1dvvsYBYcDURlW1bWen4k+RHsAth51XDB+9g
         YUyC7M4ZFB7/wl5iqi1NbV0e9lvdegmxTDHAizD7IDPHjWW2BEkcWWtI9jyUcWM0fPns
         FkHRpa0jDZbxNC+ylDner0GSdU20dUPCNx05OxYPubLgwbHV8Z3hMPtn/gTKYb3oRhVo
         n+Gg==
X-Gm-Message-State: AOAM532k/1WxXZlmmzWeepnA9yM+e8luyeUl6OutbOJh6F1TRsHsglCd
        gGuuaFusxwjoxoWkG1K9G3oYnQ==
X-Google-Smtp-Source: ABdhPJxNfMSdJg/5S43HS/VH+jA7JrZoyOTCCBu3ZeYuIkATnnLfgh3FcQjEebsSYbjXIRr8KwAMdw==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr30003335wrv.258.1605102329039;
        Wed, 11 Nov 2020 05:45:29 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:2595:ed05:1717:fe6e])
        by smtp.gmail.com with ESMTPSA id y63sm2575014wmg.28.2020.11.11.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:45:28 -0800 (PST)
Date:   Wed, 11 Nov 2020 13:45:27 +0000
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
Subject: Re: [PATCH v1 07/24] kvm: arm64: Create nVHE copy of cpu_logical_map
Message-ID: <20201111134527.ygzf5cm6qpdpcroo@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-8-dbrazdil@google.com>
 <d473fd26e5314f2407b70242488f33de@kernel.org>
 <20201111130321.qalrzfabdonrwvsz@google.com>
 <15a580e6ac06294ead8859fba8f51deb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15a580e6ac06294ead8859fba8f51deb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 01:29:29PM +0000, Marc Zyngier wrote:
> On 2020-11-11 13:03, David Brazdil wrote:
> > > > +/*
> > > > + * nVHE copy of data structures tracking available CPU cores.
> > > > + * Only entries for CPUs that were online at KVM init are populated.
> > > > + * Other CPUs should not be allowed to boot because their features were
> > > > + * not checked against the finalized system capabilities.
> > > > + */
> > > > +u64 __ro_after_init __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1]
> > > > = INVALID_HWID };
> > > 
> > > I'm not sure what __ro_after_init means once we get S2 isolation.
> > 
> > It is stretching the definition of 'init' a bit, I know, but I don't see
> > what
> > your worry is about S2? The intention is to mark this read-only for
> > .hyp.text
> > at runtime. With S2, the host won't be able to write to it after KVM
> > init.
> > Obviously that's currently not the case.
> 
> More importantly, EL2 can write to it at any time, which is the bit I'm
> worried
> about, as it makes the annotation misleading.

EL2 can't, at least not accidentally. The hyp memory mapping is PAGE_HYP_RO
(see patch 05). Does this annotation have stronger guarantees in EL1?
AFAICT, those variables are made PAGE_KERNEL_RO in mark_rodata_ro().

> 
> > One thing we might change in the future is marking it RW for some
> > initial
> > setup in a HVC handler, then marking it RO for the rest of uptime.
> 
> That'd be a desirable outcome, and it would be consistent with the rest
> of the kernel.
> 
> > 
> > > 
> > > > +
> > > > +u64 cpu_logical_map(int cpu)
> > > 
> > > nit: is there any reason why "cpu" cannot be unsigned? The thought
> > > of a negative CPU number makes me shiver...
> > 
> > Same here. That's how it's defined in kernel proper, so I went with
> > that.
> 
> I'm happy to deviate from the kernel (give the function a different name
> if this clashes with existing include files).
> 
> We can also fix the rest of the kernel (I've just written the trivial
> patch).

Shouldn't clash with include files. Where fixing the kernel might clash is
all the users of for_each_*_cpu that use an int for the iterator var.

