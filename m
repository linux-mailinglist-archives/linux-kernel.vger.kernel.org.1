Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4222BBDF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 04:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgGXCL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 22:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgGXCLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:11:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E844EC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 19:11:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so3620691pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JyrL1L2WwAwU/zTxIdLQLyyDFKn9MNNL5Q0BQ8TqQ8g=;
        b=BcQDVaOeXNuLXwq6rEFIaWdLfSrKWRpPdhCiKJDpWB3PInmdzs2Ns3o++eaMKCn+mq
         qfkEdY0JDk/B+Jjf2ciYFcb7NCHU8UTjsLHY+U83mCgOE7XKE6+HVCcPy7RanyBWN53y
         WEHKLvvHmk4g6bq8pZ4H2Am7yV9ce3gWnTqVhxLVXcCkVEVdedLokoCgXgiG8YkpPdev
         fODQtrz7/V9QpHRCG0U3IfVT2IpeXxFrD4kS9VahwI5zLig6fgxvFhVrmkG37hr7bb+p
         hN41Xr/SsUS5Z8CkHQPRSEQqDAgxBr0HAXhPKdf7TaBKa5PXKJkxckk42ePeghFZ5H9/
         M64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JyrL1L2WwAwU/zTxIdLQLyyDFKn9MNNL5Q0BQ8TqQ8g=;
        b=Gp0PZdoDdTfDK0JB4q3zwZ7y/6sMahPY/4aGAkimNFM0zoHHipLz4uKF8oXKlfAiJo
         c2IdmSnMZbiYOraXZSeJD0O75cd3JYlR5nj/8GEOx//fdZMnwzO37EisZq33lKzyAJtn
         mx2UGzkV/wvB3CowDaY3UPcm0YJSBrJNYrQoIC/Olyn/B1Q5z7ztoZnd4OKT6Kg5tw4j
         omTjuP0U72jLs7z2ABMTND1DvDvpG3TbaYu3/EImr2Jpjdv1AYy/fhj95Ux6XpCYMjtE
         NE13+IvtqmCRb00YtnFH+S9+4kx1aiaXvElNH2IZ9gwi2hcKf1fn8ph9W/ArlGP6jfk4
         BaNg==
X-Gm-Message-State: AOAM532szDzHgmMW60uaoeTQQBxZoUKzHfjZq4j7m2AmhfXwRn5ehpft
        YfYFwM3C38CpQNqFb3GGMEEuZEht
X-Google-Smtp-Source: ABdhPJwECU3do/mOtZcqdCz+JZ2lrkj7A9fIVio5Py4eptDG0qfr5sLhjbeQGoxA2aXcG52JE9319g==
X-Received: by 2002:a17:902:c697:: with SMTP id r23mr6567030plx.35.1595556684359;
        Thu, 23 Jul 2020 19:11:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m1sm3872727pjy.0.2020.07.23.19.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 19:11:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] lib/Kconfig.debug: Make TEST_LOCKUP depend on module
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1595555407-29875-1-git-send-email-yangtiezhu@loongson.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7dab63b2-4bd9-2e1a-deb2-ceb3791d71e9@roeck-us.net>
Date:   Thu, 23 Jul 2020 19:11:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595555407-29875-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 6:50 PM, Tiezhu Yang wrote:
> Since test_lockup is a test module to generate lockups, it is better to
> limit TEST_LOCKUP to module (=m) or disabled (=n) because we can not use
> the module parameters when CONFIG_TEST_LOCKUP=y.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Makes sense.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210..18b7c67 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1035,6 +1035,7 @@ config WQ_WATCHDOG
>  
>  config TEST_LOCKUP
>  	tristate "Test module to generate lockups"
> +	depends on m
>  	help
>  	  This builds the "test_lockup" module that helps to make sure
>  	  that watchdogs and lockup detectors are working properly.
> 

