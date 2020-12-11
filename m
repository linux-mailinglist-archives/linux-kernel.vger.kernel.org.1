Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DE42D79E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393403AbgLKPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:51:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34855 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393129AbgLKPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:50:16 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201211154925euoutp01f093f3b340fec5a8ed5ee88678d5c9e4~PtDzA-yvt2241222412euoutp01W
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:49:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201211154925euoutp01f093f3b340fec5a8ed5ee88678d5c9e4~PtDzA-yvt2241222412euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607701765;
        bh=eiKoUfJOSAjV/F3zyRNsA6hgRZkJZixmeT8RGGwUIQw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oaRRXkp+n8ppM8RvVaXT1WNtwcHrVjHTJuFIbo5zQQO8RZjxiit5CAgx11+gPOaIX
         xvp3rM7AABUVb30xaZ3d3Hqhn+xWUl6Tet4CRxvGL+NdudydNYSrTZnZHffeYKIANT
         Yw9I4jpQdudzSASt7RAn3No+J52MHCU+Jq3tePEU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201211154915eucas1p2383bdedb6ab8c65b61a0205840248003~PtDqM1K973270532705eucas1p2p;
        Fri, 11 Dec 2020 15:49:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 45.53.27958.BF493DF5; Fri, 11
        Dec 2020 15:49:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201211154915eucas1p127e8cf673bca639cb2e8a07d2985fd63~PtDp4LO8o2253322533eucas1p16;
        Fri, 11 Dec 2020 15:49:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201211154915eusmtrp1c3c741945ad1f7260cd6971856eea7dc~PtDp3fdI82293422934eusmtrp1x;
        Fri, 11 Dec 2020 15:49:15 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-33-5fd394fb8e43
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.7A.16282.BF493DF5; Fri, 11
        Dec 2020 15:49:15 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201211154914eusmtip164d1138cb1e6fd73ae7ad7eb73e2d72a~PtDpRCR7S1399913999eusmtip1f;
        Fri, 11 Dec 2020 15:49:14 +0000 (GMT)
