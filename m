Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376F02CDB66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731353AbgLCQjU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 11:39:20 -0500
Received: from aposti.net ([89.234.176.197]:60852 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731337AbgLCQjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:39:19 -0500
Date:   Thu, 03 Dec 2020 16:38:24 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: jz4740-i2s: add missed checks for clk_get()
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <0KVRKQ.500J00DY5DNR@crapouillou.net>
In-Reply-To: <20201203144227.418194-1-hslester96@gmail.com>
References: <20201203144227.418194-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu. 3 déc. 2020 à 22:42, Chuhong Yuan <hslester96@gmail.com> a 
écrit :
> jz4740_i2s_set_sysclk() does not check the return values of clk_get(),
> while the file dereferences the pointers in clk_put().
> Add the missed checks to fix it.
> 
> Fixes: 11bd3dd1b7c2 ("ASoC: Add JZ4740 ASoC support")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/jz4740-i2s.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/jz4740/jz4740-i2s.c 
> b/sound/soc/jz4740/jz4740-i2s.c
> index c7bd20104b20..0793e284d0e7 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -312,10 +312,14 @@ static int jz4740_i2s_set_sysclk(struct 
> snd_soc_dai *dai, int clk_id,
>  	switch (clk_id) {
>  	case JZ4740_I2S_CLKSRC_EXT:
>  		parent = clk_get(NULL, "ext");
> +		if (IS_ERR(parent))
> +			return PTR_ERR(parent);
>  		clk_set_parent(i2s->clk_i2s, parent);
>  		break;
>  	case JZ4740_I2S_CLKSRC_PLL:
>  		parent = clk_get(NULL, "pll half");
> +		if (IS_ERR(parent))
> +			return PTR_ERR(parent);
>  		clk_set_parent(i2s->clk_i2s, parent);
>  		ret = clk_set_rate(i2s->clk_i2s, freq);
>  		break;
> --
> 2.26.2
> 


