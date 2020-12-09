Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F652D4902
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbgLIS2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgLIS2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:28:46 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629ADC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 10:28:06 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id v85so2742659oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMdXn/we+ASAb31gRQdJr6+sKTP4Qjrqm7l5vM7/2N0=;
        b=uBjDfzU8tJe6+V30aOzUET0Fi/1DWGtprJdABI/JEt+ZE2s94Y30fhKOBxmqCUuDeF
         fCcuThp2wkHoxOI9GJmd/AiRPoHa0OZCK5WvKsYdMHLxuoZqZkPae4ik5Rs50LTv7UeP
         WBe9p+LoNI1L76wVobsLQC868+hlmkTN5wIhYZYSXca0eIiTDq7OWBi6ZpodCQNmeqSp
         f9iV5sMKIXZ7cde2m1WxX3kjYqxldYCrtpw2IF15hMkzldHDeUBuifaPwEl/hkntsmNy
         KxRuzDUyZHihNDp5TVjZ9G5WE5RYOOhQgQS2IIcd5F33cWzTIOb/CxOyKXAwwGHpqBlh
         CLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMdXn/we+ASAb31gRQdJr6+sKTP4Qjrqm7l5vM7/2N0=;
        b=OoeqMZTVCG0f90Qf2UZXwgzjbxaQSH/44nmKPmvr0woWpC8MRx9i2KCHwR+GBzUUX4
         eZ3+3lMqYOv8RekSuFl+keezT+oBsBID/JxZXfIXGPzWm5OYX/HuDDTO7MkaFKtbnRvn
         aUIx541tBY2J65KRYE8IF/CJqPCEyZ4rC7PKotVo2KuqjiPFUUZPVhcNsYWzO50x1kUY
         e/RqS0A8TLXtlKhuZRp8D9bFO2lINH+RJG+c7wuvgHqzP4ETxuE3WtkaVMbhiBA6V/Re
         lS2lFW2FqbW0j0xv5oTQrl8pSWWRKjZAuy1xvXod/blImniKmem0v73Ai07GAhsJRdzy
         UMxw==
X-Gm-Message-State: AOAM531ruf9knW/H1cgaLRVVuZpNOH5RigvPCQFK3IH+6fliLU9VF/Gw
        BsOtJVPX2itZySxvrrIAMVKm/g==
X-Google-Smtp-Source: ABdhPJwXF7F87GnE1UfMS2EBOABWhLPgRg1PmpgpVMqLuUiQHVmPOMnB+cm8yzRRg6ho4iiOn74A4w==
X-Received: by 2002:aca:5889:: with SMTP id m131mr2737051oib.41.1607538485699;
        Wed, 09 Dec 2020 10:28:05 -0800 (PST)
Received: from [10.10.121.52] (fixed-187-189-51-144.totalplay.net. [187.189.51.144])
        by smtp.gmail.com with ESMTPSA id k5sm461045oot.30.2020.12.09.10.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 10:28:04 -0800 (PST)
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <haibo.xu@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>
References: <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
 <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
 <0d0eb6da6a11f76d10e532c157181985@kernel.org> <20201207163405.GD1526@gaia>
 <874kkx5thq.wl-maz@kernel.org> <20201208172143.GB13960@gaia>
 <7ff14490e253878d0735633b792e1ea9@kernel.org> <20201209124443.GB13566@gaia>
 <ef14a5158fc65c00f6c3c842cfa83b2c@kernel.org> <20201209152741.GC13566@gaia>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c39b104-39c3-7cca-82b9-2e47d7cb9a9a@linaro.org>
Date:   Wed, 9 Dec 2020 12:27:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209152741.GC13566@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 9:27 AM, Catalin Marinas wrote:
> On Wed, Dec 09, 2020 at 01:25:18PM +0000, Marc Zyngier wrote:
>> Would this syscall operate on the guest address space? Or on the VMM's
>> own mapping?
...
> Whatever is easier for the VMM, I don't think it matters as long as the
> host kernel can get the actual physical address (and linear map
> correspondent). Maybe simpler if it's the VMM address space as the
> kernel can check the access permissions in case you want to hide the
> guest memory from the VMM for other reasons (migration is also off the
> table).

Indeed, such a syscall is no longer specific to vmm's and may be used for any
bulk move of tags that userland might want.

> Without syscalls, an option would be for the VMM to create two mappings:
> one with PROT_MTE for migration and the other without for normal DMA
> etc. That's achievable using memfd_create() or shm_open() and two mmap()
> calls, only one having PROT_MTE. The VMM address space should be
> sufficiently large to map two guest IPAs.

I would have thought that the best way is to use TCO, so that we don't have to
have dual mappings (and however many MB of extra page tables that might imply).


r~
