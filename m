Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4528A7B2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbgJKOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387963AbgJKOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 10:09:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD5C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 07:09:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g9so11490967pgh.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2E9XTdrHAfZUqvjslXmJY0A7DhqJxtr460qjTU+91kY=;
        b=rNjTBjkwz+MbIKTFKdCIdDRH1DaFfybQie5gGjmzEgrOqp80k4jIFZUgsm8hcbA932
         v7U9yZ9lPF6rEyK1R4M8Wj0kuPCs1U9sbn8EYBjnpj4Jm9LbCC2pKAvkmCzZI1uigpdv
         A7etPkqlwyJr5JQTvU6Ji5pVqnxsYZD5Nbp7M1rVaPBY5dfgWUNtqX94nw/z+9JDuI4k
         XgoKMV0F8xSdPsmKkCxPL/RQqys2dqWCUYqgodTyAqfDN/Ka1nNyEAAsJ8WBasuWjXUe
         /Op8H3lupaUa7c/viBSsxSK6JDqTWdt8FYgzQlZC/r9MptfuURZzKdDiM1eLom4S9N7f
         ELEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2E9XTdrHAfZUqvjslXmJY0A7DhqJxtr460qjTU+91kY=;
        b=n2NOM9fKOZgpPcW315JHnrccXjTVEu2Q30frgiRrgSNBKzW00Si8ls3o2TfhkyFTsR
         V8TXKxmi02jtTf/sJxSTPbb0k9vMjvKdI2wivQk47dF93MjZ7SpF8R7PPAys/WJFqvy/
         CI53mEvjSApGgaD9Y7hecZL9D3JAjvgI+ZDJg6yNgVq3E/1EnJtl9G+MAfzIBWjm7rqa
         9UYnPWDC3IB3ZN15Z0TVIc8xLvzhNEv0EjIMt4tPtVjVsls6WU5vzSB+Kg+Yu3tYFnGD
         oQ/6S8BC/9dqCa7miz99af6C+h4cMpPyuSrWKj87FL9UJ3JF1yrLVdaV6MWs9z304a84
         VsBA==
X-Gm-Message-State: AOAM531wYrSEpFUWa6wYGL4Pm+Eg20IAtYP3ZW+6L7oPDlZ2Jvrn1bki
        HvQpls1Ljw4zBttwfBtWDLsN
X-Google-Smtp-Source: ABdhPJyXI0tF8lDCqKYKUSLlQfExO7ycqASahIKocXscd1x1LxKbXNxhA3FyHuqn/MEzsmKx44yucQ==
X-Received: by 2002:a62:b417:0:b029:142:2501:35dc with SMTP id h23-20020a62b4170000b0290142250135dcmr19479541pfn.60.1602425396445;
        Sun, 11 Oct 2020 07:09:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:28d:c562:841e:ecfd:8468:c018])
        by smtp.gmail.com with ESMTPSA id gi20sm19355467pjb.28.2020.10.11.07.09.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Oct 2020 07:09:55 -0700 (PDT)
Date:   Sun, 11 Oct 2020 19:39:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Wolfram Sang <wsa@kernel.org>, Peter Rosin <peda@axentia.se>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH 1/3] i2c: owl: Clear NACK and BUS error bits
Message-ID: <20201011140948.GC4971@Mani-XPS-13-9360>
References: <cover.1602190168.git.cristian.ciocaltea@gmail.com>
 <6ee573f2904c001ab07e30b386815257c05f6308.1602190168.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee573f2904c001ab07e30b386815257c05f6308.1602190168.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 12:44:39AM +0300, Cristian Ciocaltea wrote:
> When the NACK and BUS error bits are set by the hardware, the driver is
> responsible for clearing them by writing "1" into the corresponding
> status registers.
> 
> Hence perform the necessary operations in owl_i2c_interrupt().
> 
> Fixes: d211e62af466 ("i2c: Add Actions Semiconductor Owl family S900 I2C driver")
> Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/i2c/busses/i2c-owl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 672f1f239bd6..a163b8f308c1 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -176,6 +176,9 @@ static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
>  	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
>  	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
>  		i2c_dev->err = -ENXIO;
> +		/* Clear NACK error bit by writing "1" */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_FIFOSTAT,
> +				   OWL_I2C_FIFOSTAT_RNB, true);
>  		goto stop;
>  	}
>  
> @@ -183,6 +186,9 @@ static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
>  	stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
>  	if (stat & OWL_I2C_STAT_BEB) {
>  		i2c_dev->err = -EIO;
> +		/* Clear BUS error bit by writing "1" */
> +		owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_STAT,
> +				   OWL_I2C_STAT_BEB, true);
>  		goto stop;
>  	}
>  
> -- 
> 2.28.0
> 
