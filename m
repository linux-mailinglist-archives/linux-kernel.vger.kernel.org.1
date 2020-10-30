Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DCE2A0D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgJ3Scb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgJ3Scb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:32:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F7C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dBlEcZCPebNOu+qYw1oX1dmdts8xl8lJcDaqBxGZQLY=; b=kqpV+cPyaXd732RDp/GIxdl8Dv
        EyKSbTPSbAfIjpzoTFIhXjKXp45okxkVbjpXAzZ3ecVuOYXtq7j2vFZZ0vw51q7QgUe7+AIxFc9tV
        M5lQS1bNL7gUy46fPcWUPbZwLLQ7GDMyRnY2LSLmOnnMbKhZ/EN+LPJuR7PeuwCPaC5DuQ37emPIY
        JEIL2Oirpr0r93uFGkj7mEQxq2i/0NCZC/j2isyZr7XcDdP5kgpbj+k7rE+2C+VDgFtnmhsCfoD0e
        7txaGX6NlvZnRlO1oaS+gl2r1GTqaFCXmiKx07GKVTMoXjiYGLQvYm/hAgSSQS1avP5ScZbxruRor
        rCc7uTGA==;
Received: from [2601:1c0:6280:3f0::371c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYZBR-00065V-GM; Fri, 30 Oct 2020 18:31:29 +0000
Subject: Re: [PATCH] ASoC: qcom: MSM8996 depends on COMMON_CLK
From:   Randy Dunlap <rdunlap@infradead.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <548bb7f8-672d-3d95-0d78-cef1c9837a42@infradead.org>
Message-ID: <a55d71fd-d5b1-26f9-c3f0-7f2ff91bef07@infradead.org>
Date:   Fri, 30 Oct 2020 11:31:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <548bb7f8-672d-3d95-0d78-cef1c9837a42@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 10:39 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a kconfig warning in sound/soc/qcom:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y] && COMMON_CLK [=n]
>   Selected by [y]:
>   - SND_SOC_MSM8996 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y]
> 
> This is needed because 'select' does not follow dependency chains.
> 
> Fixes: a6f933f63f2f ("ASoC: qcom: apq8096: Add db820c machine driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> ---
> Found in linux-next but applies to mainline.
> 
>  sound/soc/qcom/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20201016.orig/sound/soc/qcom/Kconfig
> +++ linux-next-20201016/sound/soc/qcom/Kconfig
> @@ -106,6 +106,7 @@ config SND_SOC_QDSP6
>  config SND_SOC_MSM8996
>  	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
>  	depends on QCOM_APR
> +	depends on COMMON_CLK
>  	select SND_SOC_QDSP6
>  	select SND_SOC_QCOM_COMMON
>  	help
> 

Ping. I am still seeing this kconfig warning in linux-next 20201030.

-- 
~Randy

