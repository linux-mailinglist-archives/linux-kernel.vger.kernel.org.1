Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC22B93EF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKSNwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgKSNwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:52:33 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB86C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:52:33 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so7262509wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 05:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=G/KNgOCchprOESH0Sncq7O2JGQBV5twGa9CxNg5Jhb4=;
        b=tcIoqVGYKkGFR8cr1oBKIf7LhLKu38qrXqHDAnxJu7JTWLaM3issiSovsmoxP4VgA7
         TZ9x27fUwbVy4KbT8VAQRz7XUdDflaleaIBLMfyks7NKVh71oivq3AigF2fGVRjJ5isX
         yuxRGncPFx7v1ZETr72aw94AC+XLZYau5wuh4wbCs961wNiJxn092e8WGx7pamUc5Cno
         AardQoNjAI2QR1Y9MhczbcMtAP9JiDUyaayEzhvUOtM2muYNVutzu0hzP6ruU1ig4qFS
         sQcgDmOpFJngMLZLmeWTOLXntV2RdZd1oAuM7w58BTlevnB9sum1bWuh05G3FBPnzxiF
         Z77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G/KNgOCchprOESH0Sncq7O2JGQBV5twGa9CxNg5Jhb4=;
        b=Zdei5Yol2fIC4jjcAsFnMq7psM6SEhpDritTjQhlmoy6+aEU82yCzQxo0iwWqql5Mj
         ANn7XxOOKa6y5o0ai/HALejg1BfJupuK4PWNKYmV1y02XIUd8w+xwlkjz8FCaq4nZjjb
         f1HtpFo37ah/fKtwlrzb0WmAKPwOoUieZoMv2u14jq+1Rovvoaw5N+/GefGg+ATwhz+9
         f68eWOYmlzMA2Aih4tkmeNCmnYCPckvg1b8vlVIKlzo8HLg8CJdLyVKzI8Fpc5jrwYEg
         GfvZu2XJiWiWQU2ACemA681mUBSRMhlLn7hkoOCkznLZk9CjKFO93hml/U5wP0Axp1Ui
         Gfzg==
X-Gm-Message-State: AOAM530/avp/GmGOZr9u/AscFeBMOpbdmEikRZ2kfqUWqi6bfRG57QVu
        Rlc4XxQSMXktYYLUckkdZhiNkw==
X-Google-Smtp-Source: ABdhPJxQAQ48MWgm45E5gFZ2v2NsZr+Nlv0kzKdXhkKNIaLLUhoi/+m3PrCxwEmEO4sob6nHrOo7UA==
X-Received: by 2002:a1c:8145:: with SMTP id c66mr4563872wmd.71.1605793952013;
        Thu, 19 Nov 2020 05:52:32 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f11sm38512230wrs.70.2020.11.19.05.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 05:52:31 -0800 (PST)
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Saravana Kannan <saravanak@google.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
References: <CGME20201119103753eucas1p11810b99e19d0a8477b4ca84482ab4d16@eucas1p1.samsung.com>
 <20201119103746.32564-1-m.szyprowski@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] interconnect: fix memory trashing in
 of_count_icc_providers()
Message-ID: <52f943de-bbdf-896a-1713-95a4b9a66c7f@linaro.org>
Date:   Thu, 19 Nov 2020 15:52:31 +0200
MIME-Version: 1.0
In-Reply-To: <20201119103746.32564-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 12:37, Marek Szyprowski wrote:
> of_count_icc_providers() function uses for_each_available_child_of_node()
> helper to recursively check all the available nodes. This helper already
> properly handles child nodes' reference count, so there is no need to do
> it explicitely. Remove the excessive call to of_node_put(). This fixes
> memory trashing when CONFIG_OF_DYNAMIC is enabled (for example
> arm/multi_v7_defconfig).
> 
> Fixes: b1d681d8d324 ("interconnect: Add sync state support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks Marek!

BR,
Georgi

> ---
>   drivers/interconnect/core.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 974a66725d09..5ad519c9f239 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -1083,7 +1083,6 @@ static int of_count_icc_providers(struct device_node *np)
>   			count++;
>   		count += of_count_icc_providers(child);
>   	}
> -	of_node_put(np);
>   
>   	return count;
>   }
> 
