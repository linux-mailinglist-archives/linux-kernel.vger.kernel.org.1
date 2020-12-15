Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732EC2DB1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgLOQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgLOQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:40:50 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308C9C06179C;
        Tue, 15 Dec 2020 08:40:10 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c79so14822511pfc.2;
        Tue, 15 Dec 2020 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TqfKHpZl1Ix0Kc5okq3jsiMoMVUdYzdMq5tsEYnmWAg=;
        b=jkeKfD2WijsXZ0hkNjt9AoisQAMAnf8E0TrHNd92Bh1FrQ1yM92dpEfO0kF7p/3rXP
         8mQCnPScPzqgJbyhyZAuABWfphXXMRmU01GH5c6eCSG/Ii4cUssoZyGU+WC2XMIGFXy3
         1LMysU0Q9HLc6XyAhsKGaAB/DpbWCtgzdvcUx94l1NWK3LREMCH+/69Ms2IY+v1NUmdg
         rkIPStYjJybOaKTg5QyC30nBq0ch7lCJZfsBSl/Caa1r6mjGD82/nuhw4xgstA8tRFfN
         BxENAH1cFe6eqUGqXe1ViTlUu5qrgFPaZXxp70o1uUmOktSZhaE2EiuJnJ/jBx42F7vP
         lS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TqfKHpZl1Ix0Kc5okq3jsiMoMVUdYzdMq5tsEYnmWAg=;
        b=FHyLNcvw8/tdd5ptB94bwESypSmF1cm5kUAdw9t2K3bsEnQxgUCoXSIrSsP1PI0oDO
         dNWBxkUPuPGG4MJv3R6b7kvsfPlT350o4r1zCalkLV8L0Xdu787pIEn9zT6hzwobUoma
         jNr9stflrxtPKAd+PxyW+wpGdI629aZlcsR6pCRTCPz5XnkiLyH5qH+dcs9KLHa3hhZC
         OuPiEPx+58Q9a8GEU/8ciE2Rlt1fIv8dFVjgCjTu2GGCcULfsskXmBpdxwwsI/W2NgOV
         cF8ZxhnAjLCUUSZcWJsSQjrQHYh4f0jCLOskkN+yDqHWSS48p3hmbQGMoqMzG0nfIjxS
         eZZQ==
X-Gm-Message-State: AOAM532wgIYYCmrXIp42g4cwAlnrLmH6/Gw+uBF8I2ae1KvAkJt8MTUV
        xWSx+yccHUOXCSh1kb2ZPuVxAAOC3CE=
X-Google-Smtp-Source: ABdhPJxqvdirPQ59IYTx85fUXiGlu05ZCkTtPl5ujgMs153lmNMh+D85Qudyi0R77xVHXEIQLFhA1w==
X-Received: by 2002:aa7:8499:0:b029:19e:6c5:b103 with SMTP id u25-20020aa784990000b029019e06c5b103mr1617386pfn.13.1608050408979;
        Tue, 15 Dec 2020 08:40:08 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h20sm23784577pgv.23.2020.12.15.08.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 08:40:08 -0800 (PST)
Subject: Re: [PATCH v1] ARM: tegra: Fix misplaced tegra_uart_config in
 decompressor
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201215135222.6899-1-digetx@gmail.com>
 <980f70c6-8967-c110-1699-cb0da2f46cc0@gmail.com>
 <5b01ce96-5f8b-dfcb-accd-2ba29f34947f@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5853b349-562c-3b6a-33d6-49516553dad8@gmail.com>
Date:   Tue, 15 Dec 2020 08:40:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <5b01ce96-5f8b-dfcb-accd-2ba29f34947f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/2020 8:17 AM, Dmitry Osipenko wrote:
> 15.12.2020 19:04, Florian Fainelli пишет:
>>
>>
>> On 12/15/2020 5:52 AM, Dmitry Osipenko wrote:
>>> The tegra_uart_config of the DEBUG_LL code is now placed right at the
>>> start of the .text section after commit which enabled debug output in the
>>> decompressor. Tegra devices are not booting anymore if DEBUG_LL is enabled
>>> since tegra_uart_config data is executes as a code. Fix the misplaced
>>> tegra_uart_config storage by embedding it into the code.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 2596a72d3384 ("ARM: 9009/1: uncompress: Enable debug in head.S")
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  arch/arm/include/debug/tegra.S | 54 +++++++++++++++++-----------------
>>>  1 file changed, 27 insertions(+), 27 deletions(-)
>>
>> Looks like arch/arm/include/debug/brcmstb.S would need the same
>> treatment since the implementation was copied from tegra.S.
>>
> 
> Good catch, will you be able to test the brcm and make a patch?

Yes, absolutely, building a kernel to test right now.
-- 
Florian
