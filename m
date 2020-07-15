Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA52922028F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 04:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGOC6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 22:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgGOC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:58:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C95CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:58:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ls15so1681827pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TfePUk2yeb1Ip9ZhAd8/+f2UK1/Sw83r4/BpWZTD/P8=;
        b=x6hFAGUiiTiYSdQBH//9ZDxZAC9+qHTN8B5ZKovUu0QYSR0A9eGTCY0oFGWgMoY5Ib
         sE1RInDacRJMhoPPi+QUJId3DrdNNRKEUc9H72r540ohJ6eAg8g7ZC5Y5Hh50qu0WwXH
         HF+RXoYCmWSdVplAdcX7KiNr9A2vJBNNwOU8p3/9qIwZVrpErH3GjBpAvOOTu+4dI8wY
         c/FGL/9QlD/DcZ7qEFnIFr8HL2C83+JFAHcFDSL3XJe7TBEkX7EcmqCbh9B8pYG674wC
         +M9iqYnoBna5SBM6zck9ruWRwRPCxdJObUW+KlcEHURFwVLSWKJCNeaodbM7pvvwNkv2
         +nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TfePUk2yeb1Ip9ZhAd8/+f2UK1/Sw83r4/BpWZTD/P8=;
        b=OhkbXtIIhN52JMVWIC4XHVXY+Rjr2hhfGIVZ+QZ4dLuiYvGy5O4Kv1lOnFo3k1loYM
         5ErWpK6pUhWZNg9CMCXAoJywB/+Etfh+WGUvsludYH0XLFKmZybqLKhsy+t3B8zcRhRU
         5u6kcQIaNLPROxmZI5DwWWzuXBQ9TxDpNXBmQAiRcqkiC+u+NW2DRiF2y0G8wXd20QuT
         NeWj72P7ZxScjC7DcXf39LKsqSdkCr7VZ5lCBb+XKPNcOKHjlfZeCjsIopkV6EiGi4xX
         lVDvAxbRV/P4T9yZGa+TTQxp51RP7/nw2JUldGLUcwxcaAl0ibDL0lcYb/xEmoO2qRDx
         bGMA==
X-Gm-Message-State: AOAM530lo/bqBAzI72whK7dxHGo5EqfcNuL1Weqp//mFrnKlISB3H7gM
        7+/WcBTRU3FujkLLcO+MNpXF2Q==
X-Google-Smtp-Source: ABdhPJw/scwRmkaJm5WN2+4mQyDhXsyoDWXYwlB0VHB55IZ/1yI45FR+qvYRpvKWUj2GNCKKNEhIIA==
X-Received: by 2002:a17:902:7688:: with SMTP id m8mr2594603pll.12.1594781894788;
        Tue, 14 Jul 2020 19:58:14 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id t188sm424964pfc.198.2020.07.14.19.58.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 19:58:13 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:28:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>,
        Pal Singh <ajitpal.singh@st.com>
Subject: Re: [PATCH 04/13] cpufreq: sti-cpufreq: Fix some formatting and
 misspelling issues
Message-ID: <20200715025812.dzcu5vilhns4kljw@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714145049.2496163-5-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> Kerneldoc format for attribute descriptions should be '@.*: '.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/sti-cpufreq.c:49: warning: cannot understand function prototype: 'struct sti_cpufreq_ddata '
> 
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Pal Singh <ajitpal.singh@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index 8f16bbb164b84..a5ad96d29adca 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -40,11 +40,11 @@ enum {
>  };
>  
>  /**
> - * ST CPUFreq Driver Data
> + * struct sti_cpufreq_ddata - ST CPUFreq Driver Data
>   *
> - * @cpu_node		CPU's OF node
> - * @syscfg_eng		Engineering Syscon register map
> - * @regmap		Syscon register map
> + * @cpu:		CPU's OF node
> + * @syscfg_eng:		Engineering Syscon register map
> + * @syscfg:		Syscon register map
>   */
>  static struct sti_cpufreq_ddata {
>  	struct device *cpu;

Applied. Thanks.

-- 
viresh
