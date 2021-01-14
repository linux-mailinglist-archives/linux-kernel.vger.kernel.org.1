Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EFF2F5E94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbhANKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbhANKUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:20:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 02:20:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 14D231F459A1
Subject: Re: [PATCH v6 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
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
References: <20210114065401.3498725-1-yuhsuan@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d91f6d8d-e108-eff9-4fc0-992c82cf8aac@collabora.com>
Date:   Thu, 14 Jan 2021 11:19:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114065401.3498725-1-yuhsuan@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/1/21 7:54, Yu-Hsuan Hsu wrote:
> Add the new command EC_CODEC_I2S_RX_RESET in ec_codec_i2s_rx_subcmd,
> which is used for resetting the EC codec.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

For if Mark wants to take this patch through his tree.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  include/linux/platform_data/cros_ec_commands.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 86376779ab31..95889ada83a3 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -4600,6 +4600,7 @@ enum ec_codec_i2s_rx_subcmd {
>  	EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH = 0x2,
>  	EC_CODEC_I2S_RX_SET_DAIFMT = 0x3,
>  	EC_CODEC_I2S_RX_SET_BCLK = 0x4,
> +	EC_CODEC_I2S_RX_RESET = 0x5,
>  	EC_CODEC_I2S_RX_SUBCMD_COUNT,
>  };
>  
> 
