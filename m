Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4107A2E75D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 04:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL3DeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 22:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL3DeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 22:34:12 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55DFC061799
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 19:33:31 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w17so13778253ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 19:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B3Mt7Vge4rOYCuATbNhfM4ylo5AR8DxmvdDf9ze0ORs=;
        b=pLTpME5psErfd7pgyRN5Ufaet1tygProILi68YE97K5ERpbjMupWDA7yBpeRswlo3f
         rv2NsyuiE3ItWMS7A4IkTT9wM2gbfEv1kBuIwU5sL0EeTE2xrbCLPO63RXK0at/TcyQd
         AVvOQUTj6EPRaaBiPFDx4Eet6X5SsIqnt9MAA55HXRT4AM4SjtFdnO0659LfuB63lMeD
         JgM1nRpsG6H5t1FRNVd6dl4tu/Y/Mnjs8KcyGVuafPO1KdMGpn31t8x06pVSNnQP1Dcy
         PLHVSNvmokyMV4UjohdfV/JrVvw+cWE2mayjQ9HQdd2kMM00AsuK9Cy+Oq4grfsu9M+7
         St+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B3Mt7Vge4rOYCuATbNhfM4ylo5AR8DxmvdDf9ze0ORs=;
        b=NTIE9izukDd0EKfD0gyWXRaeZSt+thkfmrDrzpbez4wo3Oo0E6Qv3WCD5BE+4JWuNs
         ZUoEvBWY8eqFldlhjJOPHkFHhuOSK+QmSsqy+hDlqa+vibgdsKpvhamYfZhr918Nejki
         OiNS8vqa8jRcnkrjbuNQETbKYZniexGodkDaaBGt63fng+qgAMFGAu6wyMiWSGuoejM/
         akmGyGeEujrQsmWMBd8JxRzb+Pd8YYc8bNvuIfzLyr7k+HMRCaSdK4VMpJ/xGZEs7M7K
         6mDRZqAuwExhf1amg410ZtLQmzYepU19hioOKQk/spqVTQdnlzEUMncez6nbo0NUo7LL
         MWog==
X-Gm-Message-State: AOAM533qhn0/uRqw8C80WSR2dZRhLW2fPtkZtPzzSnQBaU65PJ6ISfZU
        c4enIi1cMZ4t6OMttjwlWDSC9pgdT8lowQ==
X-Google-Smtp-Source: ABdhPJzXTrSmIxdHYMNyjkMFDlMMDrmiOtZdAKLDnEW+bZJlQ89iTQcBoBKa9/E/Lh0T/1SXZoMjoA==
X-Received: by 2002:a05:6e02:20e6:: with SMTP id q6mr21255757ilv.272.1609299210959;
        Tue, 29 Dec 2020 19:33:30 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f13sm27380119iog.18.2020.12.29.19.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 19:33:30 -0800 (PST)
Subject: Re: [PATCH v2 -next] staging: greybus: light: Use kzalloc for
 allocating only one thing
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, rmfrfs@gmail.com,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20201230013706.28698-1-zhengyongjun3@huawei.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <f374b9d0-4020-1c63-2c81-53e963ee182e@linaro.org>
Date:   Tue, 29 Dec 2020 21:33:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201230013706.28698-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 7:37 PM, Zheng Yongjun wrote:
> Use kzalloc rather than kcalloc(1,...)
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> @@
> 
> - kcalloc(1,
> + kzalloc(
>            ...)
> // </smpl>
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/staging/greybus/light.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index d2672b65c3f4..87d36948c610 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -290,8 +290,7 @@ static int channel_attr_groups_set(struct gb_channel *channel,
>   	channel->attrs = kcalloc(size + 1, sizeof(*channel->attrs), GFP_KERNEL);
>   	if (!channel->attrs)
>   		return -ENOMEM;
> -	channel->attr_group = kcalloc(1, sizeof(*channel->attr_group),
> -				      GFP_KERNEL);
> +	channel->attr_group = kzalloc(sizeof(*channel->attr_group), GFP_KERNEL);
>   	if (!channel->attr_group)
>   		return -ENOMEM;
>   	channel->attr_groups = kcalloc(2, sizeof(*channel->attr_groups),
> 

