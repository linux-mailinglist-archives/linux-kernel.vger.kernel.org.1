Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C51DC574
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 05:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEUDHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 23:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgEUDHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:07:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F1BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 20:07:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so2216101pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 20:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ccibA7LDXIbckabc89mZhjSjYh9Yh1XsB9j1urjankk=;
        b=QJKj5hLEAVaHWmPMeYCFgAtB2gTVZ7CmhjXdaGUbfgs7I6L0MCJI2kUWQLLaQDSNmw
         RAH2Y5zLLVU+R6V0wpcbS26hiO8TnDZ5lfONDKSZvJHL1jX4mFXHKbokR+vLmelNPUSq
         6kgyvz796KDhYSGs9GSTVyxgbJ2IntR+Jr6lgx7YeBQ+eoRLsAuZsuNcOs6nBVy4HV6Y
         avN9skUdNqsAa/h+ruWdM0XXmo5wA8MGqcTLS6dbDG33Ibka4LHqby7hnoKZQu2f1ezH
         tCIvBh8Gjtr6APay2OrzsOVTLX2arxVjsYHKtniFOj8z6JOX70xe5EJQ8i5OaAXGHrgn
         UenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ccibA7LDXIbckabc89mZhjSjYh9Yh1XsB9j1urjankk=;
        b=p1BpBBLiXiGBYlhJkq7f6logHRyTb5NTuQTnXt481bf2SHo2l0LYtldw6nICCcDJIw
         mJ0GVsimgWK3r/4oCQvGPF9lbgGVd71NlJCyNP8CylsM3pdWvV2Q2LJGwhv43gT/y8fh
         7NgHapUr5PfCwzirMZJzsR1+qAj1tXpfDMV1XA/XnTa2r3MgxfgzS8bZgPlj2iAdmIG5
         HwconO8x0zFPXJZc6sgJ4NxfOvh3/AEaQk4gZtkgMQKlYf2mv9ZhIvRnAWAueNXDd4oL
         gA00mokiOP1OEBw5LfDLO1HgipOtDcUwdzVcnvAONgfUWNtDuBBOyI+84Hlu+/MYbTg9
         7cWg==
X-Gm-Message-State: AOAM531ZFTu/GeCcbcwnKHw07mZx1MDcgMFE4tTEF4MuMBD8gRggCH6R
        riJZXp9jyaEgwIs0RkYvHfewog==
X-Google-Smtp-Source: ABdhPJyQiQ3aNvL+wpFR3LQOzxPoIr/jqJaJJQPX1TlU7vAAbOPwC86YzPcUurVOWQ6QT0EHm7spYQ==
X-Received: by 2002:a17:90a:bf08:: with SMTP id c8mr8846242pjs.13.1590030458274;
        Wed, 20 May 2020 20:07:38 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id go1sm2967314pjb.26.2020.05.20.20.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 20:07:37 -0700 (PDT)
Date:   Wed, 20 May 2020 20:07:34 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 0/3] Even moar rpmh cleanups
Message-ID: <20200521030734.GD11847@yoga>
References: <20200521012119.238270-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521012119.238270-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 May 18:21 PDT 2020, Stephen Boyd wrote:

> We remove the tcs_is_free() API and then do super micro optimizations on
> the irq handler. I haven't tested anything here so most likely there's a
> bug (again again)!
> 
> Changes from v2:
>  * Went back in time and used the v1 patch for the first patch with
>    the fixes to make it not so complicated
> 
> Changes from v1:
>  * First patch became even moar complicated because it combines
>    find_free_tcs() with the check for a request in flight
>  * Fixed subject in patch 2
>  * Put back unsigned long for bitmap operation to silence compiler
>    warning
>  * Picked up review tags
> 

Can you please resend this series with both linux-arm-msm and myself on
Cc for all three patches?

Thanks,
Bjorn

> Stephen Boyd (3):
>   soc: qcom: rpmh-rsc: Remove tcs_is_free() API
>   soc: qcom: rpmh-rsc: Loop over fewer bits in irq handler
>   soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition
> 
>  drivers/soc/qcom/rpmh-rsc.c | 65 +++++++++++++------------------------
>  1 file changed, 22 insertions(+), 43 deletions(-)
> 
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> 
> base-commit: 1f7a3eb785e4a4e196729cd3d5ec97bd5f9f2940
> -- 
> Sent by a computer, using git, on the internet
> 
