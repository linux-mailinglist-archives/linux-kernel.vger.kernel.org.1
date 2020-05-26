Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26511D37B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 19:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgENRNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 13:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbgENRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:13:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F791C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:13:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C4CCA2A2FB5
Subject: Re: [PATCH v4 7/7] drm/mediatek: mtk_dsi: Create connector for
 bridges
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
 <20200501152335.1805790-8-enric.balletbo@collabora.com>
 <CAFqH_53h=3OXzwLnw1XT3rHYkMPOPNFBdQdPeFmNubN9qq_Twg@mail.gmail.com>
 <CAAOTY_-pOUuM7LQ1jm6gqpg8acMqDWOHxGucY5XOjq0ctGUkzA@mail.gmail.com>
 <53683f2d-23c7-57ab-2056-520c50795ffe@collabora.com>
 <CAAOTY__b6V12fS2xTKGjB1fQTfRjX7AQyBqDPXzshfhkjjSkeQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <37191700-5832-2931-5764-7f7fddd023b9@collabora.com>
Date:   Thu, 14 May 2020 19:12:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY__b6V12fS2xTKGjB1fQTfRjX7AQyBqDPXzshfhkjjSkeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

On 14/5/20 18:44, Chun-Kuang Hu wrote:
> Hi, Enric:
> 
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年5月14日 週四 下午11:42寫道：
>>
>> Hi Chun-Kuang,
>>
>> On 14/5/20 16:28, Chun-Kuang Hu wrote:
>>> Hi, Enric:
>>>
>>> Enric Balletbo Serra <eballetbo@gmail.com> 於 2020年5月14日 週四 上午12:41寫道：
>>>>
>>>> Hi Chun-Kuang,
>>>>
>>>> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
>>>> dia dv., 1 de maig 2020 a les 17:25:
>>>>>
>>>>> Use the drm_bridge_connector helper to create a connector for pipelines
>>>>> that use drm_bridge. This allows splitting connector operations across
>>>>> multiple bridges when necessary, instead of having the last bridge in
>>>>> the chain creating the connector and handling all connector operations
>>>>> internally.
>>>>>
>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>>>>
>>>> A gentle ping on this, I think that this one is the only one that
>>>> still needs a review in the series.
>>>
>>> This is what I reply in patch v3:
>>>
>>
>> Sorry for missing this.
>>
>>> I think the panel is wrapped into next_bridge here,
>>>
>>
>> Yes, you can have for example:
>>
>> 1. drm_bridge (mtk_dsi) -> drm_bridge (ps8640 - dsi-to-edp) -> drm_panel_bridge
>> (edp panel)
>>
>> or a
>>
>> 2. drm_bridge (mtk_dsi)-> drm_panel_bridge (dsi panel)
>>
>> The _first_ one is my use case
>>
>>> if (panel) {
>>
>> This handles the second case, where you attach a dsi panel.
>>
>>>     dsi->next_bridge = devm_drm_panel_bridge_add(dev, panel);
>>>
>>> so the next_bridge is a panel_bridge, in its attach function
>>> panel_bridge_attach(),
>>> according to the flag DRM_BRIDGE_ATTACH_NO_CONNECTOR, if not exist,
>>> it would create connector and attach connector to panel.
>>>
>>> I'm not sure this flag would exist or not, but for both case, it's strange.
>>> If exist, you create connector in this patch but no where to attach
>>> connector to panel.
>>
>> Yes, in fact, this is transitional patch needed, as once I converted mtk_dpi,
>> mtk_dsi and mtk_hdmi to the new drm_bridge API the drm_bridge_connector_init()
>> will be done in mtk_drm_drv. We will need to call drm_bridge_connector_init for
>> dpi and dsi pipes and remove that call from mtk_dsi and mtk_dpi drivers. The
>> graphic controller driver should create connectors and CRTCs, as example you can
>> take a look at drivers/gpu/drm/omapdrm/omap_drv.c
>>
> 
> I have such question because I've reviewed omap's driver. In omap's
> driver, after it call drm_bridge_connector_init(), it does this:
> 
> if (pipe->output->panel) {
> ret = drm_panel_attach(pipe->output->panel,
>       pipe->connector);
> if (ret < 0)
> return ret;
> }
> 
> In this patch, you does not do this.
> 

I see, so yes, I am probably missing call drm_panel_attach in case there is a
direct panel attached. Thanks for pointing it.

I'll send a new version adding the drm_panel_attach call.

>>> If not exist, the next_brige would create one connector and this brige
>>> would create another connector.
>>>
>>> I think in your case, mtk_dsi does not directly connect to a panel, so
>>
>> Exactly
>>
>>> I need a exact explain. Or someone could test this on a
>>> directly-connect-panel platform.
>>
>> I don't think I am breaking this use case but AFAICS there is no users in
>> mainline that directly connect a panel using the mediatek driver. As I said my
>> use case is the other so I can't really test. Do you know anyone that can test this?
> 
> I'm not sure who can test this, but [1], which is sent by YT Shen in a
> series, is a patch to support dsi command mode so dsi could directly
> connect to panel.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mediatek?h=v5.7-rc5&id=21898816831fc60c92dd634ab4316a24da7eb4af
> 
> It's better that someone could test this case, but if no one would
> test this, I could also accept a good-look patch.
> 
> Regards,
> Chun-Kuang.
> 
>>
>> Thanks,
>>  Enric
>>
>>>
>>> Regards,
>>> Chun-Kuang.
>>>
>>>>
>>>> Thanks,
>>>>  Enric
>>>>
>>>>> ---
>>>>>
>>>>> Changes in v4: None
>>>>> Changes in v3:
>>>>> - Move the bridge.type line to the patch that adds drm_bridge support. (Laurent Pinchart)
>>>>>
>>>>> Changes in v2: None
>>>>>
>>>>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 13 ++++++++++++-
>>>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>>>> index 4f3bd095c1ee..471fcafdf348 100644
>>>>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>>>>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>>>> @@ -17,6 +17,7 @@
>>>>>
>>>>>  #include <drm/drm_atomic_helper.h>
>>>>>  #include <drm/drm_bridge.h>
>>>>> +#include <drm/drm_bridge_connector.h>
>>>>>  #include <drm/drm_mipi_dsi.h>
>>>>>  #include <drm/drm_of.h>
>>>>>  #include <drm/drm_panel.h>
>>>>> @@ -183,6 +184,7 @@ struct mtk_dsi {
>>>>>         struct drm_encoder encoder;
>>>>>         struct drm_bridge bridge;
>>>>>         struct drm_bridge *next_bridge;
>>>>> +       struct drm_connector *connector;
>>>>>         struct phy *phy;
>>>>>
>>>>>         void __iomem *regs;
>>>>> @@ -977,10 +979,19 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>>>>>          */
>>>>>         dsi->encoder.possible_crtcs = 1;
>>>>>
>>>>> -       ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL, 0);
>>>>> +       ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
>>>>> +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
>>>>>         if (ret)
>>>>>                 goto err_cleanup_encoder;
>>>>>
>>>>> +       dsi->connector = drm_bridge_connector_init(drm, &dsi->encoder);
>>>>> +       if (IS_ERR(dsi->connector)) {
>>>>> +               DRM_ERROR("Unable to create bridge connector\n");
>>>>> +               ret = PTR_ERR(dsi->connector);
>>>>> +               goto err_cleanup_encoder;
>>>>> +       }
>>>>> +       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>>>>> +
>>>>>         return 0;
>>>>>
>>>>>  err_cleanup_encoder:
>>>>> --
>>>>> 2.26.2
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Linux-mediatek mailing list
>>>>> Linux-mediatek@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
