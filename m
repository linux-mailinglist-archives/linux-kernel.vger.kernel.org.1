Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB1C297256
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462490AbgJWPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375472AbgJWPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:31:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295BC0613CE;
        Fri, 23 Oct 2020 08:31:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 03D1F1F4684E
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philippe CORNU <philippe.cornu@st.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yannick FERTRE <yannick.fertre@st.com>,
        Andrzej Hajda <a.hajda@samsung.com>, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v9 00/11] Genericize DW MIPI DSI bridge and add i.MX 6
 driver
In-Reply-To: <e841d90b-0f1d-d5d9-9f67-f90d64c4fbc7@baylibre.com>
References: <20200609174959.955926-1-adrian.ratiu@collabora.com>
 <c6f10db1-7f56-a156-36a1-125e764c8c1a@baylibre.com>
 <87lfk3kaj4.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <b318069fe873e456f18d07d11f5d165667c9b04a.camel@collabora.com>
 <e0d0efec-09e0-6bf8-bab7-44accd14fa52@baylibre.com>
 <e841d90b-0f1d-d5d9-9f67-f90d64c4fbc7@baylibre.com>
Date:   Fri, 23 Oct 2020 18:32:56 +0300
Message-ID: <87ft65vtxz.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, 15 Sep 2020, Neil Armstrong <narmstrong@baylibre.com> 
wrote:
> Hi Adrian, 
> 
> Gentle ping. 
> 
> can you rebase on drm-misc-next so I can apply the IMX and STM 
> patches ?

Sorry for the late reply, somehow missed this e-mail chain.

I have a rebase of the series but further investigation revealed 
we might regress Rockchip with a partial integration, so I'm 
getting a panel for RK to test to be sure and will re-submit.

>
> On 24/08/2020 11:47, Neil Armstrong wrote:
>> Hi,
>> 
>> 
>> On 15/08/2020 15:05, Ezequiel Garcia wrote:
>>> Hi Neil,
>>>
>>> On Wed, 2020-07-01 at 09:35 +0300, Adrian Ratiu wrote:
>>>> Hi Neil,
>>>>
>>>> On Mon, 29 Jun 2020, Neil Armstrong <narmstrong@baylibre.com> 
>>>> wrote:
>>>>> Hi Adrian, 
>>>>>
>>>>> On 09/06/2020 19:49, Adrian Ratiu wrote: 
>> [...]
>>>>
>>>
>>> It's been a month so I think it's a good idea to go forward
>>> applying IMX and STM patches (probably with the usual
>>> rebase dance).
>>>
>>> As for Rockchip...
>>>
>>>> The binding API removal change which directly touches RK can also 
>>>> be applied separately, but unfortunately I do not have access to a 
>>>> RK board with a DSI display to test it (or the bridge regmap logic 
>>>> on RK btw...), I just "eye-balled" the RK code based on the public 
>>>> docs and it LGTM.
>>>>
>>>
>>> ... I'll be getting some DSI hardware to help with the pending
>>> Rockchip issues, so we can tackle Rockchip as well. I'm quite sure
>>> we'll loop Heiko as well if needed :-)
>> 
>> Sure, Adrian, can you rebase on drm-misc-next so I can apply the IMX and STM patches ?
>> 
>>>
>>> Cheers,
>>> Ezequiel
>>>
>>>>> Neil
>>>>>
>>>>>> Big thank you to everyone who has contributed to this up to now,
>>>>>> Adrian
>>>>>>
>>>>>> Adrian Ratiu (11):
>>>>>>   drm: bridge: dw_mipi_dsi: add initial regmap infrastructure
>>>>>>   drm: bridge: dw_mipi_dsi: abstract register access using reg_fields
>>>>>>   drm: bridge: dw_mipi_dsi: add dsi v1.01 support
>>>>>>   drm: bridge: dw_mipi_dsi: remove bind/unbind API
>>>>>>   dt-bindings: display: add i.MX6 MIPI DSI host controller doc
>>>>>>   ARM: dts: imx6qdl: add missing mipi dsi properties
>>>>>>   drm: imx: Add i.MX 6 MIPI DSI host platform driver
>>>>>>   drm: stm: dw-mipi-dsi: let the bridge handle the HW version check
>>>>>>   drm: bridge: dw-mipi-dsi: split low power cfg register into fields
>>>>>>   drm: bridge: dw-mipi-dsi: fix bad register field offsets
>>>>>>   Documentation: gpu: todo: Add dw-mipi-dsi consolidation plan
>>>>>>
>>>>>>  .../display/imx/fsl,mipi-dsi-imx6.yaml        | 112 +++
>>>>>>  Documentation/gpu/todo.rst                    |  25 +
>>>>>>  arch/arm/boot/dts/imx6qdl.dtsi                |   8 +
>>>>>>  drivers/gpu/drm/bridge/synopsys/Kconfig       |   1 +
>>>>>>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 713 ++++++++++++------
>>>>>>  drivers/gpu/drm/imx/Kconfig                   |   8 +
>>>>>>  drivers/gpu/drm/imx/Makefile                  |   1 +
>>>>>>  drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c        | 399 ++++++++++
>>>>>>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |   7 +-
>>>>>>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         |  16 +-
>>>>>>  10 files changed, 1059 insertions(+), 231 deletions(-)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
>>>>>>  create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c
>>>>>>
>>>
>> 
