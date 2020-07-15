Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5B2202F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 05:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGODgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 23:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgGODga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:36:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19ABC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:36:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so1282057pfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wo4NFzdUiw6uJIzUDiz1BlvrT/9thiObvUTasK+LFJQ=;
        b=Mq1a22iMCVQmgzxOV0p0g+z9f6rKXO6mZiH6yQC84D5gxUZna9mVPfEGlQlm4ODD4s
         jvEcnb70QVoapMd8KwRbccqaKJCCIvOC3TlbYRSlR35kKKN9MSD12iMV7tzjfnh0jhxY
         1e/ZT5ntIMkVbQZrEt9sgT6hauP/RZtbcjpqij4a2lVbIB4rs7f6XIrepinp36VDp/8/
         ayHDNS59IXPBQ+4KCBhdaDOpiZSkee50rFHZ3cN5xPaMwjY0heHMsIWgPehAtKfe8cTe
         pWU+sCF3m+71zjIm6CYlZT9jftXoi1Y/3N2Cni8Ee4NjlK2z8pqO0iWO6rR4mRTdyC9a
         PA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wo4NFzdUiw6uJIzUDiz1BlvrT/9thiObvUTasK+LFJQ=;
        b=DXDE6MprRxGqkWivDUJQE4ZGBtmLpFEjELWLQKk6eBfjIWCpXl3ZxIeeFupHng+l5Y
         2DHrx7aTD+r2dRPh4j3OOLgsKLMH9fdN39XJSRxx27dzaW5CoGRDfkH7Td0TOC5gDSsQ
         nrYrr74B2IWNbb1rvTNx21Ed55adjRoyoGt1hOVYNHYCtxtMtU9yoUzPGrrzRQJsNkkA
         ub/Qacfn4vmmX0MYBEq6WStJLW0IQEHm1w5U1OwZoQL5jmVWUOMa1QHwxOxN+8Lz+8et
         gc5cpECU7mdgyw76hN5VdrSxi9lZzk155JP1KJlEvTB/LMeRTnNM3QGF84+uIa2VV0vW
         Kyeg==
X-Gm-Message-State: AOAM532oqUvRnOfF90OvRNIiRQzLQOc0U4eKiD2K8jkT7OMrpegRqaqM
        Ecr9MoTmgTH6/ffpU4CneVXOXg==
X-Google-Smtp-Source: ABdhPJx0CEZPVwHRb6DRG98OrDg97SD6ru4U8kBXKcnC8XCCUtODi6z6J8bdIefYHU1pjE+nyl0sUQ==
X-Received: by 2002:a63:e60b:: with SMTP id g11mr6368821pgh.188.1594784190122;
        Tue, 14 Jul 2020 20:36:30 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id nh14sm424492pjb.4.2020.07.14.20.36.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 20:36:29 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:06:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/13] Rid W=1 warnings in CPUFreq
Message-ID: <20200715033627.k6ardlhm3z3w65xw@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714145049.2496163-1-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> After these patches are applied, the build system no longer
> complains about any W=0 nor W=1 level warnings in drivers/cpufreq.

And you need to rebase this stuff of pm/linux-next, as there are some
changes in cpufreq.c there.

-- 
viresh
