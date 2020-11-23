Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405C22BFF48
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgKWE54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:57:56 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:59064 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgKWE5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:57:55 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201123045751epoutp025d1fc44e3b722a7eecb8dacecb0feea1~KCjxgvtAX0875208752epoutp02L
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 04:57:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201123045751epoutp025d1fc44e3b722a7eecb8dacecb0feea1~KCjxgvtAX0875208752epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606107471;
        bh=4aSo5Uy3nwbJbW9e6zyw1okIj6bqxFiOvJk4YRbbmf4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l4EZ6P1FrtAch7jPVRNkqZBJqha3CYLgU4TLAprBWPaF39dKAu8265U/vH3Qm52Lx
         oFcLpHXm/PVSAxgrc2BGaE5/g5eN9Zqc6Pc8wa9vXyQd5qy81cN6updNLAL771TczP
         ljhRW1sgnmUdMjMUtzQSnfjnQ0IAGgdp4Bgcoz+k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201123045751epcas1p1dfa5379106d822b799521cea039aa0f1~KCjxL1J-o2054120541epcas1p1Y;
        Mon, 23 Nov 2020 04:57:51 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CfZf44QF3zMqYkl; Mon, 23 Nov
        2020 04:57:48 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.22.09582.A414BBF5; Mon, 23 Nov 2020 13:57:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201123045745epcas1p1ba89f8c729465c024bbb404cc211f12e~KCjsTjR5a2054120541epcas1p1M;
        Mon, 23 Nov 2020 04:57:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201123045745epsmtrp178c362f4fa6a97c915dd36a205aecc1e~KCjsS7Z9x2846328463epsmtrp1v;
        Mon, 23 Nov 2020 04:57:45 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-d1-5fbb414a57f9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.F0.13470.9414BBF5; Mon, 23 Nov 2020 13:57:45 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201123045745epsmtip20fc7679368108e854548adf27070ddf2~KCjsF1R4w2724327243epsmtip2q;
        Mon, 23 Nov 2020 04:57:45 +0000 (GMT)
