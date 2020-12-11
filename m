Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCDD2D7186
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391510AbgLKIRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:17:21 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:12668 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgLKIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:16:38 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201211081552epoutp015346f62dde32a9841d39bf1fd522ea0e~Pm3zpGQBV3107131071epoutp019
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 08:15:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201211081552epoutp015346f62dde32a9841d39bf1fd522ea0e~Pm3zpGQBV3107131071epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607674552;
        bh=Es9Z5Z3qK/5h6SMaFabTxq8a+/fzDDT109pEEthLjMg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=N6lLbpt7+nq7VblqlRVOP7GwMZyfGyVCJ6AqSC8JIkwvWaIVvM96XKHYsMklY3jNe
         75aD+yMJSC3nvAlja9RNooJh0uJR1c6JZpM0U9YMH2qq8EHTOd4L6mAV2gQ/WdgiPX
         4EuUdsvE9wH3kWc9FRwbBT+Ffwe4KSqTtRnin9L8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201211081552epcas1p1875b8e9d05475a4d87a60707e8d634ef~Pm3zdM8lC3177631776epcas1p1g;
        Fri, 11 Dec 2020 08:15:52 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CskBF6NZQz4x9Ps; Fri, 11 Dec
        2020 08:15:49 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.85.09577.1BA23DF5; Fri, 11 Dec 2020 17:15:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201211081544epcas1p2a6f26b6d464769d6961311b6027996ee~Pm3sK0Aq81370513705epcas1p2x;
        Fri, 11 Dec 2020 08:15:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201211081544epsmtrp19a2268c437eddb65c3755a58b4ee8394~Pm3sKHTTR0637106371epsmtrp1X;
        Fri, 11 Dec 2020 08:15:44 +0000 (GMT)
X-AuditID: b6c32a39-193b3a8000002569-45-5fd32ab17337
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.DB.13470.0BA23DF5; Fri, 11 Dec 2020 17:15:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201211081542epsmtip20351f2ff420f18b0b00bbf6e18f5f36e~Pm3qbsYc83029930299epsmtip2M;
        Fri, 11 Dec 2020 08:15:42 +0000 (GMT)
