Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1A2D9703
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407705AbgLNLIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgLNLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:08:02 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0420DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 03:07:22 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id p18so648321pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 03:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nhvczI875RAqYozQmX6a4KjWPjocOe6JQuYZD7+5AbY=;
        b=a59rYTd34IN0283Kz0g5E3Dac35Dk/rAaqo7/ZxKc8hDqNM93JEihIaHgJg9dyYZQ5
         6alyoRFrLGHkpdU0OxqB0SH6BTcbh6a97Bxbi/nSX0EASaowqfmxHeptaQ9WS3yULUVF
         kIHy6iK7yZz9MK7fC4ej6vFReon7ppo13rIckXDGSpK3stREcfBatHkIwfJtxvvnwmQx
         EPdd0gERHndsau6Pe2wblaLOK+MnqBplB1kCAQJLhl9fzlA5XSd0Pk/fXDxGdKbW+vCm
         2oQVp6CEUIZC6bRYDR4TybwwN+v7bezqT/1DPq7f7DgpQ2cbcA1yN8xnsoQEWGxqyAp3
         sr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nhvczI875RAqYozQmX6a4KjWPjocOe6JQuYZD7+5AbY=;
        b=DtBRdyx3PFW7ryuSQd60wHTM6g8VcHKtSBGYtSmCkV7VRHPZ+js+v+ETsTdZqRA1c9
         7pFmfvQ6jITLapHrXCZg4BA3NwKfW7WZr22d//5tauoMipJaJ+pUq8VC0Znq2bk9Gc9G
         z8y0mtfc9GNRE2ngfVFEFPoIZy6AS8DR5EtCo4OpBodG9qyDlKEV0yY1WaZtYMAPIDGT
         s53xxaxx9QEbsIpkbnlTV2IM2TYOxYL2UYwMcJPowp6mttYOzC8Yf9NzujpPQbbahtNp
         395ZZCPxtml2NCbq4ETL7P0t68UFsnffyaQ71NgI4Q8uLtKcR5us6fBzYU0mHq2JCEuI
         4dcA==
X-Gm-Message-State: AOAM531RoFz4JmZEiJTo49T9yQbNSSrlI/UZi47WW2O5pkD1kklyhTd3
        +T5I8cuJp5ui/5rx0ZH3FfIouA==
X-Google-Smtp-Source: ABdhPJyj5LiZDZBmokWfP7RHGIp0ZCkGV97YY5y91duF0GaYeFoq/e/d5l1YcsPJCwj51i2gL+JqzQ==
X-Received: by 2002:a63:4f4c:: with SMTP id p12mr20929161pgl.432.1607944041554;
        Mon, 14 Dec 2020 03:07:21 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id k15sm19067997pfh.40.2020.12.14.03.07.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 03:07:20 -0800 (PST)
Date:   Mon, 14 Dec 2020 16:37:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [PATCH v1 2/4] cpufreq: schedutil: Adjust utilization instead of
 frequency
Message-ID: <20201214110717.boz634eih2ymjtju@vireshk-i7>
References: <20360841.iInq7taT2Z@kreacher>
 <1916732.tSaCp9PeQq@kreacher>
 <20201208085146.pzem6t3mt44xwxkm@vireshk-i7>
 <CAJZ5v0idoNOPU5-toOw+uTRvjJz60Ddc2xV7rMQeufY_EW58uQ@mail.gmail.com>
 <20201209051642.ddwgds4gznxt3lfn@vireshk-i7>
 <CAJZ5v0iOvG0PNQDXN00oKCzyZmaF71UB+DJ+zHL5P3xRCAk1tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iOvG0PNQDXN00oKCzyZmaF71UB+DJ+zHL5P3xRCAk1tQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-12-20, 16:32, Rafael J. Wysocki wrote:
> So I have misunderstood your example.
> 
> In the non-invariant case (which is or shortly will be relevant for
> everybody interested) cpuinfo.max_freq goes into the calculation
> instead of the current frequency and the mapping between util and freq
> is linear.  In the freq-dependent case it is not linear, of course.
> 
> So I guess the concern is that this changes the behavior in the
> freq-dependent case which may not be desirable.

Right and we end up increasing the frequency here..

> Fair enough, but I'm not sure if that is enough of a reason to avoid
> sharing the code between the "perf" and "freq" paths.

Sure, I am not against sharing the code path, but all we need is
something like this here:

     if (sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
             sg_cpu->util = prev_util;
     else
             next_f = get_next_freq(sg_policy, sg_cpu->util, sg_cpu->max);

i.e. we don't need to call get_next_freq() in this case at all.

-- 
viresh
