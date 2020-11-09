Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9978F2AB433
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgKIJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:58:56 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36262 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgKIJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:58:56 -0500
Received: by mail-ej1-f68.google.com with SMTP id o21so11362207ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 01:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DynqxE17DAgOAA4iepCmaZ4Iydubo6B4RnUwCs5M/as=;
        b=VUc1nMMA+ggdiqp0Ij+YQLR0z+vLVHYDRV1+B4XaPbc7VAlEmOCRg/4TbOuGdu2nwH
         BIAzYW20TE5eoykszYiKzYro6hwAU+P1B2gb/kaykbrx/ZXXAnkSbgjGCCzkAAnypQUh
         bhkMtSvjx8mMi+HaFWe5p70tVNoPMV/151LKDrpsVKLhPbdVfARJSYnlm4n2QGHs62c7
         ztvfoXBYhztG1FFXLEkCpIMPSZUcGX3oVH3FMQX7hanPWmGFpw/V7seZsPmcc7cqBygx
         OZufaig7TtfvCFzHlmo/FsuFS6KyBEC7kpcWl+kZ1o2EbPI7ZkqcJ9Xj1VjDOlRlx7sx
         044A==
X-Gm-Message-State: AOAM531PcSd5VVQsYf7/Z+C9Z/tffTsYup7qnk1H4wSdEY59tXuf+0m5
        +9WnS9bUVFXjdE4cq/roHxw=
X-Google-Smtp-Source: ABdhPJxrl/OKI6ObWGBQw4tultWQuuannmSxU5881aaEgWpHNs0H0mw2wBo1hBaN3mfqas55DmUpkA==
X-Received: by 2002:a17:907:1008:: with SMTP id ox8mr13937453ejb.189.1604915934728;
        Mon, 09 Nov 2020 01:58:54 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a10sm8458436edn.77.2020.11.09.01.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 01:58:54 -0800 (PST)
Subject: Re: [PATCH v1 3/3] vt: keyboard, make use of assign_bit() API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <20201106143551.43908-3-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <5c016558-9f0c-ad4d-adaa-17bf1171ca03@kernel.org>
Date:   Mon, 9 Nov 2020 10:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106143551.43908-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 11. 20, 15:35, Andy Shevchenko wrote:
> We have for some time the assign_bit() API to replace open coded
> 
> 	if (foo)
> 		set_bit(n, bar);
> 	else
> 		clear_bit(n, bar);
> 
> Use this API in VT keyboard library code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vt/keyboard.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 647c343f61fb..b5132191b0ad 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -1433,10 +1433,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
>   		raw_mode = true;
>   	}
>   
> -	if (down)
> -		set_bit(keycode, key_down);
> -	else
> -		clear_bit(keycode, key_down);
> +	assign_bit(keycode, key_down, down);
>   
>   	if (rep &&
>   	    (!vc_kbd_mode(kbd, VC_REPEAT) ||
> 


-- 
js
suse labs
