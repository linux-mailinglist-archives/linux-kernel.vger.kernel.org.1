Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9CB2F660A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhANQeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbhANQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:34:07 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784B9C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:33:27 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 9so6519354oiq.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wdfGHaLMmvGeKZR+Q52L5VCEAR0Xq0lYTJy3reN0RWc=;
        b=xz8/G6/x6/sFJixEahTaLsigMU8aO/sgNYuJ9G3b7O/mxCmT1mtKfMXZaN2KqDhNJ+
         ZYx338jiLzmB9hRTVhGMRS/xdpWhW9plLdA5vPF2bmiXxmL3R94OY/ajQf0gm0IIxpK/
         OwtZKoaOGYU7Qg2PHuPq1QkA+s+u0Lkv4VITjQ/A6yAoODn/moHa7VPiENab2M45eDSw
         xsZEKV4anWYnYO6CTMxhKDIDLaLIi6DFxTNpWVi13Aimhh3T67QJOoW6YlnQx1ISXow9
         sBqfIr3oH9Dho/COrZ/FQVBirRLDr9DsRZlY1Q3F2k4C9VDOy8UDJnq+6Brkc2ItbF+v
         hRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wdfGHaLMmvGeKZR+Q52L5VCEAR0Xq0lYTJy3reN0RWc=;
        b=mkd0pGw6st54AVxthD1enA/F5KrC2+VtQiNjTtfZv8DR5cNdgnZQUEI1EF3Jr6NcIt
         V67ZNexH0gKZqpX4JPG7EJ5U3AaCH8Ko9QF5nP9b19OSzZtmDEuICYdTPGy25CW43jOi
         s3F6HWpY+Ud4dPBM5HFb6jfnTg5/PQOyXiSHuKzg2f2igk7QgL0iqPuJJdlOkQE7k7+M
         UeN+XwvVCWV209uOITp+Hga4Eb5RaFdKd73e2olx0H85LnUnE5vBm1eGBppaCxhtgPOj
         hV8FzoXXwaGbJjJPyDdn2aovbui1afic7GF9Mr147R4D8Y7JbEpG/s7cr6EPc+d7GHo+
         p5eA==
X-Gm-Message-State: AOAM532ySXBsa7YY3ksJXp0LLR9DzsG/2AGwB83voldhEFb4chOskd3Z
        CRybagNuCgncJ7jqb9MHI1wG0w==
X-Google-Smtp-Source: ABdhPJzx9HXkyQFolo8kyKKH+IvZy4gOusrB4m3kDTJv59KO4OACHdTLFF2O12FaEyUYuBNpfFi0/g==
X-Received: by 2002:aca:c592:: with SMTP id v140mr3045719oif.10.1610642006813;
        Thu, 14 Jan 2021 08:33:26 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n16sm1201193oop.9.2021.01.14.08.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:33:26 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:33:24 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-gpio@vger.kernel.org,
        Srinivas Ramana <sramana@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] pinctrl: qcom: No need to read-modify-write the
 interrupt status
Message-ID: <YAByVOwhDU1W21RM@builder.lan>
References: <20210108093339.v5.1.I3ad184e3423d8e479bc3e86f5b393abb1704a1d1@changeid>
 <20210108093339.v5.2.I3635de080604e1feda770591c5563bd6e63dd39d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108093339.v5.2.I3635de080604e1feda770591c5563bd6e63dd39d@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Jan 11:35 CST 2021, Douglas Anderson wrote:

> When the Qualcomm pinctrl driver wants to Ack an interrupt, it does a
> read-modify-write on the interrupt status register.  On some SoCs it
> makes sure that the status bit is 1 to "Ack" and on others it makes
> sure that the bit is 0 to "Ack".  Presumably the first type of
> interrupt controller is a "write 1 to clear" type register and the
> second just let you directly set the interrupt status register.
> 
> As far as I can tell from scanning structure definitions, the
> interrupt status bit is always in a register by itself.  Thus with
> both types of interrupt controllers it is safe to "Ack" interrupts
> without doing a read-modify-write.  We can do a simple write.
> 
> It should be noted that if the interrupt status bit _was_ ever in a
> register with other things (like maybe status bits for other GPIOs):
> a) For "write 1 clear" type controllers then read-modify-write would
>    be totally wrong because we'd accidentally end up clearing
>    interrupts we weren't looking at.
> b) For "direct set" type controllers then read-modify-write would also
>    be wrong because someone setting one of the other bits in the
>    register might accidentally clear (or set) our interrupt.
> I say this simply to show that the current read-modify-write doesn't
> provide any sort of "future proofing" of the code.  In fact (for
> "write 1 clear" controllers) the new code is slightly more "future
> proof" since it would allow more than one interrupt status bits to
> share a register.
> 
> NOTE: this code fixes no bugs--it simply avoids an extra register
> read.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v5:
> - ("pinctrl: qcom: No need to read-modify-write the ...") new for v5.
> 
>  drivers/pinctrl/qcom/pinctrl-msm.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 1d2a78452c2d..1787ada6bfab 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -792,16 +792,13 @@ static void msm_gpio_irq_clear_unmask(struct irq_data *d, bool status_clear)
>  
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
> -	if (status_clear) {
> -		/*
> -		 * clear the interrupt status bit before unmask to avoid
> -		 * any erroneous interrupts that would have got latched
> -		 * when the interrupt is not in use.
> -		 */
> -		val = msm_readl_intr_status(pctrl, g);
> -		val &= ~BIT(g->intr_status_bit);
> -		msm_writel_intr_status(val, pctrl, g);
> -	}
> +	/*
> +	 * clear the interrupt status bit before unmask to avoid
> +	 * any erroneous interrupts that would have got latched
> +	 * when the interrupt is not in use.
> +	 */
> +	if (status_clear)
> +		msm_writel_intr_status(0, pctrl, g);
>  
>  	val = msm_readl_intr_cfg(pctrl, g);
>  	val |= BIT(g->intr_raw_status_bit);
> @@ -906,11 +903,7 @@ static void msm_gpio_irq_ack(struct irq_data *d)
>  
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
> -	val = msm_readl_intr_status(pctrl, g);
> -	if (g->intr_ack_high)
> -		val |= BIT(g->intr_status_bit);
> -	else
> -		val &= ~BIT(g->intr_status_bit);
> +	val = (g->intr_ack_high) ? BIT(g->intr_status_bit) : 0;
>  	msm_writel_intr_status(val, pctrl, g);
>  
>  	if (test_bit(d->hwirq, pctrl->dual_edge_irqs))
> -- 
> 2.29.2.729.g45daf8777d-goog
> 
