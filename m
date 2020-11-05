Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E392A789E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgKEIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:12:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45349 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgKEIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:12:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id q3so298657edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9k0PUeO60JBFgHy+r0PQSEUvbL6I/98BC9PRbIUtqY8=;
        b=ZWlpHl0ftx3BY0BsRHFgh3GvPPhDEJU1g8PBW6WAVvrLmmHcD7wNUSW+GMFI2rxMJ1
         klhuwvBtxzuW2KAqzX7u2Hqyg0+DqYhXgz7uVEYtSCDknmi6UVQ1OrxFPsRhAlyldx+o
         nVvOW7of/jLOR/0DfCIsetmXC5dcE9+uZJ1fqCn0f7TKht/Hxi2T+DNj/dsoOwkaN1R0
         j+2CHwDBoaDqeRFZdIBPZ5Y/B+juLTJP51xtSwDA/0H0KR+bSNC1YzFsFTv1j0OGMdof
         YOyGkPFScNh76lXSoBRFwlYoA5D1142Ez9zVz3HUIAKGSZuawefNuiaGOMEUOvY7vdIU
         A51A==
X-Gm-Message-State: AOAM533B7z4Jet/vW14C59dCDkyXyxcJDkq0aNmL2kTOvABRRyGVdbwd
        F9pLscPwfAj+wu83zn4Ugvs=
X-Google-Smtp-Source: ABdhPJyogQH62BjyiPpVfIBH5lPJrc0fx5MttKD5BzS8bODGBSqitPyd7psdhIQiCdAmGl5vZtjhkA==
X-Received: by 2002:a50:e185:: with SMTP id k5mr1364031edl.48.1604563970507;
        Thu, 05 Nov 2020 00:12:50 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id p1sm474767ejd.33.2020.11.05.00.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 00:12:49 -0800 (PST)
Subject: Re: [PATCH 08/36] tty: tty_ldisc: Fix some kernel-doc related
 misdemeanours
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-9-lee.jones@linaro.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8f07fa1e-d81f-fd43-9dfa-bfb9f9171619@kernel.org>
Date:   Thu, 5 Nov 2020 09:12:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201104193549.4026187-9-lee.jones@linaro.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 11. 20, 20:35, Lee Jones wrote:
>   - Functions must follow directly on from their headers
>   - Demote non-conforming kernel-doc header
>   - Ensure notes have unique section names
>   - Provide missing description for 'reinit'
> 
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/tty_ldisc.c:158: warning: cannot understand function prototype: 'int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD); '
>   drivers/tty/tty_ldisc.c:199: warning: Function parameter or member 'ld' not described in 'tty_ldisc_put'
>   drivers/tty/tty_ldisc.c:260: warning: duplicate section name 'Note'
>   drivers/tty/tty_ldisc.c:717: warning: Function parameter or member 'reinit' not described in 'tty_ldisc_hangup'
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/tty/tty_ldisc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> index fe37ec331289b..aced2bf6173be 100644
> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -190,7 +189,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
>   	return ld;
>   }
>   
> -/**
> +/*
>    *	tty_ldisc_put		-	release the ldisc

Having tty_ldisc_get in kernel-doc, while tty_ldisc_put not doesn't make 
much sense. What's missing to tty_ldisc_put to conform to kernel-doc?

thanks,
-- 
js
suse labs
