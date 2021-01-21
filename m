Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A52FE070
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbhAUENN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbhAUEJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:09:10 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4510C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:08:29 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id j12so713186pfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X4Jw/E+MtQCCTnL+PGuuK0p7Rc+43AmkTUUI5e9cfl8=;
        b=zNayIhusqeaJcQKJoNACth9N6WIAptS33FTJhomoi5rFhdlCG4d3T63nrUWB2tTHVC
         lWi7KXdFnO0nXBbBVghWQjlANtXi1z79PkIeDAi1VkBwIbgG1/SSc2QTDgTUxZggeTbT
         ZhyW84SuqbzH8Zr9pUCUW8rqgb9YtgOcGfddOuCAI7cRbsLkEDq7gjuE6+0QTb8cDOOs
         qm9cOa6Vf4NzBN/x7g5Wz/KoKYozCfulX++avvbOu5a07qXNTUsnojSE3j89VFxzE6eH
         Vj8beYYR8bgec4BVA6sM434V20kxQM/tEi6+cn0U7+l7yzbuf6tEbaJLUaV10f2pKQfQ
         7Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X4Jw/E+MtQCCTnL+PGuuK0p7Rc+43AmkTUUI5e9cfl8=;
        b=jbHwnDs7383vd7Om1ZRKUpwgExPx5ym/bDtHoG1jvaoSooTnBIdS4bgizxL9Xi3xeA
         iaSZDXHzz1fEWOEjuJtXQvGVaU4MJNx3zYpkJ+CTY1RzRdeKaWwxYVfsex0yYhsgzl7K
         crl7N9eGXwDueW5r3cazsti5SaixGP2jHwBpu0iajFRRiMCmjkF99xJtIog8NQDYVEIn
         9cfEWfRTrt4rm4nClTsqXWz7R0z8wWt5Z42k5yJQ8MnXSsSjAKGlFPEcP6tClr9nnzV8
         TV3aniSJx9lYMBll/JsobTk4xGPoFiaZVs4WKbfXnXMxJjLe5x0SgIqj7IdRDvw2ZJ30
         Z1qg==
X-Gm-Message-State: AOAM532JpE/j14Jz1yZgCdrfyw9DjJTSSPE8JrHr9Sq0HksLWPttVbyN
        ci8Y+KxxJSmkQwbL5fMxvv1o1A==
X-Google-Smtp-Source: ABdhPJytsWhRYcWkltf5/Tc9Fp63GWINBFAh/gZQi00WIv4gQiwq3VmsZi6nh+YyCfv8eBHuYPnT+Q==
X-Received: by 2002:a62:64c9:0:b029:1b9:6b48:7901 with SMTP id y192-20020a6264c90000b02901b96b487901mr11809332pfb.0.1611202109309;
        Wed, 20 Jan 2021 20:08:29 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 126sm3687628pfu.31.2021.01.20.20.08.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:08:28 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:38:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PM: domains: Make set_performance_state()
 callback optional
Message-ID: <20210121040826.jsxdv24vxnobq45s@vireshk-i7>
References: <20210120211232.17299-1-digetx@gmail.com>
 <20210120211232.17299-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120211232.17299-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-21, 00:12, Dmitry Osipenko wrote:
> Make set_performance_state() callback optional in order to remove the
> need from power domain drivers to implement a dummy callback. If callback
> isn't implemented by a GENPD driver, then the performance state is passed
> to the parent domain.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> [tested on NVIDIA Tegra20/30/124 SoCs]
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/base/power/domain.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
