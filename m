Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26973267D54
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 04:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgIMCsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 22:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgIMCsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 22:48:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C42C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 19:48:06 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w25so10558813otk.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gi4RgsDejluKNSDuptpFIorLHS9rpKmYHVtwd6skt4k=;
        b=NmIFRPIWmLgyTP+WVcCdvtq7yQAko5YmzN4qDAVmZKtvg+m5NLLO6fPRznrj3VO+57
         Wk4eJ/T8q07qtNuurteTNnTG4t4Nm10rAL14ThV8lcpZpdYoGElQITH1Z2RiIgHHsCeN
         RalGVjnznh8VaE+1QXmIB+/xPy9vnlwMWVAQpALDQeltiuOXSlUdusfE3X3Vk7i7Z1RE
         4vVR/1g20y2kOFNFCF2rCalY0auJ5qni5IBPbmPwn40zbI949FVBdJjsRWnusAcamHeE
         CEV+63+rEqgMhWSNwVoGvZ+b7POr8HPKsQDKh0Lw6JfiofkOj6CNyZLchrjTwxJlE0xO
         PWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gi4RgsDejluKNSDuptpFIorLHS9rpKmYHVtwd6skt4k=;
        b=f/bh3gpJ3vBLgYmafCEsz7W23BNQfFSxkU4xKEJK8nw/6AbS+h+fO7qsNb8bhtapqV
         lH+FW3kdaKRZDM135NoLpPnbD0HcJZqNYtFyp3LU3b0lUM05mxW2XmGI9DTK0nYubbxT
         iLkXhpEbdbmdjqMH72EKtvfqFNU5vm8LdiSqd9vhCPRJMm1IB6DK9S6gbkgvKpdQ30J6
         L044oJruE8cgm+TLzXxSOxUglrwopsnVzUb6DQirZVzzsWl6TO9r0NZREqSMhDr3OfF7
         Z2qetEKtoGzbxysW4W4nhgjbuUyFBNvA+MEFu7wFaTZtp1fXqFgXQpi1u74VYMQxWGA6
         IcaA==
X-Gm-Message-State: AOAM530Kb3x2bKxoyJ7lOrSFkewTdz/Rj5MjnlsK6DfVe/oirty0X/9/
        c2z52U3khOIzlXj5Ui62dKAuRQ==
X-Google-Smtp-Source: ABdhPJzawApxC6RklfJj5492nsUZevZw9PqKX+Z+w9zrVwfyp8ba1Ma9z+eFpUfgvNxYIPnIq5w70w==
X-Received: by 2002:a9d:4c06:: with SMTP id l6mr5401432otf.359.1599965285586;
        Sat, 12 Sep 2020 19:48:05 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id k19sm1229228otb.45.2020.09.12.19.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 19:48:04 -0700 (PDT)
Date:   Sat, 12 Sep 2020 21:47:59 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, evgreen@chromium.org,
        subashab@codeaurora.org, cpratapa@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] net: ipa: enable wakeup on IPA interrupt
Message-ID: <20200913024759.GP3715@yoga>
References: <20200912004532.1386-1-elder@linaro.org>
 <20200912004532.1386-7-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912004532.1386-7-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11 Sep 19:45 CDT 2020, Alex Elder wrote:

> Now that we handle wakeup interrupts properly, arrange for the IPA
> interrupt to be treated as a wakeup interrupt.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/net/ipa/ipa_interrupt.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
> index 90353987c45fc..cc1ea28f7bc2e 100644
> --- a/drivers/net/ipa/ipa_interrupt.c
> +++ b/drivers/net/ipa/ipa_interrupt.c
> @@ -237,8 +237,16 @@ struct ipa_interrupt *ipa_interrupt_setup(struct ipa *ipa)
>  		goto err_kfree;
>  	}
>  
> +	ret = enable_irq_wake(irq);
> +	if (ret) {
> +		dev_err(dev, "error %d enabling wakeup for \"ipa\" IRQ\n", ret);
> +		goto err_free_irq;
> +	}
> +
>  	return interrupt;
>  
> +err_free_irq:
> +	free_irq(interrupt->irq, interrupt);
>  err_kfree:
>  	kfree(interrupt);
>  
> @@ -248,6 +256,12 @@ struct ipa_interrupt *ipa_interrupt_setup(struct ipa *ipa)
>  /* Tear down the IPA interrupt framework */
>  void ipa_interrupt_teardown(struct ipa_interrupt *interrupt)
>  {
> +	struct device *dev = &interrupt->ipa->pdev->dev;
> +	int ret;
> +
> +	ret = disable_irq_wake(interrupt->irq);
> +	if (ret)
> +		dev_err(dev, "error %d disabling \"ipa\" IRQ wakeup\n", ret);
>  	free_irq(interrupt->irq, interrupt);
>  	kfree(interrupt);
>  }
> -- 
> 2.20.1
> 
