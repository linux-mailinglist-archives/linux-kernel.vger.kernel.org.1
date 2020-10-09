Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DAD2888DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgJIMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730878AbgJIMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:35:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20D1C0613D2;
        Fri,  9 Oct 2020 05:34:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so10109833wrp.8;
        Fri, 09 Oct 2020 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=arXJ0tK64lVD474SrsZL15lNj1CHd4/0uMPQBKlDggM=;
        b=Tq8ecdMt/vmkX053Pg++C4Uk9SVuUFiz/TBkJqmMb1jS7pj76ybDA3YzHnxVeWjXQt
         stdvLakFE4syOiug0U1lzbEhQjmc/Eo2gQ5sSBksTqn4AeJEYsP6KFPYSkimnO2/Ti5J
         49KTc6+mqXPkvb6bXYZKx3Z2U/ojMr/zizEVuY8nu44sdywnDxytiL6RUd3vXyQrmhnb
         HTrRlCuESnPvJE0sLChuLFS2hUUXM09YxctLadYsgkF/ZYyDbHXTQEWTpjQTe/BlfeQX
         WPIkFjkUJqlEpGP7yKJQnNfMuxqJTBr7RlrVQID5IKWePFF8mwL/+Ag0I6eYZgL8geUe
         Hubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=arXJ0tK64lVD474SrsZL15lNj1CHd4/0uMPQBKlDggM=;
        b=Wv/+G8WN5p9v44BjvQsNU6DiX0/sLnGE7gtoYWVt+9l+z7YwagWB9aL+Aog2eZzjOG
         9oOgqBkh9AyBCUpoxHgMrAGLMRdUg6ye9WdG7r3EST/wqq3OIdx6q/lYmrUCHHMxYnlS
         2aH3pvQ+Gyb8fkPo5UegU1aqSeyJv3fchTHVW05Fui8qKVyywKl7/EJ3bDx5WEHRZrF2
         MTIOsS65nBBPyXHPsdbEsOHw2W3JY+6LBWZNpMeSpQUigWJncPLszXhNamEnKvgbKxT9
         SvVOZq0B6k4uqjw/r6nRUkktIcve7UtWmevUwAqtlMP3Bmzff7zD09nXt/2LBPTYM5IN
         bn6w==
X-Gm-Message-State: AOAM532roeoyCTTrqUtE5bXtOoAxq7kSThmS977/G718455AXMBWp7t8
        1zaHc6s+mPUTEEb+5SxN1P7d87w5qmhUyg==
X-Google-Smtp-Source: ABdhPJzb0l67YtCO8ZRSDEv7cjHsgr+7vKydt2IU/L5UzsOFSlUrERISoXTabfEwY/6OrPCc0n/8eA==
X-Received: by 2002:adf:a405:: with SMTP id d5mr8547724wra.421.1602246898481;
        Fri, 09 Oct 2020 05:34:58 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id 13sm11086386wmk.20.2020.10.09.05.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 05:34:57 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] soc: mediatek: add mt6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
 <1598497593-15781-3-git-send-email-neal.liu@mediatek.com>
 <c41ec664-73a0-3c63-a31c-48c89028dfac@gmail.com>
 <1602124514.28301.17.camel@mtkswgap22>
 <d8aec3a3-10b6-8c9e-6b2d-f9d9c0418b33@gmail.com>
 <1602149965.8784.6.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <0ece983b-2e55-cf06-aca8-02a014fce090@gmail.com>
Date:   Fri, 9 Oct 2020 14:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1602149965.8784.6.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2020 11:39, Neal Liu wrote:
> On Thu, 2020-10-08 at 10:45 +0200, Matthias Brugger wrote:
>>
>> On 08/10/2020 04:35, Neal Liu wrote:
>>> On Wed, 2020-10-07 at 12:44 +0200, Matthias Brugger wrote:
>>>>
>>>> On 27/08/2020 05:06, Neal Liu wrote:
[...]

>>>>> +static int mtk_devapc_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct device_node *node = pdev->dev.of_node;
>>>>> +	struct mtk_devapc_context *ctx;
>>>>> +	u32 devapc_irq;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (IS_ERR(node))
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>>>>> +	if (!ctx)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	ctx->data = of_device_get_match_data(&pdev->dev);
>>>>> +	ctx->dev = &pdev->dev;
>>>>> +
>>>>> +	ctx->infra_base = of_iomap(node, 0);
>>>>
>>>> Does this mean the device is part of the infracfg block?
>>>> I wasn't able to find any information about it.
>>>
>>> I'm not sure why you would ask infracfg block. devapc is parts of our
>>> SoC infra, it's different with infracfg.
>>>
>>
>> I'm asking because I want to understand the HW better. I'm not able to find any
>> information in the datasheets. I want to avoid a situation as we had with the
>> MMSYS where a clock driver was submitted first and later on we realized that
>> MMSYS is much more then that and we had to work hard to get the driver right.
>>
>> Now it's happening with SCPSYS, where a driver with the scpsys compatible was
>> send years ago. But SCPSYS is much more then the driver submitted. In this case
>> we opted to write a new driver, but moving from one driver to another one is
>> painfull and full of problems. For that I want to make sure we fully understand
>> Device APC (by the way, what does APC stands for?). Is it a totally independent
>> HW block or is it part of a subsystem, like for example SCP?
>>
>> Regards,
>> Matthias
> 
> It's a totally independent HW block instead of a subsystem.
> I think it's more simple than MMSYS or SCPSYS. But if you would like to
> understand more about this HW, we could find another way/channel to
> introduce it.
> 

If it's a independent HW block, then we are good. No further information needed 
by me. I'd just advise to rename the infra_base to something like base, as it 
made me confuse.

Thanks!
Matthias
