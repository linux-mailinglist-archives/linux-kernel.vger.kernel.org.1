Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6504530074F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbhAVP3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbhAVP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:28:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A6FC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:27:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so5456403wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VGeW9EARaoJCpPpoau57S098VzTUAKw4Gh0s4w2uBRw=;
        b=LCgQySMGrcqfO061iCqVejbCMPpFXQ2o/6PkmCcMBoZ/CBRvYO2TlLOYdlFtIt0lr9
         Z/5R8IiQYbTmWus1WpUbDRtBUl6+cqjQSeV3/mUr/4vbeXWYjnRXkyJqBw584E7C8qRN
         1/mEWLsQ/0FIkHQRRk3e0w8D9tcnTkIcJTMUipnDEcD7QCzZsVcvYoAmmaWYa8XhF2+d
         /7vWT3tDirfT2SPsNLcP+7pglO/LuUK2HN+UEws5u1YvPb9DPlpP0JbUwKNS6I15eNft
         iil9Q4opl5uHz6p8nqVg8PA+yBiYhwOcMZFenAZE7I4gpfzl6CUHFej9H+s7AeBprXz4
         xZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VGeW9EARaoJCpPpoau57S098VzTUAKw4Gh0s4w2uBRw=;
        b=tWI7jVl3uFb4cq/dtc+8NdQsrNj4RxCq5/sJL7u5ZvGHWTmPrU3leImFOAzHfb9Mf8
         obXwKiSKUT7NRqIT71puXTL+Ca6IrzYS8sNOcHJu6cpviQjiHyTONho9/TW3in5VGT5U
         XKXWzyp8NBM4/VGhXBZdD6TA/eH164c4kTo23/sd6PU3LF1zTTyKuBedxz4O6XM2/atq
         oMLi+HzqToYyjFQXvIvuY5PUW4Tbn1LT26+zKhT9Jn5OWCtJufGdj2zaC0XGVYfGPAm5
         DMez7yYQcFleGyaNYKMY+sXfohHfLQLWnWjOiInJcjLLyhiSADDoDalNBlFf0SCYKjHu
         xIuQ==
X-Gm-Message-State: AOAM5327W6OgD7lODArwlCFjk8IoR3R5jXw49dS39Y1TiKQSp67Qv6Po
        5mLf+K9GmkOwwCtGb1asS1ftsaWkhER6Rg==
X-Google-Smtp-Source: ABdhPJy3A+p+2NUo2ofccX8Pbxyvfw+mH50UN0umZAvck0PU8OJhNu/uj3T1n9PrBF16AfBNTkBVZw==
X-Received: by 2002:adf:ee09:: with SMTP id y9mr5054851wrn.74.1611329274055;
        Fri, 22 Jan 2021 07:27:54 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id r12sm859015wrp.13.2021.01.22.07.27.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:27:53 -0800 (PST)
Subject: Re: [PATCH v4] nvmem: core: skip child nodes not matching binding
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>, ceggers@arri.de,
        kernel@pengutronix.de, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210118132411.6268-1-a.fatoum@pengutronix.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6b90cdd0-a710-943d-b444-f7ae44c5875b@linaro.org>
Date:   Fri, 22 Jan 2021 15:27:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210118132411.6268-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2021 13:24, Ahmad Fatoum wrote:
> The nvmem cell binding applies to all eeprom child nodes matching
> "^.*@[0-9a-f]+$" without taking a compatible into account.
> 
> Linux drivers, like at24, are even more extensive and assume
> _all_ at24 eeprom child nodes to be nvmem cells since e888d445ac33
> ("nvmem: resolve cells from DT at registration time").
> 
> Since df5f3b6f5357 ("dt-bindings: nvmem: stm32: new property for
> data access"), the additionalProperties: True means it's Ok to have
> other properties as long as they don't match "^.*@[0-9a-f]+$".
> 
> The barebox bootloader extends the MTD partitions binding to
> EEPROM and can fix up following device tree node:
> 
>    &eeprom {
>      partitions {
>        compatible = "fixed-partitions";
>      };
>    };
> 
> This is allowed binding-wise, but drivers using nvmem_register()
> like at24 will fail to parse because the function expects all child
> nodes to have a reg property present. This results in the whole
> EEPROM driver probe failing despite the device tree being correct.
> 
> Fix this by skipping nodes lacking a reg property instead of
> returning an error. This effectively makes the drivers adhere
> to the binding because all nodes with a unit address must have
> a reg property and vice versa.
> 
> Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time").
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> ---
> Previous Discussion: https://lore.kernel.org/lkml/20200428111829.2215-1-a.fatoum@pengutronix.de/
> v1:
>    - Ignore all nodes with a unit address (i.e. contain @)
> v1 -> v2:
>    - use ->full_name instead of ->name as to not break existing correct
>      cells (Christian)
> v2 -> v3:
>    - use optional compatible property to weed out nodes instead of name
>    - extend binding documentation (Srini)
> v3 -> v4:
>    - drop optional nvmem-cell compatible because it's redundant (Rob)
>    - Make driver adhere to binding instead of changing binding
> 
> As review feedback on v3, Rob suggested moving nvmem cells into a
> separate MTD partition. This sound good for people who want MTD
> partitions and nvmem to coexist, but my problem described above where
> MTD partitions are already fixed up top level into an EEPROM node isn't
> solved by this. Revisiting the issue, I think the correct way forward is
> along the lines of v1 & v2, where the driver is fixed to actually adhere
> to the existing binding. Srini didn't like string matching for @ in driver
> code, so I now check for presence of reg instead. They are equivalent
> per device tree specification. From v0.3:
> 
>    "The unit-address must match the first address specified in the
>    reg property of the node. If the node has no reg property, the
>    @unit-address must be omitted"...
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>   drivers/nvmem/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)


Applied thanks,

--srini

> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 177f5bf27c6d..f114df55f403 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -682,7 +682,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
>   
>   	for_each_child_of_node(parent, child) {
>   		addr = of_get_property(child, "reg", &len);
> -		if (!addr || (len < 2 * sizeof(u32))) {
> +		if (!addr)
> +			continue;
> +		if (len < 2 * sizeof(u32)) {
>   			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
>   			return -EINVAL;
>   		}
> 
