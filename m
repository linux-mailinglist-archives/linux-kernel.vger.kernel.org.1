Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906861A182B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDGW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 18:29:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36670 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDGW3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:29:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id n10so1468317pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/5Dlo9c6NkrNlKhGxo4WiMmRax8P6tj8YZhOaAlFBfg=;
        b=nI+28tmDYxfUXfht9m038gFrt7Recb9Ozlvc4UQxEyYgc+WlN6FE3ncBzInK0cMsj7
         y6a/Kuv1KV1lcnKjVKDGdW3KbWuhTVQdBSBvzjXT6vPIeqdwNiFn4YENmwLcFq8Y44xj
         YD262bhCXpaI5QIN2ofdWk/08Vwbn9w1s5BSA3VVn3imBJ14PW4djp9KiRr8M5GyWp8c
         RuQOKb+DCPoPS9TETWvkGfDF+qAWuR6h7hWZ63vvq3WAFCwOdF1jknf+ivEB3L1ghqyF
         RyDLDhe4hYKQ2LEDMwgXJQOdlA9MTwFwa5XRe75Kr1dUkD63YxfE0sIK/7aIRtmwJSkS
         b5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5Dlo9c6NkrNlKhGxo4WiMmRax8P6tj8YZhOaAlFBfg=;
        b=Bi6Sz7KlCCKRNQTfr0838KQ0EihhKR6gzYmRqDZczH82Bu+107FYga7ZM4qRsnpJnQ
         7o9DgJlP6T7GzKU5XWuwTPJDBOWP9dROaVXBhJ/wckrbHSRhBSVQa+IC7V24RJ7RY4/s
         DBSH67ovaqSPXr/Qo2c2oJBeVGAiGkTbwGQ/CmANIwbvbBcmUF0i4V+9FebAOWACldIe
         3f2irP5wNtlj3YJWyRikyQkD/6AScEdRhagb+NJBGU1oCVYgTO5HaFJYiXHKEF9O19tI
         EwBByB71BA5J0d82BaBwHnnLMWCblBRM/NxfPRcS55kTcWNBBTvjDo6D5LWwssyxjt39
         I+UA==
X-Gm-Message-State: AGi0Puav1AZaLBsTxmWkML7VHM3SZTGE2bxyDQCIycwd7nGJeLKtzgpk
        G9ms7plXJxH4A3+z1M/L6l88m7M/sNk=
X-Google-Smtp-Source: APiQypJz2ExCAgyCPPwVRM5J8c8RKa6kKi9IhliwMD/WX4yhCs1nX97X4GqALHk0m2lsH8vN6KHeAg==
X-Received: by 2002:a63:31c2:: with SMTP id x185mr4178337pgx.380.1586298592970;
        Tue, 07 Apr 2020 15:29:52 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 3sm11016636pfd.140.2020.04.07.15.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 15:29:52 -0700 (PDT)
Date:   Tue, 7 Apr 2020 15:29:58 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH 2/2] remoteproc: core: Prevent sleep when rproc crashes
Message-ID: <20200407222958.GL20625@builder.lan>
References: <1582164713-6413-1-git-send-email-sidgup@codeaurora.org>
 <1582164713-6413-3-git-send-email-sidgup@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582164713-6413-3-git-send-email-sidgup@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19 Feb 18:11 PST 2020, Siddharth Gupta wrote:

> Remoteproc recovery should be fast and any delay will have an impact on the
> user-experience. Use power management APIs (pm_stay_awake and pm_relax) to
> ensure that the system does not go to sleep.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 5ab65a4..52e318c 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1712,6 +1712,8 @@ static void rproc_crash_handler_work(struct work_struct *work)
>  
>  	if (!rproc->recovery_disabled)
>  		rproc_trigger_recovery(rproc);
> +
> +	pm_relax(&rproc->dev);
>  }
>  
>  /**
> @@ -2242,6 +2244,8 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>  		return;
>  	}
>  
> +	pm_stay_awake(&rproc->dev);

Following Mathieu's question I was expecting you to do this on
rproc->dev.parent.

But looking at the implementation of pm_stay_awake(), it ends up being a
nop if dev->power.wakeup isn't specified. This in turn seems to come
from device_wakeup_enable(), which will bail if dev->power.can_wakeup is
not set. But I don't see where this would be set for either the platform
driver or the remoteproc's struct device - and neither one of them have
a "wakeup" attribute in sysfs.

Is there some additional plumbing needed for this?

Regards,
Bjorn

> +
>  	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
>  		rproc->name, rproc_crash_to_string(type));
>  
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
