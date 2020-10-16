Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57115290A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390509AbgJPRSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390477AbgJPRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:18:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F125AC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:18:48 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f37so3040980otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYW+PwysYhYMS+2uJ+6opFI9if/3+0MrY9QzZA2zMkA=;
        b=SRT+T1RjlIijuy4sKekVlrNmDJMb02bqeETTgju/KIQ7MZC6qLiRhVUXYD5BEJ9hrC
         jP9yaOUa/uREUccbW652cUyXgsBiy6liRc26ovoqBPxNvMdt0109ZnI3p3nl5Brwb9+8
         LWSuTiEMXwcLdpeb1Te8kj3Fi+8P2Q3hyWSO7JtoZk3P8xgkJBMnahlnUHCw2Df7Qscm
         S8x5O9ltgzd69ggWEID+l+2iOIr71aYk7spYZOWlfAYyTMgsfiX2YbMYGVLM96uAXJ/u
         ntIH78uER8sypJ6/ZslRypKe996lwVNrmWfuEgQezgSNyCFJFuR2ks7FrHOU93rdc5Gr
         9Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYW+PwysYhYMS+2uJ+6opFI9if/3+0MrY9QzZA2zMkA=;
        b=qcdcA/kRXMcj//zeKqOLUtoG5VcmkE0DkPNF6XjyG/lycrf0icZ5Emo/Zr41WGeuXD
         dWMdAeZID8bHT3pNQIE8gadG0Xcyq+XLbzLiGRYywX8eTkU16a8XkQPdmy671glznBbU
         R/Y9aOp+nEOJr9JqeJH75VDmO6nTAbHLzZhPcyzYCty61M7bMN4EdX2qJm0NU3IQzUdc
         +OR1EJbBOJ9FSt/GvvCHf7sk4JsRzgQetVgZxNwS+zhkHNXc/Q1ankidkmeGgBLUFLwk
         hbmisDWqDXwimSds4SVPeffSAvr/eeGgU+Gg/ZVFpOX8Zg6U6bPwKg36vnu9wS9n49zn
         8XDw==
X-Gm-Message-State: AOAM5301ugj+kD2sauERiWzYXRieDRFspfovuJ9OyyjTSSdkm7IyJguh
        n56MsJePi3Kjf7ArEIro5E8JlA==
X-Google-Smtp-Source: ABdhPJxBcu6t+ucNkpCAM+tjRv5gmJP66u9MCor/elLGt0c7cX9lSmy5tRNMLlFd4b473MuB4kmlkw==
X-Received: by 2002:a9d:3787:: with SMTP id x7mr3362323otb.165.1602868728287;
        Fri, 16 Oct 2020 10:18:48 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i5sm1252465ooo.32.2020.10.16.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:18:47 -0700 (PDT)
Date:   Fri, 16 Oct 2020 12:13:37 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Markus Elfring <elfring@users.sourceforge.net>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] soc: qcom: smp2p: Safely acquire spinlock without
 IRQs
Message-ID: <20201016171337.GA241575@builder.lan>
References: <20200929133040.RESEND.1.Ideabf6dcdfc577cf39ce3d95b0e4aa1ac8b38f0c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929133040.RESEND.1.Ideabf6dcdfc577cf39ce3d95b0e4aa1ac8b38f0c@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29 Sep 15:30 CDT 2020, Evan Green wrote:

> smp2p_update_bits() should disable interrupts when it acquires its
> spinlock. This is important because without the _irqsave, a priority
> inversion can occur.
> 
> This function is called both with interrupts enabled in
> qcom_q6v5_request_stop(), and with interrupts disabled in
> ipa_smp2p_panic_notifier(). IRQ handling of spinlocks should be
> consistent to avoid the panic notifier deadlocking because it's
> sitting on the thread that's already got the lock via _request_stop().
> 
> Found via lockdep.
> 
> Fixes: 50e99641413e7 ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
> Signed-off-by: Evan Green <evgreen@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  drivers/soc/qcom/smp2p.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index 07183d731d747..a9709aae54abb 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -318,15 +318,16 @@ static int qcom_smp2p_inbound_entry(struct qcom_smp2p *smp2p,
>  static int smp2p_update_bits(void *data, u32 mask, u32 value)
>  {
>  	struct smp2p_entry *entry = data;
> +	unsigned long flags;
>  	u32 orig;
>  	u32 val;
>  
> -	spin_lock(&entry->lock);
> +	spin_lock_irqsave(&entry->lock, flags);
>  	val = orig = readl(entry->value);
>  	val &= ~mask;
>  	val |= value;
>  	writel(val, entry->value);
> -	spin_unlock(&entry->lock);
> +	spin_unlock_irqrestore(&entry->lock, flags);
>  
>  	if (val != orig)
>  		qcom_smp2p_kick(entry->smp2p);
> -- 
> 2.26.2
> 
