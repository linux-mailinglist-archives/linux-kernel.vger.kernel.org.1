Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D712872D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgJHKxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJHKxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:53:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F6C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 03:53:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so6484073wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wotskCcQ8Bfd9kB9LqYWsitlA9BI8lFl5qjTxF+AmRI=;
        b=VAwrMdmAi7DTJSt1xSvEQ0AJyG7DCnU4ribw1JuLI5Yfceu8pIReZthIiESDilbSqp
         Vf0gdeiQrdlQqRxJ+hrGg8mM0bB+Z8OeLcHhv6jQQASN1Hb+PGzWK/eCe911vrLR+RIT
         HR0E4bih7yH4P5AZakfzTTENk/LpQQOO8lOQjPi5/JDvrNUeDKH3Tv+bccT4lNEtj58q
         rBFCc+TFBdD/PrDzo9+hDERhvKMiGuEJz5qJtyoN9c2dYkapPO6DL3d8WsjB5z+iYITT
         GNMLBj0jUIFfS/xijL5b9InSd3vxqPALTuYL/NOVnAu1uwwzHLSL3M7vDtMKCWAwD/D5
         0WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wotskCcQ8Bfd9kB9LqYWsitlA9BI8lFl5qjTxF+AmRI=;
        b=LPcpsNSAwe0RcZohZTl95PGDq+co5Dh752QjWMGb3ARg98LD+VEBgQDa5eUrmWVqsj
         uU0khvTCe0O6gAQFZaojQliMBmwSNv1PQ/p1NJFlPNz1sBrAJ/9KBexzjiwWKEr2d8dR
         aMnqYb0gYwo+qmVaOtsOx6GNUd8VLqh4id0Q6o++35bOZlLFlgBBOaNOyn7ErZrAJ7Rm
         WX2/FdvvSegSF3eCjzKuVWuIzMkncx4Jr3fPEY44QAFZNLumm/AiEAY6GM3tHWjcUA6O
         Y1F2bhokm09Nd6NGqTssim02ssyFS6S9J4Ql2918mklzNLaQ/90vOL4zjS8HnqjH+lGW
         wHsg==
X-Gm-Message-State: AOAM5338F0zVb9N9KM8XtPDpUeb1YDA4jlrVtvxK1bNcdsJj34tXEQkr
        o5nzbqZkHfIpk7QNoaHGmjE=
X-Google-Smtp-Source: ABdhPJznG7dHOrS1DRUjCidZScs64soiMYfjbGBAooA1olh4Aec3dFavbraorso1hCwwx5JyQ+GOzQ==
X-Received: by 2002:a1c:bcd5:: with SMTP id m204mr7878483wmf.26.1602154413420;
        Thu, 08 Oct 2020 03:53:33 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id c16sm7139623wrx.31.2020.10.08.03.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 03:53:32 -0700 (PDT)
Subject: Re: [PATCH 4/4] soc: mediatek: mmsys: Use an array for setting the
 routing registers
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
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
 <CAAOTY__X8L2sK0s3rkq2LDaMNoQrZKfzn=aJ791fK=UwnJMAyQ@mail.gmail.com>
 <580ecdf4-a686-f14c-a230-7f87f0c8cde5@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d46f09a9-22bf-da68-5629-f080f7804b92@gmail.com>
Date:   Thu, 8 Oct 2020 12:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <580ecdf4-a686-f14c-a230-7f87f0c8cde5@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2020 09:49, Enric Balletbo i Serra wrote:
> Hi Chun-Kuang,
> 
> On 8/10/20 2:01, Chun-Kuang Hu wrote:
>> Hi, Enric:
>>
>> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年10月7日 週三 上午3:33寫道：
>>>
>>> From: CK Hu <ck.hu@mediatek.com>
>>>
>>> Actually, setting the registers for routing, use multiple 'if-else' for different
>>> routes, but this code would be more and more complicated while we
>>> support more and more SoCs. Change that and use a table per SoC so the
>>> code will be more portable and clear.
>>>
>>> Signed-off-by: CK Hu <ck.hu@mediatek.com>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>>   drivers/soc/mediatek/mtk-mmsys.c | 393 +++++++++++++++++--------------
>>>   1 file changed, 210 insertions(+), 183 deletions(-)
>>>
>>
>> [snip]
>>
>>>
>>>   static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>>> @@ -93,10 +115,6 @@ static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data = {
>>>          .clk_driver = "clk-mt6797-mm",
>>>   };
>>>
>>> -static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>>> -       .clk_driver = "clk-mt8173-mm",
>>> -};
>>> -
>>>   static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>>>          .clk_driver = "clk-mt8183-mm",
>>>   };
>>> @@ -106,180 +124,192 @@ struct mtk_mmsys {
>>>          const struct mtk_mmsys_driver_data *data;
>>>   };
>>>
>>
>> [snip]
>>
>>> +static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>>> +       .clk_driver = "clk-mt8173-mm",
>>> +       .routes = mt8173_mmsys_routing_table,
>>> +       .num_routes = ARRAY_SIZE(mt8173_mmsys_routing_table),
>>> +};
>>>
>>
>> I remove my Reviewed-by tag. You does not set routes for mt2701 and
>> mt2712, but these two SoC need that. Maybe now they use the same table
>> as mt8173.
>>
> 
> I did that on purpose as explained in the cover letter, and asked for someone
> with the hardware to provide me a working routing table. But, if you think the
> same routing should work on those devices I'm fine to use the same for all the
> current devices. I don't have that hardware, so anyway, will need to test.
> 

But you could deduce the routes needed by having a look into the components in 
mtk_drm_drv.c, correct?
Well see my other email, but defining them twice sounds like not a good approach 
to me.

Regards,
Matthias
