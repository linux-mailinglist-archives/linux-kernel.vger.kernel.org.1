Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BC32FB6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbhASJ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbhASJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:13:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D12C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:12:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id kx7so2137077pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mhq6+MsHUQV7TIzepvt+9lxlFxVhKFu6Vfs/P5sqRA0=;
        b=zCNu3jZhy89x1DZ/SxSwSTwFiPtHKNPAM/fzd0bmr/HBP7y5vEiDKUduu29kraQ7ob
         3d3JtdoM8LAQ7q1Vqnz2kJTn9niMpZUVvbUbzdwaLlPmP2VAem2f5wu4eLTL8DtgYZ+G
         rho12iYSe1+zuxbrnqngdJq5bA0mpZUufwYcSy1eVOII1K/owe6N75/GzP/Z6p0BM2Le
         yvHnO+8FBM2Ycj/6WFsbj9OXI5e8x5RxUFMP70Zkxt5UG+FhTgiD2GL7WtuQYCLb2gaK
         +cemfsR9773GOrgq9qP28AourpqbCeA9JKjajeLC/Db1DNPwPD9xTzP4Ca741yohJsHA
         xJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mhq6+MsHUQV7TIzepvt+9lxlFxVhKFu6Vfs/P5sqRA0=;
        b=WP2CYeLTGls9NZX3IsAFVWQla2Sa0szth7qvcvONk0WbLx4S8kQw2LP9joA21TturA
         p5EFekvkf6Oy4wJFd06w12msTM1fUafeo/oHBgOwksa7YLAYiAzmWZm+wEmz0xAY4oyx
         o7pB1mM006nTzFQP6wQ2GvhrFdZSQj+WkJtl8CsAFf3DFF5v/ZHqzC7DkUBP9cuPWPSM
         DCO2KVM+GJt3b3qkNJRaQDuVMNASZfwytCZJlSY/FyMWXvmt9+FPowk9AytyoGAlK6xV
         rFpxf9V84ztUhkE8FzwoJslMd1TX05+F6libfGTOui5tQf2PnZ1ewplz1pEoxA187Gsv
         wlVw==
X-Gm-Message-State: AOAM5333yQaWxeH3R+qzCI8Wm4GPt3WIdD0rQi7hPO0hiSOn7q+f/Bwk
        p1CFCq4kKgeDJSmRZCWi2z2Y4ASk1lmBXQ==
X-Google-Smtp-Source: ABdhPJyZ/4rdEg6QuISCj6DWNWBZsbWDsCCApjNRz8TnyF+D9beBWAYgwRYxLLloaPYO/6j2UeTHEw==
X-Received: by 2002:a17:90a:4096:: with SMTP id l22mr4279450pjg.114.1611047552114;
        Tue, 19 Jan 2021 01:12:32 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id hs21sm2237380pjb.6.2021.01.19.01.12.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 01:12:30 -0800 (PST)
Date:   Tue, 19 Jan 2021 14:42:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/3] arm64: topology: improvements
Message-ID: <20210119091228.zkshnk37mxtiabir@vireshk-i7>
References: <cover.1610104461.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610104461.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-21, 16:46, Viresh Kumar wrote:
> Hi,
> 
> Here is the V4 with the general improvements for topology stuff. This
> cleans up the code and makes it work with cpufreq modules.
> 
> V4:
> - Added Rby from Ionela.
> - In 3/3, Print cpus instead of amu_fie_cpus and make it pr_debug
>   instead.
> 
> Viresh Kumar (3):
>   arm64: topology: Avoid the have_policy check
>   arm64: topology: Reorder init_amu_fie() a bit
>   arm64: topology: Make AMUs work with modular cpufreq drivers
> 
>  arch/arm64/kernel/topology.c | 115 +++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 59 deletions(-)

Catalin,

Can you please push this series for 5.12? Thanks.

-- 
viresh
