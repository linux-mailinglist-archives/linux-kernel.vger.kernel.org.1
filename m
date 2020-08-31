Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0646F257759
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHaKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 06:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgHaKfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:35:36 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35ED020DD4;
        Mon, 31 Aug 2020 10:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598870136;
        bh=V1ZLMFYN+hd025pVnh+Yww7lnqsvYV7nIlFHgJ6wVF0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QBKfUCQSPkEfS/h6P3Sqp+d62D6FYKrtw5pPhnOmSzIKEUfeuFhiIDB7AW4vjh4cl
         7OC2WKi1VGNRtIZY/MIO9uQ5UVV9+IrnFEhW1bY/gSc9BMruuCvNktAMcyExGDJP6P
         dQ5dT6pubfosL4soPm3ebl8MPyVf0sYhA9g9qbok=
Subject: Re: [PATCH 23/33] ARM: dts: exynos: Remove empty camera pinctrl
 configuration in Odroid X/U3
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Denis GNUtoo Carikli <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20200830135200.24304-1-krzk@kernel.org>
 <CGME20200830135508eucas1p21ad0d4f6a2ef78f854fc74750db3fa2a@eucas1p2.samsung.com>
 <20200830135200.24304-23-krzk@kernel.org>
 <c9daff05-dca7-f1b1-8cfe-46b185bf60dd@samsung.com>
 <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <96651e85-c27f-3167-7b41-2ea051c25c65@kernel.org>
Date:   Mon, 31 Aug 2020 12:35:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfR8YVmBqCd5+8B2TdM_tXZbWobK0pLxXxxkrsDEMR-vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/31/20 10:38, Krzysztof Kozlowski wrote:
> On Mon, 31 Aug 2020 at 10:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> On 30.08.2020 15:51, Krzysztof Kozlowski wrote:
>>> The camera's pinctrl configuration is simply empty and not effective.
>>> Remove it to fix dtbs_check warning:
>>>
>>>     arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> I think that this was intentional to properly enable support for
>> mem-2-mem mode in Exynos4-IS (FIMC), but I'm not sure what are the
>> default values if no pinctrl properties are provided. Sylwester, could
>> you comment?
> 
> Indeed it could be intentional... I see now errors:
> [   33.752203] s5p-fimc-md soc:camera: Failed to get pinctrl: -19
> 
> I wonder why getting an empty pinctrl is needed... maybe the driver
> should accept missing pinctrl?

It might have been better to have the pinctrl properties optional, as there
might be boards without the image sensor attached and FIMC could still be 
used in memory-to-memory mode, as Marek pointed out. But it seems too late 
now to change that. The binding defines the pinctrl properties as required 
(Documentation/devicetree/bindings/media/samsung-fimc.txt) and we need to
keep them in dtses.

--
Regards,
Sylwester
