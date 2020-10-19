Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03DB2925B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgJSK0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgJSK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:26:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6EC0613CE;
        Mon, 19 Oct 2020 03:26:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i1so10789388wro.1;
        Mon, 19 Oct 2020 03:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LF3ORmMoGqS/hxFMe+tpwXv3PmdT4f80BHlurUKBSuY=;
        b=WgGC+dK031/CPcsoeMxwhW+H3Zz9qc4Krd6s6DyJsbTXiGr3XJ09t4ESMfBDckSXcb
         Q8aFW5rgFeUeP2EajOUVlPP2JlpPzncMBbwTyDIE1bmwRpRz1XAkpzOdpTjizWi8NteC
         oa0ayROHc3P8yHl4bp/G9QCv+3gYIhCPAbEZXMUabhXLPm9JSaaHiCID7QK66WA5HgsR
         dQBp9j1SINqsSY2UZ+O3r04V96JSI4Im3QGj5i0e1eDiWtfKoQVSVHUjMNH4bdND+YTC
         OGfqGZLs7u4BIIEp8U0oordfXt3zhn8n2HvcBnvPe4nTVUF0bAMVODbLKPJWWFcwzleH
         LgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LF3ORmMoGqS/hxFMe+tpwXv3PmdT4f80BHlurUKBSuY=;
        b=hqZIoIyMOvVZMtsKN33NN9EZpXp3XEk1bqPCJZ8glL7mj8Jw54UiCihR3aMWTg0RSq
         Bj0U6KyFIAzC5Qz60VGdpd0WIzH3T3zpoqUa42wz2xQ3SSWoCrvsIn79R0egmHm/7l7y
         MT9Zid2rLtF8W/7uybStYqK6v9sEoGuPUsTN3ZQUUuUJSUwomTHVWyUxJP7aJZEPl7Y8
         yNagjTXeacdck3RowE80hNkbDjXlYdHoNp7ydCuZL5K9Zcw5sI4/0iYQEzQYazn1s+Eh
         okif5BGs7GrULifBENinPBtMv91lN/8T1Xpwxn2EO/E3R5ycWJg8712Zcljx4CwZb4RG
         JTUA==
X-Gm-Message-State: AOAM533KMT+FfmDkk8laGVPsJpkDjZkLRUwsrHQX+iJKJ3bFTwKAM7WP
        eK/Jfk1tUjV70sZbkPyaHyo=
X-Google-Smtp-Source: ABdhPJyM1z3+ZxGl43cj39NefKQxXMWzDZZvG8qPptC7P2+1AuqgUBLmSY7aKTbaEp5GBiCnN0pg0A==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr18686214wrn.35.1603103177062;
        Mon, 19 Oct 2020 03:26:17 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id b15sm17435133wrm.65.2020.10.19.03.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 03:26:16 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8516: rename usb phy
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20201014162404.1312544-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <3332df44-33f1-d7b6-9c8a-e34e16ab8658@gmail.com>
Date:   Mon, 19 Oct 2020 12:26:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201014162404.1312544-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/10/2020 18:24, Fabien Parent wrote:
> The USB phy node is named usb0_phy but there is only one phy with
> 2 ports on MT8516. Rename the phy to make it more obvious it can
> also support the usb1 node.
> The usb1 node will be added in a follow-up commit.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.10-tmp/dts64

Thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi         | 2 +-
>   arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index 943c426e9aaf..50049b6c1ba7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -455,7 +455,7 @@ usb0: usb@11100000 {
>   			status = "disabled";
>   		};
>   
> -		usb0_phy: usb@11110000 {
> +		usb_phy: usb@11110000 {
>   			compatible = "mediatek,generic-tphy-v1";
>   			reg = <0 0x11110000 0 0x800>;
>   			#address-cells = <2>;
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index dfceffe6950a..8bad8faf35d2 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -195,7 +195,7 @@ usb_con: connector {
>   	};
>   };
>   
> -&usb0_phy {
> +&usb_phy {
>   	status = "okay";
>   };
>   
> 
