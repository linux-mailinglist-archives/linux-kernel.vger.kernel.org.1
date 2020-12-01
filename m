Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA992CA466
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391334AbgLANwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387884AbgLANwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:52:20 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:51:39 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u12so2768591wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EQOI8T+d8gKQ2/dOWJZGivhsk/dAAdxIvvx15lVtny0=;
        b=nkgSXV2gOuBncMrl6+3qDmAAJ4sR0cdviEFX9turKav6mGUBpXp81f6hKbuJBj5J21
         N/LPrBTLq6YzT24g9KYZcIeH/otFXDRLF1bVxLD4QdMx05wn81nclYKmV/Ymr/0lvCGc
         qE+YeW2TSkoqBDMFyBUyHpLNUen/MGvUi3BE1URoNJGKnWdJZgZXgwuckoFZJuXo6fzv
         JxgI7Vipe6a5Q85l7yBv3yg/BIFoAcL1Hhp8J6e86aq7ne5qvATCGBPtB2vx5Ih0JSgX
         ipwQCUb2RNzz9+9u/prs0HS3hKdSabdM+0Oeclxlq/B+fzMfZqHdETKz8L/h71aKuvk2
         QUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQOI8T+d8gKQ2/dOWJZGivhsk/dAAdxIvvx15lVtny0=;
        b=VwrNenZMDNYZkvRkaMIHxG1cw2wTTcwlE7rbpIXzbcFBR9TzWNPLGkjkEea2bXa8Ys
         Vd90VTaO81C6atnTOJg5ZtkzTbpIU8zXh4iLLP+TF+SnjwxbbfmYserGpg8TVODCXakx
         wnhPwwrWBSE+dAcDlKlTYYV6/n8roL4lFDtPHoI81R/AK9gunhr0DW5k7BVzF1nlbF6M
         AU9Jpc8qrw3Y6/ApxaYIhNBsCs3lZxKmJlwsom8V76887+4qsyBQAzMGQi4dPTBkm8p3
         AUqNNABHaXGCbWDYF4oIZD/EiKjAOFB3yAtQ6xSHXOFo1eOpG5PiV3SXhFEabp3nY7Se
         zgKQ==
X-Gm-Message-State: AOAM530dDBfxCwLHNal7z6072T29nak1cVH4oY1FYA7CqFsEySqkCSaL
        NPEQETv93xq8u2G16ttOybSljg==
X-Google-Smtp-Source: ABdhPJwh0+cFKMPciz4Nv7GTSBxYfP4MSIi6pO0Seh9bXRp5bIKM0x+xRWrLyjLNPXBk204l11OtTA==
X-Received: by 2002:adf:a39e:: with SMTP id l30mr3882676wrb.195.1606830698299;
        Tue, 01 Dec 2020 05:51:38 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:7c5f:5ab5:ac1f:89ce])
        by smtp.gmail.com with ESMTPSA id e3sm3281251wro.90.2020.12.01.05.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:51:37 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:51:35 +0000
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
Subject: Re: [PATCH v3 19/23] kvm: arm64: Intercept host's CPU_ON SMCs
Message-ID: <20201201135135.ejgqytcxqyiwyic6@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-20-dbrazdil@google.com>
 <20201127174726.4b6azdyzn5j6qmao@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127174726.4b6azdyzn5j6qmao@bogus>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sudeep,

> > +static unsigned int find_cpu_id(u64 mpidr)
> > +{
> > +	unsigned int i;
> > +
> > +	/* Reject invalid MPIDRs */
> > +	if (mpidr & ~MPIDR_HWID_BITMASK)
> > +		return INVALID_CPU_ID;
> > +
> > +	for (i = 0; i < NR_CPUS; i++) {
> 
> I may not have understood the flow correctly, so just asking:

> This is just called for secondaries on boot right ? 
No, secondaries are booted before KVM is initialized. kvm_arch_init() installs
the hypervisor on each core that is online at that point. That flow does not
touch this code.

But the kernel can later power down some of those cares and then this handler
is called if it tries to power them on again. You can exercise this with:

	# echo 0 > /sys/devices/system/cpu/cpu5/online
	# echo 1 > /sys/devices/system/cpu/cpu5/online

> And the cpumasks are setup by then ? 
Cpumasks are initialized before KVM init, so yes, we could copy that
information up to EL2 and use it here. That comes down to copying `nr_cpu_ids`
because the possible set is logical IDs 0..nr_cpu_ids-1 (see smp_init_cpus()).

> Just trying to see if we can use cpu_possible_mask instead of running through
> all 256/1k/4k cpus(ofcourse based on NR_CPUS config)

I decided to keep things simple because a valid MPIDR should not need to
scan the entire array, at most the first `nr_cpu_ids` entries. An invalid MPIDR
will scan all NR_CPUS entries but that does not seem worth optimizing for.

David
