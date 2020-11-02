Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633E42A2A57
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgKBMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:05:16 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3015 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728421AbgKBMFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:05:16 -0500
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 085BD73E37ADF4386AD0;
        Mon,  2 Nov 2020 12:05:14 +0000 (GMT)
Received: from localhost (10.52.120.98) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 2 Nov 2020
 12:05:13 +0000
Date:   Mon, 2 Nov 2020 12:03:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        "Dan Murphy" <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [RESEND PATCH v2] MAINTAINERS: add Dan Murphy as TP LP8xxx
 drivers maintainer
Message-ID: <20201102120311.000078d8@Huawei.com>
In-Reply-To: <20201029132720.13962-1-krzk@kernel.org>
References: <20201029132720.13962-1-krzk@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.98]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 14:27:20 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Milo Kim's email in TI bounces with permanent error (550: Invalid
> recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> credits and add Dan Murphy from TI to look after:
>  - TI LP855x backlight driver,
>  - TI LP8727 charger driver,
>  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Acked-by: Dan Murphy <dmurphy@ti.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>

Typo in patch title unless I'm missing what TP means!

> 
> ---
> 
> Dear Lee,
> 
> Could you take care about this patch?
> 
> Best regards,
> Krzysztof
> 
> Changes since v1:
> 1. Add Dan Murphy, do not remove the entries.
> ---
>  CREDITS     | 3 +++
>  MAINTAINERS | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index cb02b9923a52..2a214a47c67a 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1910,6 +1910,9 @@ S: 660 Harvard Ave. #7
>  S: Santa Clara, CA 95051
>  S: USA
>  
> +N: Milo Kim
> +D: TI LP855x, LP8727 and LP8788 drivers
> +
>  N: Russell King
>  E: rmk@arm.linux.org.uk
>  D: Linux/arm integrator, maintainer & hacker
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..9d74b222f9ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17529,20 +17529,20 @@ F:	sound/soc/codecs/isabelle*
>  F:	sound/soc/codecs/lm49453*
>  
>  TI LP855x BACKLIGHT DRIVER
> -M:	Milo Kim <milo.kim@ti.com>
> +M:	Dan Murphy <dmurphy@ti.com>
>  S:	Maintained
>  F:	Documentation/driver-api/backlight/lp855x-driver.rst
>  F:	drivers/video/backlight/lp855x_bl.c
>  F:	include/linux/platform_data/lp855x.h
>  
>  TI LP8727 CHARGER DRIVER
> -M:	Milo Kim <milo.kim@ti.com>
> +M:	Dan Murphy <dmurphy@ti.com>
>  S:	Maintained
>  F:	drivers/power/supply/lp8727_charger.c
>  F:	include/linux/platform_data/lp8727.h
>  
>  TI LP8788 MFD DRIVER
> -M:	Milo Kim <milo.kim@ti.com>
> +M:	Dan Murphy <dmurphy@ti.com>
>  S:	Maintained
>  F:	drivers/iio/adc/lp8788_adc.c
>  F:	drivers/leds/leds-lp8788.c

