Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2330B2E79C1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgL3NoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:44:22 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:57967 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgL3NoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:44:21 -0500
Received: from [192.168.1.25] (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id CD3D2200002;
        Wed, 30 Dec 2020 13:43:38 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] nvmem: core: skip nodes with compatibles other
 than "nvmem-cell"
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@pengutronix.de, ceggers@arri.de,
        linux-kernel@vger.kernel.org
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
 <20200428111829.2215-3-a.fatoum@pengutronix.de>
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
Message-ID: <ee29ed40-a665-2b78-4049-506b718094bf@bootlin.com>
Date:   Wed, 30 Dec 2020 14:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200428111829.2215-3-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

On 4/28/20 1:18 PM, Ahmad Fatoum wrote:
> The nvmem cell binding used to apply to all objects which match
> "^.*@[0-9a-f]+$", without taking a compatible into account, which
> precluded extension of EEPROMs by child nodes other than nvmem.
> 
> A previous commit changed the binding, so that nvmem cells that
> feature a compatible property must have "nvmem-cell" as the value,
> otherwise they are skipped.
> 
> Adjust the driver to observe the new binding change. This change
> does not change behavior for any device tree that was already
> compliant with the nvmem binding.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Tested-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

> ---
>   drivers/nvmem/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 05c6ae4b0b97..eb697f5ad07d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -547,6 +547,10 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   	parent = dev->of_node;
>   
>   	for_each_child_of_node(parent, child) {
> +		if (of_find_property(child, "compatible", NULL) &&
> +		    !of_device_is_compatible(child, "nvmem-cell"))
> +			continue;
> +
>   		addr = of_get_property(child, "reg", &len);
>   		if (!addr || (len < 2 * sizeof(u32))) {
>   			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
> 

-- 
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
