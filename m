Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22332D387D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgLIB41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:56:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32074 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLIB41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:56:27 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201209015543epoutp035ecef0cf7a286b54751ebe57536e70b1~O6ZUmPjVT0561905619epoutp03C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:55:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201209015543epoutp035ecef0cf7a286b54751ebe57536e70b1~O6ZUmPjVT0561905619epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607478943;
        bh=rKPdRn8+8aCa+zS2qeZmcogWqauBTSK/4fGUyOr3En0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BG6SlueyK51bvRO5kyc9Z141cTAiTM4N02QktbMUxP4OoAkLYQfCVCY1DI4pQB/aD
         DniwrZTrN3Qt3rTQ1w8mOiId0ZZAPG+ExmITBJCExCi1g7Ic2QBzleHIi+wuAZbV2J
         ZXHkNn3Tj8oWn/tOdKRWx9oOeCHs79Y0N0jSb8Bo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201209015543epcas1p1330363f8ff032c8a7b06ee94604603ce~O6ZT2ySju2430224302epcas1p1J;
        Wed,  9 Dec 2020 01:55:43 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CrKrX5Z1cz4x9QD; Wed,  9 Dec
        2020 01:55:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.67.63458.B9E20DF5; Wed,  9 Dec 2020 10:55:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201209015539epcas1p3b0c37736fcbf916c7991ec06f778fd1f~O6ZQRvCXI3110531105epcas1p3X;
        Wed,  9 Dec 2020 01:55:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201209015539epsmtrp263361ea6269fe1fefa9f2e0eb3b3bb98~O6ZQRKx6H1735617356epsmtrp2h;
        Wed,  9 Dec 2020 01:55:39 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-8e-5fd02e9b045c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.F3.13470.B9E20DF5; Wed,  9 Dec 2020 10:55:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201209015538epsmtip2d5e5eccba43d1533dc97ea1c1fc25dfd~O6ZQCd3322067720677epsmtip2I;
        Wed,  9 Dec 2020 01:55:38 +0000 (GMT)
