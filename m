Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01402F35E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405168AbhALQfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbhALQfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:35:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610BAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:34:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 916941F45495
Subject: Re: [PATCH 2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
References: <20210107085942.2891525-1-yuhsuan@chromium.org>
 <20210107085942.2891525-2-yuhsuan@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e6c33a5f-1765-7cb6-8479-ff049992f2b7@collabora.com>
Date:   Tue, 12 Jan 2021 17:34:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107085942.2891525-2-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu-Hsuan,

Thank you for the patch.

On 7/1/21 9:59, Yu-Hsuan Hsu wrote:
> It is not guaranteed that I2S RX is disabled when the kernel booting.
> For example, if the kernel crashes while it is enabled, it will keep
> enabled until the next time EC reboots. Reset I2S RX when probing to
> fix this issue.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

If I am not mistaken this is the four version of this patchset (see [1]). Please
prefix your patches with the proper version and maintain a changelog for them,
otherwise makes difficult to follow all the discussions already done.

[1]
v1: https://lkml.org/lkml/2020/7/8/173
v2: https://mailman.alsa-project.org/pipermail/alsa-devel/2020-July/170933.html
v3:
https://patchwork.kernel.org/project/alsa-devel/patch/20210106050559.1459027-1-yuhsuan@chromium.org/
v4: https://patchwork.kernel.org/project/alsa-devel/list/?series=410441

> ---
>  sound/soc/codecs/cros_ec_codec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index f33a2a9654e7..28b3e2c48c86 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -1011,6 +1011,13 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
>  	}
>  	priv->ec_capabilities = r.capabilities;
>  
> +	/* Reset EC codec i2s rx. */
> +	p.cmd = EC_CODEC_I2S_RX_RESET;
> +	ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> +				   (uint8_t *)&p, sizeof(p), NULL, 0);
> +	if (ret)
> +		dev_warn(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
> +

My comment in the first version is still valid, I guess. This command was
introduced later and with an old firmware I suspect this message will appear on
every boot, right? So, to solve the issue and get rid of this warn you're forced
to upgrade the firmware. Would make sense to handle returned error value to warn
when the firmware needs to be updated and error and break when is really an error?

We have mapped ec error codes to linux error codes. So, it should be possible now.

Thanks,
 Enric

>  	platform_set_drvdata(pdev, priv);
>  
>  	ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
> 
