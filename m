Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7ED2A6431
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgKDMYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:24:21 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53080 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDMYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:24:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201104122409euoutp01c2e9f2a0fa7d1d5cadad84a7c6b2f400~ETZBSt83h2615426154euoutp01f
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 12:24:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201104122409euoutp01c2e9f2a0fa7d1d5cadad84a7c6b2f400~ETZBSt83h2615426154euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604492649;
        bh=gNAVfzFmOeobVChNyMtYG+v5xd03G54CGeOD9WGCmLI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YI7BphXKCoFPDDyBCpD8lSlaQSUoL5n0T7q7JQfgy5vI/Zv4hm2xzN6BboP8FZnbU
         zFRhdpvsm/PE97lO2g6OymQp4BRW+Qz1gm/498sRY5TuXLQoXMGuO6mVMPsqrwlfLR
         QePJvg3LT7pRTZY9gzpBQLHlu0+fB8OorQVP+D1A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201104122403eucas1p2ce65adcd61df8984a196e8af8b093254~ETY75KKpQ2571425714eucas1p24;
        Wed,  4 Nov 2020 12:24:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.3C.06318.36D92AF5; Wed,  4
        Nov 2020 12:24:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201104122403eucas1p1d3c5bb3e42ef306c6b9b46a5d30cb475~ETY7h43nR0150101501eucas1p1s;
        Wed,  4 Nov 2020 12:24:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201104122403eusmtrp10eebf657a62c6fac526661b357c353ca~ETY7hSN5u0837908379eusmtrp1B;
        Wed,  4 Nov 2020 12:24:03 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-86-5fa29d63c7eb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.56.06017.36D92AF5; Wed,  4
        Nov 2020 12:24:03 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201104122402eusmtip17ed41908c69de8265f61076ec6ec0aff~ETY7FehHM3263732637eusmtip1X;
        Wed,  4 Nov 2020 12:24:02 +0000 (GMT)
Subject: Re: [PATCH] ARM: dts: exynos: Assign a fixed index to mmc devices
 on ODROID XU3/4 boards
To:     Markus Reichl <m.reichl@fivetechno.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <4ac01b71-e806-18c8-13ce-6acdcc1a3b41@samsung.com>
Date:   Wed, 4 Nov 2020 13:24:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104100855.2337-1-m.reichl@fivetechno.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7rJcxfFG6y9r2Ex/8g5Vovz5zew
        W2x6fI3V4vKuOWwWM87vY7J4eeQHo0Xr3iPsDuwet+7Ue2xa1cnmsXlJvcfnTXIBLFFcNimp
        OZllqUX6dglcGQ3b5zMV/OeueLbgD1MD41XOLkZODgkBE4k1N3YzdzFycQgJrGCUWH3xIyOE
        84VRYkrfFBYI5zOjxLZdtxlhWp68PwiVWM4o8fj2TyYI5z2jxNS5DewgVcICyRI72iczgdgi
        AqUS7bO+gC1hFmhnlDg15wZYEZuAoUTX2y42EJtXwE7i2sEnYCtYBFQkjn84B2aLCiRJ/P38
        hxmiRlDi5MwnLCA2p4C1xOq3m8DizALyEtvfzoGyxSVuPZkPdpGEwDJ2ibezTgM1cAA5LhJ3
        N2pDvCAs8er4FnYIW0bi9OQeFoj6ZkaJh+fWskM4PYwSl5tmQD1tLXHn3C82kEHMApoS63fp
        Q4QdJdafewc1n0/ixltBiBv4JCZtm84MEeaV6GgTgqhWk5h1fB3c2oMXLjFPYFSaheSzWUi+
        mYXkm1kIexcwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITDyn/x3/uoNx35+kQ4wC
        HIxKPLwHti2MF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNF
        L2OFBNITS1KzU1MLUotgskwcnFINjKuMpTP8OvkL50VmGqZ32kpPXekxtzPkmJ5u6bNPFSsu
        i0+fsWL9l7BvMmJ6LDMba9m93mzdcYNXOGv1CZZ9m5ub3i3vLT1Znmczh/+Nn87qYuODBttS
        l4mnN921a1N4urD7XmBXzOq3QZW/N7ozcIo7NX7gPJXb8O6F3uwJysHOay40hEVPV2Ipzkg0
        1GIuKk4EAOFm7r44AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7rJcxfFGxzdwmcx/8g5Vovz5zew
        W2x6fI3V4vKuOWwWM87vY7J4eeQHo0Xr3iPsDuwet+7Ue2xa1cnmsXlJvcfnTXIBLFF6NkX5
        pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GQ3b5zMV/Oeu
        eLbgD1MD41XOLkZODgkBE4kn7w+ydDFycQgJLGWUOLVwDwtEQkbi5LQGVghbWOLPtS42iKK3
        jBKHrsxgBkkICyRLTN90CaxIRKBUYteeNWCTmAXaGSXuvJ0N1dHHKPFn0TmwsWwChhJdb0FG
        cXLwCthJXDv4hBHEZhFQkTj+4RyYLSqQJPHywlQmiBpBiZMzn4D1cgpYS6x+uwlsM7OAmcS8
        zQ+hbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGRXnFibnFp
        Xrpecn7uJkZgrG079nPLDsaud8GHGAU4GJV4eA9sWxgvxJpYVlyZe4hRgoNZSYTX6ezpOCHe
        lMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OB6aBvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJ
        JanZqakFqUUwfUwcnFINjB1bTjoy22lssPxXlSGX8W8R89Z7zRJqUxXXbDN+ukvs2ecjdSwe
        Af2bAled+MZ859RyHx7DlLOKZundrxsLUkryBMzXd3mp+Ni73mRV/qf/80fTEonI10mhM6/c
        cTi265ZFmzjr+SONigHNCz4pedz+wh2TklN+hOFfTV5148bFIeLh2QxBSizFGYmGWsxFxYkA
        8WalVcsCAAA=
X-CMS-MailID: 20201104122403eucas1p1d3c5bb3e42ef306c6b9b46a5d30cb475
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201104105152eucas1p28eb6ca629a685f24a2463c72898fdbc5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201104105152eucas1p28eb6ca629a685f24a2463c72898fdbc5
References: <CGME20201104105152eucas1p28eb6ca629a685f24a2463c72898fdbc5@eucas1p2.samsung.com>
        <20201104100855.2337-1-m.reichl@fivetechno.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On 04.11.2020 11:08, Markus Reichl wrote:
> Recently introduced async probe on mmc devices can shuffle block IDs.
> Pin them to fixed values to ease booting in evironments where UUIDs
> are not practical. Use newly introduced aliases for mmcblk devices from [1].
>
> [1]
> https://patchwork.kernel.org/patch/11747669/

Wow, this is a long standing issue, called by others 'a feature'. Good 
that this has been finally solved.

> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index e35af40a55cb..91d2840ac8ca 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -13,6 +13,11 @@
>   #include "exynos5422-odroid-core.dtsi"
>   
>   / {
> +	aliases {
> +		mmc0 = &mmc_2;
> +		mmc1 = &mmc_0;

Frankly, I would keep the MMC numbers the same as in u-boot and 
datasheets. 0 for the build-in eMMC and 2 for the SD-card. This would be 
much more natural. On the other hand, I would agree to do it differently 
only on Odroid HC1/HD2/MC1, which don't have build-in eMMC - just use 0 
there for the SD-card.

> +	};
> +
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   		pinctrl-names = "default";

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