Subject: Re: [PATCH] extcon: max77693: Fix modalias string
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2c155bb1-b356-4fec-bb2a-2ef52a0abec4@samsung.com>
Date:   Wed, 9 Dec 2020 11:10:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201208133627.10699-1-m.szyprowski@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTV3e23oV4g2sHzC02zljPanH+/AZ2
        i8u75rBZrD1yl93iduMKNgdWj02rOtk8+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtj6+nZzAU3OSq+nHvK3sC4g72L
        kZNDQsBE4uma+WxdjFwcQgI7GCXmf5rMAuF8YpTYvvApVOYbo0TjhWlMMC3zXy5ihEjsZZS4
        9LiVHcJ5zyjxYvIbNpAqYQEriSctb4ASHBwiAv4Sl34XgtQwC3QxSuy+0gY2iU1AS2L/ixtg
        9fwCihJXfzxmBLF5BewktrS9YAaxWQRUJFZsfQdWIyoQJnFyWwtUjaDEyZlPWEBsTqD6Te03
        weLMAuISt57MZ4Kw5SW2v53DDLJYQqCRQ+LB0ptsEC+4SFzofAH1jrDEq+NboKEhJfH53V6o
        mmqJlSePsEE0dzBKbNl/gRUiYSyxf+lkJpDPmAU0Jdbv0ocIK0rs/D0X6gg+iXdfe1hBSiQE
        eCU62oQgSpQlLj+4C7VWUmJxeyfbBEalWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwIj
        5OjexAhOj1pmOxgnvf2gd4iRiYPxEKMEB7OSCK+a1Nl4Id6UxMqq1KL8+KLSnNTiQ4ymwACe
        yCwlmpwPTNB5JfGGpkbGxsYWJoZmpoaGSuK8f7Q74oUE0hNLUrNTUwtSi2D6mDg4pRqYFupm
        bJa7vO1Aa38LX/PfvG2pguX3H8b88rj0v3FVQMDqDy5ZTlH7ZEqy/3errd5SYnwisv+i2gFr
        DbubFboTfVPXzJquvG/+F/kv++qTOW7PWX2vWbz7y1ohvvY+ZteFpkorDWY1LFZjj9V1vvXc
        cMv05+12xbfWrLv5JGzudRczgx3zJQQKPk5Uyz9027Od9XnYk2NJrez7OuyL9DeYXtAz11AI
        t+7i0Ai6ELS2vNH11GxbAek/f0W/S70S23Fm1fszN9zTXHg2K8VlyO9/cKzvcXHApXObd1ae
        Y0rnNPuiI3JzMsde77aFWYEzl77lq/bjyNB/3/u85PkE/qvOx14+SCuZKqRocv372eumSizF
        GYmGWsxFxYkAvsKerBgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvO5svQvxBss7WSw2zljPanH+/AZ2
        i8u75rBZrD1yl93iduMKNgdWj02rOtk8+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2Pr6dnM
        BTc5Kr6ce8rewLiDvYuRk0NCwERi/stFjF2MXBxCArsZJRY8WcMKkZCUmHbxKHMXIweQLSxx
        +HAxRM1bRolph26xgdQIC1hJPGl5AzZIRMBXordnAtggZoEeRokp06YzQXRMZJTomTeRCaSK
        TUBLYv+LG2Dd/AKKEld/PGYEsXkF7CS2tL1gBrFZBFQkVmx9B1YjKhAmsXPJYyaIGkGJkzOf
        sIDYnED1m9pvgvUyC6hL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYzCs5C0z0LSMgtJyywkLQsY
        WVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHipbmDsbtqz7oHWJk4mA8xCjBwawk
        wqsmdTZeiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqYC
        J9YJXibLtrqEbtjHcNHzs1mum1bFYolfb+pOPlpTbKIwwVPz0GzxqIQ/J3R/e33cXOy33MQy
        Z8+k1p6vGlWXvHyfTEiQWnM03UY+5KbCcY2Vj2SvpkYqBCjd48hz93nhMEe7+sNGWR+mtZND
        n/ruLLluHBC+Pfn17r5kp9hLJvXPzus23tFef/jZ/g0WJasL2R64zVM9uOXzstO/orvv1E1a
        dlr6/yJ51SeJm4sX/5nK91OZyVr3e5zebob32340Xv47o7iCWy7mxkmhwNAvXuZnmeqzZxz5
        LSAU+NNsS+Rq6edLmKfNPLyyKWnrnwOCm9flbeSe+PLnEY2wGSzHv2d9WGkq0jwnbPeRIlcH
        JZbijERDLeai4kQAqio3FwMDAAA=
X-CMS-MailID: 20201209015539epcas1p3b0c37736fcbf916c7991ec06f778fd1f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201208133637eucas1p2e2264886ce4641171ec72fa4ab962d14
References: <CGME20201208133637eucas1p2e2264886ce4641171ec72fa4ab962d14@eucas1p2.samsung.com>
        <20201208133627.10699-1-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 10:36 PM, Marek Szyprowski wrote:
> The platform device driver name is "max77693-muic", so advertise it
> properly in the modalias string. This fixes automated module loading when
> this driver is compiled as a module.
> 
> Fixes: db1b9037424b ("extcon: MAX77693: Add extcon-max77693 driver to support Maxim MAX77693 MUIC device")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max77693.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
> index 4a410fd2ea9a..92af97e00828 100644
> --- a/drivers/extcon/extcon-max77693.c
> +++ b/drivers/extcon/extcon-max77693.c
> @@ -1277,4 +1277,4 @@ module_platform_driver(max77693_muic_driver);
>  MODULE_DESCRIPTION("Maxim MAX77693 Extcon driver");
>  MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:extcon-max77693");
> +MODULE_ALIAS("platform:max77693-muic");
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
