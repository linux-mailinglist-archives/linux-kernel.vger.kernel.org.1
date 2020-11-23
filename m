Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD852C00E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgKWHwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 02:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgKWHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:52:21 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CA3C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:52:20 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 1so16309492wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6FLxwuUTQc6cRh7lRrVMYXIgZfDzgJlYaSbkXy3g/G0=;
        b=ZwDgkPu7A90VXGwTQrYGNLGC8EibbIz5MiBElK4SpSSeRwZqUdZV/UU/TXWv0BSv3x
         uBQwNJVFFiUNIdmm4QPWfgLgnN1KinzIzib5xXFpqYGwZYfg+NY64ngDfoDs8Tg6U5E8
         kn3NSkHK5ltZ1Q0T0fUvuOeoso2I2DDA8uX1dmiNjwe4lwSG36giUE1QAp07raUSXElg
         cLIRaILUg6hUoBIXi0F86H58rZ0pGONBa4SFsOgw2o5H201H1bWGVaw42+9l5Z3ikA+E
         PVdJKEuupWpNmuzGbjKfM7vw68fbcBpgVRAOI7fGWMuv0UH4YeMbDTSshZ55tjyMQYZt
         yc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6FLxwuUTQc6cRh7lRrVMYXIgZfDzgJlYaSbkXy3g/G0=;
        b=mgQp4mNHv22/ExIcY6OreqaomhZOMm502a5/cDa0VSavbstB6VgDR9R8yjPYEm7JFT
         da5EEoh1Bre3VktBx174o7fPqqy9sGTqMFJnk9rr9sNa0y5OFdoxHiNhJQYu9Z6mQS1X
         Q6kB+qePGzgEAUc+Py8W6IhkDDhBrgThHptOoDQBokCGnX8Y35TSQUcyhRtcsppRrTiA
         57sta6VNTEMeMYugtA9uRIOOaOERxzscLJr7NpvRpeoHrSADu+vAuu4RDYpt0OgkBZ+n
         vkr3N/DoXeB7ghvvfZS/2CQXiWo7l4/4jZVTk4WGTUB/CykAut8dXSb9n6DAfdZCFzAh
         /Ipw==
X-Gm-Message-State: AOAM530WiCiDlNYb+PeMXRW/L/Em7kRZcBVtREciknG13fZEWiHjgEWd
        ZsuHHsK66hNfw9MwJyZj9QiZuBaqTM3VDpUf
X-Google-Smtp-Source: ABdhPJzNZm7iinub3G6SGd3Kj1uOQQlZOW9ivFVGKglqtiB9VzNFMYSmP1ViO+1gwYF8fZwwk3N43A==
X-Received: by 2002:a1c:1982:: with SMTP id 124mr21866556wmz.74.1606117938228;
        Sun, 22 Nov 2020 23:52:18 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae? ([2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae])
        by smtp.gmail.com with ESMTPSA id f20sm14494858wmc.26.2020.11.22.23.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 23:52:17 -0800 (PST)
Subject: Re: [PATCH 0/4] arm64: dts: meson-axg-s400: add support for USB and
 PCIe
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201120153229.3920123-1-narmstrong@baylibre.com>
 <160589952950.11499.15261993036625823660.b4-ty@baylibre.com>
 <7hwnyfstg3.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <c1070a70-b3f1-d771-d04d-d981c7ea7928@baylibre.com>
Date:   Mon, 23 Nov 2020 08:52:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7hwnyfstg3.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2020 20:45, Kevin Hilman wrote:
> Kevin Hilman <khilman@baylibre.com> writes:
> 
>> On Fri, 20 Nov 2020 16:32:25 +0100, Neil Armstrong wrote:
>>> This adds the USB and PCIe to AXG, and enables USB & the two M.2 PCIe ports on the S400 board.
>>>
>>> Dependencies:
>>> - Patch 1, 2, 4: None
>>> - Patch 3: [1] arm64: dts: meson-axg-s400: add support for Power Controller & MIPI-DSI PHY
>>>
>>> [1] https://lore.kernel.org/r/20201120152131.3918814-1-narmstrong@baylibre.com
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/4] arm64: dts: meson-axg: add USB nodes
>>       commit: ca91acde9a9858a20522abbb2c79c6883ef9bc73
>> [2/4] arm64: dts: meson-axg-s400: enable USB OTG
>>       commit: 160f1630878e11668336fded29eeb0fe82fb3faf
>> [3/4] arm64: dts: meson-axg: add PCIe nodes
>>       commit: 9bfc5abed67ae7dcc837dd8f6d61396d1cc9ac2b
>> [4/4] arm64: dts: meson-axg-s400: enable PCIe M.2 Key E slots
>>       commit: eee685ef92d8cbabb2a61c45fe7d976c3ebc9b1e
> 
> FYI... these commit IDs are no longer accurate.  I relized that the USB
> patches were already in my fixes branch, so needed a rebase.  I fixed
> everything up locally, but the commit IDs are no longer the same as
> above.

Oops it's my fault, i forgot they were merged on -rc2.

thx,
Neil

> 
> Kevin
> 

