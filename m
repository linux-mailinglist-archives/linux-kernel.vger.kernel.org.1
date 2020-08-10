Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7782407C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 16:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgHJOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgHJOqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:46:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E708C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ST9uT/svvVM3VjFTpOnQ2kyruMHX89YknoXDFMfmz1Y=; b=qZT9QL55N+ijZXxNUmmIYQWYhb
        Lc0Q5kjGV5uOUCjTc7bCMc1r5n1sVNI8Oi2b7MjyvSM5oW/LNxCYuWqFt24HpwQ+8Bv5r2myUh+iO
        an1I6A9x+qWeG1wWg9BjpojyJfNsS1UIVoc7K23JNUruJVYaxe+ctqarlZIfbVzrAiUJdj4XUBLhW
        VWk54u+046uij8MID3XcTjDwZlfUP5L7MiopALQcI5P55o3ZlKqAJ0gZ3Exfmk18auTFGFmvW8JY3
        kSGXst3aYKKCvg/TPD5IMmcfZBIFb4EYwuakEVJp4vkgSs2rL3Ju523SMsIDCTJi3UP7WDUvRTdTj
        IyEDzyEQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k593z-0004Lv-91; Mon, 10 Aug 2020 14:46:11 +0000
Subject: Re: [PATCH v1 2/2] drm/bridge: add refactored it6505 driver
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Yilun Lin <yllin@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <1597054312-25538-1-git-send-email-allen.chen@ite.com.tw>
 <1597054312-25538-3-git-send-email-allen.chen@ite.com.tw>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dab6261e-708b-b832-17cb-833023383156@infradead.org>
Date:   Mon, 10 Aug 2020 07:46:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597054312-25538-3-git-send-email-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 3:11 AM, allen wrote:
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 43271c2..a9f49c7 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -48,6 +48,13 @@ config DRM_DISPLAY_CONNECTOR
>  	  on ARM-based platforms. Saying Y here when this driver is not needed
>  	  will not cause any issue.
>  
> +config DRM_ITE_IT6505
> +	tristate "ITE IT6505 DP bridge"
> +	depends on OF
> +	select DRM_KMS_HELPER
> +	help
> +	  ITE IT6505 DP bridge chip driver.

Maybe it's just me, but I would appreciate it if somewhere in the
Kconfig entry here, it said DisplayPort instead of just DP.

> +
>  config DRM_LVDS_CODEC
>  	tristate "Transparent LVDS encoders and decoders support"
>  	depends on OF

thanks.
-- 
~Randy

