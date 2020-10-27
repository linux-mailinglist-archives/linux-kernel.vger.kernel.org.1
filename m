Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8A29A59F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507896AbgJ0Hk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:40:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40053 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507889AbgJ0HkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:40:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id k18so379665wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sj5y+fdLPNbWrqn2selN8cFPdmtn8S/J2GevEupVS90=;
        b=NMw8moDjxdU7U+EbrdBHUJasZ07w0Ucj/3rE+Z9tRDz9Ss028I/jt4e7lOTi9sL13Z
         w5d1FWkxXoXU8E5t0LvDJmrsSsT5AJ8rfXXH2/7DORwQ9nfS7rRlZUh47NKrG9wFeZ24
         anBQ40cUY2Q8nFpaMOldZoY/N5zyn/uEJa7mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sj5y+fdLPNbWrqn2selN8cFPdmtn8S/J2GevEupVS90=;
        b=cqN6nCh6nUZeCFXuT5JMNclHCLPrUtB3BAjRNu/santpURt1By2+kG7zVof9w0arEO
         x95msRYLRAenkFYHBwENCtY7VSP80QQ/yWvAqXgnj43YobNQCTpNpwYLu271evIxxCWU
         +/XdkJMcjS/CmctsXHYS5TJAI8bSRMZtP7bwVE0bLH0gdwyDrYW6hVEF1L5FTrctPm/C
         nQMo89oAHErtbizRrpUv1SnQFbqOSl8z1CECPm5MIjGOvqfHTsjYVqNgIAXlQOutWi5v
         sB+beEOuwjOqgia3N5Hcj9ZHbP70QB+KxNZlf07BzFergZoU5An2ZI22P+5QQwXlNR8e
         Im/A==
X-Gm-Message-State: AOAM530Ow198VEzjiZILHiG4gGJMPvgBeRkhFE+0+YFMyLr+XbUkQO1R
        uZckS4UK3NjXA2LZDg04Hj7+1w==
X-Google-Smtp-Source: ABdhPJzGwgSChZpZB3GukMqvYH2BEBLfYsue1QKbgg4C6aFtH3zYguOWXKuCCpMIE8clZTpkIs8Fzg==
X-Received: by 2002:a1c:4006:: with SMTP id n6mr1168827wma.46.1603784423614;
        Tue, 27 Oct 2020 00:40:23 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q5sm935168wrs.54.2020.10.27.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 00:40:23 -0700 (PDT)
Subject: Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
To:     Biwen Li <biwen.li@oss.nxp.com>, shawnguo@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com,
        zhiqiang.hou@nxp.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
Date:   Tue, 27 Oct 2020 08:40:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027044619.41879-1-biwen.li@oss.nxp.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 05.46, Biwen Li wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add an new IRQ chip declaration for LS1043A and LS1088A
> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A. SCFG_INTPCR[31:0]
>   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
>   reverse)

s/defaultly/by default/ I suppose. But what does that mean? Is it still
configurable, just now through some undocumented register? If that
register still exists, does it now have a reset value of all-ones as
opposed to the ls1021 case? If it's not configurable, then describing
the situation as "by default" is confusing and wrong, it should just say
"On LS1043A, LS1046A, SCFG_INTPCR is stored/read bit-reversed."


> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v2:
> 	- add despcription of bit reverse
> 	- update copyright
> 
>  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
> index 4d1179fed77c..9587bc2607fc 100644
> --- a/drivers/irqchip/irq-ls-extirq.c
> +++ b/drivers/irqchip/irq-ls-extirq.c
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
> -
> +/*
> + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>

If I wanted my name splattered all over the files I touch or add, I'd
add it myself, TYVM. The git history is plenty fine for recording
authorship as far as I'm concerned, and I absolutely abhor having to
skip over any kind of legalese boilerplate when opening a file.

Rasmus