Subject: Re: [PATCH 09/16] mfd: max77686: drop of_match_ptr from
 of_device_id table
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d8812dd1-1912-edac-d2a7-eb2462ab1923@samsung.com>
Date:   Mon, 23 Nov 2020 14:12:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201120162133.472938-9-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQNfLcXe8wYZvFhYbZ6xntTh/fgO7
        xf2vRxktLu+aw+bA4rFpVSebx51re9g8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtj5aM/7AX7OSvmL77M1sB4lb2L
        kYNDQsBEomuHZxcjF4eQwA5GiefLmpkhnE+MEq+bVjJCON8YJRoe/AByOME6Xl9sgErsZZQ4
        96kbynnPKLF70lImkCphgVCJK21XwGwRgWyJ9vl/mEFsZgELia1bV7OD2GwCWhL7X9xgA7H5
        BRQlrv54zAhyE6+AnUTzcXWQMIuAqsT6o3NZQGxRgTCJk9tawI7gFRCUODnzCQtIOaeAmcSM
        5foQ08Ulbj2ZzwRhy0s0b50N9o2EwF92iZvXtrNDPOAicfX/EmYIW1ji1fEtUHEpiZf9bVB2
        tcTKk0fYIJo7GCW27L/ACpEwlti/dDITyGJmAU2J9bv0IcKKEjt/z2WEWMwn8e5rDyskeHkl
        OtqEIEqUJS4/uMsEYUtKLG7vZJvAqDQLyTezkLwwC8kLsxCWLWBkWcUollpQnJueWmxYYIwc
        15sYwYlRy3wH47S3H/QOMTJxMB5ilOBgVhLhbZXbGS/Em5JYWZValB9fVJqTWnyI0RQYvhOZ
        pUST84GpOa8k3tDUyNjY2MLE0MzU0FBJnPePdke8kEB6YklqdmpqQWoRTB8TB6dUA9PpHwGy
        ul4P/TOvCpgsXTjt/v1P67f5nFnwZUGNm0bcR5N0vegzN8Sktynt/X5WIty5Tzf4rvGzkHXX
        emYe0Sw4ISZWekBYedmptzMEOZX2C1wvZ3xUuytNpFesYmr/YolARp/kS3b6D82yn3x5qf0i
        WCXAdkaA7yHzHIZLgiZ9p4r17aO3Wad9lLU9sNS97EcJr9Zqb2Z1o4/RLT5O6/4F8ngnvs8T
        Xcl0pS38xF+jjltO4uumMNZvLZdIl43dNt1LU8xu8WmB/XHzhJaaW8i9SZ/w58VJyR3KR+6o
        3jkq2C1wUTpIxXrps8s7bvuEfLxzYMGSOxuOJc3XueNzV3COwWOl7a9sRGfdDQsyPa3EUpyR
        aKjFXFScCAAzppGLFQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvK6n4+54g5ufTCw2zljPanH+/AZ2
        i/tfjzJaXN41h82BxWPTqk42jzvX9rB59G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8bKR3/Y
        C/ZzVsxffJmtgfEqexcjJ4eEgInE64sNjCC2kMBuRom1L/Uh4pIS0y4eZe5i5ACyhSUOHy6G
        KHnLKHHsQCqILSwQKvGg7SkrSImIQLbExMv+IGFmAQuJrVtXA03nAirfyijxYNEvJpAEm4CW
        xP4XN9hAbH4BRYmrPx4zgvTyCthJNB9XBwmzCKhKrD86lwXEFhUIk9i55DFYK6+AoMTJmU9Y
        QMo5BcwkZizXh1ilLvFn3iVmCFtc4taT+UwQtrxE89bZzBMYhWch6Z6FpGUWkpZZSFoWMLKs
        YpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjg4tzR2M21d90DvEyMTBeIhRgoNZSYS3
        VW5nvBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeG4UL44QE0hNLUrNTUwtSi2CyTBycUg1MQbPZ
        ZdXYu3Yff2O59tCfac/cjH7euTNj2dfbM+corE9cNlFv4fTrRx9PSjmQrak4Mf2pCUvDZ2+j
        quqgAMUVhjez1RvlZ5U+iN/28YSA8KS5l55JdcgorxR9H+o8+4KPl+iKLclzG3bzn/R4qX/m
        iuipe5KWP93mTnm5cfLy5df3zrhrZ7nqi05t53PNsFVWzxtWzGXXNiny8LZL3FKsqmj9dtXy
        S3N2MPLmdpQLpdgp76hN/CFpwlC9JU3Qyl3x9ILCbffi7dc2zH1kbP5Oy8Gyy8C/avP9Hzev
        iP7JCmx0jZm+ne2JcdrX6bkbT+uyTJbl+l2dMqfjRU/xLoa3z569dpwQ9LDoI+ORle+kTJVY
        ijMSDbWYi4oTAcqHjEn9AgAA
X-CMS-MailID: 20201123045745epcas1p1ba89f8c729465c024bbb404cc211f12e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201120162209epcas1p1fadb15044c554d5d65134167e0e25888
References: <20201120162133.472938-1-krzk@kernel.org>
        <CGME20201120162209epcas1p1fadb15044c554d5d65134167e0e25888@epcas1p1.samsung.com>
        <20201120162133.472938-9-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 11/21/20 1:21 AM, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):
> 
>   drivers/mfd/max77686.c:148:34: warning: ‘max77686_pmic_dt_match’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/max77686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
> index 71faf503844b..2ad554b921d9 100644
> --- a/drivers/mfd/max77686.c
> +++ b/drivers/mfd/max77686.c
> @@ -270,7 +270,7 @@ static struct i2c_driver max77686_i2c_driver = {
>  	.driver = {
>  		   .name = "max77686",
>  		   .pm = &max77686_pm,
> -		   .of_match_table = of_match_ptr(max77686_pmic_dt_match),
> +		   .of_match_table = max77686_pmic_dt_match,
>  	},
>  	.probe_new = max77686_i2c_probe,
>  };
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
