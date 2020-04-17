Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628481AE03E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgDQOxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 10:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgDQOxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:53:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3BEC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:53:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2BC642A2ABC
Subject: Re: [PATCH v2 3/7] drm/mediatek: mtk_dsi: Rename bridge to
 next_bridge
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200416155720.2360443-1-enric.balletbo@collabora.com>
 <20200416155720.2360443-4-enric.balletbo@collabora.com>
 <20200416172435.GM4796@pendragon.ideasonboard.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c1319dc1-5fdf-7e7d-1410-a23ed1d87d67@collabora.com>
Date:   Fri, 17 Apr 2020 16:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416172435.GM4796@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 16/4/20 19:24, Laurent Pinchart wrote:
> Hi Enric,
> 
> Thank you for the patch.
> 
> On Thu, Apr 16, 2020 at 05:57:15PM +0200, Enric Balletbo i Serra wrote:
>> This is really a cosmetic change just to make a bit more readable the
>> code after convert the driver to drm_bridge. The bridge variable name
>> will be used by the encoder drm_bridge, and the chained bridge will be
>> named next_bridge.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v2: None
>>
>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index cfa45d6abd74..44ee884cc31c 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -182,7 +182,7 @@ struct mtk_dsi {
>>  	struct drm_encoder encoder;
>>  	struct drm_connector conn;
>>  	struct drm_panel *panel;
>> -	struct drm_bridge *bridge;
>> +	struct drm_bridge *next_bridge;
>>  	struct phy *phy;
>>  
>>  	void __iomem *regs;
>> @@ -903,8 +903,9 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
>>  	dsi->encoder.possible_crtcs = 1;
>>  
>>  	/* If there's a bridge, attach to it and let it create the connector */
> 
> Maybe s/bridge/next bridge/ here ? I expect this comment to go away
> though, as there will always be a next bridge when the driver switches
> to the DRM panel bridge helper.
> 

I'll rename it to next bridge for coherency, however, as you point this message
is removed later.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>> -	if (dsi->bridge) {
>> -		ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL, 0);
>> +	if (dsi->next_bridge) {
>> +		ret = drm_bridge_attach(&dsi->encoder, dsi->next_bridge, NULL,
>> +					0);
>>  		if (ret) {
>>  			DRM_ERROR("Failed to attach bridge to drm\n");
>>  			goto err_encoder_cleanup;
>> @@ -1185,7 +1186,7 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>> -					  &dsi->panel, &dsi->bridge);
>> +					  &dsi->panel, &dsi->next_bridge);
>>  	if (ret)
>>  		goto err_unregister_host;
>>  
> 
