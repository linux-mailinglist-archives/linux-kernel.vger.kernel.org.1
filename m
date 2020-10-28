Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3FD29D665
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgJ1WMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgJ1WL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:28 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:11:28 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m128so1187504oig.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lMQ52opYyBFO/8867Rc9HWGhmmRhbhGzcJErb4OtTk=;
        b=fI0t4BxySPIKVYRDW0X9AXX9OUIVJ0i/IcCj1u6CvQF8PsgvfX6iDVVZmT+L5OwIWk
         yoG+215nSPpM6CL47027i0uDqhuClzPHJLJTFYPqlBePyix501UL4sg5W6uJnBEPSzdv
         QNbm3DYpW3acKN2JX9MeWEj/i94spl3Ekzj7+7YyXHo+dqPM9Hvo1UrUTsX+lXrbfyKm
         IHr/sYrZ/nPuU7uHWl30RPPs9gNvhpqSbtdmdKUo8eS1IPHYkkrcmNk6ZSb9X7efUEiT
         xdBg/+u/V5As2OXPt81jOWeTwHpGsJXhVirjF3ESdAcqadsGDH2/w4KWEDWhW6SqEHvo
         l3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lMQ52opYyBFO/8867Rc9HWGhmmRhbhGzcJErb4OtTk=;
        b=FC1g7ldJgrBU41dlqKphRg81OgDoR5/5qljWmY5PamjPthE6QHitymdXMEXFhmXZsQ
         Z2gRyyuSfTWn3xnccK01IUTDX42EUWj3WBT6xb9lUWV5wHLg/CzIBcmsyhe5jfXdGixN
         Y2y1psEiBIh0Ex9xC2vGezc1ppzsG2osJQnQBNphqXz+P1Z48RE3aY421urd47v9n/By
         598u0bE2TfOuj/BPLhoDgNgPos6uRPRZC24X+TK8n7VVF0w/0fNczD9xV1CSUtRvYERk
         29AsBAYMRsiIqi0HtJIVvZihYK80jB8JG9f63lHNaYh5Gdxj+e8nBQu78Ph5a7fnVAHB
         pIFw==
X-Gm-Message-State: AOAM5323247qGhkblXcpZpB+5+s4/p+tB4iTJD7/+GP3hT54t2/Ak2Og
        GMt0VxGqC/KSv7fPMRU2XLddhg9O00hs5Q==
X-Google-Smtp-Source: ABdhPJwieZLKERYh5i+WcdYFNjnB1YDi1rMC2Wk3oXGFuwXvXKqEySiv1P8w4btQ05XHTYrpVhRGQQ==
X-Received: by 2002:a17:90a:1f07:: with SMTP id u7mr7452262pja.69.1603896848198;
        Wed, 28 Oct 2020 07:54:08 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 63sm6317614pfv.25.2020.10.28.07.54.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:54:07 -0700 (PDT)
Date:   Wed, 28 Oct 2020 20:24:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: fix bad error check logic in the opp helper register
Message-ID: <20201028145405.ucfepzt6xoxro6fi@vireshk-i7>
References: <20201028141357.10345-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028141357.10345-1-t-kristo@ti.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-20, 16:13, Tero Kristo wrote:
> The error check is incorrectly negated causing the helper to never
> register anything. This causes platforms that depend on this
> functionality to fail always with any cpufreq transition, and at least
> TI DRA7 based platforms fail to boot completely due to warning message
> flood from _generic_set_opp_regulator complaining about multiple
> regulators not being supported.
> 
> Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 2483e765318a..4ac4e7ce6b8b 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1930,7 +1930,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
>  		return ERR_PTR(-EINVAL);
>  
>  	opp_table = dev_pm_opp_get_opp_table(dev);
> -	if (!IS_ERR(opp_table))
> +	if (IS_ERR(opp_table))
>  		return opp_table;
>  
>  	/* This should be called before OPPs are initialized */

A similar fix is already pushed in linux-next for this.

-- 
viresh
