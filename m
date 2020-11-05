Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917BC2A7933
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKEI2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:28:04 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:35901 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKEI2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:28:04 -0500
Received: by mail-ej1-f68.google.com with SMTP id o21so1388833ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kub1Lp2e1PmOcVJO6y4wLb/0t5h4kQLdsa0jQnqFwbM=;
        b=pN1STENZ86uD61cHFSyW23YBOx+mgyfpx8PcBLv6WX/wVQ0dRGAIRM/Rbtb8B05PCs
         m4esFStjh7eVUrHi1/0/uwOMBb25i2TmfHCsMIr9zxXtWp720oqerlIycP+sEvP36uBJ
         jfXKk+UypVkvVKtV08jokhQ5BT7Jmx94ss90iIj5RqM2wJy6i60AfwvpvPCMSZOjWRva
         kSATRHLBXdqgpBzSb4WfJaKeguA1PZ7UAsENLq1rGaqA1/ls+FiqQ0yDhBQEq1bH++d8
         W8f5hNtIRWvNct4uuTTl044d0DeTkJqO+VuXrCnuJQDEpjJyWodvas3e4i18Se/9Km5l
         W6tQ==
X-Gm-Message-State: AOAM531bMjCAuWIBvLmG2DYjU+Jm8mLo5vC8nfkrCO5+n6IawFbXdqri
        IIDw96B6KWR9LwkPrelsuPFjlB7MZ98=
X-Google-Smtp-Source: ABdhPJyXZotSGJWOs0mue51/Ny+A0SmvsZncZsFHz++KJgsZVjrFL0Ri099DT1cohvDJKh3gDf/oMg==
X-Received: by 2002:a17:906:b150:: with SMTP id bt16mr1236690ejb.257.1604564882302;
        Thu, 05 Nov 2020 00:28:02 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id y18sm498747ejq.69.2020.11.05.00.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 00:28:01 -0800 (PST)
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        paulkf@microgate.com
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
Date:   Thu, 5 Nov 2020 09:28:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201104193549.4026187-28-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 11. 20, 20:35, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/synclinkmp.c: In function ‘init_adapter’:
>   drivers/tty/synclinkmp.c:5167:6: warning: variable ‘readval’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: paulkf@microgate.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/tty/synclinkmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
> index 0ca738f61a35b..75f494bfdcbed 100644
> --- a/drivers/tty/synclinkmp.c
> +++ b/drivers/tty/synclinkmp.c
> @@ -5165,7 +5165,7 @@ static bool init_adapter(SLMP_INFO *info)
>   
>   	/* Set BIT30 of Local Control Reg 0x50 to reset SCA */
>   	volatile u32 *MiscCtrl = (u32 *)(info->lcr_base + 0x50);
> -	u32 readval;
> +	u32 __always_unused readval;

Why not just remove readval completely as in other cases?

And the loop can be turned into ndelay:

         /*
          * Force at least 170ns delay before clearing
          * reset bit. Each read from LCR takes at least
          * 30ns so 10 times for 300ns to be safe.
          */
         for(i=0;i<10;i++)
                 readval = *MiscCtrl;


thanks,
-- 
js
suse labs
