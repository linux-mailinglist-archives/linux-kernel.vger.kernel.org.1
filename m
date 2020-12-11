Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB02D79DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393102AbgLKPuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:50:03 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34802 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393096AbgLKPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:50:00 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201211154908euoutp018c219fb01d3fbfbe71b6b0aacff346e1~PtDj_Z0192253722537euoutp01O
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:49:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201211154908euoutp018c219fb01d3fbfbe71b6b0aacff346e1~PtDj_Z0192253722537euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607701748;
        bh=DLsBHuIsxwQznb4SGq60dLHfzH/CgapbMJcC+1Ifi1M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CuSKW5r4WBrS8ebI+F2JaAneKpMTBHKY0fszW5lZnNH24HLzdKqDmdI1McCSs9iMT
         siJMLvAcBTkVfxO9KofDs/BrtmN4uXED6RnqzvEDB2T3KHMCbjdVj9Jg+qWcIpYsZY
         SXS1n1NmKboUmIvVsm2kAvVhvOWJbh7FFhe+N3bo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201211154903eucas1p21c6efdf0d994093eb86ffa3a27b53cf6~PtDe4BFsM2802728027eucas1p2s;
        Fri, 11 Dec 2020 15:49:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7D.43.27958.FE493DF5; Fri, 11
        Dec 2020 15:49:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201211154902eucas1p12a9852517ec2a514f43ecc2b13a5da86~PtDeYH7OE0222202222eucas1p1X;
        Fri, 11 Dec 2020 15:49:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201211154902eusmtrp2f44459dce8ec39b29f9ee6681258cf43~PtDeXZ9bG1125811258eusmtrp2b;
        Fri, 11 Dec 2020 15:49:02 +0000 (GMT)
X-AuditID: cbfec7f2-f15ff70000006d36-11-5fd394ef7bd6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.7C.21957.EE493DF5; Fri, 11
        Dec 2020 15:49:02 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201211154902eusmtip2efcb42ddb4b8ccc844e01ed65238e7c3~PtDdzE8FL2533625336eusmtip2G;
        Fri, 11 Dec 2020 15:49:02 +0000 (GMT)
