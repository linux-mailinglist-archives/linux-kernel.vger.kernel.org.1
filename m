Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8AD260B43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgIHGxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 02:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgIHGxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:53:12 -0400
Received: from coco.lan (ip5f5ad5ce.dynamic.kabel-deutschland.de [95.90.213.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E65121532;
        Tue,  8 Sep 2020 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599547992;
        bh=kX4OBNeuOTXrAp1QEjnnD5+YUWM194wv+em948K2p7U=;
        h=Date:From:Cc:Subject:In-Reply-To:References:From;
        b=yWgQW1AAWSizcuZNknmH7z4JdnCeWIkTmnbpgHUFdlerRbPBbe/vgJHvSWcZPQn0I
         3X0f/AJhaKAloJD4PvishVLAItI0ql3tdZ/OkFW5THVsAhT1r7vA+BV/7/O6qeQL6L
         1mzMmxz0MYkzIGSs6fTOJY7tmTWwNRwRIzHTgdhw=
Date:   Tue, 8 Sep 2020 08:53:07 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] dwc3-of-simple: add support for Hikey 970
Message-ID: <20200908085307.2c25657b@coco.lan>
In-Reply-To: <83393769e4391d038c4ab69a67ac77e2ca34efd4.1599493845.git.mchehab+huawei@kernel.org>
References: <cover.1599493845.git.mchehab+huawei@kernel.org>
        <83393769e4391d038c4ab69a67ac77e2ca34efd4.1599493845.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon,  7 Sep 2020 17:59:34 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index 8852fbfdead4..2d497165efe2 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -49,7 +49,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>  	 * Some controllers need to toggle the usb3-otg reset before trying to
>  	 * initialize the PHY, otherwise the PHY times out.
>  	 */
> -	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
> +	if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") ||
> +	    of_device_is_compatible(np, "hisilicon,hi3670-dwc3"))
>  		simple->need_reset = true;

It turns that this hunk caused Serror during my suspend/resume tests.

Without this one, the driver works just fine.

As you already applied this patch, do you prefer a patch dropping it,
or should I send a version 2 without it?

Thanks,
Mauro