Subject: Re: [PATCH 3/9] ARM: dts: exynos: correct PMIC interrupt trigger
 level on Rinato
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <611b44f2-759a-35f9-bc72-a8d6c1c9c60f@samsung.com>
Date:   Fri, 11 Dec 2020 16:49:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210212903.216728-3-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7q/p1yON9g2V9pi44z1rBbXvzxn
        tZh/5ByrxfnzG9gt7n89ymix6fE1VovLu+awWcw4v4/JonXvEXaL9qcvmR24PDat6mTzuHNt
        D5vH5iX1Hn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJVx8dwF9oL1nBW9U16wNDDeYe9i5OSQ
        EDCR6Jt0Gcjm4hASWMEosWfeYjYI5wujxIOv/5ghnM+MEm/3bWeBaXl99ANUYjmjxIaVK6Cc
        j4wSHacXMIJUCQtES2zqeMkCkhARuMIkcWRnLxtIgllAV2L6uzfMIDabgKFE19suoDgHB6+A
        ncTbO9kgYRYBVYlNtz+ClYgKJEms7/oB1sorIChxcuYTsCs4BcwkFvZMYYQYKS+x/e0cZghb
        XOLWk/lMIHslBD5wSFz9Mg3qbBeJzxevMELYwhKvjm+BhoCMxOnJPSwQDc2MEg/PrWWHcHoY
        JS43zYDqsJa4c+4X2KXMApoS63fpQ4QdJVb37WcCCUsI8EnceCsIcQSfxKRt05khwrwSHW1C
        ENVqErOOr4Nbe/DCJeYJjEqzkLw2C8k7s5C8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJucWl
        eel6yfm5mxiBKer0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd7f9ZfjhXhTEiurUovy44tKc1KL
        DzFKc7AoifOumr0mXkggPbEkNTs1tSC1CCbLxMEp1cA07fv/qkkP/px/s7vGZOPZNfW66son
        k25yXDmj3+9qHnB4g+rev5L3th+axNB6t1VNK/VzbPoVyTXVkuenm/ufCf4SvCRA1aJD9NPn
        cv4T39YnCP+OU3ExbGA6Hty31W5/xdLf3lMDrMqnWX6evaHt7OUzpx5ErhB3nrBOLOMiq3tE
        j721Iqtzn5Us1/J5P3USxHietPy7tKl5lf0Ws6pdCg/9Lf5c+7DR34TDwz0osZD70plJxs73
        K3ZNu/fr+pXbrWpZB+SSlf1vRH3dpyJwfPlVzuje0ubC54Jr/FtjN3POfRh67PvN1i9aTsff
        +GkdZNtnxJly9fLqTaHufoJ3J96c9en2PeagA6fel4gzKrEUZyQaajEXFScCAEb5EiDAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7q/p1yON3h8kdVi44z1rBbXvzxn
        tZh/5ByrxfnzG9gt7n89ymix6fE1VovLu+awWcw4v4/JonXvEXaL9qcvmR24PDat6mTzuHNt
        D5vH5iX1Hn1bVjF6fN4kF8AapWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqk
        b2eTkpqTWZZapG+XoJdx8dwF9oL1nBW9U16wNDDeYe9i5OSQEDCReH30A3MXIxeHkMBSRonX
        Pb9YIBIyEienNbBC2MISf651sUEUvWeUmPHmJDNIQlggWmJTx0sWkISIwBUmidZLVxhBEswC
        uhLT372BGruVUWLHj6dgo9gEDCW63oKM4uDgFbCTeHsnGyTMIqAqsen2R2aQsKhAksTZ04Ig
        YV4BQYmTM5+AHcQpYCaxsGcK1HgziXmbHzJD2PIS29/OgbLFJW49mc80gVFoFpL2WUhaZiFp
        mYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAiNx27OeWHYwrX33UO8TIxMF4iFGC
        g1lJhPd3/eV4Id6UxMqq1KL8+KLSnNTiQ4ymQO9MZJYSTc4HpoS8knhDMwNTQxMzSwNTSzNj
        JXFekyNr4oUE0hNLUrNTUwtSi2D6mDg4pRqYQuVvthu7zZi0u2TOdP/ssxVz9bInmjZPn/b2
        y/H9AamHeH6y8yif6WWpYZyvIay388LCyil7a6S0pDgdeA5wzu44kZHXraLP4Xr60lW3j8KN
        E/ViTsaedlvwdauOVWfqeWHBtP66lRn8aXr8nvsDD+/iWKM/d/+KM6k7pr9hXrrU+O4LruML
        ri7nD2qvt1tc2ZPJdqumg22m0Lo++7Klvdd9QlpulvldP8jdtmtN6XO+Hz5zN15ITnmVV284
        /YLCk2m2jBmrfjot8r4aff/L7sMbVz9geBiSeSR+mWCNx9Kf6QmvnrzoXqN74JRIHJN9Qzab
        wy4lt3t/JaY99N0m87ErPCRoy5clrBxqhy6xKbEUZyQaajEXFScCAAsdQjNRAwAA
X-CMS-MailID: 20201211154915eucas1p127e8cf673bca639cb2e8a07d2985fd63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201210212922eucas1p117b0b0d2295642062dcdd98f2de18d76
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201210212922eucas1p117b0b0d2295642062dcdd98f2de18d76
References: <20201210212903.216728-1-krzk@kernel.org>
        <CGME20201210212922eucas1p117b0b0d2295642062dcdd98f2de18d76@eucas1p1.samsung.com>
        <20201210212903.216728-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.2020 22:28, Krzysztof Kozlowski wrote:
> The Samsung PMIC datasheets describe the interrupt line as active low
> with a requirement of acknowledge from the CPU.  Without specifying the
> interrupt type in Devicetree, kernel might apply some fixed
> configuration, not necessarily working for this hardware.
>
> Fixes: faaf348ef468 ("ARM: dts: Add board dts file for exynos3250-rinato")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm/boot/dts/exynos3250-rinato.dts | 2 +-
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
> index a26e3e582a7e..d64ccf4b7d32 100644
> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
> @@ -270,7 +270,7 @@ &i2c_0 {
>   	pmic@66 {
>   		compatible = "samsung,s2mps14-pmic";
>   		interrupt-parent = <&gpx0>;
> -		interrupts = <7 IRQ_TYPE_NONE>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
>   		reg = <0x66>;
>   		wakeup-source;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

