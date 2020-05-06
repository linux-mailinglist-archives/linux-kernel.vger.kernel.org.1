Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CA71C6579
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 03:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgEFB1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729457AbgEFB1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 21:27:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 18:27:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e6so63130pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 18:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xPLZJsayQjCGQwY1s3pIHaRye61Spu3GPa2g53Bgbks=;
        b=fEeDB7ZtkjwraZ9jqNqbxrp7Cectj/LniyG/WVDfQNq5mosFEZjdmr1kmgJXXf7gS7
         YrOsB8SvewJ12YN9j8EeYsTeXkf2jy0QY3xtTWr8zhWljmjTm5WPRdeMuVgMp75XZimU
         7ziiQemGDg6TRHGHElVK9iHo8KxOxqUfkxAY1BUfFaRAYUzySKqtlhu8Xl/7PBBLSdMy
         ZVO9y7q/g7hz/bEA1epVZ4L/vpmlB4LkfhTqm1WuhY11A0UQTl6+Nv7WJ7PdROMka9KA
         fNsryR1MYk5rtPLfoFUFzXBHAhmO5RlCCYU/lBWfxTP80j6Ul/WIQys3RFyl/zydXvaQ
         pS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xPLZJsayQjCGQwY1s3pIHaRye61Spu3GPa2g53Bgbks=;
        b=p6Bwi1R/5M0mfOgRNV3O2JiEuMJRDoxXoU7nSyYaBGhvDG4QGZKkEisi1ZAaPEwilo
         0hc5r/3w6QVtDkYCcB7Rqd4fNE680IvebOU4DndG/xDbR5BIHDZ8J4Tfy6Ij+CcC70zH
         EXttemLvW/lelyjMzaa78XYip5B7hIqUE3Bvo1XCsQhrKfs8857ZRrwhmQpvk59UHhbm
         S6AhTia5ryO9WzSXj7dJudhrfK1My+MGs4VXjkS9cqDdT3lO8IrzK0sX5/eC7wx/ege4
         JuifEV7biKsPz2hVRhScBnfpV8CoDbtlrspbjxFuG8Vaz2xLJS10mx83NbXw9f9yb1U1
         +X+A==
X-Gm-Message-State: AGi0PuYR5sqOT9wFVC7OksN/ol5/uzSDm1yuDroWyXnJ28/GlMZxaKEz
        IfFXUCbM8WrPAkKFUxm7GmCo7g==
X-Google-Smtp-Source: APiQypKMMlkzNjpv5d0j02REz81TfCnytVATHuXPJbjlnGrYHmHErVvmMGUWN25gsFd796v7EFTpgQ==
X-Received: by 2002:a17:90a:df88:: with SMTP id p8mr6494662pjv.119.1588728423310;
        Tue, 05 May 2020 18:27:03 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y2sm106442pfq.16.2020.05.05.18.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 18:27:02 -0700 (PDT)
Date:   Tue, 5 May 2020 18:27:48 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, loic.pallardy@st.com, arnaud.pouliquen@st.com,
        s-anna@ti.com, linux-remoteproc@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/14] remoteproc: Deal with synchronisation when
 changing FW image
Message-ID: <20200506012748.GH2329931@builder.lan>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-12-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424200135.28825-12-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Apr 13:01 PDT 2020, Mathieu Poirier wrote:

> This patch prevents the firmware image from being displayed or changed
> when the remoteproc core is synchronising with a remote processor. This
> is needed since there is no guarantee about the nature of the firmware
> image that is loaded by the external entity.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_sysfs.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 7f8536b73295..cdd322a6ecfa 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -13,9 +13,20 @@
>  static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
> +	ssize_t ret;
>  	struct rproc *rproc = to_rproc(dev);
>  
> -	return sprintf(buf, "%s\n", rproc->firmware);
> +	/*
> +	 * In most instances there is no guarantee about the firmware
> +	 * that was loaded by the external entity.  As such simply don't
> +	 * print anything.

Not only "in most instances", we have no idea what firmware is running,
so this can be shortened.

However, this does implicate that on_init = true, after_crash = false,
this will read blank, but a future rproc_report_crash() will indeed load
and boot rproc->firmware.

> +	 */
> +	if (rproc_needs_syncing(rproc))
> +		ret = sprintf(buf, "\n");
> +	else
> +		ret = sprintf(buf, "%s\n", rproc->firmware);
> +
> +	return ret;
>  }
>  
>  /* Change firmware name via sysfs */
> @@ -39,6 +50,17 @@ static ssize_t firmware_store(struct device *dev,
>  		goto out;
>  	}
>  
> +	/*
> +	 * There is no point in trying to change the firmware if loading the
> +	 * image of the remote processor is done by another entity.
> +	 */
> +	if (rproc_needs_syncing(rproc)) {
> +		dev_err(dev,
> +			"can't change firmware while synchronising with MCU\n");

The conditional checks for a future event, but the error message
indicates an ongoing event. How about "can't change firmware on remote
controlled remote processor"? "externally controlled"?

Regards,
Bjorn

> +		err = -EBUSY;
> +		goto out;
> +	}
> +
>  	len = strcspn(buf, "\n");
>  	if (!len) {
>  		dev_err(dev, "can't provide a NULL firmware\n");
> -- 
> 2.20.1
> 
