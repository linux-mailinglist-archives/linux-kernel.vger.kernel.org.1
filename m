Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344262A797F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgKEIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:35:40 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46294 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgKEIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:35:39 -0500
Received: by mail-ej1-f65.google.com with SMTP id w13so1364452eju.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A8p+H3RYNG8jjI1AszxS6HyIBWC6MEoTDsggNv7VAsc=;
        b=UyvGBmN3MTLjkkn3+pT44z8ofZCLAuGJKgbuLm4gPlZ9KVx5e9lmgCLc4OLlrX9h8z
         1Vr2/AZLQZGhZgPS/byvWFXiIY86kgIpVonAl10//fPgAJckLace/aksHmgWeklHAnvZ
         oBVwoRP5UfkGJ2l13KQvAz/sSThxfFvLA0oK1rhow7WQHzWy/JuyNtajG/GVwWI7kLyM
         AOUxz4x7YDaUeXDpVes7n8e5NOkbyYFND1o+shDrMH3O0W5ZX0QjKXlTc9PsFWyOcNjB
         M9p3fVEzUA6lZGyGdtZi2TNHEZEcsiT1uJBCmZn+QN7MXpYA0hZhJDxZ67k7NLn0SE2H
         hVFQ==
X-Gm-Message-State: AOAM533wqFlTgRc41WEX8mdn6zF3DXOJrdiiqo5OCPIvg8vkLe402qUZ
        g+FbuadEhQ29a0YRe3WgdrM=
X-Google-Smtp-Source: ABdhPJxrU+T7OaIDwT9JkXcGJCxI+P6UV14Ud8Tg8wN0XRMVaZSPHYBKf6JChdFdhKTgFHTr91OOAw==
X-Received: by 2002:a17:906:1a0c:: with SMTP id i12mr1238667ejf.176.1604565336204;
        Thu, 05 Nov 2020 00:35:36 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id k4sm461477edq.73.2020.11.05.00.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 00:35:35 -0800 (PST)
Subject: Re: [PATCH 35/36] tty: synclink: Mark disposable variables as
 __always_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        paulkf@microgate.com
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-36-lee.jones@linaro.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <8c45684e-057a-20f9-9a78-b0f6e9bcddaa@kernel.org>
Date:   Thu, 5 Nov 2020 09:35:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201104193549.4026187-36-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 11. 20, 20:35, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/tty/synclink.c: In function ‘usc_reset’:
>   drivers/tty/synclink.c:5571:6: warning: variable ‘readval’ set but not used [-Wunused-but-set-variable]
>   drivers/tty/synclink.c: In function ‘mgsl_load_pci_memory’:
>   drivers/tty/synclink.c:7267:16: warning: variable ‘Dummy’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: paulkf@microgate.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/tty/synclink.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
> index c8324d58ef564..8ed64b1e7c378 100644
> --- a/drivers/tty/synclink.c
> +++ b/drivers/tty/synclink.c
> @@ -5568,7 +5568,7 @@ static void usc_load_txfifo( struct mgsl_struct *info )
>   static void usc_reset( struct mgsl_struct *info )
>   {
>   	int i;
> -	u32 readval;
> +	u32 __always_unused readval;

The same as in synclinkmp.

>   
>   	/* Set BIT30 of Misc Control Register */
>   	/* (Local Control Register 0x50) to force reset of USC. */
> @@ -7264,7 +7264,7 @@ static void mgsl_load_pci_memory( char* TargetPtr, const char* SourcePtr,
>   
>   	unsigned short Intervalcount = count / PCI_LOAD_INTERVAL;
>   	unsigned short Index;
> -	unsigned long Dummy;
> +	unsigned long __always_unused Dummy;

You can kill it completely.

>   
>   	for ( Index = 0 ; Index < Intervalcount ; Index++ )
>   	{
> 

thanks,
-- 
js
suse labs
