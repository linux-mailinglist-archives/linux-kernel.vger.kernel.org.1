Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031C72BBCB6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgKUDjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgKUDjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:39:42 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD853C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:39:41 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id g19so10695689otp.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yt1RKeBAyO/ZvyBjIZKUNXc1EPd/mhgYIE1hAiiHLA4=;
        b=PrVavSIAKHzqHIrSaafaiiSEVMcgTha2+wFop+AYntc+ri24hKAib3maBrgyHOigIh
         MnrrGEdpHF7Z8BhBbu6KDVpXkNk0amQzb/LbAWP+J/c2faJjugvReaYUYm1J+elGZKEV
         AuPkz5bb6mP4B4JcoCORSwh7Y8AzczCaKRPGlWBNS4sSgZnFe1i0PYlauoSKpVGpkMTL
         vquIr0rNONKvJX3h80pzWrO0LeIAFRC99wsWZlGbbLTywTiC+y6H/RDrHpIfjglcturM
         AWC15T0g1LxsCcWBXGK23O/N80UkQTU1WniOJFBNvLpHAKaPDhV8UQfWed2sy3VduwHs
         DHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yt1RKeBAyO/ZvyBjIZKUNXc1EPd/mhgYIE1hAiiHLA4=;
        b=EKfGGixZJH5ZZqZ8KLEJgye410px/m96W3/uDVt73rIC+N7TW/MJmiJYzC11ngFeAw
         GRpHNfN4FRnRG51qMp8R9wwjkSV35QdNc1lJaUjaRgohqwpU1lysIgsDnwsPjEfhDi0W
         J65mMRfNUw04SdgHNP/FfC3kq2Djyy30nEsKM79euPGw9uYMlm566Rnlr8LW/j6NOjOA
         XICRYmXXxvUBPy3kckuAE2Np9vQrjG4vLKPDbZ8sTAhxHW3wXCaHYGL28dUwNL/mpUWs
         1mH7f84vaeVaSH0TIWAeFMs2fiQ+Zyndk60u6DKOdXEZG/1kl/kaTOsbj9Uhm0mt6VlM
         GQ8g==
X-Gm-Message-State: AOAM530xZHgNr8u5eWtHIAcWkUlonZGOkY8lZM+PQNS7troHX5B+f0ES
        tYsaNpfufQjShEGXn16CMi0S3g==
X-Google-Smtp-Source: ABdhPJzxbDle5d1+EsCC/raEZWSn9K83g5/BDo0MkIhkGm4FiPS6Nb7OUDiHpyUlTov9CDBZCJyi0Q==
X-Received: by 2002:a9d:27c9:: with SMTP id c67mr15608307otb.301.1605929981238;
        Fri, 20 Nov 2020 19:39:41 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w14sm2688442oou.16.2020.11.20.19.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 19:39:40 -0800 (PST)
Date:   Fri, 20 Nov 2020 21:39:38 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] remoteproc: wkup_m3: Set deny_sysfs_ops flag
Message-ID: <20201121033938.GH9177@builder.lan>
References: <20201121030156.22857-1-s-anna@ti.com>
 <20201121030156.22857-4-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121030156.22857-4-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Nov 21:01 CST 2020, Suman Anna wrote:

> The Wakeup M3 remote processor is controlled by the wkup_m3_ipc
> client driver, so set the newly introduced 'deny_sysfs_ops' flag
> to not allow any overriding of the remoteproc firmware or state
> from userspace.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2: rebased version, no code changes, patch title adjusted slightly
> v1: https://patchwork.kernel.org/project/linux-remoteproc/patch/20180915003725.17549-6-s-anna@ti.com/
> 
>  drivers/remoteproc/wkup_m3_rproc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
> index b9349d684258..d92d7f32ba8d 100644
> --- a/drivers/remoteproc/wkup_m3_rproc.c
> +++ b/drivers/remoteproc/wkup_m3_rproc.c
> @@ -160,6 +160,7 @@ static int wkup_m3_rproc_probe(struct platform_device *pdev)
>  	}
>  
>  	rproc->auto_boot = false;
> +	rproc->deny_sysfs_ops = true;
>  
>  	wkupm3 = rproc->priv;
>  	wkupm3->rproc = rproc;
> -- 
> 2.28.0
> 
