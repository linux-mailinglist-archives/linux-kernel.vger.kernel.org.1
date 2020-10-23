Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED41296C61
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461788AbgJWJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461781AbgJWJyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:54:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:54:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n15so1128573wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=33PxRKHXGZaR8Akuh25nhwh94mQILSpGUhfNOEDRamY=;
        b=Pf6ThxZAqQDbjixttCY5ALkbcs0hoN7kkdH6NwwXvfnfR0AMHG9dRaPPT8Dpq3e/DX
         ewBWEPM9xvzxF3LJhl8O4wXjq641eSO5lPl73XJMpXdqQta/gmtz9W20vzNJICItsrn+
         jCtfjcXH9tMJDa0TS2mCuBQ0f08tETCacGVEKn1ZhVjYjls40xxyQhITTxp8N34Pmggq
         X65Um0q5prMNdeMm5XOSukFxXsFQLbYs3CrO48VWSihj/lKVaR2Vpw+iIFnuzMaX+F0Z
         Ig9TLXm7wDd7255n19casZ183Rr6BCQ353GJxofAF/45U6A5pNgziPh2Rl1SABtvibOn
         2RhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=33PxRKHXGZaR8Akuh25nhwh94mQILSpGUhfNOEDRamY=;
        b=GMSWMNsm4QQtTGeKFcl8dU+8EfFWatXJx9Ap0R8rruN/9x9ri0N0w5kUtj30edc7B6
         6zTSikPqSzprHuvrc/RknlyuIXLrCQ4YdJg+UyjeDPwoxfaTZVBDYOzVj80tl8NvOgl/
         VfEg/ReofXI9imBxNAtRNA+ZqAVcJzP3OHjZa3c5HvnbLsT6cKpdAXQMF4vxPG8RcHmj
         rjuXIMAr/hYt+EQBkW5caOFe/GQPjvJQKXDJ3A5hiUrCMXEujjWXUbw83xkVUqqU7lN4
         c3bIamVV2322hsWCnAWXQyc0PwsWKZRC0DHLLRLZJ88bBmwJAiukZKCp8dcUtErvtNpk
         0KYA==
X-Gm-Message-State: AOAM533ldPKImRy+jZq7mP8iD6OwRGOEj8ESem5i0mSkBPP5EiPt/k+d
        2PEujunEbZNA40AFnyZsLBc=
X-Google-Smtp-Source: ABdhPJy+ySkVkHwUExvk/bcRpM2hZ71hE496Y1reuvgUUPyeXvWXypE55nkBpoJIYXnB/yxtaIqz4w==
X-Received: by 2002:adf:a455:: with SMTP id e21mr1898622wra.158.1603446890187;
        Fri, 23 Oct 2020 02:54:50 -0700 (PDT)
Received: from ziggy.stardust ([213.195.117.206])
        by smtp.gmail.com with ESMTPSA id q6sm2325490wma.0.2020.10.23.02.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 02:54:49 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: change mediatek wiki page
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>, matthias.bgg@kernel.org
Cc:     kuohong.wang@mediatek.com, yh.chen@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miles.Chen@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, Yingjoe.Chen@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20201020152639.21950-1-matthias.bgg@kernel.org>
 <CAAOTY__MegNwaUGphYNpnKrC_y8SX-_rDNXGxsaBJ6FDBKsQ_w@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8605c61c-4329-9771-ba45-058e7d3f199c@gmail.com>
Date:   Fri, 23 Oct 2020 11:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY__MegNwaUGphYNpnKrC_y8SX-_rDNXGxsaBJ6FDBKsQ_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/10/2020 18:53, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> <matthias.bgg@kernel.org> 於 2020年10月20日 週二 下午11:27寫道：
>>
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> The old wiki page unfortunately got lost by server crash.
>> The new wiki can be found on the kernel.org infrastructure
>>
> 
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> 

pushed to v5.10-tmp/soc

Thanks

>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 14b8ec0bb58b..7d0088782a9f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2067,7 +2067,7 @@ M:        Matthias Brugger <matthias.bgg@gmail.com>
>>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   L:     linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>>   S:     Maintained
>> -W:     https://mtk.bcnfs.org/
>> +W:     https://mtk.wiki.kernel.org/
>>   C:     irc://chat.freenode.net/linux-mediatek
>>   F:     arch/arm/boot/dts/mt6*
>>   F:     arch/arm/boot/dts/mt7*
>> --
>> 2.28.0
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
