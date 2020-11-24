Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE222C256B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbgKXMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:12:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729172AbgKXMM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606219946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYtm4WS/VKbRUCOq0XLPYf6Vll9ag4HN6eyUxZktLK0=;
        b=hUMLn53SOOxKyNamTEU8aqOvfZELcZc1a972Gsg2Y34cHeA3QM40E/gx22jlAJkfgfwMjx
        qWjB1F8fPNxNrbA4B3x06hQ9/hIAdot8tTsr6kpuWLF1xihHkP1LzQgtUXlt4v4PHDhEcH
        zlnlVDHERSc4qVR7JZpZle6DsRs4ThI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-Ek2yfpF1MCi1zNdfWz2Xhw-1; Tue, 24 Nov 2020 07:12:25 -0500
X-MC-Unique: Ek2yfpF1MCi1zNdfWz2Xhw-1
Received: by mail-ej1-f71.google.com with SMTP id pv11so689028ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 04:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QYtm4WS/VKbRUCOq0XLPYf6Vll9ag4HN6eyUxZktLK0=;
        b=iqwCxg1MtIpLvh7e0w60XqcZdujSMxhfndgClcFsxzuzdoc6xUd4Qs+53Q1Djt9HQN
         xdoZA3R3ZAKIQWlti/OvO3E8UZiLuYXpnM3moR1GfuB7/7vbHplLIcDtlhzeJRXdAyi3
         +bkiTNNyiAqeCkEmY0w5P111uL2qv6oa0lgJwi6v5xXQrtSZi8ZoirHo8rxHHeVlDTfG
         yMOcpzECrcfNaCEA4DNie6NyVsJFPxhaiqKs7X8j0Oo+IwmJUNcJcbYVuWkajVnHa5/X
         /FQ7gsGZdtK5+08BqYVB5BURSASTjZD8xXXaHRPC0FIMFfh+wsu7c1D/2gfFgQoN8Tf5
         3o/A==
X-Gm-Message-State: AOAM533uN9/8FmvihCz/JI27c8ee1L4mBCVrNTDUTKQLBZiMduN+kxxe
        GBc3fGrvXk/HtqyJ2T++Wx5Mk1HB1gBU1m5MBx9Fhi4RiD3ochpslzUyVTPN3qXbCC8gNVeJa2U
        Cuj/V26/473sTe6fvxvcdS84TaBlEXR/a7muH/WSBdqgXuBhJzUP7ueRL5bEqJwqK4Lc47CFUe6
        0L
X-Received: by 2002:a17:906:1183:: with SMTP id n3mr3751842eja.188.1606219943610;
        Tue, 24 Nov 2020 04:12:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk/PTwzMP+ErI6EGlqY2qYdUTtV53aR0KLZ94Bj3nBwadWAvcZpZNWLEJ5MKudenQ/xcOiPw==
X-Received: by 2002:a17:906:1183:: with SMTP id n3mr3751822eja.188.1606219943366;
        Tue, 24 Nov 2020 04:12:23 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id j7sm6742345ejk.14.2020.11.24.04.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 04:12:22 -0800 (PST)
Subject: Re: [PATCH] platform/x86: intel-vbtn: Support for tablet mode on HP
 Pavilion 13 x360 PC
To:     Max Verevkin <me@maxverevkin.tk>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201124131652.11165-1-me@maxverevkin.tk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a7efc180-be37-8058-465a-5e334e131b48@redhat.com>
Date:   Tue, 24 Nov 2020 13:12:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201124131652.11165-1-me@maxverevkin.tk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/24/20 2:16 PM, Max Verevkin wrote:
> Signed-off-by: Max Verevkin <me@maxverevkin.tk>

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
>  drivers/platform/x86/intel-vbtn.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index f5901b0b07cd..0419c8001fe3 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -206,6 +206,12 @@ static const struct dmi_system_id dmi_switches_allow_list[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "HP Stream x360 Convertible PC 11"),
>  		},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion 13 x360 PC"),
> +		},
> +	},
>  	{} /* Array terminator */
>  };
>  
> 

