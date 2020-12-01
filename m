Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3E32CA609
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391704AbgLAOod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391653AbgLAOod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:44:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A34C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:43:52 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so2998335wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JIA0Scl4OIMMkSS/5dfb1RixGjs/UhotRuHwz308dGA=;
        b=ICa9ez6xKvXoVFd5a+nyt9V7db40a6UDXltW3gu+5eDTPPoS7Y+JHn0qhh505cto8f
         GRLJkOPi8X4qfWqafWsQ6KrEg1FBVyXFnMuueku5Rvh2nAkHFVLVmB94DGc7SMapcND8
         iCfVQkWismF7cf9Pxzp3Pi5NrsRfBnkClOAt3axQ3sGSRNPGhXQv7qFGz5pajfx4cjxn
         5vFpF4gkJTjJGtnvbwVNxH5lm7Jc0cCZfd9IXPiS4SNeZVCufI98odvCCzyskxTIRMwx
         S+gz72PQ6q5hfrC4mBZr8J/bOiuIbHPAIKUX5idfyO8GKJNpNm3oeMe1COzvBl6m/a3D
         I85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JIA0Scl4OIMMkSS/5dfb1RixGjs/UhotRuHwz308dGA=;
        b=oGM/JjRJ+J5XvQM5lYtx//68xQj8hSx9vX9/3lXOwqUHUXFYhtUSALPlPVS10H8Hj6
         CgcNpZ+zF1oX0UPgI5pcxx2c4Yb9kl1S9/ILlVX9wekJAqrViD8N810PgcdtZ6ZJ6bZD
         iMHge0UjdkwkjBCbsOl5AevNyjTqq4agYrODv8zCdZZdFYWBiLh0hIJtERWqw25u0j47
         6VLQd4ryfx0/FnwjP03dcLE5EyfFRjIBd/hQcfUyRWQV6Rn26r4jK+cZKfbZXF5cAdlz
         +TzwQ9PsTriB0b9uLI5hwue9nJ/xVFo5XCG65UjoBbbwQKUFC8YHJ8lMl5/MQSGly7Bk
         6kkA==
X-Gm-Message-State: AOAM531KZSWDKgjxxTe1BN+f/RC9AC9vDttoe+1GKmbWwdMEdINv1VJz
        HGMP0RIe3xSuhwA/mvYiuFmDuA==
X-Google-Smtp-Source: ABdhPJxFvoIa6LKNTCZysKjYl0L3o6ekKKdzC32vTURn5ckCGb5MJxfK027unJvURm7vUyFNvUoRNg==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr4467528wru.70.1606833831387;
        Tue, 01 Dec 2020 06:43:51 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:7c5f:5ab5:ac1f:89ce])
        by smtp.gmail.com with ESMTPSA id y130sm99756wmc.22.2020.12.01.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 06:43:50 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:43:49 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kvmarm@lists.cs.columbia.edu,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH v3 06/23] kvm: arm64: Add kvm-arm.protected early kernel
 parameter
Message-ID: <20201201144349.bglz7yicc3peixe6@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-7-dbrazdil@google.com>
 <20201127163254.zxdrszlveaxhluwn@bogus>
 <20201201131913.u7m2eifvtus74dra@google.com>
 <20201201140734.GA86881@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201140734.GA86881@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > be just me, but if you agree please update so that it doesn't give remote
> > > idea that it is not valid on VHE enabled hardware.
> > > 
> > > I was trying to run this on the hardware and was trying to understand the
> > > details on how to do that.
> > 
> > I see what you're saying, but !CONFIG_ARM64_VHE isn't accurate either. The
> > option makes sense if:
> >   1) all cores booted in EL2
> >      == is_hyp_mode_available()
> >   2) ID_AA64MMFR1_EL1.VH=0 or !CONFIG_ARM64_VHE
> >      == !is_kernel_in_hyp_mode()
> > 
> > The former feels implied for KVM, the latter could be 'Valid if the kernel
> > is running in EL1'? WDYT?
> 
> I reckon we can avoid the restriction if we instead add an early stub
> like with have for KASLR. That way we could parse the command line
> early, and if necessary re-initialize EL2 and drop to EL1 before the
> main kernel has to make any decisions about how to initialize things.
> That would allow us to have a more general kvm-arm.mode option where a
> single kernel Image could support:
> 
> * "protected" mode on nVHE or VHE HW
> * "nvhe" mode on nVHE or VHE HW
> * "vhe" mode on VHE HW
> 
> ... defaulting to VHE/nVHE modes depending on HW support.
> 
> That would also be somewhat future-proof if we have to add other
> variants of protected mode in future, as we could extend the mode option
> with parameters for each mode.

Agreed that 'mode' is a more future-proof flag and I would very much love to
have an option to force nVHE on VHE HW. I however expect that the early stub
would not be a trivial addition and would not want to get into that in this
series. Could we agree on 'protected' as the only supported value for the time
being?

David

