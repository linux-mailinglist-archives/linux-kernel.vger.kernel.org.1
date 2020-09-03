Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B384425BF63
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgICKuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 06:50:21 -0400
Received: from crapouillou.net ([89.234.176.41]:49158 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgICKuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599130208; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXg3aqgmFb8tKfR4TEoiu32nZCgBWfcl5v4Q44mU658=;
        b=aL+sHYDogDi8odA19gwRz4rweOeF1jr+yCLbpS1gEROe3fA7E/jfDC5BeFmJAUnF5eryIC
        IdxX7nQpGG7VkZGyAzxbp9xwe0eFQFIBK58dVNueyRCjIxt/lOYFswheujnU2UtA4nuHiz
        Erg60GWs/LhPy2ysrTXzXyDxGTvSHyo=
Date:   Thu, 03 Sep 2020 12:49:52 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 04/11] mmc: jz4740: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
Message-Id: <4RW2GQ.J2DD55HCZMCH2@crapouillou.net>
In-Reply-To: <20200902193658.20539-5-krzk@kernel.org>
References: <20200902193658.20539-1-krzk@kernel.org>
        <20200902193658.20539-5-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le mer. 2 sept. 2020 =E0 21:36, Krzysztof Kozlowski <krzk@kernel.org> a=20
=E9crit :
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mmc/host/jz4740_mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/jz4740_mmc.c=20
> b/drivers/mmc/host/jz4740_mmc.c
> index 81d71010b474..0c5b52b53303 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -991,9 +991,8 @@ static int jz4740_mmc_probe(struct=20
> platform_device* pdev)
>=20
>  	ret =3D mmc_of_parse(mmc);
>  	if (ret) {
> -		if (ret !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev,
> -				"could not parse device properties: %d\n", ret);
> +		dev_err_probe(&pdev->dev, ret,
> +			      "could not parse device properties\n");

I think you can put that on one line.

With that said:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

>  		goto err_free_host;
>  	}
>=20
> --
> 2.17.1
>=20


