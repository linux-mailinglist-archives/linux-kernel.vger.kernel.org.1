Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD612948F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440992AbgJUHee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408228AbgJUHee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:34:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E9C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:34:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w11so771881pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fPlK2iJZuWNSVaRZPV6Xl5e0rIsxttsntniiCED68Zc=;
        b=hbiRX9dnbCCOOlMz53DPhowFpm+qalU5e+U6iP5x+JVk1WjmS4Ysfvq5jrULk5x6hz
         QrsUXEYAFUegrW8UVPuqz4ZsPPbdakpK3eEiPKk8+R3bdfQjas6n3AlwSUUUOcogXc/8
         imct2la7/8R6aYsNdJnnY58gT+5j9ejdRa3tjuVYBQycMg2Up+JXM1LmB/WgyuUQI/LA
         K405fgDeNcNSugmaInyXUT46fLkAnRe7PfAFdm109pP7VXw/pQaOe0zRzxNd/xyrjVeF
         DUMgba0zlFVc6SxnQ9cFgnEO82eqFNsHW2D7YMvSdBE9oX2ftsq0ZM9Yz/XrfU78LSQ3
         mYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fPlK2iJZuWNSVaRZPV6Xl5e0rIsxttsntniiCED68Zc=;
        b=LbBMWOrTmU7Uvkigy6cAcBmbu31QAgT+hi6Tz9WD6wSw7jppK6y/r0IfBaA3khezWc
         UuTkuHIO9iX3EphJboUOOOEXVOjUIaRVmSRrkhxtjQgdv/EdN94+ekUE4lTHvCcLRTDb
         rCDT19k4UKbCOIC4NTqfHs0dUSA+L+LzsBkmJKT70AQJiLBSx2Va2aOaSI2otf5yZgYA
         UoXWQz+ZBsFfl5PwGdNtBHWNWCOQgDCKnFeJzfUuuJSqoj+FLpdMqX6OvTUjehMVIxRX
         PWNpehsOCvwa28ggvfzRU+BD/3R7SplzjX1aVIEzEKOUCj12IciyBKzMccGzN4b3h/w5
         gyVg==
X-Gm-Message-State: AOAM531JBr1o+4FQz1Qwhqy/2SW8waHEAQwbUajp/aVF+VwW58aXZEgv
        SIpR+byqhO7TfP2Rwjpzq6+7NQ==
X-Google-Smtp-Source: ABdhPJyDDeskv393Ac7lgDT9GWLFsB6GLtycYLuAScps5KJrZ6EDbYeWOP54iJHoYCgrlcQK1H/xUQ==
X-Received: by 2002:a17:902:684b:b029:d5:a3a0:3b47 with SMTP id f11-20020a170902684bb02900d5a3a03b47mr2016920pln.76.1603265672387;
        Wed, 21 Oct 2020 00:34:32 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x19sm169608pjk.25.2020.10.21.00.34.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 00:34:31 -0700 (PDT)
Date:   Wed, 21 Oct 2020 13:04:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 8/8] qcom-geni-se: remove has_opp_table
Message-ID: <20201021073429.akspqkj2i5td7r7c@vireshk-i7>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <7e28e6f93f463ffbe91b2a5c18b82e7123500f44.1598594714.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e28e6f93f463ffbe91b2a5c18b82e7123500f44.1598594714.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 11:37, Viresh Kumar wrote:
> has_opp_table isn't used anymore, remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> ---
> V2: No changes.
> ---
>  include/linux/qcom-geni-se.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index 8f385fbe5a0e..02d1417c8ecf 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -48,7 +48,6 @@ struct geni_icc_path {
>   * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
>   * @icc_paths:		Array of ICC paths for SE
>   * @opp_table:		Pointer to the OPP table
> - * @has_opp_table:	Specifies if the SE has an OPP table
>   */
>  struct geni_se {
>  	void __iomem *base;
> @@ -59,7 +58,6 @@ struct geni_se {
>  	unsigned long *clk_perf_tbl;
>  	struct geni_icc_path icc_paths[3];
>  	struct opp_table *opp_table;
> -	bool has_opp_table;
>  };
>  
>  /* Common SE registers */

Rajendra,

This patch depended on following patches which are part of Linus's master now:

7d568edff5cb spi: spi-geni-qcom: Unconditionally call dev_pm_opp_of_remove_table()
c7ac46dac744 tty: serial: qcom_geni_serial: Unconditionally call dev_pm_opp_of_remove_table()

Who is going to merge this one ? Should I ask Greg or you can take it ?

-- 
viresh
