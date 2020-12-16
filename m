Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3012DC44D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgLPQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLPQbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:31:46 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87828C061794;
        Wed, 16 Dec 2020 08:31:06 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id k7so5346408ooa.0;
        Wed, 16 Dec 2020 08:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q0xWAts6qR5e9pEsAVLTUfemL71dH9b7+6g7q6uqfJU=;
        b=ML5pUC+exNynNHAbqJDt9bm7XljKiMfdfk6o5iWkKA6fdCtuhUlstXN38KNrXvnsHx
         GPi7Ag4BZxtlH84aLqFcBrAezXt3V3VnxzgbUMhTA7+syqlxHceN6Dp8A88/dlHzTPnG
         dNjoWzlFb5Jl9319YO4vZbIAgfbLt4NS2wa7Quh/t9S38CEpBjzirplX8dPpIPGPXI38
         V0ZOKiBbwVb6erdh6RhY3xmsiDgmmYaSJW1+Bq9mjd2Yf2iKCboJyM4nkzoSo6ybWRLB
         vZI1gA9OQpfBoHHGkX7YPcBSYmEIV/1UQeJ+X6wxnTea+9dd/ODGj6NpRBX2yD9P/Z/9
         L75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Q0xWAts6qR5e9pEsAVLTUfemL71dH9b7+6g7q6uqfJU=;
        b=pgamezPNKFS8VOIXhDEOItA7f712mxg7NbDTWhWyVaPbCms0YsHsQYyW9rhFCsgotp
         2zd5kV6q9eNBV+8ZmWrN2e/tJ6t00eDEfLWtkkzShMMOWDiefgMV2EW0CpN7wNdl+3/o
         jyhtYgTkitV3of5nP/0oK9oeWWjY9hJye4ITTflvXqZEC0ly7O8G6pO/d3mT8vUnYslT
         8r6OHvn3vUcTXWkdUrNRsyeXuSUmhCOJ79pmCpUn/JTS0vILLBRA6WCK2B3JKzJaFR9w
         ISquhrs7w7Z0G3F6QCOBp0uj6tndULAwqahbRQhgMe3y0TxyAJXYdECB91BfHzFESI1Z
         m3zQ==
X-Gm-Message-State: AOAM533nJ4C4Y/3SM9mORMnu2AHMYhbDh7SV5WxW/NrCUU9jphuhwauB
        dmGqJCryx8snN8xvyFyvIfr6G5gev2w=
X-Google-Smtp-Source: ABdhPJx8tQnllx5qDxPA/zFby+gUTNxRC51M0H35Ty9ecs1gkt294tvjNQacYvlWbQTH//xLeKuirQ==
X-Received: by 2002:a4a:8c73:: with SMTP id v48mr10841113ooj.53.1608136265717;
        Wed, 16 Dec 2020 08:31:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p81sm451324oif.30.2020.12.16.08.31.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Dec 2020 08:31:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Dec 2020 08:31:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Kun Yi <kunyi@google.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: SENSORS_SBTSI should depend on X86
Message-ID: <20201216163103.GA59351@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 02:46:41PM +0100, Geert Uytterhoeven wrote:
> The AMD SB Temperature Sensor Interface (SB-TSI) is only present on AMD
> X86 SoCs.  Hence add a dependency on X86, to prevent asking the user
> about this driver when configuring a kernel without AMD X86 platform
> support.
> 
> Fixes: e7bb1a2ab8c4b156 ("hwmon: (sbtsi) Add basic support for SB-TSI sensors")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Makes sense. Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 1ecf697d8d99b70c..63d28f98108d4bb5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1536,6 +1536,7 @@ config SENSORS_SL28CPLD
>  config SENSORS_SBTSI
>  	tristate "Emulated SB-TSI temperature sensor"
>  	depends on I2C
> +	depends on X86 || COMPILE_TEST
>  	help
>  	  If you say yes here you get support for emulated temperature
>  	  sensors on AMD SoCs with SB-TSI interface connected to a BMC device.
> -- 
> 2.25.1
> 
