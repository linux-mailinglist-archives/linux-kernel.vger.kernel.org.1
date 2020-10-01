Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C828015A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgJAOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:33:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B4FC0613D0;
        Thu,  1 Oct 2020 07:33:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so6033711wrn.13;
        Thu, 01 Oct 2020 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b3P3LV9RhutiTsTO5Suv2CILZHpCdIFEhL9gMG13gMw=;
        b=sjH0URHHv1v932gE4pVV6KEJUXeW1bwdd/NKsLAqRnL953En3UJHLfhivZd1U4USGg
         oZdHqZX4Vo3MFvg7lGHG4NVwI0UWCLBv7km08T3rTR3cbP/9g4tSSaOHfJAgjgyMdOFX
         jlUjUpwTmzoaCzuwHtHHg2bVFpzSbgzo/oKY82QEpNt/6VP+2yxNzJsSJ6FnK6pZgnyu
         2tcN7DVOBDKK/KUB8F8kb4EIDbTHppMg2K5N4C+AZA4DJn1b3uwLdHFLLwkmJBw1PP4e
         My7EwZwjrEKBL9mih3YXF32qj6dPSwutX8OqXOkSW0Ew7pGDE0EH0xfxKFQ9+m9wkqt8
         6maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b3P3LV9RhutiTsTO5Suv2CILZHpCdIFEhL9gMG13gMw=;
        b=rdgyCNgd0h8/Dr4xJI1gwCctuXLv1nwWVT4AwhAyxNky9aQfK9u6GTu4k/mRdJwGAy
         lBslcsApNJG58acSkLw45vSo0pJSmJeI9duBWW+tk7YHLJDGiXpNuH8joGjCScK5NJu2
         Srv7pE09gEbfnasHGG0GxLvRm/SYSLMUV01JkvT3RdGnbd8UhVtbNm73mVd0eAAuou+G
         cSn+19qvWwE4ExB5XAv4fyxusbEHDJgvBntzVx4w1z6XYKFeUqr/GTtCu3fbzrDrcUFY
         Yoga5jI2cKaGmrHGAZYmxLxUM8WcNYiGSVmIxvjH6wdR0NKh0C4YEko2D0NtE2eHPTEA
         ooNQ==
X-Gm-Message-State: AOAM533gLcZeOrbiy8VSvDXd8II4f7LfccgxT4UYlO/6sAgydOnUl0IT
        NGrQCTKiBpI0EBOb+aCS24o=
X-Google-Smtp-Source: ABdhPJylhiCucri9sPMCLR8/g4mcnNpPddQeyxJ58v14bLXNYPfCCAqVmUSj2SiOW/SyoMqa8Wa1xg==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr9953527wrn.12.1601562835011;
        Thu, 01 Oct 2020 07:33:55 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id 70sm219279wmb.41.2020.10.01.07.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 07:33:53 -0700 (PDT)
Subject: Re: [PATCH v17 06/12] soc: mediatek: Add support for hierarchical
 scpsys device node
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
References: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
 <1596705715-15320-7-git-send-email-weiyi.lu@mediatek.com>
 <CANMq1KByYjeD0D81sPzDxx5SzrPvpGxPgm+xvLWcFsmfUJDWBQ@mail.gmail.com>
 <1601437039.28469.3.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <0f750b5c-86b6-f78f-f03f-d63bb599922e@gmail.com>
Date:   Thu, 1 Oct 2020 16:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1601437039.28469.3.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/09/2020 05:37, Weiyi Lu wrote:
> On Mon, 2020-09-28 at 15:14 +0800, Nicolas Boichat wrote:
>> On Thu, Aug 6, 2020 at 5:22 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>>>
>>> Try to list all the power domains of under power controller
>>> node to show the dependency between each power domain directly
>>> instead of filling the dependency in scp_soc_data.
>>> And could be more clearly to group subsys clocks into power domain
>>> sub node to introduce subsys clocks of bus protection in next patch.
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> ---
>> [snip]
>>> +static int traverse_scp(struct platform_device *pdev, struct scp *scp,
>>> +                       const struct scp_domain_data *scp_domain_data)
>>> +{
>>> +       struct device *dev = &pdev->dev;
>>> +       struct device_node *np = dev->of_node;
>>> +       struct device_node *sub;
>>> +       int ret;
>>> +
>>> +       INIT_LIST_HEAD(&scp->dep_links);
>>> +
>>> +       for_each_available_child_of_node(np, sub) {
>>> +               ret = scpsys_get_domain(pdev, scp, sub, scp_domain_data);
>>> +               if (ret) {
>>> +                       dev_err(&pdev->dev, "failed to handle node %pOFn: %d\n", sub, ret);
>>
>> minor comment: this error should not be printed if ret ==
>> -EPROBE_DEFER (use the new dev_err_probe?)
>>
> 
> You're right! I'll use dev_err_probe() instead if anyone is interested
> in this series. Thank you!
> 

I'd propose that we put all our effort of reviewing and testing into the series 
Enric send:
https://lore.kernel.org/linux-mediatek/20200910172826.3074357-1-enric.balletbo@collabora.com/

Regards,
Matthias

>>> +                       goto err;
>>> +               }
>>> +       }
>>> +
>>> +       return 0;
>>> +
>>> +err:
>>> +       of_node_put(sub);
>>> +       return ret;
>>> +}
>> [snip]
> 
