Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBB24AE7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 07:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgHTFjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 01:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHTFjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:39:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49168C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 22:39:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so610135pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THYhk6JOC4TXpYcTdTNB05bB3kc64g/hoRGOJ2KPS5g=;
        b=vUNZOjjum+PBtEM3XlGi73tWZ5COii2DJIxmx3PWecAaYP9ZkvQUA7habblAnQnr6d
         alqrkUOAhgfUDXVG7WOOUGxceCadhsQh/LBW98JK8KmX/2c1Kn/PUn7HN4V2K6cx6p3U
         GsKt+ALuaCIaI6S2b8rxVKkNQrxFMMbHXW2e22cCB0gpgwnewwThTAttwYA8fGBN7CdO
         Fn1oNlNG1TB0kVnpI0/8Ei7m3hcwPoWdPiyd3cAwl2G1Sarxl5ZcSBxtB+1kvyO7TVrw
         SYyTOaFPJbATGo+HmKy+0kwEAYwvH3C58ILx1n9AmgRcUtE4veIvTM11S2CUZ3ZIeVBm
         WnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=THYhk6JOC4TXpYcTdTNB05bB3kc64g/hoRGOJ2KPS5g=;
        b=oabiNi6A3izMpHb12iNRfShWQGNaWCKysjYT9nO0hFjZR275vLCX/oEo2r+bcVi+Z7
         Majm/zbND5NNT3VZ38W9WmWMf69uhcWBBkHr3OlcGmNxQPLw8B+Lneyq2mni8i4ABS0t
         w5fkGRlaCbBJsDFbjYdeU3vCDP2iT3Z8Rpf2y2VeDjNbEvumiYuAqUnRH8gu+ulRoIrN
         ImOQxk+j6t+WCfCunPGcRMRgNQxKy4JAk7xzTXuzJsiRZCIE1j0tBE2Kpe7JOBFdaw94
         wkOU3GP+/Bm5Ss31tmne39AW2R1U3G86jgFPaXlqn+eJhz5X+6ZlgSRfKrpcrlB0XIWg
         VfgA==
X-Gm-Message-State: AOAM5319Z8pXwzrMGFEUJTHIewA96FZ8cls1VsCHOeQEC7f2OgBW0ePk
        qtaAyLYv6lYQ3ujkQM2nu/HmFQ==
X-Google-Smtp-Source: ABdhPJyiv6R/08txV3btGY8Wex4DoNWiQ9V8i7TVrXG6grrAcw0P8NDqDoa/L6UCGKZqA6mKxIB7VA==
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr1028280pfk.219.1597901988631;
        Wed, 19 Aug 2020 22:39:48 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id u21sm802708pjn.27.2020.08.19.22.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 22:39:47 -0700 (PDT)
Date:   Thu, 20 Aug 2020 11:09:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     sudeep.holla@arm.com, rjw@rjwysocki.net, catalin.marinas@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, wangkefeng.wang@huawei.com
Subject: Re: [Patch] cpufreq: replace cpu_logical_map with read_cpuid_mpir
Message-ID: <20200820053945.xlwtpkvbt4o23flk@vireshk-i7>
References: <1597174997-22505-1-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597174997-22505-1-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-08-20, 01:13, Sumit Gupta wrote:
> Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
> fixes the issue with building tegra194 cpufreq driver as module. But
> the fix might cause problem while supporting physical cpu hotplug[1].
> 
> This patch fixes the original problem by avoiding use of cpu_logical_map().
> Instead calling read_cpuid_mpidr() to get MPIDR on target cpu.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200724131059.GB6521@bogus/
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh
