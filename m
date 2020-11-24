Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93E2C2559
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbgKXMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:07:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729172AbgKXMHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606219657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUepnH/BY2weycp09UNa2ieOA6E5qsUEEiisaW54yy4=;
        b=AmO6oycel7AXbYUhOnTizKVNYdraaIT813jBwBASKXWDLgMC/+NRcAUCf8fixS7Hj4nXi6
        vSX3eQ2SbsggvNFi3rP/hBTUFJirCxGpM3M6+qCZBrXFFW7XUB1F245jr4nEqx2OFiQZMI
        fYcRPtr7ga+mcYRkhN5GzfFDbHIHV2g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-NQKhEZlHPDegaCYpSDF9tA-1; Tue, 24 Nov 2020 07:07:33 -0500
X-MC-Unique: NQKhEZlHPDegaCYpSDF9tA-1
Received: by mail-ed1-f72.google.com with SMTP id dj19so7858354edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUepnH/BY2weycp09UNa2ieOA6E5qsUEEiisaW54yy4=;
        b=jsvkmyfLlp2eGbrK8+CFvpLD0ENbID8K25XEqrI4GqE+fm6Y6vPUh5W+1kPDrfMUFL
         2FNqnG1F2SDhf2V2HkmMhkkD0c5GChpam5iS8udOt1Ukgwo9NG4OxeyUtSItsFaS1kpN
         U7UYa0kaldWiXWTJQnciz7bUU3YNfOefs1oVDdxD+pNrs9TEX4+CyoVQGiPUWSyYWOnZ
         vyJ+Vm6/XPJiXhA4k4pYaKzEB0PKkN96bJbkwP5aHd8vEHHJfead1iNeoTs8kzrEujcN
         Ddy9+inFcohu+Gqr8dzeOJZ5TnZgDOTMNZx+27jDxo758vMNZKyxTktoKvs/KksxbYCv
         3JVQ==
X-Gm-Message-State: AOAM533kP7vfkM7Fm4BwueADUOqKslZKGtoa79KRGzfC6hUpX0N+TxWk
        YWr5HDUcZqvRgiLE76Dsy6jdDXs9JrFoCbnE9s6aNov75Pnr8W2c8ii9gTZrOVNVG4l6T3d7P4S
        ceZ9tFxSXe8lxEiOAwfJLUKlZT+iS/tM3CueoLKyswGiiye7GU/50OfI1YWpvLqp8CM3eSoFvQr
        9u
X-Received: by 2002:aa7:d801:: with SMTP id v1mr3507241edq.252.1606219652003;
        Tue, 24 Nov 2020 04:07:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoJogVcFvQbdPqObhJFAsKvlWD4bs/ji5r0zZThKsuDDMBWN5+EhaXd9jsoqJ8+JF7NrcKKA==
X-Received: by 2002:aa7:d801:: with SMTP id v1mr3507213edq.252.1606219651736;
        Tue, 24 Nov 2020 04:07:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id j9sm6690121ejf.105.2020.11.24.04.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 04:07:31 -0800 (PST)
Subject: Re: [PATCH] platform/surface: gpe: Add support for 15" Intel version
 of Surface Laptop 3
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20201113223935.2073847-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <265fc25c-c6f8-e1df-ccc5-fa4f55c42f39@redhat.com>
Date:   Tue, 24 Nov 2020 13:07:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201113223935.2073847-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/13/20 11:39 PM, Maximilian Luz wrote:
> In addition to a 13" version, there is also a 15" (business) version of
> the Surface Laptop 3 based on Intel CPUs. This version also handles
> wakeup by lid via (unmarked) GPEs, so add support for it as well.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

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
>  drivers/platform/surface/surface_gpe.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
> index 0f44a52d3a9b..e49e5d6d5d4e 100644
> --- a/drivers/platform/surface/surface_gpe.c
> +++ b/drivers/platform/surface/surface_gpe.c
> @@ -146,6 +146,18 @@ static const struct dmi_system_id dmi_lid_device_table[] = {
>  		},
>  		.driver_data = (void *)lid_device_props_l4D,
>  	},
> +	{
> +		.ident = "Surface Laptop 3 (Intel 15\")",
> +		.matches = {
> +			/*
> +			 * We match for SKU here due to different variants: The
> +			 * AMD (15") version does not rely on GPEs.
> +			 */
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Laptop_3_1872"),
> +		},
> +		.driver_data = (void *)lid_device_props_l4D,
> +	},
>  	{ }
>  };
>  
> 

