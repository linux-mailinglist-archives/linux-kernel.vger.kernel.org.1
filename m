Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE631A071B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 08:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgDGGPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 02:15:04 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34080 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgDGGPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:15:03 -0400
Received: by mail-pj1-f66.google.com with SMTP id q16so836121pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CPlaxgayQ+N8MMMgIjFe5Z07E3atFvajpg/1wJmrQ4E=;
        b=duuJ/dCMH1GS2IhzjWHgtKDPtdz+mC+7tRLFQi833UXwl/X9ymcCGx3w54JBnlnMHP
         TsM+ZPpNTH7E1SDzv15C0Wa8LS1j/5x8ZQUMUK5DTTbDJD84IaCN+n6uVLz6iCCHVSnf
         ZH2ptMQk3aGfZAmSq6UpPl4GvsyCWYy+eBNsdrV8jHpIOt7MJVuLe8rL3yotvjuNixX2
         U8tz2ylApBeEF7vtjckch4fkJ4kxt+zP5k5jVrqnmITz+vL2zlFzBTOFx/ECrQMFmBiI
         OGfg+bnHgFoTK5whjS8hRyMLvowZizPJGeqHNC+YOlf8ata1t2miQN8YmKUfDA0CLL3A
         5sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CPlaxgayQ+N8MMMgIjFe5Z07E3atFvajpg/1wJmrQ4E=;
        b=g1AQf8/8WOJG+rOtT+7nyLUvzcI0MkJpzHut0uDAANp08NnxI9acisZa0fY1onasf1
         +HTuNJk0Lb7RMT+bMTPqmnnrMZpTE8ca4+EwqiURruTBUcT0WBc9YB/GRaW71/KKXdFE
         sf4L2FUTU3/lvvsKriKebyY4TbP2LsHs6MxRHEcUS6NhqsBcD3E2afameB1RuYCo8S0b
         UmL3ELLZj/UMusAFtXphnScWM6nMYKNDnC+99D1VOlov7S3zJOCQUQlmyKCxgyYac1G3
         lscB2lNpYT2w/ZXzKOsYm9upB81brMU5YMaA3X0QLjtMVkkxh4rwWqfRC96WnQFe15Ob
         P+1Q==
X-Gm-Message-State: AGi0PuZE6u+nA9bOxtEAxx5v56cM0d7JKqiZHbBExG/XfIpRULvudNHt
        aO0hUFMsWjJKRmVY81SNKRn7
X-Google-Smtp-Source: APiQypKg9GQP7HSI0sIBC/WkLuQ+scrTQg6EQWIm62SUZwcY4ef1Iyh0wNK40QrAvAAmAh1HpTsdfQ==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr837275pja.174.1586240101941;
        Mon, 06 Apr 2020 23:15:01 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e86:d03b:80dc:a9ff:fe0a:9bd3])
        by smtp.gmail.com with ESMTPSA id o19sm2403759pfp.119.2020.04.06.23.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 23:15:01 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:44:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] bus: mhi: core: Make sure to powerdown if
 mhi_sync_power_up fails
Message-ID: <20200407061455.GB2442@Mani-XPS-13-9360>
References: <1586207077-22361-1-git-send-email-jhugo@codeaurora.org>
 <1586207077-22361-3-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586207077-22361-3-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 03:04:36PM -0600, Jeffrey Hugo wrote:
> Powerdown is necessary if mhi_sync_power_up fails due to a timeout, to
> clean up the resources.  Otherwise a BUG could be triggered when
> attempting to clean up MSIs because the IRQ is still active from a
> request_irq().
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/bus/mhi/core/pm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index cd6ba23..1bfa334 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -922,7 +922,11 @@ int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
>  			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
>  			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
>  
> -	return (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -EIO;
> +	ret = (MHI_IN_MISSION_MODE(mhi_cntrl->ee)) ? 0 : -EIO;
> +
> +	if (ret)
> +		mhi_power_down(mhi_cntrl, false);
> +	return ret;

I'd prefer the style of,

```
statement
if (cond)
	statement

return
```

Please stick to this. The change itself looks good.

Thanks,
Mani

>  }
>  EXPORT_SYMBOL(mhi_sync_power_up);
>  
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
