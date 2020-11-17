Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333EB2B5ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgKQMFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgKQMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:05:05 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:05:04 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id d12so22877498wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i2NSbE2GJ1K5LQUCG3yi/zC4b4F5mGd3uE8mjQliaik=;
        b=VeoI0NM8o1thw5usvDBU1uSb/n56yDlZDEseNnKfAqmxzFWekylSgT2FWdBJ9YuTrC
         aZXo+Q+6JqhRbfvvE7216PdZEB3RV7g7NZJspN3DLQgwoxNagHVOKOADXLl7wq/EbExQ
         efD9/hVN24fOrjdekhN8OrlkqtbW56DOzqyEQrw7GxWjmozS9DuBQK/lZiXJIjS1LRvh
         AZmtSUrcIY1XKpHEKM8gqREbRXSJ3OWbzfgN5tS267+Zi4s3zUbwesXMUrDWzU8jDcNA
         h8MEx5/16tSUpD+VpyBXemfcxSsoChcCt63jZZOKUeVdRD6f1lyeO8NjBIrKugN5XpKy
         9V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i2NSbE2GJ1K5LQUCG3yi/zC4b4F5mGd3uE8mjQliaik=;
        b=q8OSPNrmbIgdtemp/ScDMzgxZ1Yai1yFwbNzoNEQd1hTz4jKtfAGsyY5bKJh0UzqX6
         lNrG7TskT28ojIIeXeDg8ZfwfnqzN+GsuCkZjpNDa6GBQi7xQJV35dcgT80rDzz+e7bg
         Fxu9CtYYoebDW1aG4UGNiUXrhtYIx41laBj4/Ngg3ZfWRTirbzvjZcrwYvDViaYdG/VG
         w2+nmXo1oIud1bAAWNmOGA1Sh2f1aPsl8rHxR9AG3R/T2UfE7kQlmkIy0ntpSCmgtLhZ
         d/FZfBRhnvQbevfGzAeywzMdDQPc9zFci5vQRChWKxQLkDgmGDGxP6UxCaf1/qu5q0y+
         +8Fg==
X-Gm-Message-State: AOAM530D+A84DfCczDfmOnGiwjRh5GSp1pladPYjttyD1JLn9Cb//irb
        YYp6bCyayYNwH4beOzaDl4Q=
X-Google-Smtp-Source: ABdhPJxSyrNAxAvfT1+XwkATrVUcM7qjvWrgPL6yjAHLV1n5gVtMEx4Dw11H5YtGl/rRjYdLCFSeJA==
X-Received: by 2002:adf:f241:: with SMTP id b1mr24713314wrp.248.1605614703714;
        Tue, 17 Nov 2020 04:05:03 -0800 (PST)
Received: from ziggy.stardust ([213.195.112.112])
        by smtp.gmail.com with ESMTPSA id p3sm20860055wrs.50.2020.11.17.04.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 04:05:02 -0800 (PST)
Subject: Re: [PATCH v2] mfd: syscon: Add
 syscon_regmap_lookup_by_phandle_optional() function.
To:     Lee Jones <lee.jones@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
 <20201113101940.GH3718728@dell>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c4ed34d5-83a1-98d1-580f-8f8504c5ca0a@gmail.com>
Date:   Tue, 17 Nov 2020 13:05:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201113101940.GH3718728@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 13/11/2020 11:19, Lee Jones wrote:
> On Tue, 10 Nov 2020, Enric Balletbo i Serra wrote:
> 
>> This adds syscon_regmap_lookup_by_phandle_optional() function to get an
>> optional regmap.
>>
>> It behaves the same as syscon_regmap_lookup_by_phandle() except where
>> there is no regmap phandle. In this case, instead of returning -ENODEV,
>> the function returns NULL. This makes error checking simpler when the
>> regmap phandle is optional.
>>
>> Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>
>> Changes in v2:
>> - Add Matthias r-b tag.
>> - Add the explanation from the patch description to the code.
>> - Return NULL instead of -ENOTSUPP when regmap helpers are not enabled.
>>
>>   drivers/mfd/syscon.c       | 18 ++++++++++++++++++
>>   include/linux/mfd/syscon.h | 11 +++++++++++
>>   2 files changed, 29 insertions(+)
> 
> Applied, thanks.
> 

I've a series [1] that's based on this patch, could you provide a stable branch 
for it, so that I can take the series.

Thanks,
Matthias

[1] 
https://lore.kernel.org/linux-mediatek/20201030113622.201188-1-enric.balletbo@collabora.com/
