Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97F92DCD48
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgLQH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgLQH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:58:16 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA6CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 23:57:36 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t22so9123611pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 23:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+/wN0EKTx4mL+4/wFwwWiw4m/cPokd3GgWbsqCS8T2E=;
        b=hgqPyhLH2//k67Nph3v7xdlZQYp1FOPqiuppL7CJYrmwKqURsGPlgNvZoL1ridqorV
         z7wCNYGb+V2B43SKq5u8l0TdTlfTkHn/WiFkbsbx/cCZuLkKQXqXYbwY5PNMnlJZPVq+
         yQeLcG3xzUqMdHwLrDNLOTtJYkRE0igcKKOtirgaLS/BgWt4T9sscC9NGzn7oMWlxgoe
         dGtgn7jIxMvKmrawrHg5+JffpzMlFNZFQimWlz/NyepeWCufaX33RKNgYOIJg7o9W39n
         tv86tu8iBQXBBHzaoKQr88C85JNQRD4n2UKCa+ne8u1JiPtnAAFJM/ki1cua3YtodqM3
         7dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/wN0EKTx4mL+4/wFwwWiw4m/cPokd3GgWbsqCS8T2E=;
        b=CqTmyoFLOePE3mO5Owjl9KxlTbgZtNL7a5UEyk/+GgrO1e4xbU67sJBn2Sf24wlAyI
         rZl2hNWUvszKxQeAQrpkBYDxjDI0M1xGCG1JxLxt8j97R2Hd0+9ccvYQuTCLaRAB2c6h
         vXzRWipYK0Wpy/GANJ4/nAQ4KWzAFywp+a6YX+PgHmylrNukM7A3xHuWkUWB270kbz9j
         H7OKWQVOyIIyeJ79HVP7nmQnq60qYISAQrMaVuWxt/etvsgQbhtYgEzV39I7GmuPTWlS
         hlCkdRI7ZYh/I2WjVw3lZRgperodQ8uZmA1HEoA9nQ4IKyCXEgoOO2wwce6/aTk3AGfU
         OTZw==
X-Gm-Message-State: AOAM531W9XlDni4q7VlSOkCpil004O94PtycvnpA7UQvGaIz3XBAeoNv
        OauCsr5q1wIb2zG9wqZyOy3XYA==
X-Google-Smtp-Source: ABdhPJzIjS1DqDxwVMjPpgyztBxmFj/nHBKd8kVJl/TNlGXXfdf/VfsDlr9cmkBYaxm1ujuOUsOOew==
X-Received: by 2002:a63:e1b:: with SMTP id d27mr37119666pgl.441.1608191855552;
        Wed, 16 Dec 2020 23:57:35 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id h4sm5411012pgp.8.2020.12.16.23.57.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 23:57:34 -0800 (PST)
Date:   Thu, 17 Dec 2020 13:27:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] arm64: topology: Avoid the have_policy check
Message-ID: <20201217075732.blac5pbca7prmuum@vireshk-i7>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-12-20, 11:04, Viresh Kumar wrote:
> Every time I have stumbled upon this routine, I get confused with the
> way 'have_policy' is used and I have to dig in to understand why is it
> so. Here is an attempt to make it easier to understand, and hopefully it
> is an improvement.
> 
> The 'have_policy' check was just an optimization to avoid writing
> to amu_fie_cpus in case we don't have to, but that optimization itself
> is creating more confusion than the real work. Lets just do that if all
> the CPUs support AMUs. It is much cleaner that way.
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3:
> - Added Reviewed by tag.

Catalin, please pick the first two patches for 5.11. I will send the
last one separately later on.

-- 
viresh
