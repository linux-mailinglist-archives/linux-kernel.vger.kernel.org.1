Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8428FD14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgJPEHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgJPEHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:07:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080FBC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 21:07:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c20so706647pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 21:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8vX6ndPTi8E0weS4M30AEHmjjkLUgJeoHZsUqEDqihg=;
        b=dUdKWY6Jhx5+1cfkWmojPdPlr/pmkDTzwPQ+xyqNJObDcOwpuvD+A3cr0W+xkwP/M0
         YgRdYCg64sgcX/z/zh1WhITxU0bWX+5gGSinRooozAeNpb5zC0VNMteclsfIepJq4aoG
         utgGwQ0GWhETE5xvJI2sC6v0ffOwQOXy4T87rUfAgDozbyke6L7owsoTd/JtQ2LM4cZd
         juG05Xa0+MNJgWGp8qCFkYRpUe17UdqYgsDMdW8tszaWZwBbm/Fl1yrAt5DeMtffO++U
         xa995M0boaXZ0+HhiM8rcI8P7JpATbsG4N3ONQgIZCPZDQUiKVXSTjnGC1i9dlxtEfMr
         TeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8vX6ndPTi8E0weS4M30AEHmjjkLUgJeoHZsUqEDqihg=;
        b=cXT0grSR/9Kpnay0tQJ0ejH6Qx13hKwqFRUgPWkOIRmdsZjGK1qWBkUCIf7UBKEndL
         XXOJ6UFS3HJvsdv+Ial4uu08XXozu3YSY3/MA+zqMXVIYJ+HqDHhoQG76F3PhBFIxMlr
         ywzZaa4uhm4kau3HFCsDPjmOZYEAUU3II+G5OyGFMCOu3orF9nGg6x3DAT/3p2Kl+Hh9
         FNkg7gbCuHExIkpSK6aIldT/jXKYG0VFUnHuYxFWYsRp5JuOnH6yP8UClg1yIfZVaVwd
         AaOXm2O7V15ukPQHEGe84rSnKAfgsVr2cK4PzACiqK9VMI//lcNOHSPqe3pE3SXC8aA9
         z+tQ==
X-Gm-Message-State: AOAM532nnLCjR/AmQLwnRGCUkt5gkDS4jD+X/KNs/U4aySNb+26Y9R7G
        h76liWnM6PAro6aEYEUyPE/trg==
X-Google-Smtp-Source: ABdhPJyBTTEAFamTg4RJhFEdUUEc/mchclzo4KAppRt1V0Onx7JzwJTpskED/j0U2zGvoBE6O9jPNw==
X-Received: by 2002:aa7:83d9:0:b029:138:b217:f347 with SMTP id j25-20020aa783d90000b0290138b217f347mr1937661pfn.0.1602821223447;
        Thu, 15 Oct 2020 21:07:03 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e20sm858618pfi.30.2020.10.15.21.07.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 21:07:02 -0700 (PDT)
Date:   Fri, 16 Oct 2020 09:37:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: tegra186: Fix initial frequency
Message-ID: <20201016040700.wzfegk7hmabxgpff@vireshk-i7>
References: <20200824145907.331899-1-jonathanh@nvidia.com>
 <20200825055003.qfsuktsv7cyouxei@vireshk-i7>
 <09ac354e-a55b-5300-12ae-3f24c8f8b193@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ac354e-a55b-5300-12ae-3f24c8f8b193@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-20, 15:03, Jon Hunter wrote:
> If not too late, would you mind dropping this patch for v5.10?

It is already part of Linus's master now.

-- 
viresh