Subject: Re: [PATCH] regulator: max14577: Add proper module aliases strings
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2bc9dcfb-543c-96a5-0980-f8e066b788c6@samsung.com>
Date:   Fri, 11 Dec 2020 17:30:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201210112139.5370-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTX3ej1uV4gysfRS02zljPajH14RM2
        i/PnN7BbXN41h81i7ZG77A6sHptWdbJ59G1ZxejxeZNcAHNUtk1GamJKapFCal5yfkpmXrqt
        kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
        Rn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBhQnbGwy/6BZM5Kua07WNvYGxl72Lk
        5JAQMJFYsfA7YxcjF4eQwA5GiZf337BBOJ8YJW6saIDKfGOUuPJmOytMS+uK2cwQib2MEme2
        XWGBcN4zSlz4tJsFpEpYwFti3cE3QDYHh4iAv8Sl34UgNcwCTYwSH//sYQKpYRPQktj/4gYb
        iM0voChx9cdjRhCbV8BOYubJq2BxFgFVic0TroHFRQXCJE5ua4GqEZQ4OfMJ2C5OAVuJWddu
        gtnMAuISt57MZ4Kw5SW2v50DdqmEwE92ifmfJrJBvOAisW3bDUYIW1ji1fEt0NCQknjZ3wZl
        V0usPHmEDaK5g1Fiy/4LUP8bS+xfOpkJ5DNmAU2J9bv0IcKKEjt/z2WEWMwn8e5rDytIiYQA
        r0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZxaSF2YheWEWwrIFjCyrGMVSC4pz01OLDQtM
        kWN7EyM4OWpZ7mCc/vaD3iFGJg7GQ4wSHMxKIryyLJfihXhTEiurUovy44tKc1KLDzGaAgN4
        IrOUaHI+MD3nlcQbmhoZGxtbmBiamRoaKonz/tHuiBcSSE8sSc1OTS1ILYLpY+LglGpgWp+d
        /fyuxvXfNoU3nn2+L3dw28MDwV/DtO/z77vl/i35oG+FVY463/3cuRtSxGpM5PRnnCycc9b3
        RNn//fyfxO82PKk9XHCh+tscO7ZpMi8vXBCbXej74EmX7NTMzzlPHTJa8xM6X105eer3py+z
        p64L5A1yOP5CasfjhKnm1+ecnP8o/b1c1tmQnMmH7lwtKhc0UwxNcxOJmiNysuyMnOuTTY+m
        W7bP9/vC3tL05qPnq93vrk7ytugV/B1iyfko3onpWt/htV2KM3JL16hGGj0PTLcIOXBpziSv
        G+WmjiY3tpRUVM0WmndWpHeJas+BxX8Pb5RwinrUnGyndkZoH5PvSofvXKpmkjwuUk6LLZVY
        ijMSDbWYi4oTAZGZwWgXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO4GrcvxBi8+qFlsnLGe1WLqwyds
        FufPb2C3uLxrDpvF2iN32R1YPTat6mTz6NuyitHj8ya5AOYoLpuU1JzMstQifbsEroyHX/QL
        JnNUzGnbx97A2MrexcjJISFgItG6YjZzFyMXh5DAbkaJg0+eM0EkJCWmXTwKlOAAsoUlDh8u
        BgkLCbxllLj+gA/EFhbwllh38A0LiC0i4CvR2zOBEcRmFmhhlPj51Rxi5gRGiXVbt4DNZBPQ
        ktj/4gYbiM0voChx9cdjsAZeATuJmSevgsVZBFQlNk+4BhYXFQiT2LnkMRNEjaDEyZlPwJZx
        CthKzLp2kwVimbrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg8C0n7LCQts5C0zELSsoCRZRWj
        ZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnCMaGnuYNy+6oPeIUYmDsZDjBIczEoivLIs
        l+KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYFKY1pv6
        98DTV4zOB0p3pp04xHRW6K2pgKja7qYFrvunr6/uyJ21ZbKLr0hO7z7BSNfGsxfWCyh45HBJ
        vUvcceXBhyUhpcoMUZvWdt3v/eJ9X+lsS9izd3eP2do0mVy8Z81xyWvhqglyXjcM9UUVv9QE
        Phe7tk2lYVF8CrfezJ3ngtkc35y0zvm+54PGkuVfJ96SKm8/qmaweHP0uqrglxOE8lh2hUSw
        Fbzd7+KuHd3vpT3pYJNAtsRSRsfXV0OY9O6fMOg5eszff4aCAwOnZr3NvqkLrrufXFNboPjN
        PXJPSP+nLcdfTwjisfupOru0s/R67KW7OQ9Fk3Pb1xjEO4R8+9Qr9CWS9/nhdX3Lq5VYijMS
        DbWYi4oTAb/WK08AAwAA
X-CMS-MailID: 20201211081544epcas1p2a6f26b6d464769d6961311b6027996ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201210112148eucas1p287afa49e63255e3320495d480eb06965
References: <CGME20201210112148eucas1p287afa49e63255e3320495d480eb06965@eucas1p2.samsung.com>
        <20201210112139.5370-1-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 8:21 PM, Marek Szyprowski wrote:
> Add proper modalias structures to let this driver load automatically if
> compiled as module, because max14577 MFD driver creates MFD cells with
> such compatible strings.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/regulator/max14577-regulator.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
> index e34face736f4..1d78b455cc48 100644
> --- a/drivers/regulator/max14577-regulator.c
> +++ b/drivers/regulator/max14577-regulator.c
> @@ -269,3 +269,5 @@ module_exit(max14577_regulator_exit);
>  MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
>  MODULE_DESCRIPTION("Maxim 14577/77836 regulator driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:max14577-regulator");
> +MODULE_ALIAS("platform:max77836-regulator");
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
