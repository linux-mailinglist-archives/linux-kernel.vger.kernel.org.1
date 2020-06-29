Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0466D20D9C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbgF2Tud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388075AbgF2Tub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:50:31 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E796920702;
        Mon, 29 Jun 2020 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593460231;
        bh=Gv9PLMZnlHIBTdk8O+vpWP9KP6QOJHRkkviInyIDGFY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pRE1DYgdoC+D7zeA7XuI7g0EKUwKzDggaCcFUh8Yez80tWfqrygUio+UBwLy+RI4C
         /Dy2ktTmVZ24qt23e64C7C1Cv6wAwcKUrJdZNscvrAidcoSOZjDvoageMG4p8YrVXC
         5qvJmj+i6DG306rIUjaJRse+BMv8Y+J6eyP4Oga4=
Subject: Re: [PATCH 1/3] ARM: dts: exynos: Fix missing empty reg/ranges
 property regulators on Trats
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
References: <20200629193338.29540-1-krzk@kernel.org>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <03a23289-1188-db77-6c38-a7dddeac183c@kernel.org>
Date:   Mon, 29 Jun 2020 21:50:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629193338.29540-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 6/29/20 21:33, Krzysztof Kozlowski wrote:
> Remove the simple-bus compatible from a regulators node because its
> children do not have any unit addresses.  This fixes DTC warning:
> 
>      Warning (simple_bus_reg): /regulators/regulator-0: missing or empty reg/ranges property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm/boot/dts/exynos4210-trats.dts | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> index 3d791db6095c..cec413ee4490 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -31,8 +31,6 @@
>   	};
>   
>   	regulators {
> -		compatible = "simple-bus";

I think you would also need to remove the 'regulators' node altogether, 
otherwise with your change the subnodes below won't get parsed and the 
regulators will not get registered.

>   		vemmc_reg: regulator-0 {
>   			compatible = "regulator-fixed";
>   			regulator-name = "VMEM_VDD_2.8V";
> 

--
Thanks,
Sylwester
