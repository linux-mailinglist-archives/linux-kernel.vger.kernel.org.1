Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9875929E910
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgJ2Kd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:33:56 -0400
Received: from foss.arm.com ([217.140.110.172]:59686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgJ2Kdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:33:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4080C139F;
        Thu, 29 Oct 2020 03:33:55 -0700 (PDT)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C00453F66E;
        Thu, 29 Oct 2020 03:33:53 -0700 (PDT)
Subject: Re: [PATCH 04/25] ASoC: rockchip: remove unnecessary CONFIG_PM_SLEEP
To:     Coiby Xu <coiby.xu@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
 <20201029074301.226644-4-coiby.xu@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8589f68f-fa6b-d75e-d7be-fbb354adbde0@arm.com>
Date:   Thu, 29 Oct 2020 10:33:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201029074301.226644-4-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-29 07:42, Coiby Xu wrote:
> SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

I don't see anything in the !CONFIG_PM_CONFIG side of 
SET_SYSTEM_SLEEP_PM_OPS() that prevents unused function warnings for the 
callbacks - does this change depend on some other patch or is it just wrong?

Robin.

> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>   sound/soc/rockchip/rockchip_pdm.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
> index 5adb293d0435..f3c19310aeeb 100644
> --- a/sound/soc/rockchip/rockchip_pdm.c
> +++ b/sound/soc/rockchip/rockchip_pdm.c
> @@ -574,7 +574,6 @@ static int rockchip_pdm_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_PM_SLEEP
>   static int rockchip_pdm_suspend(struct device *dev)
>   {
>   	struct rk_pdm_dev *pdm = dev_get_drvdata(dev);
> @@ -601,7 +600,6 @@ static int rockchip_pdm_resume(struct device *dev)
>   
>   	return ret;
>   }
> -#endif
>   
>   static const struct dev_pm_ops rockchip_pdm_pm_ops = {
>   	SET_RUNTIME_PM_OPS(rockchip_pdm_runtime_suspend,
> 
