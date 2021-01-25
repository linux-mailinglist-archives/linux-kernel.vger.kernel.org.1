Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD5F303300
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 05:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhAZEoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 23:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbhAYJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D42C061354
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:43:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m1so10646446wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HRNVV2iDjrCd53h8d8qkoxjSqSZom490lrNTzWH/TBg=;
        b=DEMHOdisgPMlWuDwRhxkdgPsMYb2HvYJEsaIPV/pEzRm1WIvI+aR7Cc0/gMY0xtcdW
         6GMSCn7N4WHFH+uqBaqQPirMKQ5EIWzDyT+oJjC7Zpv7Gq40TwqepjvxhEuCS/gl0F61
         U/B2r/2HEuBjWCNL4R6sk+/O7NWA43uoLQblD6SlOc7oF8KnNZ4PwEXeEo5MThriKrIe
         kW4oo8eHYDt3uUdDwZbIYiCGceG3B7dcSQHO9V7hOEx98rMtOIyxigopbCDMpe44Nbpa
         2Pr+aclgW3uZ+bdwNAx1HeI5VQTaj1GW7ebymcK10tJrHSwld+logKxKW3qlEzmSgy72
         8ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HRNVV2iDjrCd53h8d8qkoxjSqSZom490lrNTzWH/TBg=;
        b=jqwN9Jh5Bw9jUPSzIMk2jfvZ9G4Hd1xj37ns7H9QwcLFo7SapKtGmRHt5XknLCxUWk
         d6mDsdE6ZSSLtkqUDQ972HyDa2CxAwpk72q4U4WsUSzogA+qoX/xds5nFEMudM2JcXfK
         yqp4sBH+sIFml2AeoVRARMC4CvRfBB+tWVpm5Ih6yo2ePM7DJnpCz0wBjPYH17rza0rX
         SfpQKCM7L2gWUD8C5yUCUz0rQDGEyK7DYnwTyKWVERniHaD1Bkm3HrGS0aww+0OSZd1u
         3lyOj5pAhVlSAaXTqeD4Ci3TEtO3kyXOt7hzsqR8HCSHVBZoTnIqBgQYCYko4VEaM5Qd
         Glcg==
X-Gm-Message-State: AOAM5300f5EfWPw6IJl5SdOxC0dwhNYVcYJCcUAzxsG0qju4C/3CiNf6
        yAHLiZPNGMQMiL10ISaDi8C7KN8lxOhB2/Dg
X-Google-Smtp-Source: ABdhPJwvLfswC9FXq6MuFq+ZdO3vzAT3bgIMyj9AJioqn5g1p5HNPxy3qgU8vqusss7ONaFxsmAqxA==
X-Received: by 2002:a5d:6041:: with SMTP id j1mr4600359wrt.155.1611564229349;
        Mon, 25 Jan 2021 00:43:49 -0800 (PST)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id d199sm20098457wmd.1.2021.01.25.00.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 00:43:48 -0800 (PST)
Date:   Mon, 25 Jan 2021 08:43:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max8997: Replace 8998 with 8997
Message-ID: <20210125084347.GU4903@dell>
References: <20210124170528.1230932-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210124170528.1230932-1-timon.baetz@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jan 2021, Timon Baetz wrote:

> Replace occurrences of 8998 with 8997.

Because ...

> Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> ---
>  include/linux/mfd/max8997.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mfd/max8997.h b/include/linux/mfd/max8997.h
> index e955e2f0a2cc..6c98edcf4b0b 100644
> --- a/include/linux/mfd/max8997.h
> +++ b/include/linux/mfd/max8997.h
> @@ -14,13 +14,13 @@
>   * others and b) it can be enabled simply by using MAX17042 driver.
>   */
>  
> -#ifndef __LINUX_MFD_MAX8998_H
> -#define __LINUX_MFD_MAX8998_H
> +#ifndef __LINUX_MFD_MAX8997_H
> +#define __LINUX_MFD_MAX8997_H
>  
>  #include <linux/regulator/consumer.h>
>  
>  /* MAX8997/8966 regulator IDs */
> -enum max8998_regulators {
> +enum max8997_regulators {
>  	MAX8997_LDO1 = 0,
>  	MAX8997_LDO2,
>  	MAX8997_LDO3,
> @@ -207,4 +207,4 @@ struct max8997_platform_data {
>  	struct max8997_led_platform_data *led_pdata;
>  };
>  
> -#endif /* __LINUX_MFD_MAX8998_H */
> +#endif /* __LINUX_MFD_MAX8997_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
