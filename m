Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2096128F341
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgJONcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:32:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60888 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgJONcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:32:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D92061F45A82
Subject: Re: [PATCH 4/4] soc: mediatek: mmsys: Use an array for setting the
 routing registers
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20201006193320.405529-1-enric.balletbo@collabora.com>
 <20201006193320.405529-5-enric.balletbo@collabora.com>
 <474b10a5-123b-d3cb-e846-1d504ad3e8fd@gmail.com>
 <CAAOTY_9NBAtCgZ0y_32BfdtzGPKW=q7Cjk1maZiftcbDXu62iw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <74cee4b6-748c-ebb5-e36f-8840b8140554@collabora.com>
Date:   Thu, 15 Oct 2020 15:32:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_9NBAtCgZ0y_32BfdtzGPKW=q7Cjk1maZiftcbDXu62iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias and Chun-Kuang,

On 11/10/20 4:22, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Matthias Brugger <matthias.bgg@gmail.com> 於 2020年10月8日 週四 下午6:22寫道：
>>
>> Hi Enric and CK,
>>
>> On 06/10/2020 21:33, Enric Balletbo i Serra wrote:
>>> From: CK Hu <ck.hu@mediatek.com>
>>>
>>> Actually, setting the registers for routing, use multiple 'if-else' for different
>>> routes, but this code would be more and more complicated while we
>>> support more and more SoCs. Change that and use a table per SoC so the
>>> code will be more portable and clear.
>>>
>>
>> I'd like to have some clarifications on this patch. Now we use one big if-else
>> structure to decide which value and address we need. As this values work for a
>> large set of SoCs I suppose the hardware block is the same.
>>
>> When we add new HW like mt8183, mt8192 or mt6779 we will need different values.
>> But my question is, if the HW between theses new platforms will be different
>> (read values change for every SoC). Or will it be the same HW block for all
>> these SoCs so that we could add three new functions ddp_mout_en, ddp_sout_sel
>> and ddp_sel_in.
>>
> 
> As I know, routes in mt8173, mt2701, mt2712 are different. That means
> in the same register address, it control different input/output
> selection for each SoC. But they use a very tricky way to use the same
> table: some register's default value (the default routes) meet their
> requirement, they do not set it and just set the register whose
> default value does not meet the requirement. But this tricky way fail
> when support more SoC, so mt8183 and mt8192 need an independent route.
> So we have better have different route for each SoC, but we don't have
> the complete route information for these three SoC, so just keep them
> in the same table. After we've more information, we could separate
> mt2701, mt2712 to an independent table.
> 
>> Why I'm asking? Because right now it seems like double the work we have to do
>> for every SoC. We will need to define the components in the DRM driver and then
>> we need to add the values for the routing.
> 
> The double work are two different function work. mmsys driver provide
> full routing control and drm choose the route according to its
> application. For example:
> 
> mmsys provide the three route:
> 
> rdma0 -> dsi0
> rdma1 -> dsi0
> rdma2 -> dsi0
> 
> and drm could only choose one at some moment. Even drm now just choose
> rdma0 -> dsi0, I think mmsys still should provide the full route
> control like clock driver (even though some clock is not use by client
> driver, clock driver should implement all clock control function)
> 
>>
>> More comments below.
>>
>>> Signed-off-by: CK Hu <ck.hu@mediatek.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>>   drivers/soc/mediatek/mtk-mmsys.c | 393 +++++++++++++++++--------------
>>>   1 file changed, 210 insertions(+), 183 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
>>> index da2de8f6969e..f00d6d08c9c5 100644
>>> --- a/drivers/soc/mediatek/mtk-mmsys.c
>>> +++ b/drivers/soc/mediatek/mtk-mmsys.c
>>> @@ -42,39 +42,61 @@
>>>   #define RDMA0_SOUT_DSI1                             0x1
>>>   #define RDMA0_SOUT_DSI2                             0x4
>>>   #define RDMA0_SOUT_DSI3                             0x5
>>> +#define RDMA0_SOUT_MASK                              0x7
>>>   #define RDMA1_SOUT_DPI0                             0x2
>>>   #define RDMA1_SOUT_DPI1                             0x3
>>>   #define RDMA1_SOUT_DSI1                             0x1
>>>   #define RDMA1_SOUT_DSI2                             0x4
>>>   #define RDMA1_SOUT_DSI3                             0x5
>>> +#define RDMA1_SOUT_MASK                              0x7
>>>   #define RDMA2_SOUT_DPI0                             0x2
>>>   #define RDMA2_SOUT_DPI1                             0x3
>>>   #define RDMA2_SOUT_DSI1                             0x1
>>>   #define RDMA2_SOUT_DSI2                             0x4
>>>   #define RDMA2_SOUT_DSI3                             0x5
>>> +#define RDMA2_SOUT_MASK                              0x7
>>>   #define DPI0_SEL_IN_RDMA1                   0x1
>>>   #define DPI0_SEL_IN_RDMA2                   0x3
>>> +#define DPI0_SEL_IN_MASK                     0x3
>>>   #define DPI1_SEL_IN_RDMA1                   (0x1 << 8)
>>>   #define DPI1_SEL_IN_RDMA2                   (0x3 << 8)
>>> +#define DPI1_SEL_IN_MASK                     (0x3 << 8)
>>>   #define DSI0_SEL_IN_RDMA1                   0x1
>>>   #define DSI0_SEL_IN_RDMA2                   0x4
>>> +#define DSI0_SEL_IN_MASK                     0x7
>>>   #define DSI1_SEL_IN_RDMA1                   0x1
>>>   #define DSI1_SEL_IN_RDMA2                   0x4
>>> +#define DSI1_SEL_IN_MASK                     0x7
>>>   #define DSI2_SEL_IN_RDMA1                   (0x1 << 16)
>>>   #define DSI2_SEL_IN_RDMA2                   (0x4 << 16)
>>> +#define DSI2_SEL_IN_MASK                     (0x7 << 16)
>>>   #define DSI3_SEL_IN_RDMA1                   (0x1 << 16)
>>>   #define DSI3_SEL_IN_RDMA2                   (0x4 << 16)
>>> +#define DSI3_SEL_IN_MASK                     (0x7 << 16)
>>>   #define COLOR1_SEL_IN_OVL1                  0x1
>>>
>>>   #define OVL_MOUT_EN_RDMA                    0x1
>>>   #define BLS_TO_DSI_RDMA1_TO_DPI1            0x8
>>>   #define BLS_TO_DPI_RDMA1_TO_DSI                     0x2
>>> +#define BLS_RDMA1_DSI_DPI_MASK                       0xf
>>>   #define DSI_SEL_IN_BLS                              0x0
>>>   #define DPI_SEL_IN_BLS                              0x0
>>> +#define DPI_SEL_IN_MASK                              0x1
>>>   #define DSI_SEL_IN_RDMA                             0x1
>>> +#define DSI_SEL_IN_MASK                              0x1
>>> +
>>> +struct mtk_mmsys_routes {
>>> +     u32 from_comp;
>>> +     u32 to_comp;
>>> +     u32 addr;
>>> +     u32 mask;
>>
>> We didn't need the mask up to now, if needed in the future, we should add it
>> when needed. This will make the code cleaner for now.
> 
> Agree.
> 
>>
>>> +     u32 val;
>>> +};
>>>
>>>   struct mtk_mmsys_driver_data {
>>>       const char *clk_driver;
>>> +     const struct mtk_mmsys_routes *routes;
>>> +     const unsigned int num_routes;
>>>   };
>>>
>>>   static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>>> @@ -93,10 +115,6 @@ static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
>>>       .clk_driver = "clk-mt6797-mm",
>>>   };
>>>
>>> -static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>>> -     .clk_driver = "clk-mt8173-mm",
>>> -};
>>> -
>>>   static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>>>       .clk_driver = "clk-mt8183-mm",
>>>   };
>>> @@ -106,180 +124,192 @@ struct mtk_mmsys {
>>>       const struct mtk_mmsys_driver_data *data;
>>>   };
>>>
>>> -static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
>>> -                                       enum mtk_ddp_comp_id next,
>>> -                                       unsigned int *addr)
>>> -{
>>> -     unsigned int value;
>>> -
>>> -     if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
>>> -             *addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
>>> -             value = OVL0_MOUT_EN_COLOR0;
>>> -     } else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
>>> -             *addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
>>> -             value = OVL_MOUT_EN_RDMA;
>>> -     } else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {
>>> -             *addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
>>> -             value = OD_MOUT_EN_RDMA0;
>>> -     } else if (cur == DDP_COMPONENT_UFOE && next == DDP_COMPONENT_DSI0) {
>>> -             *addr = DISP_REG_CONFIG_DISP_UFOE_MOUT_EN;
>>> -             value = UFOE_MOUT_EN_DSI0;
>>> -     } else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_OVL1_MOUT_EN;
>>> -             value = OVL1_MOUT_EN_COLOR1;
>>> -     } else if (cur == DDP_COMPONENT_GAMMA && next == DDP_COMPONENT_RDMA1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN;
>>> -             value = GAMMA_MOUT_EN_RDMA1;
>>> -     } else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
>>> -             value = OD1_MOUT_EN_RDMA1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
>>> -             value = RDMA0_SOUT_DPI0;
>>> -     } else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
>>> -             value = RDMA0_SOUT_DPI1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
>>> -             value = RDMA0_SOUT_DSI1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
>>> -             value = RDMA0_SOUT_DSI2;
>>> -     } else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
>>> -             value = RDMA0_SOUT_DSI3;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
>>> -             value = RDMA1_SOUT_DSI1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI2) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
>>> -             value = RDMA1_SOUT_DSI2;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
>>> -             value = RDMA1_SOUT_DSI3;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
>>> -             value = RDMA1_SOUT_DPI0;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
>>> -             value = RDMA1_SOUT_DPI1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
>>> -             value = RDMA2_SOUT_DPI0;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
>>> -             value = RDMA2_SOUT_DPI1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
>>> -             value = RDMA2_SOUT_DSI1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
>>> -             value = RDMA2_SOUT_DSI2;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI3) {
>>> -             *addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
>>> -             value = RDMA2_SOUT_DSI3;
>>> -     } else {
>>> -             value = 0;
>>> -     }
>>> -
>>> -     return value;
>>> -}
>>> -
>>> -static unsigned int mtk_mmsys_ddp_sel_in(enum mtk_ddp_comp_id cur,
>>> -                                      enum mtk_ddp_comp_id next,
>>> -                                      unsigned int *addr)
>>> -{
>>> -     unsigned int value;
>>> -
>>> -     if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
>>> -             *addr = DISP_REG_CONFIG_DISP_COLOR0_SEL_IN;
>>> -             value = COLOR0_SEL_IN_OVL0;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>>> -             *addr = DISP_REG_CONFIG_DPI_SEL_IN;
>>> -             value = DPI0_SEL_IN_RDMA1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
>>> -             *addr = DISP_REG_CONFIG_DPI_SEL_IN;
>>> -             value = DPI1_SEL_IN_RDMA1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
>>> -             *addr = DISP_REG_CONFIG_DSIE_SEL_IN;
>>> -             value = DSI0_SEL_IN_RDMA1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
>>> -             *addr = DISP_REG_CONFIG_DSIO_SEL_IN;
>>> -             value = DSI1_SEL_IN_RDMA1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI2) {
>>> -             *addr = DISP_REG_CONFIG_DSIE_SEL_IN;
>>> -             value = DSI2_SEL_IN_RDMA1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI3) {
>>> -             *addr = DISP_REG_CONFIG_DSIO_SEL_IN;
>>> -             value = DSI3_SEL_IN_RDMA1;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
>>> -             *addr = DISP_REG_CONFIG_DPI_SEL_IN;
>>> -             value = DPI0_SEL_IN_RDMA2;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
>>> -             *addr = DISP_REG_CONFIG_DPI_SEL_IN;
>>> -             value = DPI1_SEL_IN_RDMA2;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI0) {
>>> -             *addr = DISP_REG_CONFIG_DSIE_SEL_IN;
>>> -             value = DSI0_SEL_IN_RDMA2;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI1) {
>>> -             *addr = DISP_REG_CONFIG_DSIO_SEL_IN;
>>> -             value = DSI1_SEL_IN_RDMA2;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI2) {
>>> -             *addr = DISP_REG_CONFIG_DSIE_SEL_IN;
>>> -             value = DSI2_SEL_IN_RDMA2;
>>> -     } else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI3) {
>>> -             *addr = DISP_REG_CONFIG_DSIE_SEL_IN;
>>> -             value = DSI3_SEL_IN_RDMA2;
>>> -     } else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
>>> -             *addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
>>> -             value = COLOR1_SEL_IN_OVL1;
>>> -     } else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
>>> -             *addr = DISP_REG_CONFIG_DSI_SEL;
>>> -             value = DSI_SEL_IN_BLS;
>>> -     } else {
>>> -             value = 0;
>>> +static const struct mtk_mmsys_routes mt8173_mmsys_routing_table[] = {
>>> +     {
>>> +             DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0,
>>> +             DISP_REG_CONFIG_OUT_SEL,
>>> +             BLS_RDMA1_DSI_DPI_MASK, BLS_TO_DSI_RDMA1_TO_DPI1
>>> +     }, {
>>> +             DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0,
>>> +             DISP_REG_CONFIG_DSI_SEL,
>>> +             DSI_SEL_IN_MASK, DSI_SEL_IN_BLS
>>> +     }, {
>>> +             DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
>>> +             DISP_REG_CONFIG_OUT_SEL,
>>> +             BLS_RDMA1_DSI_DPI_MASK, BLS_TO_DPI_RDMA1_TO_DSI
>>> +     }, {
>>> +             DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
>>> +             DISP_REG_CONFIG_DSI_SEL,
>>> +             DSI_SEL_IN_MASK, DSI_SEL_IN_RDMA
>>> +     }, {
>>> +             DDP_COMPONENT_BLS, DDP_COMPONENT_DPI0,
>>> +             DISP_REG_CONFIG_DPI_SEL,
>>> +             DPI_SEL_IN_MASK, DPI_SEL_IN_BLS
>>
>> I wonder if we could make the data structure easier to read by grouping actions
>> for the same component tuple together.
> 
> Maybe if-else is the simple way to group then. Two layer array could
> achieve this but it's more complicated.
> 
>>
>>> +     }, {
>>> +             DDP_COMPONENT_GAMMA, DDP_COMPONENT_RDMA1,
>>> +             DISP_REG_CONFIG_DISP_GAMMA_MOUT_EN,
>>> +             GAMMA_MOUT_EN_RDMA1, GAMMA_MOUT_EN_RDMA1
>>> +     }, {
>>> +             DDP_COMPONENT_OD0, DDP_COMPONENT_RDMA0,
>>> +             DISP_REG_CONFIG_DISP_OD_MOUT_EN,
>>> +             OD_MOUT_EN_RDMA0, OD_MOUT_EN_RDMA0
>>> +     }, {
>>> +             DDP_COMPONENT_OD1, DDP_COMPONENT_RDMA1,
>>> +             DISP_REG_CONFIG_DISP_OD_MOUT_EN,
>>> +             OD1_MOUT_EN_RDMA1, OD1_MOUT_EN_RDMA1
>>> +     }, {
>>> +             DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
>>> +             DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
>>> +             OVL0_MOUT_EN_COLOR0, OVL0_MOUT_EN_COLOR0
>>> +     }, {
>>> +             DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
>>> +             DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
>>> +             COLOR0_SEL_IN_OVL0, COLOR0_SEL_IN_OVL0
>>> +     }, {
>>> +             DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
>>> +             DISP_REG_CONFIG_DISP_OVL_MOUT_EN,
>>> +             OVL_MOUT_EN_RDMA, OVL_MOUT_EN_RDMA
>>> +     }, {
>>> +             DDP_COMPONENT_OVL1, DDP_COMPONENT_COLOR1,
>>> +             DISP_REG_CONFIG_DISP_OVL1_MOUT_EN,
>>> +             OVL1_MOUT_EN_COLOR1, OVL1_MOUT_EN_COLOR1
>>> +     }, {
>>> +             DDP_COMPONENT_OVL1, DDP_COMPONENT_COLOR1,
>>> +             DISP_REG_CONFIG_DISP_COLOR1_SEL_IN,
>>> +             COLOR1_SEL_IN_OVL1, COLOR1_SEL_IN_OVL1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA0, DDP_COMPONENT_DPI0,
>>> +             DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
>>> +             RDMA0_SOUT_MASK, RDMA0_SOUT_DPI0
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA0, DDP_COMPONENT_DPI1,
>>> +             DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
>>> +             RDMA0_SOUT_MASK, RDMA0_SOUT_DPI1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI1,
>>> +             DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
>>> +             RDMA0_SOUT_MASK, RDMA0_SOUT_DSI1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI2,
>>> +             DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
>>> +             RDMA0_SOUT_MASK, RDMA0_SOUT_DSI2
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI3,
>>> +             DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN,
>>> +             RDMA0_SOUT_MASK, RDMA0_SOUT_DSI3
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
>>> +             DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
>>> +             RDMA1_SOUT_MASK, RDMA1_SOUT_DPI0
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
>>> +             DISP_REG_CONFIG_DPI_SEL_IN,
>>> +             DPI0_SEL_IN_MASK, DPI0_SEL_IN_RDMA1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI1,
>>> +             DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
>>> +             RDMA1_SOUT_MASK, RDMA1_SOUT_DPI1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI1,
>>> +             DISP_REG_CONFIG_DPI_SEL_IN,
>>> +             DPI1_SEL_IN_MASK, DPI1_SEL_IN_RDMA1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI0,
>>> +             DISP_REG_CONFIG_DSIE_SEL_IN,
>>> +             DSI0_SEL_IN_MASK, DSI0_SEL_IN_RDMA1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI1,
>>> +             DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
>>> +             RDMA1_SOUT_MASK, RDMA1_SOUT_DSI1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI1,
>>> +             DISP_REG_CONFIG_DSIO_SEL_IN,
>>> +             DSI1_SEL_IN_MASK, DSI1_SEL_IN_RDMA1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI2,
>>> +             DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
>>> +             RDMA1_SOUT_MASK, RDMA1_SOUT_DSI2
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI2,
>>> +             DISP_REG_CONFIG_DSIE_SEL_IN,
>>> +             DSI2_SEL_IN_MASK, DSI2_SEL_IN_RDMA1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI3,
>>> +             DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
>>> +             RDMA1_SOUT_MASK, RDMA1_SOUT_DSI3
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI3,
>>> +             DISP_REG_CONFIG_DSIO_SEL_IN,
>>> +             DSI3_SEL_IN_MASK, DSI3_SEL_IN_RDMA1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DPI0,
>>> +             DISP_REG_CONFIG_DISP_RDMA2_SOUT,
>>> +             RDMA2_SOUT_MASK, RDMA2_SOUT_DPI0
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DPI0,
>>> +             DISP_REG_CONFIG_DPI_SEL_IN,
>>> +             DPI0_SEL_IN_MASK, DPI0_SEL_IN_RDMA2
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DPI1,
>>> +             DISP_REG_CONFIG_DISP_RDMA2_SOUT,
>>> +             RDMA2_SOUT_MASK, RDMA2_SOUT_DPI1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DPI1,
>>> +             DISP_REG_CONFIG_DPI_SEL_IN,
>>> +             DPI1_SEL_IN_MASK, DPI1_SEL_IN_RDMA2
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI0,
>>> +             DISP_REG_CONFIG_DSIE_SEL_IN,
>>> +             DSI0_SEL_IN_MASK, DSI0_SEL_IN_RDMA2
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI1,
>>> +             DISP_REG_CONFIG_DISP_RDMA2_SOUT,
>>> +             RDMA2_SOUT_MASK, RDMA2_SOUT_DSI1
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI1,
>>> +             DISP_REG_CONFIG_DSIO_SEL_IN,
>>> +             DSI1_SEL_IN_MASK, DSI1_SEL_IN_RDMA2
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI2,
>>> +             DISP_REG_CONFIG_DISP_RDMA2_SOUT,
>>> +             RDMA2_SOUT_MASK, RDMA2_SOUT_DSI2
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI2,
>>> +             DISP_REG_CONFIG_DSIE_SEL_IN,
>>> +             DSI2_SEL_IN_MASK, DSI2_SEL_IN_RDMA2
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI3,
>>> +             DISP_REG_CONFIG_DISP_RDMA2_SOUT,
>>> +             RDMA2_SOUT_MASK, RDMA2_SOUT_DSI3
>>> +     }, {
>>> +             DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI3,
>>> +             DISP_REG_CONFIG_DSIO_SEL_IN,
>>> +             DSI3_SEL_IN_MASK, DSI3_SEL_IN_RDMA2
>>>       }
>>> +};
>>>
>>> -     return value;
>>> -}
>>> -
>>> -static void mtk_mmsys_ddp_sout_sel(void __iomem *config_regs,
>>> -                                enum mtk_ddp_comp_id cur,
>>> -                                enum mtk_ddp_comp_id next)
>>> -{
>>> -     if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
>>> -             writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
>>> -                            config_regs + DISP_REG_CONFIG_OUT_SEL);
>>> -     } else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
>>> -             writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
>>> -                            config_regs + DISP_REG_CONFIG_OUT_SEL);
>>> -             writel_relaxed(DSI_SEL_IN_RDMA,
>>> -                            config_regs + DISP_REG_CONFIG_DSI_SEL);
>>> -             writel_relaxed(DPI_SEL_IN_BLS,
>>> -                            config_regs + DISP_REG_CONFIG_DPI_SEL);
>>> -     }
>>> -}
>>> +static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>>> +     .clk_driver = "clk-mt8173-mm",
>>> +     .routes = mt8173_mmsys_routing_table,
>>> +     .num_routes = ARRAY_SIZE(mt8173_mmsys_routing_table),
>>> +};
>>>
>>>   void mtk_mmsys_ddp_connect(struct device *dev,
>>>                          enum mtk_ddp_comp_id cur,
>>>                          enum mtk_ddp_comp_id next)
>>>   {
>>>       struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
>>> -     unsigned int addr, value, reg;
>>> -
>>> -     value = mtk_mmsys_ddp_mout_en(cur, next, &addr);
>>> -     if (value) {
>>> -             reg = readl_relaxed(mmsys->regs + addr) | value;
>>> -             writel_relaxed(reg, mmsys->regs + addr);
>>> -     }
>>> -
>>> -     mtk_mmsys_ddp_sout_sel(mmsys->regs, cur, next);
>>> -
>>> -     value = mtk_mmsys_ddp_sel_in(cur, next, &addr);
>>> -     if (value) {
>>> -             reg = readl_relaxed(mmsys->regs + addr) | value;
>>> -             writel_relaxed(reg, mmsys->regs + addr);
>>> -     }
>>
>> What I don't like of this new approach is the fact, that we loose information
>> about the different grouping we had up to now, mout_en, sout_sel and sel_in.
> 
> Agree. Maybe we should keep if-else model in mt8173, mt2701, mt2712.
> And ask mt8183 [1] , mt8192 [2] to use if-else model.
> 
> [1] https://patchwork.kernel.org/patch/11706231/
> [2] https://patchwork.kernel.org/patch/11725595/
> 

Ok, I'll give a second round of these patches trying to address your comments.
Matthias, patch 1 and 2 are kind of independent/unrelated patches and can be
applied. I just added here to avoid conflicts. So I am wondering if you are fine
with them, if you can pick these two.

Thanks,
  Enric


> Regards,
> Chun-Kuang.
> 
>>
>> Regards,
>> Matthias
