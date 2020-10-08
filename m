Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB6286FCE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgJHHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:49:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57596 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJHHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:49:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 334FB28DBF3
Subject: Re: [PATCH 4/4] soc: mediatek: mmsys: Use an array for setting the
 routing registers
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20201006193320.405529-1-enric.balletbo@collabora.com>
 <20201006193320.405529-5-enric.balletbo@collabora.com>
 <CAAOTY__X8L2sK0s3rkq2LDaMNoQrZKfzn=aJ791fK=UwnJMAyQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <580ecdf4-a686-f14c-a230-7f87f0c8cde5@collabora.com>
Date:   Thu, 8 Oct 2020 09:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY__X8L2sK0s3rkq2LDaMNoQrZKfzn=aJ791fK=UwnJMAyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

On 8/10/20 2:01, Chun-Kuang Hu wrote:
> Hi, Enric:
> 
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年10月7日 週三 上午3:33寫道：
>>
>> From: CK Hu <ck.hu@mediatek.com>
>>
>> Actually, setting the registers for routing, use multiple 'if-else' for different
>> routes, but this code would be more and more complicated while we
>> support more and more SoCs. Change that and use a table per SoC so the
>> code will be more portable and clear.
>>
>> Signed-off-by: CK Hu <ck.hu@mediatek.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/soc/mediatek/mtk-mmsys.c | 393 +++++++++++++++++--------------
>>  1 file changed, 210 insertions(+), 183 deletions(-)
>>
> 
> [snip]
> 
>>
>>  static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>> @@ -93,10 +115,6 @@ static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
>>         .clk_driver = "clk-mt6797-mm",
>>  };
>>
>> -static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>> -       .clk_driver = "clk-mt8173-mm",
>> -};
>> -
>>  static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>>         .clk_driver = "clk-mt8183-mm",
>>  };
>> @@ -106,180 +124,192 @@ struct mtk_mmsys {
>>         const struct mtk_mmsys_driver_data *data;
>>  };
>>
> 
> [snip]
> 
>> +static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>> +       .clk_driver = "clk-mt8173-mm",
>> +       .routes = mt8173_mmsys_routing_table,
>> +       .num_routes = ARRAY_SIZE(mt8173_mmsys_routing_table),
>> +};
>>
> 
> I remove my Reviewed-by tag. You does not set routes for mt2701 and
> mt2712, but these two SoC need that. Maybe now they use the same table
> as mt8173.
> 

I did that on purpose as explained in the cover letter, and asked for someone
with the hardware to provide me a working routing table. But, if you think the
same routing should work on those devices I'm fine to use the same for all the
current devices. I don't have that hardware, so anyway, will need to test.

Thanks,
 Enric

> Regards,
> Chun-Kuang.
> 
