Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD59329EE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgJ2ObR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgJ2ObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:31:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EBAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:31:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so2485411pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wLslsAi2G28LH9YJ0zfY79HW10N4bzzwRkzXCVZRDwY=;
        b=EN2kcQVa32mEd/K4hOG8By0UDzPzo+BftuvRI8L1lXA7v0f6Btzj8FmrVO4rRyiMnK
         o3v+rD6VTjsm40RtPPixW0a84KVo4k5qIs+5/TpNBLdhvrMF2NiO5KVnWk5rD3hGhxXe
         9ehk+yumZOOzJ/acHlyz8JZhgsLBgNAZWIWUjQM6EyEK1eZidelPFpddHofdrvsX7FdI
         WRam8PpMVC+lBGXVptAk2oQ9PCVTCm74PotHP+/0BDKlsWxwilH2qDcrrhVbY0b+ctBM
         FktMFpMxgQqIyP7S4uCM3UUfhSv32Yjc6UI+uDTnnivwEAXL8+O4exIuHTxhkRll/cdq
         7W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLslsAi2G28LH9YJ0zfY79HW10N4bzzwRkzXCVZRDwY=;
        b=cI8yWbObusNemD1PZX1deVmQxBG4ZSbGxuGuux86yVvux2FNcFd+oKYE6VbW4wqMZJ
         QkLcv1dCxZS9eP82gZESe67iADDTsR0efN9AUl3tWMAZWJ1mkf5geNiiQaOpYwHJXLu8
         WorP2ObbHm6VKubrd5U6Qlj2hFQSCD2ys/iPMHjQZMX5ydAvMZkCfjFobu7QRV59PmQl
         HOyjE9Z95OipRj6mwFRU+42gqYmGAQaxFNQ76RNzoQKZef4W85OB0Dqtgt6BihNFgKc9
         +4IuyC2S34GPEUBpDOatJW6fyRWpPe11SZIevvKF1LIvHiyWL0xWaOVpuvh6cZspGEZ/
         8BWw==
X-Gm-Message-State: AOAM531f+jZSIjXpTelYVOj+WtDMIb3Om/xkns31EXOHz272eGTi7hSh
        ehShmkJxETpmsqF97anGEqU=
X-Google-Smtp-Source: ABdhPJy0sr40Jhllz/XQxRR+IEcDDKRuW5TxBqDWR9ZWN1OmyVVdN4IBmHlTPx+KqBxsvCtsYSKtYw==
X-Received: by 2002:a65:62ca:: with SMTP id m10mr4245650pgv.407.1603981876521;
        Thu, 29 Oct 2020 07:31:16 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id b3sm3047003pfd.66.2020.10.29.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 07:31:16 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date:   Thu, 29 Oct 2020 22:23:25 +0800
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 04/25] ASoC: rockchip: remove unnecessary CONFIG_PM_SLEEP
Message-ID: <20201029142325.mhq6azowlyuurhtl@Rk>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
 <20201029074301.226644-4-coiby.xu@gmail.com>
 <8589f68f-fa6b-d75e-d7be-fbb354adbde0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8589f68f-fa6b-d75e-d7be-fbb354adbde0@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:33:52AM +0000, Robin Murphy wrote:
>On 2020-10-29 07:42, Coiby Xu wrote:
>>SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.
>
>I don't see anything in the !CONFIG_PM_CONFIG side of
>SET_SYSTEM_SLEEP_PM_OPS() that prevents unused function warnings for
>the callbacks - does this change depend on some other patch or is it
>just wrong?
>
Thank you for the feedback! I'll add "__maybe_unused" in v2.

>Robin.
>
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  sound/soc/rockchip/rockchip_pdm.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>>diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
>>index 5adb293d0435..f3c19310aeeb 100644
>>--- a/sound/soc/rockchip/rockchip_pdm.c
>>+++ b/sound/soc/rockchip/rockchip_pdm.c
>>@@ -574,7 +574,6 @@ static int rockchip_pdm_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>-#ifdef CONFIG_PM_SLEEP
>>  static int rockchip_pdm_suspend(struct device *dev)
>>  {
>>  	struct rk_pdm_dev *pdm = dev_get_drvdata(dev);
>>@@ -601,7 +600,6 @@ static int rockchip_pdm_resume(struct device *dev)
>>  	return ret;
>>  }
>>-#endif
>>  static const struct dev_pm_ops rockchip_pdm_pm_ops = {
>>  	SET_RUNTIME_PM_OPS(rockchip_pdm_runtime_suspend,
>>

--
Best regards,
Coiby