Subject: Re: [PATCH 1/9] ARM: dts: exynos: correct PMIC interrupt trigger
 level on Artik 5
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <800ac3de-5c46-f4b6-b793-31175e27ee47@samsung.com>
Date:   Fri, 11 Dec 2020 16:49:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210212903.216728-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSFfTNdpk1qxoJyBZHYxAUVtK4jonG30T+aGKMVLQUmVYGCraho
        1EZcGxcwBLAUMQRBBqXYEkQUEqFCCKFVi7iBVaQiKBAWwSURGUeUf98995537k0egUsZvi+x
        T3uQ1mnVMTKBmFda890Z1JPqUs3vTPam7mZY+NSLgXY+lW138Cmns1hIub8+RpT1QxOfcpWb
        BVSGsxKjzlTYhdQ5Twe+SqywMhcEiuamhwKFLfek4nIJgxT91qlb+EpxaBQds+8QrZu3Mly8
        N+t9gzD+i+hIb6uDZ0AphBGJCCAXwaW3pQKWpeQtBE0fwYjEIzyAoOddqpAr+hG86b2HjTra
        ip/jXCMfQabppoArekcsqcxIhyC8yDBwX49gdW+yEQP7/Ut/MnAyCNK7v+AsC0g5GLuMf3QJ
        uRJ+uksQ6+WR0+FTspCVJ5IRYDF++zsyAequtfFYFpFLwFNhxbgnA+Belxnn2Adet2VjbC6Q
        AwSkfDfwuK3XQf9Q+1/2gs7aEiHHU2D4/qghCcF7xx0hV1xE4DqVgbip5dDs+CFgt8PJQLCU
        z2MRyNWQUreNw/HwsmsCt8N4uFqajnOyBM6flXJvzABTbdG/1EdPnuHJSGYac5lpzDWmMdeY
        /sfeQDwG+dAJ+lgNrZdr6cPBenWsPkGrCY6Mi7Wike9U/6u2rwxldfYGVyGMQFUICFzmLfl5
        0qWSSqLUiUdpXZxKlxBD66uQH8GT+UiYzNsqKalRH6SjaTqe1o12MULka8CWuvTK8JwV/vwK
        9cW5ZVunbfI0x5MNc4pbdvkfD5pfbahMq32aOKXaGej5Yd7oWu/9cijJzJw7cWbyRLcmaU/7
        cCNj8eANa3fbXuWHM8WO6FRl3OeWrA0z7a22AOWyxLzGy9FRYPHKs1k388NqTkXuTDcfb8kO
        LigP0ARFNSwsqvtaWtil8tu1UDTO8MI2fXV0aETIseqEyMDI1/FnE8OaS/y6r+zPkXwbXHOo
        e/nkA+8yK+wbDmBD9Z7F3fKyolY38n+yoC1/7aTBjsJrG9/siJ2V15H2SXE6HT3LDt3eYx0c
        7nnkO+lBpbwvLfehSxuS1N/3PKRgq1JjEL8a3KZWZsh4+r1q+Wxcp1f/BoYMQxi9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7rvplyON2j6pW+xccZ6VovrX56z
        Wsw/co7V4vz5DewW978eZbTY9Pgaq8XlXXPYLGac38dk0br3CLtF+9OXzA5cHptWdbJ53Lm2
        h81j85J6j74tqxg9Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
        t7NJSc3JLEst0rdL0MuY+/Ase8EbzoqPj86xNDBO5Ohi5OSQEDCReLLhKnMXIxeHkMBSRolv
        Z+6xQyRkJE5Oa2CFsIUl/lzrYoMoes8oceLLRKYuRg4OYYEYifvzkkDiIgJXmCRaL11hBGlg
        FtCVmP7uDdTUTkaJbWc/M4Mk2AQMJbregkzi5OAVsJP4fX8LI8ggFgFViRcT2EFMUYEkibOn
        BSEqBCVOznzCAmJzCphJPN27iQlivJnEvM0PmSFseYntb+dA2eISt57MZ5rAKDQLSfssJC2z
        kLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmA8bjv2c/MOxnmvPuodYmTiYDzE
        KMHBrCTC+7v+crwQb0piZVVqUX58UWlOavEhRlOgbyYyS4km5wMTQl5JvKGZgamhiZmlgaml
        mbGSOO/WuWvihQTSE0tSs1NTC1KLYPqYODilGpjUE//l5vf/rXpv/rzQZv2W+S5bzV+VvynJ
        2jOhp2gGw54W/QVeb5m5Jt4Trth2+qSpzmaPHY35GmK3SopuuTZrl8zu2v9dybHz/YwWHp37
        0yceSFu1uuuF46ezVusOMD+0+M76oX0WwxODKa/576/4PvHS+XMbP9t+YpC4LXNGc+fy1Nuz
        399Lnxrybctdla6bE71EW5oPPnkSWr3xwv9UG/OHzfIV98I27J0jkH7bq/Er27z8gKjUmNJl
        LCe5+2O6q2SvVcrvLilXOC7qaLtyU0ipAWvj2aXLMy5NbBZ7duDf6RUSl6xuxho4m97d9fr4
        x+LXkgrHEw7eypr43PH+hXrOPR0f+rcqn/y/RtOpQImlOCPRUIu5qDgRAOrSGpBQAwAA
X-CMS-MailID: 20201211154902eucas1p12a9852517ec2a514f43ecc2b13a5da86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201210212917eucas1p2d0bc9a3099abfc2d2c223facc86be03e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201210212917eucas1p2d0bc9a3099abfc2d2c223facc86be03e
References: <CGME20201210212917eucas1p2d0bc9a3099abfc2d2c223facc86be03e@eucas1p2.samsung.com>
        <20201210212903.216728-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.2020 22:28, Krzysztof Kozlowski wrote:
> The Samsung PMIC datasheets describe the interrupt line as active low
> with a requirement of acknowledge from the CPU.  Without specifying the
> interrupt type in Devicetree, kernel might apply some fixed
> configuration, not necessarily working for this hardware.
>
> Fixes: b004a34bd0ff ("ARM: dts: exynos: Add exynos3250-artik5 dtsi file for ARTIK5 module")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm/boot/dts/exynos3250-artik5.dtsi | 2 +-
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> index 04290ec4583a..829c05b2c405 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> @@ -79,7 +79,7 @@ &i2c_0 {
>   	pmic@66 {
>   		compatible = "samsung,s2mps14-pmic";
>   		interrupt-parent = <&gpx3>;
> -		interrupts = <5 IRQ_TYPE_NONE>;
> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&s2mps14_irq>;
>   		reg = <0x66>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

