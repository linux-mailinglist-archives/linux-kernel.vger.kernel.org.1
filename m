Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED482DA8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgLOHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgLOHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:55:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D71C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 23:54:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m5so18824247wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 23:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jseI11zOblLneH9TFFk1vBqDmhjh0ZCOnucsuBpGmrw=;
        b=y5H6HAkzTcnlvCjuEa8MseP+GPT99B2eYvEbijUrOT/5H7uwwd3ZAVGc3La3sm3z9p
         UBo4Bg4QFCMB8kbn/eD9H1R8JdpPtZXs55Db5ayWDX8Z0kr26Qatj688+ejPUxNXIKMS
         GigH0WI2NsB5s8iDiuSDjSzACRXGOd2wgsm11VZvX47MhCebje7vIM7nqIyBM611z2VR
         WE5e0PqjKQhqcIP/A1YVbOIXLb0vrVw/dIKRX5rfcgTVrBTVWWE2gWHMP0pEE8H+SkaP
         DeLIcee5zbY98KZ7//Aw3fkSQYWFw8i1yft/w+u7x5404t9DriReOCoAf7EdVYIBaHQe
         1PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jseI11zOblLneH9TFFk1vBqDmhjh0ZCOnucsuBpGmrw=;
        b=GgjBM6pvJmNXSo3Sy0eYscGTIlXbGjoB5SWyR5LYgnhgCbyIKIMF2OtgppwGgXjccR
         JXXPNen3qexklMmwA8AKQsAUbuT1cifWKRE4V+vo13ToSocxU9NVNJIpdAma7Bs5JW6J
         UdZfAVzMe42JOocFQTXesZxJU9eskg821QsPC8a2jTxCAByvjrF6F7eGMhoS+IiIspZ8
         syn8Hmgk6istRremNbfpM1GmX9DnU5ZwMn+EnDSkmCGqL/yz/nL+hDn8t0Ilc6XllDE4
         iDWI6aQNV71+TXcQoQWZZgBjqouG8yFjnP1bnnhfIcUPq/qQvrXzgt4wkflHbiI8GZuY
         WWVQ==
X-Gm-Message-State: AOAM530RZGwo8jxDbHBHSdRvAXkFqr7gl6RfZ2N0F0tOEqYwJbEJJw5/
        82P2mkaQm+av3tMRKkNS3+3cDQ==
X-Google-Smtp-Source: ABdhPJwAuzCd0m07hD/vufzfGZUvwA+CMKD/sYngmTlBeUxjGQgCI0P3ujFw8s6OzWLzMBAB9gS0Bw==
X-Received: by 2002:adf:a2ce:: with SMTP id t14mr33682554wra.308.1608018867982;
        Mon, 14 Dec 2020 23:54:27 -0800 (PST)
Received: from dell ([91.110.221.168])
        by smtp.gmail.com with ESMTPSA id e15sm31441318wrx.86.2020.12.14.23.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 23:54:27 -0800 (PST)
Date:   Tue, 15 Dec 2020 07:54:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, vpalatin@chromium.org,
        guenter@chromium.org, bleung@chromium.org,
        Alex Levin <levinale@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: PCHG: Peripheral device charger
Message-ID: <20201215075425.GJ5029@dell>
References: <20201215023120.2514920-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215023120.2514920-1-dnojiri@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020, Daisuke Nojiri wrote:

> This patch adds a driver for PCHG (Peripheral CHarGer). PCHG is a
> framework managing power supplies for peripheral devices.
> 
> This driver creates a sysfs node for each peripheral charge port:
> 
> 	/sys/class/power_supply/PCHGn
> 
> where <n> is the index of a charge port.
> 
> For example, when a stylus is connected to a NFC/WLC port, the node
> prints:
> 
> 	/sys/class/power_supply/PCHG0/
> 		capacity=50
> 		status=Charging
> 		type=Wireless
> 
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---
> 
>  drivers/mfd/cros_ec_dev.c                     |   1 +

This should be a separate patch.

>  drivers/power/supply/Kconfig                  |  10 +
>  drivers/power/supply/Makefile                 |   1 +
>  .../power/supply/cros_peripheral_charger.c    | 346 ++++++++++++++++++
>  .../linux/platform_data/cros_ec_commands.h    |  48 +++
>  5 files changed, 406 insertions(+)
>  create mode 100644 drivers/power/supply/cros_peripheral_charger.c
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 6135321592b76c..945565fc46a319 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -85,6 +85,7 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
>  static const struct mfd_cell cros_usbpd_charger_cells[] = {
>  	{ .name = "cros-usbpd-charger", },
>  	{ .name = "cros-usbpd-logger", },
> +	{ .name = "cros-pchg", },
>  };

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
