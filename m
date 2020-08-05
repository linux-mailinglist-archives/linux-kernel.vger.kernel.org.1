Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F123C3ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 05:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHEDRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 23:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:17:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B21AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 20:17:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l60so3716413pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 20:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GwdmrPeI8+8TYOiNO0lD90Om+SOTXHqTR+EgYSaZFgk=;
        b=SYlGxCo/yiyBv5rqBK1rNwVcV4mP1C2ypksFqVk1Y0RvviPd6g2aklM49igfGS/Lxb
         ysaHKDVz9/pQ6FZt897GGEmW8iqWwy54NFGec5CBEzCV3ZKOoaBLIASilSKp9drS0ePH
         pJlS8DDZW9Sr2O0lH3DDbMnTl2ry9VTZbEE6XerZmeIqtBUFC25Rm/LWHQvf3tIxj11a
         fh2Or2VTMjSljWKWUQ9Jh9ija1JgExdM9od/2YFWyI46y5MX7DMwbZONGegJpDhLoT5u
         /XenrWqMxDU7PH/N+YYhlzW0DLuFrMBSEVwL2YOVr8MN5TD41jYjWVEVpfQY2BEhkW+3
         aHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GwdmrPeI8+8TYOiNO0lD90Om+SOTXHqTR+EgYSaZFgk=;
        b=TuIeMZlgwzme3S46FcUOj9meJmf40G84fYi7e7QWkRDK5bztfvfaWEq+qAQZrjOeD+
         Mi5lSletLXr3xwMwlnA3kRkz4/vR8YQVWbe1oKyrzv47Ok7/3yChtlhW338OROE2Z34C
         7wVT29HHTBI7pDLCYPmDdla3oLI8IGHL0+M4cSQZN2WyMtlXx/tQ9G3rM/WuHock4kql
         HNtpjqx1E6Gobzw2teQ4yCF2KwP9JHmO/X8IF7wgyUh4mS3LiIhtL3Yb0psPhOTwX5mn
         DcC+ch7y/wiUw+yTp7jYZpJa524SZP6kX3ZKqPon3TzRAS8olQFCIr73LLoEfWZGMnbJ
         X/8Q==
X-Gm-Message-State: AOAM531XVkHK7fXA78uGvD7BmQ9c9z44ass3e6KBpgN/oTTiwZ75fcyX
        Qg9BNAoJ7Upv5TwCdr+gfO1ajTtS2k9BGA==
X-Google-Smtp-Source: ABdhPJxPOfey3C2baFVSSKIGqAjMLFDKnHKK3tvfEMC2BmmUotR5lvRJJnKuhDov03HvAMc9g37wMg==
X-Received: by 2002:a17:90a:9502:: with SMTP id t2mr1065046pjo.205.1596597429716;
        Tue, 04 Aug 2020 20:17:09 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id c139sm845196pfb.65.2020.08.04.20.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 20:17:08 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] powerpc/pseries/iommu: Move window-removing part
 of remove_ddw into remove_dma_window
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200805030455.123024-1-leobras.c@gmail.com>
 <20200805030455.123024-4-leobras.c@gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <2cebc8bd-81f8-9f48-900e-43ced9b04e6c@ozlabs.ru>
Date:   Wed, 5 Aug 2020 13:17:03 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805030455.123024-4-leobras.c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/08/2020 13:04, Leonardo Bras wrote:
> Move the window-removing part of remove_ddw into a new function
> (remove_dma_window), so it can be used to remove other DMA windows.
> 
> It's useful for removing DMA windows that don't create DIRECT64_PROPNAME
> property, like the default DMA window from the device, which uses
> "ibm,dma-window".
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> Tested-by: David Dai <zdai@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>  arch/powerpc/platforms/pseries/iommu.c | 45 +++++++++++++++-----------
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 1a933c4e8bba..4e33147825cc 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -781,25 +781,14 @@ static int __init disable_ddw_setup(char *str)
>  
>  early_param("disable_ddw", disable_ddw_setup);
>  
> -static void remove_ddw(struct device_node *np, bool remove_prop)
> +static void remove_dma_window(struct device_node *np, u32 *ddw_avail,
> +			      struct property *win)
>  {
>  	struct dynamic_dma_window_prop *dwp;
> -	struct property *win64;
> -	u32 ddw_avail[DDW_APPLICABLE_SIZE];
>  	u64 liobn;
> -	int ret = 0;
> -
> -	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> -					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
> -
> -	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
> -	if (!win64)
> -		return;
> -
> -	if (ret || win64->length < sizeof(*dwp))
> -		goto delprop;
> +	int ret;
>  
> -	dwp = win64->value;
> +	dwp = win->value;
>  	liobn = (u64)be32_to_cpu(dwp->liobn);
>  
>  	/* clear the whole window, note the arg is in kernel pages */
> @@ -821,10 +810,30 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
>  		pr_debug("%pOF: successfully removed direct window: rtas returned "
>  			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
>  			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN], liobn);
> +}
> +
> +static void remove_ddw(struct device_node *np, bool remove_prop)
> +{
> +	struct property *win;
> +	u32 ddw_avail[DDW_APPLICABLE_SIZE];
> +	int ret = 0;
> +
> +	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> +					 &ddw_avail[0], DDW_APPLICABLE_SIZE);
> +	if (ret)
> +		return;
> +
> +	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
> +	if (!win)
> +		return;
> +
> +	if (win->length >= sizeof(struct dynamic_dma_window_prop))
> +		remove_dma_window(np, ddw_avail, win);
> +
> +	if (!remove_prop)
> +		return;
>  
> -delprop:
> -	if (remove_prop)
> -		ret = of_remove_property(np, win64);
> +	ret = of_remove_property(np, win);
>  	if (ret)
>  		pr_warn("%pOF: failed to remove direct window property: %d\n",
>  			np, ret);
> 

-- 
Alexey
