Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7A72A25F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgKBISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:18:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39810 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgKBISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:18:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A28HkjG095958;
        Mon, 2 Nov 2020 02:17:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604305066;
        bh=PKURKhrStf5hrU/3/FF8PfX58ZYAVeadBgvFHZofdUQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aBk9tP4xdkqFm+ZsJtTWJASXy4g8DHzi/WCcG1PXOBg5cUc9e3Be39Cgu6md+6JbB
         H+acGNAdSqAMWLIvF5U3xqVqPO5z2Va273STE7hdctiLgeWib5IiY8tECBeHTeWLHk
         +V1nv47qCi57ZIlKmf+2BRKCwy10JTZEGpDjVXKY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A28Hkj4016878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 02:17:46 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 02:17:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 02:17:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A28HiDm044386;
        Mon, 2 Nov 2020 02:17:44 -0600
Subject: Re: [PATCH] ASoC: ti: davinci-evm: Remove redundant null check before
 clk_disable_unprepare
To:     Xu Wang <vulab@iscas.ac.cn>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20201029082513.28233-1-vulab@iscas.ac.cn>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ec63e4cc-b723-d183-8205-20fd0debbb43@ti.com>
Date:   Mon, 2 Nov 2020 10:18:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029082513.28233-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2020 10.25, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  sound/soc/ti/davinci-evm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
> index 105e56ab9cdc..b043a0070d20 100644
> --- a/sound/soc/ti/davinci-evm.c
> +++ b/sound/soc/ti/davinci-evm.c
> @@ -46,8 +46,7 @@ static void evm_shutdown(struct snd_pcm_substream *substream)
>  	struct snd_soc_card_drvdata_davinci *drvdata =
>  		snd_soc_card_get_drvdata(soc_card);
>  
> -	if (drvdata->mclk)
> -		clk_disable_unprepare(drvdata->mclk);
> +	clk_disable_unprepare(drvdata->mclk);
>  }
>  
>  static int evm_hw_params(struct snd_pcm_substream *substream,
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
