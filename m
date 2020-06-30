Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E420FE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgF3VCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 17:02:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37474 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgF3VCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:02:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 70B3F2A3C6B
Subject: Re: [RESEND PATCH v4 0/7] Convert mtk-dsi to drm_bridge API and get
 EDID for ps8640 bridge
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20200615203108.786083-1-enric.balletbo@collabora.com>
 <20200620213302.GC74146@ravnborg.org>
 <593a4666-d6aa-7d16-f3a0-ba3713047d84@collabora.com>
 <CAAOTY_9ZHemp0U76_oPjwy-XoTRXW108UMD_9JVnNXndNNsiTw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <43e5b273-d156-beea-bcfb-cc61b190a671@collabora.com>
Date:   Tue, 30 Jun 2020 23:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_9ZHemp0U76_oPjwy-XoTRXW108UMD_9JVnNXndNNsiTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

On 30/6/20 18:26, Chun-Kuang Hu wrote:
> Hi, Enric:
> 
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年6月30日 週二 下午10:34寫道：
>>
>> Hi Sam, Chun-Kuan,
>>
>> On 20/6/20 23:33, Sam Ravnborg wrote:
>>> Hi Enric
>>>
>>> On Mon, Jun 15, 2020 at 10:31:01PM +0200, Enric Balletbo i Serra wrote:
>>>> (This resend is to fix some trivial conflicts due the merge window)
>>>>
>>>> The PS8640 dsi-to-eDP bridge driver is using the panel bridge API,
>>>> however, not all the components in the chain have been ported to the
>>>> drm_bridge API. Actually, when a panel is attached the default panel's mode
>>>> is used, but in some cases we can't get display up if mode getting from
>>>> eDP control EDID is not chosen.
>>>>
>>>> This series address that problem, first implements the .get_edid()
>>>> callback in the PS8640 driver (which is not used until the conversion is
>>>> done) and then, converts the Mediatek DSI driver to use the drm_bridge
>>>> API.
>>>>
>>>> As far as I know, we're the only users of the mediatek dsi driver in
>>>> mainline, so should be safe to switch to the new chain of drm_bridge API
>>>> unconditionally.
>>>>
>>>> The patches has been tested on a Acer Chromebook R13 (Elm) running a
>>>> Chrome OS userspace and checking that the valid EDID mode reported by
>>>> the bridge is selected.
>>>>
>>>> Changes in v4:
>>>> - Remove double call to drm_encoder_init(). (Chun-Kuang Hu)
>>>> - Cleanup the encoder in mtk_dsi_unbind(). (Chun-Kuang Hu)
>>>>
>>>> Changes in v3:
>>>> - Replace s/bridge/next bridge/ for comment. (Laurent Pinchart)
>>>> - Add the bridge.type. (Laurent Pinchart)
>>>> - Use next_bridge field to store the panel bridge. (Laurent Pinchart)
>>>> - Add the bridge.type field. (Laurent Pinchart)
>>>> - This patch requires https://lkml.org/lkml/2020/4/16/2080 to work
>>>>   properly.
>>>> - Move the bridge.type line to the patch that adds drm_bridge support. (Laurent Pinchart)
>>>>
>>>> Changes in v2:
>>>> - Do not set connector_type for panel here. (Sam Ravnborg)
>>>>
>>>> Enric Balletbo i Serra (7):
>>>>   drm/bridge: ps8640: Get the EDID from eDP control
>>>>   drm/bridge_connector: Set default status connected for eDP connectors
>>>>   drm/mediatek: mtk_dsi: Rename bridge to next_bridge
>>>>   drm/mediatek: mtk_dsi: Convert to bridge driver
>>>>   drm/mediatek: mtk_dsi: Use simple encoder
>>>>   drm/mediatek: mtk_dsi: Use the drm_panel_bridge API
>>>>   drm/mediatek: mtk_dsi: Create connector for bridges
>>>
>>> Patch seems ready to apply. Will they be applied to a mediatek tree
>>> or to drm-misc-next?
>>> Or shall we take the first two patches via drm-misc-next, and the
>>> remaning via a mediatek tree? (I hope not)
>>>
>>
>> I think the only concern is from Chun-Kuan regarding patch 7/7 "drm/mediatek:
>> mtk_dsi: Create connector for bridges" whether we should support the old API or
>> not, but the discussion stalled.
>>
> 
> I get more clear now. In patch 7/7,
> 
> ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
>                                         DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> 
> this would call into mtk_dsi_bridge_attach() first, and then call into
> panel_bridge_attach() next. So panel_bridge_attach() would receive
> DRM_BRIDGE_ATTACH_NO_CONNECTOR and it return immediately so it does
> not call drm_panel_attach(). So where do you call drm_panel_attach()?
> 

Why I need to call drm_panel_attach?

I believe drm_panel_attach() was to attach a panel to a connector, but we don't
need to do this with the new API as the connector is already created and
attached to the "dummy" encoder.

Makes that sense to you? What do you think will not work if I don't call
drm_panel_attach?

[1]
https://elixir.bootlin.com/linux/v5.8-rc3/source/drivers/gpu/drm/drm_panel.c#L101

Regards,
 Enric


> Regards,
> Chun-Kuang.
> 
>> Thanks,
>>  Enric
>>
>>
>>
>>>       Sam
>>>
>>>
>>>>
>>>>  drivers/gpu/drm/bridge/parade-ps8640.c |  12 ++
>>>>  drivers/gpu/drm/drm_bridge_connector.c |   1 +
>>>>  drivers/gpu/drm/mediatek/mtk_dsi.c     | 269 ++++++++-----------------
>>>>  3 files changed, 97 insertions(+), 185 deletions(-)
>>>>
>>>> --
>>>> 2.27.0
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>
> 
