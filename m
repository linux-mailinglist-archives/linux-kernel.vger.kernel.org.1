Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030482F3629
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbhALQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390718AbhALQu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:50:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06E6C061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:50:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t30so3253896wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=90x7bSE6XP8JZlzynOLHF7U7UF119XCh3OM9LGBjMTs=;
        b=VeV7Bhbi83JAOnTWd71Dy939nVpu0J42s1sPM4bsu44fgHA910w59T24ByGjHj2k7B
         WWcR3YELkWLB8XK50PnnLR4gfbh2NKfaOsRVUn+dnMDddWD94eB53iViry2J/gyWkcs0
         iJrpCk9E/iZdoRBdsSr9jcGh+i1jdxEbRpW0iuqqpLPYkphnlVHvQJvcrnltVRybFdOn
         CeiDSnZKMNQkaEQtyGiNRx725KRfnaSPh9WtwkAxESUeeR0pz2L2tqZWhAy0q+Vck8Sb
         fQIfk204viOE/LY5i8CJlXl4RXPqVJXSoZKPs933VKUmcHwgdQIcOmDmjiDThspf0U0c
         /gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=90x7bSE6XP8JZlzynOLHF7U7UF119XCh3OM9LGBjMTs=;
        b=tj87UUhobA2YFl5DCoy3t5LwhyckhUcgAoKxxPNyJRUM4ffUpGTsZnO9zSBLnikvtJ
         a2G981e7EOtvXAK3++dfVTLJEEcCO4IAdFwc9PKdpfSqIu0Kr4dvWPaeHCuGHHPuNXVI
         +2DO0gHEwxws6x5kSjKADSQfz+B+ObuLbLIaxWgwKlSuio9TBG3WmmmHA4x9EJQUiB9j
         UqzpQL04EZ2l0KEFkJ4TJFYZFgEMrb7VbFcmN9+yKDkCg3vRO5dQklztmI/MlqDtQOpa
         drMxaxJzXxIpjhj+c8ovqFBqGiWv8OPlXTuWDDS5TvmWzRCVOT4iYiatmjeNfMWnrmva
         G4ZA==
X-Gm-Message-State: AOAM5327z+NffHRRuBREb56f4aXG2gBco/DNkigx8ioUv9shLjKrI9Nu
        dUA/tl12CcqmBniQC+lAQ7pVJw==
X-Google-Smtp-Source: ABdhPJzS5AdRFcljD6Jz7OxKl5NJ+IEYr2nuZgQOpFTfBMfhhk81jA6ozUI57bPy8UvCQiWftyNS0g==
X-Received: by 2002:a05:6000:2c1:: with SMTP id o1mr5334917wry.264.1610470215396;
        Tue, 12 Jan 2021 08:50:15 -0800 (PST)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id n10sm4133998wrx.21.2021.01.12.08.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:50:14 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:50:12 +0000
From:   Quentin Perret <qperret@google.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 15/26] of/fdt: Introduce
 early_init_dt_add_memory_hyp()
Message-ID: <X/3TRIkakv9mSHSQ@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-16-qperret@google.com>
 <CAL_JsqLmzFWmTc=6JSRMofSEVRx9GCrwGxEsYog9dC16EMGdvQ@mail.gmail.com>
 <X/1xN2UxiUxkzAiN@google.com>
 <CAL_Jsq+5d+Ox_-m_Rd83R9xoZb6e2cxCNfbL8YPzKdwj=y0M8Q@mail.gmail.com>
 <X/2xlxx9Ucp4UZvL@google.com>
 <CAL_Jsq+o+t4YYXEW_nYqMsT4ubYJWe6Kdhu614RtrCqsHBtfLw@mail.gmail.com>
 <X/3LIGgx83XJ+U0F@google.com>
 <CAL_Jsq+SeOrn4qFyFuPUmXdnM1oMNMLWLsDzrYgUt9Ts3hyoNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+SeOrn4qFyFuPUmXdnM1oMNMLWLsDzrYgUt9Ts3hyoNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 Jan 2021 at 10:45:56 (-0600), Rob Herring wrote:
> Umm, yes you are right. But both are dealing with nomap. So someone
> needs to sort out what the right thing to do here is. No one cared
> enough to follow up in a year and a half.

Fair enough, happy to do that. I'll send a small series with these two
patches independently from this series which may take a while to land.

Thanks,
Quentin
