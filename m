Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9AA2B8A87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgKSDyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgKSDyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:54:11 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9BFC0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 19:54:11 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b63so3137836pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 19:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bY60GSlLO2ruttlt3lBiygVojLgvG+1tKw+aonD1tf0=;
        b=h6kuLugVduO0z7Xd8KjXshQXwF+7cCZ/s8v0IpbJBLsbwPtH+Bho3MjUlGoIWscJWK
         9Libw0oeW+hmns3gEO77TcqRwoJMyWy4Y1/1zZSYQZXJNtPeXlB6HYzOiZItNHbAjCpj
         vam4TOEMrk+QzscnEX5rVE+0icMt/v35orHJX9Rhoa4UqovnIcyKNzm8P09h6YhctRNy
         fManwRfftei/2FeVlR/CPhZDIIu1zngGJfJZO9FzJOSycpZdgh+GjXT1N3zyThEv6nBH
         c1gLzsLpLMgK7t0T0TKF+qtKw7pP20hGr8C9LNYxpNHU50ofNOHdwlVe1HDEmi0mTpGx
         7BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bY60GSlLO2ruttlt3lBiygVojLgvG+1tKw+aonD1tf0=;
        b=kVjzfhjyPADKICFb9bhhvsYc+9gM3opIn9guEBFNsbULk6CXFHnMBaw5D22n0GoXol
         wE294Qqa3Ox/eBbZfUa7q9Uz76XlKGoo+Bb/0KnB13LKqa6GMMDoKOKPnad9KeHfyKxT
         ljvAyEUZrzw6xnCnZ8UwTpXOEEQ1n29av1bgQc+mLSGZbV+xIKKInxF6PbuAOP67msx9
         4+Hv/QiwnnvMjFaH2hDj6A/DBG7FBuUhiv55KXWl+K9UkGn6Q3pNZKj0gIyJqaXpq45Z
         l+bqCFLDvtnK7suy4cGaHTa9rYuQGv4p/hVJKjjF4RH+TuHOSwCvqz7B+pCA9b4tmFdi
         Yndg==
X-Gm-Message-State: AOAM5304l4nNo7ovv1Ek6kXPYoAi1T1XajHx/PbKTkRdba73UA4HwVe+
        7cAA/UntD6e90h7qiCKQwEny/w==
X-Google-Smtp-Source: ABdhPJw7Q5wDrq3TOZXxcS6uKnHTtzi5cscSt8Li1bmeaRhm2cmkFkWS0/mUHfAIfKKkoY52aKvHVQ==
X-Received: by 2002:a17:90a:e2d4:: with SMTP id fr20mr1591639pjb.202.1605758050468;
        Wed, 18 Nov 2020 19:54:10 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s15sm18796282pfd.33.2020.11.18.19.54.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 19:54:09 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:24:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Fix up several kerneldoc comments
Message-ID: <20201119035407.4mamgendovnmypj4@vireshk-i7>
References: <1739462.uCgn0Xls2p@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1739462.uCgn0Xls2p@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-20, 20:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fix up the remaining kerneldoc comments that don't adhere to the
> expected format and clarify some of them a bit.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   72 +++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
