Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A025F207F26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 00:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbgFXWJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 18:09:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39380 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387853AbgFXWJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:09:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OM8bQG066351;
        Wed, 24 Jun 2020 17:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593036517;
        bh=8pxGcSuDGHL5/biPmNuRMj2l3xMNTG6V1WBrzq8DbV8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dew2+X+xSol3YYZIrkXvLmNttcwE1ukDAiVHz+Vo+ZzGEQpzssCP2gBtVQcMplq3b
         ky9x5liGGAsvAOJtzc+3uop7JlYH0bsBpkeOe/thg+jtwRzT9POJVMmKAj/HQsf+M0
         5l06R3bRbEpFuvwwt1xYrGfe4dKfkyKAgFpWJWkY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OM8bUj052317
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 17:08:37 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 17:08:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 17:08:37 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OM8bgi092136;
        Wed, 24 Jun 2020 17:08:37 -0500
Subject: Re: [PATCH v6 4/7] ASoC: tas2562: Add rx and tx slot programming
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
References: <20200624174932.9604-1-dmurphy@ti.com>
 <20200624174932.9604-5-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c3c86e7f-de5e-dea1-98de-045bdd564fbc@ti.com>
Date:   Wed, 24 Jun 2020 17:08:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624174932.9604-5-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 6/24/20 12:49 PM, Dan Murphy wrote:
> Add programming for the tdm slots for both tx and rx offsets.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   sound/soc/codecs/tas2562.c | 17 ++++++++++++++++-
>   sound/soc/codecs/tas2562.h |  4 ++++
>   2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
> index d26e30a2948c..2f1d4b697f01 100644
> --- a/sound/soc/codecs/tas2562.c
> +++ b/sound/soc/codecs/tas2562.c
> @@ -208,6 +208,22 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
>   	if (ret < 0)
>   		return ret;
>   
> +	if (tx_mask > TAS2562_TX_OFF_MAX) {
> +		dev_err(tas2562->dev, "TX slot is larger then %d",
> +			TAS2562_TX_OFF_MAX);
> +		return -EINVAL;
> +	}
> +
> +	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG1,
> +					    TAS2562_RX_OFF_MASK, rx_mask << 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG4,
> +					    TAS2562_TX_OFF_MASK, tx_mask << 1);
> +	if (ret < 0)
> +		return ret;
> +

I need to fix this patch to remove the slot programming during dai_fmt 
as the code is not correct and resets the slots

Dan


