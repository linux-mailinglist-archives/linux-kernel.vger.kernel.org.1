Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180562F1919
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbhAKPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbhAKPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:04:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC04CC061786;
        Mon, 11 Jan 2021 07:03:59 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d17so679ejy.9;
        Mon, 11 Jan 2021 07:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aAeE0TTHdKHoJkBYQsPdM4kqaplDlSaeVpHaFu0f2pw=;
        b=vSp5iHmtr+/75uywTjkXTBnxCX3gZU/hlkgu7K8AMQUHLiqpyG8enC7XVQ71V/QaGK
         biRC0kvKBRu+mlWp9xCbs5+9VAGnzcGv0kFFpymvUsR6P3ykiEL6rM55ahyO9ieG8JjZ
         q990kKVHlOLSXu750+i0m1dMMoZ7IlfYK9jngg5aBqUgT7+Nba8ndXLe5swygJedvWwP
         QsQ5DUWSXyO5MThoWwrbyis9PYgNfuYafMKCI4JTHaYiLAoLsLcgUHNCTfRJ3YJSYg0p
         CBVWfve1OnVo0ArrGx1rUiv4/7mfag5UeqPvvmH6e5Ll9XjfOhatl8EnrRzb9gTgK58k
         H8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aAeE0TTHdKHoJkBYQsPdM4kqaplDlSaeVpHaFu0f2pw=;
        b=FDN0APK7O1mUMUqUXIpEW8HSLltxBdk0HjrHGUjDhoR8YeZX1VXS7JbA0QIjcv952z
         9iDF+zEuRXenOY0NLsu7r7ux5GjTF10pESwFNBOmNj8HcRQjvPbzDFCluI5EO75zayhw
         CMc5kgzRnT4F/smjzTjYZkM4KGuJ3H842AhsFfahccZ3iXNO2ofbknXk2QecD5aBC0lY
         hnWCY46jTiz3BH5jHfu0BJeyATs3ybHHiQf+of3TMrORBXv3iSJoj+Ur8a3iVNan+iC9
         ET3dg7mVHKUrDOERiQbg3oa4Cnl0Vr6ixHxehyfcH17cs9gW61cKz7ttVGXb383f4Vhk
         iEig==
X-Gm-Message-State: AOAM532PK43YmJRLp9UpqKTglYmSn4E8c3JFxNhD5KAYJsRmZRSBh1gA
        JGQfDxBnHOh9AgTIIXVKDA2922smjv4=
X-Google-Smtp-Source: ABdhPJxIyaLozHRUSkxGCf9e46os4PII+e+rFlcGTGASsZ5G6GpsA7YmSEqFQ0qbBTusFlQlcioPdw==
X-Received: by 2002:a17:906:7a46:: with SMTP id i6mr10589160ejo.257.1610377438272;
        Mon, 11 Jan 2021 07:03:58 -0800 (PST)
Received: from [192.168.2.202] (pd9ea3126.dip0.t-ipconnect.de. [217.234.49.38])
        by smtp.gmail.com with ESMTPSA id j23sm58529edv.45.2021.01.11.07.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 07:03:57 -0800 (PST)
Subject: Re: [PATCH][next] platform/surface: fix potential integer overflow on
 shift of a int
To:     Colin King <colin.king@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210111144648.20498-1-colin.king@canonical.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <94d4044a-d50f-0108-9312-53338c388f39@gmail.com>
Date:   Mon, 11 Jan 2021 16:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111144648.20498-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 3:46 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The left shift of int 32 bit integer constant 1 is evaluated using 32 bit
> arithmetic and then passed as a 64 bit function argument. In the case where
> func is 32 or more this can lead to an oveflow.  Avoid this by shifting
> using the BIT_ULL macro instead.
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: fc00bc8ac1da ("platform/surface: Add Surface ACPI Notify driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/platform/surface/surface_acpi_notify.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
> index 8cd67a669c86..ef9c1f8e8336 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -188,7 +188,7 @@ static int san_acpi_notify_event(struct device *dev, u64 func,
>   	union acpi_object *obj;
>   	int status = 0;
>   
> -	if (!acpi_check_dsm(san, &SAN_DSM_UUID, SAN_DSM_REVISION, 1 << func))
> +	if (!acpi_check_dsm(san, &SAN_DSM_UUID, SAN_DSM_REVISION, BIT_ULL(func)))
>   		return 0;
>   
>   	dev_dbg(dev, "notify event %#04llx\n", func);
> 

Thanks, looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Regards,
Max
