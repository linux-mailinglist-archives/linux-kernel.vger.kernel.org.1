Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCAFA2D4B59
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbgLIUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbgLIUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:13:51 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7101C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 12:13:10 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id q25so2643169otn.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 12:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e8PjCwF/fkBvctzYsKsZigRs7c0yUbgHiIHG6Juga9s=;
        b=BIV963S9gDvXeQAOzns5FeH54xHaZsWE2jkhvfcqjhTbpeqeT0estcM/IfKJmSSHH+
         jkh57TwvgmRVvfxB+Qo71cAE0xrZYMHfkKuyI64hd1XQdnL6GMJZlsO2xpbIJrcTcX9V
         vKHcJUdwk3WKtQciMOSuTQh5G++HPfT/Joq8LGH4unQwsOxA44wujOoCBlvODbfuPGzg
         el+3ulvnUXnUhmFx+pSJBMi+fGpeU+1aEjt7cOgXEdndQM3eISMcRGcodf14HUz4jTJo
         bYRVTqY7o9uYWxwgrlTFgr47ReMJfvbUmzJ/WQpWW6Ri+wy8gteEDbtHpTLzD9lngSKX
         RzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8PjCwF/fkBvctzYsKsZigRs7c0yUbgHiIHG6Juga9s=;
        b=jG0oTSRlcUMYXrsoS37HKZ8NujcxIR7aB6vdah2BoFhQ91SkQQFQbLcLv+VaFrvvCM
         5IeHiI2S89jFZbf3L926d9ZnhiuDzewcUz2Kk8wtdpyM7xKLbZGQTZUL2yvZ+mJDCGvL
         dVPqsnPuhjcgdAGoy3RXBYWBi2umbuOb6+bZ71f0cq6kp0ptrcZBeqdAlYrdglCkeWcZ
         2IqHtMDegUsvjbpxVmBHNH7HIQstQcJudz2cJ1658A6p8T/d4hsteDBEGpWLGynCAo1I
         bhZsGJWUtvDQPIQAR+jUZShJkoIkHUUtXCOIuq0koZpiFWNVZMruAnpSe7pOH/8bBU9C
         Y6Mg==
X-Gm-Message-State: AOAM532K8MDyud+immWSj5Bv06iOgMSWn6IUPV/wvujmbM0cWiD+2D/+
        70ZooGEtUnRlY8prIxH0/WVD3Q==
X-Google-Smtp-Source: ABdhPJymjhe79Shp+3MxdinfT87wlVy927PQ3peJTbXAMIVFHAHI6bhArk4K6dMUycTMNOoArAw/Kw==
X-Received: by 2002:a05:6830:1ae4:: with SMTP id c4mr2163447otd.295.1607544790091;
        Wed, 09 Dec 2020 12:13:10 -0800 (PST)
Received: from [10.10.121.52] (fixed-187-189-51-144.totalplay.net. [187.189.51.144])
        by smtp.gmail.com with ESMTPSA id l1sm522451ooi.48.2020.12.09.12.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 12:13:09 -0800 (PST)
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
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
References: <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com>
 <0d0eb6da6a11f76d10e532c157181985@kernel.org> <20201207163405.GD1526@gaia>
 <874kkx5thq.wl-maz@kernel.org> <20201208172143.GB13960@gaia>
 <7ff14490e253878d0735633b792e1ea9@kernel.org> <20201209124443.GB13566@gaia>
 <ef14a5158fc65c00f6c3c842cfa83b2c@kernel.org> <20201209152741.GC13566@gaia>
 <8c39b104-39c3-7cca-82b9-2e47d7cb9a9a@linaro.org>
 <20201209183920.GI13566@gaia>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b9072fb-1232-e9fb-0b97-e69709980f99@linaro.org>
Date:   Wed, 9 Dec 2020 14:13:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201209183920.GI13566@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 12:39 PM, Catalin Marinas wrote:
>> I would have thought that the best way is to use TCO, so that we don't have to
>> have dual mappings (and however many MB of extra page tables that might imply).
> 
> The problem appears when the VMM wants to use MTE itself (e.g. linked
> against an MTE-aware glibc), toggling TCO is no longer generic enough,
> especially when it comes to device emulation.

But we do know exactly when we're manipulating guest memory -- we have special
routines for that.  So the special routines gain a toggle of TCO around the
exact guest memory manipulation, not a blanket disable of MTE across large
swaths of QEMU.


r~
