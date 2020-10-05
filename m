Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20628391E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgJEPKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgJEPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:10:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986A2C0613CE;
        Mon,  5 Oct 2020 08:10:10 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m12so8945094otr.0;
        Mon, 05 Oct 2020 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1Z0afjwiSxiIssLndoQNyQcwPRpf3Ba8DGu293eCYU=;
        b=mWltcYJIsUHQ3ccnkfUilO5Bk1Rcx0lC88e1sv1BeIHb9DR8Pj2L/xmqNA6OLkRdZr
         ycg2oZEP28g/8ywUzzj/XwalBLH0Mbh1UXmJMZQMO+DGsBCx5jMPVVUs7Vm9jVD7nVMr
         TDqWX0Zoi5tIlFTZzCNA+3Eetw7vbfG8qewOuDj2qem3+LDqJB81w51HfqjbKBzmkU37
         zeN8STD+4x829Mkvdd+8wHHrb2DCOgfYtO6RC4XM9hEzwlCb1V/vnaQX1y6H/12XunJd
         jfAxepOE72sZhBgr3SDzr5L19TjoCLSt1RSRULTki9CoZs64ZaRCyI8DYCj2fhNMX9u0
         zcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1Z0afjwiSxiIssLndoQNyQcwPRpf3Ba8DGu293eCYU=;
        b=iKTLvM5ONgk6d5y64+4/Y2t1CpZ18nFcsD+UQ0283IDeI+iO17sPP/3OucgesPySdq
         vxUMkpmxH+QiiQOJUB6QVKFhJAQRGwfJdE/FdOPQ3wS82k+Iok3Oo8UbWnbMX4vCe7ir
         57mf1eSRVS/jTyYY6UjvW09zrveBwI+tPdIPevL1u3zewDeLyQ+DKYnjzr6DEagvNBbf
         huLrLySxOf4tMvFFbxCmd+9qJm3qKN3VBF51P03xpfQ7C9VSmO2mAOuy2BBh85LP2QrO
         8oHviEXoCSBFQnSO18YNIjM+8l+aqkBN28YjW97ww5KO80+SWARbQvLnun3h4eydbJE7
         8cNw==
X-Gm-Message-State: AOAM533J/TmZIGgdM5sAvRfJC48mqJ2qL1L0LumL0BNtY6rSLI7H66Pl
        UBjfN40tGmmaW14pKfh+NRQ=
X-Google-Smtp-Source: ABdhPJxVEFJ3q62PnMgQOuWhzd9lg4HJcbRhx8hoWOqCUMo/gmfQJCMmKHXq/XLGcU9+5fkobdAn5w==
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr10586768otq.38.1601910608467;
        Mon, 05 Oct 2020 08:10:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 71sm3136451otm.81.2020.10.05.08.10.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Oct 2020 08:10:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Oct 2020 08:10:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vadim Pasternak <vadimp@mellanox.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jiri Kosina <trivial@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] hwmon: (mlxreg-fan) Fix double "Mellanox"
Message-ID: <20201005151006.GA44155@roeck-us.net>
References: <20201005124843.26688-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005124843.26688-1-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 02:48:43PM +0200, Geert Uytterhoeven wrote:
> Remove the duplicate "Mellanox" in the help text for the Mellanox FAN
> driver configuration option.
> 
> Fixes: 65afb4c8e7e4e7e7 ("hwmon: (mlxreg-fan) Add support for Mellanox FAN driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 8dc28b26916ec4c8..64abec37ca9d5d0d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1080,7 +1080,7 @@ config SENSORS_MCP3021
>  	  will be called mcp3021.
>  
>  config SENSORS_MLXREG_FAN
> -	tristate "Mellanox Mellanox FAN driver"
> +	tristate "Mellanox FAN driver"
>  	depends on MELLANOX_PLATFORM
>  	imply THERMAL
>  	select REGMAP
