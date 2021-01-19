Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC82FB80A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391745AbhASLrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391582AbhASLgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:36:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 03:36:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 078FC1F44E05
Subject: Re: [PATCH v7 2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org
References: <20210115075301.47995-1-yuhsuan@chromium.org>
 <20210115075301.47995-2-yuhsuan@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <faa8e91f-441d-2a43-c7db-5d6d27686c15@collabora.com>
Date:   Tue, 19 Jan 2021 12:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115075301.47995-2-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu-Hsuan,

Thanks to apply the nit, but you can maintain the reviewed tag.

On 15/1/21 8:53, Yu-Hsuan Hsu wrote:
> It is not guaranteed that I2S RX is disabled when the kernel booting.
> For example, if the kernel crashes while it is enabled, it will keep
> enabled until the next time EC reboots. Reset I2S RX when probing to
> fix this issue.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
> Updated the info message.
> 
>  sound/soc/codecs/cros_ec_codec.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index f33a2a9654e7..c4772f82485a 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -1011,6 +1011,18 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
>  	}
>  	priv->ec_capabilities = r.capabilities;
>  
> +	/* Reset EC codec i2s rx. */
> +	p.cmd = EC_CODEC_I2S_RX_RESET;
> +	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> +				   (uint8_t *)&p, sizeof(p), NULL, 0);
> +	if (ret == -ENOPROTOOPT) {
> +		dev_info(dev,
> +			 "Missing reset command. Please update EC firmware.\n");
> +	} else if (ret) {
> +		dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
> +		return ret;
> +	}
> +
>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
> 
