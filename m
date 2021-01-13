Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE62F4794
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbhAMJ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:27:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbhAMJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610529960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vhGBheygAegbfi9rXHPYkyAW71b1XQ8FOLJsWiApa9k=;
        b=NHoaDFHQAZVPxAeGifRajypNVCFEHqKac10WsgsNR08D9+ahHZzRTts3ba1eB4gporlftP
        YxOCcNFpKGw3JuJxzGxCHjpC7EY0SKktOtlhiGl0D1TxLbpHSC9BM0zlQCpG081tCKz8zz
        IOdqYbp9QXxXl36EmqXsln72hG1n9r0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-NCxLJinJPU-6k9iP2bWO8A-1; Wed, 13 Jan 2021 04:25:59 -0500
X-MC-Unique: NCxLJinJPU-6k9iP2bWO8A-1
Received: by mail-ed1-f71.google.com with SMTP id g14so594694edt.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 01:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vhGBheygAegbfi9rXHPYkyAW71b1XQ8FOLJsWiApa9k=;
        b=IOJMd0rvNuRTZuxs45wE6vX1JCE6pKqvRkxnVS1xrHRaH9On1A27J1g7X+AYzoyKhF
         vG4sL5TLAyOkvRhbZNBqswoEkV4qr0wkt5QjuyN3QmFAGMK98XHqi0asjK1KtCuWNYfw
         XE+3Hq0ypW2lFAGtIjCOcoCXNaT0hKbiftYqPc4+hPOsioY4hmFJjXTxronWqpVnMHuZ
         fRdJTRFkpOhMKzCURI++Sz5ErdgQqS6OCbbMggad+wpBDtIokuTLo1QD5BNvSFMtqw8J
         UphnBkeS12SatfbX+T9bR/hnvFQQuqcsoS1IYsbj2krZQZJu9R3kRNfwr/wASbA8ZwZL
         4sQQ==
X-Gm-Message-State: AOAM5303LZ8xRX+4gJs9XzYJHbHucFcepkPpQq1m4XFRc099DrgVnNNE
        Ik9jUEXhLQ739MtUGNjP7rSi0JMLDN6ClroNX9fPlzglPRR/uKpqI6k8Lw8gAQjfyxWjyBpLVRO
        abch3VHNQzia7oqAbgyYutS8mLTy55uqcTAd0SEYyJ9C7LzpBsA7/NMDXfTZCF4nrnbeMscuWIQ
        XT
X-Received: by 2002:a50:d60f:: with SMTP id x15mr1023703edi.224.1610529957651;
        Wed, 13 Jan 2021 01:25:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxppPFuiEj429kT4UmRf8AVmVPxSIzK+1V4paib69p0+KuGMTPwkvEoW4ilQaa533kik78OkQ==
X-Received: by 2002:a50:d60f:: with SMTP id x15mr1023686edi.224.1610529957437;
        Wed, 13 Jan 2021 01:25:57 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id m24sm465153ejo.52.2021.01.13.01.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 01:25:56 -0800 (PST)
Subject: Re: [PATCH][next] platform/surface: fix potential integer overflow on
 shift of a int
To:     Colin King <colin.king@canonical.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210111144648.20498-1-colin.king@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e4092c8d-8857-ad95-065b-f72e774dfbb6@redhat.com>
Date:   Wed, 13 Jan 2021 10:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111144648.20498-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/surface/surface_acpi_notify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
> index 8cd67a669c86..ef9c1f8e8336 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -188,7 +188,7 @@ static int san_acpi_notify_event(struct device *dev, u64 func,
>  	union acpi_object *obj;
>  	int status = 0;
>  
> -	if (!acpi_check_dsm(san, &SAN_DSM_UUID, SAN_DSM_REVISION, 1 << func))
> +	if (!acpi_check_dsm(san, &SAN_DSM_UUID, SAN_DSM_REVISION, BIT_ULL(func)))
>  		return 0;
>  
>  	dev_dbg(dev, "notify event %#04llx\n", func);
> 

