Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB72CEA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgLDJPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgLDJPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:15:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C801CC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 01:15:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B79A01F45EFB
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_spi: Don't overwrite
 spi::mode
To:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
References: <20201203011649.1405292-1-swboyd@chromium.org>
 <20201203011649.1405292-2-swboyd@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <03518a00-c30c-a3ba-d26e-10bae4060640@collabora.com>
Date:   Fri, 4 Dec 2020 10:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201203011649.1405292-2-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you for your patch.

On 3/12/20 2:16, Stephen Boyd wrote:
> There isn't any need to overwrite the mode here in the driver with what
> has been detected by the firmware, such as DT or ACPI. In fact, if we
> use the SPI CS gpio descriptor feature we will overwrite the mode with
> SPI_MODE_0 where it already contains SPI_MODE_0 and more importantly
> SPI_CS_HIGH. Clearing the SPI_CS_HIGH bit causes the CS line to toggle
> when the device is probed when it shouldn't change, confusing the driver
> and making it fail to probe. Drop the assignment and let the spi core
> take care of it.
> 
> Fixes: a17d94f0b6e1 ("mfd: Add ChromeOS EC SPI driver")
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

>  drivers/platform/chrome/cros_ec_spi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index dfa1f816a45f..f9df218fc2bb 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -742,7 +742,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>  	int err;
>  
>  	spi->bits_per_word = 8;
> -	spi->mode = SPI_MODE_0;
>  	spi->rt = true;
>  	err = spi_setup(spi);
>  	if (err < 0)
> 
