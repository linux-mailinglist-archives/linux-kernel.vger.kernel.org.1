Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D97A26A255
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgIOJeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgIOJeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:34:19 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853FC06174A;
        Tue, 15 Sep 2020 02:34:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so2679207wme.0;
        Tue, 15 Sep 2020 02:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=67DGhnHI5ky9aYFAddzT1xx//rw0HE/G/UG2KwUwvZg=;
        b=jtSqh/AVWGpCMKkgPVN4OUymijGKQV8H7Ic+ZeXAtbgB/ZfIuICvROHikgdZ9cop3X
         fpsFP3Co1qOhVtYeiyj0DAAHB/Iq4CmkNzeQnD6uHVGO7bVP094dXQ4g8a1Edy7qKXSX
         TstQWKr+xJEti7JHNI8qD2JDPAjpUeSN5PiTrd03/kqHts3YRWWIwoyziyt1hdg6PNLB
         R9/28q7E52Yoa8eWPI41p82dImuZxrk+YpXkiIEF3kSjESaceXbcveC32pLsBCYzHIzH
         8bkeeEmID6tc/suwcN1+rpDWig6uNr259S7EnQ2eQZ9QiTGTTIMuUeE6Or8wb/J9DHOT
         gMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=67DGhnHI5ky9aYFAddzT1xx//rw0HE/G/UG2KwUwvZg=;
        b=f9oO/OELgvIc+YXxQaWk5t+OwJ12YLu5eT8eOk8ooT66ZpfHfd7fgCVj/pzE0/yvui
         l6pPcnI2XMwiwX9oq7nWFsgJmyzjJIZFHpEsNT7q7ZIqujCrp9FZe1/V2sSkggMyPQuq
         YSh+SskqYuXyHoAR0jQNFKXlHZRcMgdUAh6VmtcJ5XQuDBUCcybNvT0Lh6CorvuZP26J
         VbsuCjq+c8Ulyf4gIcu0Qer4SH+BgxrlpBe6ZXQC6Y9XS8YrbIaoy6p0aRUyy+vL5ggs
         TL1A4Ja68O/gvb6Qi1ZeQDcdW8WwKSzDhwcqz5VdCPzZbm92A4w0sS150k5eckepnrYn
         VOJA==
X-Gm-Message-State: AOAM532VzoNcrxAL9cyiBnXlUvijz4qy0b66gOmcz08cS62ttWzt+zb8
        Iusrwwnoqqk6QXcA8WFQt84=
X-Google-Smtp-Source: ABdhPJyzMN+PH6DddtIX0wFjsQw7cBewtV8OuM9oQ/XZCiLuwUuFUrsS4EFZipnC9IJfFm10GINqOQ==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr3914315wma.32.1600162458037;
        Tue, 15 Sep 2020 02:34:18 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id a15sm27345109wrn.3.2020.09.15.02.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 02:34:17 -0700 (PDT)
Subject: Re: [PATCH 0/3] Mediatek MT8192 scpsys support
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com
References: <1599201895-11013-1-git-send-email-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <673c1209-f71c-398d-dbce-7ad6ca3610de@gmail.com>
Date:   Tue, 15 Sep 2020 11:34:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599201895-11013-1-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

On 04/09/2020 08:44, Weiyi Lu wrote:
> This series is based on v5.9-rc1, MT8192 clock v3[1] and MT8183 scpsys v17[2].

First of all, thanks for your patch!

The actual scpsys driver has some limitations. Enric and I are working on a new 
driver [1]. My idea is to deprecate the old scpsys driver in favor of this new one.

Would you mind to resend your series on top of [1]?

Regards,
Matthias

> 
> [1] https://patchwork.kernel.org/cover/11752231/
> [2] https://patchwork.kernel.org/cover/11703253/
> 
> 
> Weiyi Lu (3):
>    dt-bindings: soc: Add MT8192 power dt-bindings
>    soc: mediatek: Add MT8192 scpsys support
>    arm64: dts: Add power controller device node of MT8192
> 
>   .../bindings/soc/mediatek/scpsys.txt          |   5 +
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 148 +++++++++
>   drivers/soc/mediatek/mtk-scpsys.c             | 297 ++++++++++++++++++
>   include/dt-bindings/power/mt8192-power.h      |  32 ++
>   4 files changed, 482 insertions(+)
>   create mode 100644 include/dt-bindings/power/mt8192-power.h
> 
