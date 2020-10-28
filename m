Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C40229DBA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbgJ2AGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:06:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59843 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389376AbgJ2AAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:00:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kXmN0-0006sW-JS; Wed, 28 Oct 2020 14:24:10 +0000
Subject: Re: [PATCH] ASoC: qcom: sm8250: Fix array out of bounds access
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
References: <20201028142001.22431-1-srinivas.kandagatla@linaro.org>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <4fc6b58a-e3e6-b57e-7ae7-16fd32392bcb@canonical.com>
Date:   Wed, 28 Oct 2020 14:24:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201028142001.22431-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2020 14:20, Srinivas Kandagatla wrote:
> Static analysis Coverity had detected a potential array out-of-bounds
> write issue due to the fact that MAX AFE port Id was set to 16 instead
> of using AFE_PORT_MAX macro.
> 
> Fix this by properly using AFE_PORT_MAX macro.
> 
> Fixes: aa2e2785545a ("ASoC: qcom: sm8250: add sound card qrb5165-rb5 support")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/sm8250.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
> index 7d43de6d909f..52c40512102f 100644
> --- a/sound/soc/qcom/sm8250.c
> +++ b/sound/soc/qcom/sm8250.c
> @@ -13,12 +13,11 @@
>  
>  #define DRIVER_NAME		"sm8250"
>  #define MI2S_BCLK_RATE		1536000
> -#define MAX_SDW_STREAMS		16
>  
>  struct sm8250_snd_data {
> -	bool stream_prepared[MAX_SDW_STREAMS];
> +	bool stream_prepared[AFE_PORT_MAX];
>  	struct snd_soc_card *card;
> -	struct sdw_stream_runtime *sruntime[MAX_SDW_STREAMS];
> +	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
>  };
>  
>  static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> 

Thanks, looks good to me.

Reviewed-by: Colin Ian King <colin.king@canonical.com>
