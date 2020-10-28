Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06F329E27C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgJ2COz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbgJ1Vfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603920935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJHhfZ2V2kb0ESkGQZCAib+1qqkooRbQR95yCbytl7s=;
        b=EFZBLLoFENA5ieRplqxCSfzhUzYAHdUhuFnztpG3/I+HOaIOZvKdFBrar1dsvK/Fy8S6oW
        GmAASkgGdqgguknAhyLsQuDUeI0Qt3TIrEes2vaYCQ6Pp2hyXvcW2BWHC7pa5KNAtLC0yB
        0KHtRt9QumE53cCL/aY8Htike29JoC4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-95NiMNOMN0i5xv_8YuE0BA-1; Wed, 28 Oct 2020 07:33:42 -0400
X-MC-Unique: 95NiMNOMN0i5xv_8YuE0BA-1
Received: by mail-ed1-f72.google.com with SMTP id b16so1988650edn.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 04:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJHhfZ2V2kb0ESkGQZCAib+1qqkooRbQR95yCbytl7s=;
        b=SJhacxQFhWb5jf1TgDpD2KXJlFBjQ6Vrgnm3OHfMX+A5QCaL/JeKdSm1fR+zuIUOwX
         zSmAsxJAGZnhB+9yIJF/1QXnQDq6lygNHsiNj/I8Lb+dIA9yyMYYwdXHPw7H1gRrN9xx
         mcMKlV/4n5RzERfqs+uG9f74lIPPfXs0G7c6pv7EtbgjCIMGjMRCpm2JIw7ZzTCc47RT
         LXoKd7FSwGPTl9CsNcwkr9u3y0c310ZpQM0N27Aje3wIHWeKFgEwRasGLtU2L8BqlbVe
         eY7h9bpz5/EBcpEiRRunYmLu0Sm6bci8aAJvclC51WCT7qxpATDgWD3Gyge0k7wiJJr9
         OS1w==
X-Gm-Message-State: AOAM531QpSkIyV8kD+nKD9Ajn4VHJewFySlWd4YfyXZ5lhRF/lb7NpKW
        srO47V5UNxOVMpgSrJVKQnhTqBsg95SoNDq8GmtP30gCq2EmxQf5autTbzumFIbxFfsURjzGvTX
        tKPZOVX1cAn7rNbiyYMJVPjIp
X-Received: by 2002:a17:906:402:: with SMTP id d2mr3293514eja.165.1603884820790;
        Wed, 28 Oct 2020 04:33:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIKV5nnNTcNuopRKBG+aVCqjxcweo+pTjYRN//cyr5S9Wkk3HlbZG1Mt+zdaQ2EMO5feyEGA==
X-Received: by 2002:a17:906:402:: with SMTP id d2mr3293495eja.165.1603884820534;
        Wed, 28 Oct 2020 04:33:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id k18sm2651040edx.54.2020.10.28.04.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 04:33:39 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: remove unneeded break
To:     trix@redhat.com, jlee@suse.com, mgross@linux.intel.com,
        malattia@linux.it
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201019133212.12671-1-trix@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dd06e057-7ca8-972b-3d71-8e06aa68961f@redhat.com>
Date:   Wed, 28 Oct 2020 12:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019133212.12671-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/19/20 3:32 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a return
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up there once I've pushed my local branch there,
which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

> ---
>  drivers/platform/x86/acer-wmi.c    | 1 -
>  drivers/platform/x86/sony-laptop.c | 3 ---
>  drivers/platform/x86/wmi.c         | 3 ---
>  3 files changed, 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 49f4b73be513..1c2084c74a57 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -792,7 +792,6 @@ static acpi_status AMW0_set_u32(u32 value, u32 cap)
>  		switch (quirks->brightness) {
>  		default:
>  			return ec_write(0x83, value);
> -			break;
>  		}
>  	default:
>  		return AE_ERROR;
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index e5a1b5533408..704813374922 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -2467,13 +2467,11 @@ static int __sony_nc_gfx_switch_status_get(void)
>  		 * 0: integrated GFX (stamina)
>  		 */
>  		return result & 0x1 ? SPEED : STAMINA;
> -		break;
>  	case 0x015B:
>  		/* 0: discrete GFX (speed)
>  		 * 1: integrated GFX (stamina)
>  		 */
>  		return result & 0x1 ? STAMINA : SPEED;
> -		break;
>  	case 0x0128:
>  		/* it's a more elaborated bitmask, for now:
>  		 * 2: integrated GFX (stamina)
> @@ -2482,7 +2480,6 @@ static int __sony_nc_gfx_switch_status_get(void)
>  		dprintk("GFX Status: 0x%x\n", result);
>  		return result & 0x80 ? AUTO :
>  			result & 0x02 ? STAMINA : SPEED;
> -		break;
>  	}
>  	return -EINVAL;
>  }
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index d88f388a3450..44e802f9f1b4 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1260,13 +1260,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physical_address address,
>  	switch (result) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
> -		break;
>  	case -ENODEV:
>  		return AE_NOT_FOUND;
> -		break;
>  	case -ETIME:
>  		return AE_TIME;
> -		break;
>  	default:
>  		return AE_OK;
>  	}
> 

