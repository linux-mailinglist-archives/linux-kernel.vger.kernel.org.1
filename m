Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3F42A232A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgKBCrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:47:14 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:23776 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgKBCrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:47:14 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201102024711epoutp04aba3a3af0f0c255ab0145eb51c9a6a9c~DkOsEroly2702827028epoutp042
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:47:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201102024711epoutp04aba3a3af0f0c255ab0145eb51c9a6a9c~DkOsEroly2702827028epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604285231;
        bh=VOrfLY032QgorKUQNIL2pCx5BueZFlqJC2sBo5mzyj4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DSOD3cIMNO1Y9yCIiz1NzBCZE7HbBEnCoQJW0I+u1CEPnywWWRh9yeHSKfJc0QNuV
         l6dTstkxkB0lHXGyLztjcX5fHPCGJRmz4m7n8049pXeDeSDepErpaBZSk/8yhn/j8G
         o7JODL2bGhex2eaxt8QnyYgd6DzcKXSNuly9nrAg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201102024711epcas1p3d61cadfe853c8fadc54d567059eac74c~DkOryCa3I0354103541epcas1p3y;
        Mon,  2 Nov 2020 02:47:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CPcl05PRrzMqYkp; Mon,  2 Nov
        2020 02:47:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.0D.63458.6237F9F5; Mon,  2 Nov 2020 11:47:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201102024702epcas1p19967141e12133934e780f7eddff70b92~DkOjujjq92411924119epcas1p1C;
        Mon,  2 Nov 2020 02:47:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201102024702epsmtrp156a32c9d3eefbf1fd2d80d9d5f79fc2a~DkOjt8rWi3265432654epsmtrp1d;
        Mon,  2 Nov 2020 02:47:02 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-4c-5f9f732629ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.6B.13470.6237F9F5; Mon,  2 Nov 2020 11:47:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201102024702epsmtip17fe9500470cf05a44592d6e02ce2b164~DkOjjvmav0770407704epsmtip1o;
        Mon,  2 Nov 2020 02:47:02 +0000 (GMT)
Subject: Re: [PATCH 2/2] extcon: fsa9480: Support TI TSU6111 variant
To:     Linus Walleij <linus.walleij@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ead95b16-d8c8-37b3-bc00-408068d2fbba@samsung.com>
Date:   Mon, 2 Nov 2020 12:01:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201101004357.1076876-2-linus.walleij@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmga5a8fx4g3VfNSym/FnOZHF51xw2
        i9uNK9gcmD3uXNvD5tG3ZRWjx+dNcgHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        lgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGR/n/mMreMpesWbDXMYGxg1sXYwcHBICJhL990y7
        GLk4hAR2MEpc+fOVBcL5xCjx/9IHKOcbo0Rb0zzGLkZOsI7OVRegEnsZJWa8e84E4bxnlPj0
        o48FpEpYwEWioXUimC0iEC6x79gBZhCbWUBB4te9TawgNpuAlsT+FzfYQGx+AUWJqz8eg23g
        FbCTuDmxjx3EZhFQkTj87y5YXFQgTOLkthaoGkGJkzOfgM3nFHCQeDVxGzvEfHGJW0/mM0HY
        8hLb385hhrj6I7vE3gXsELaLxOvrc6G+EZZ4dXwLVFxK4mV/G5RdLbHy5BE2kMckBDoYJbbs
        v8AKkTCW2L90MhMo8JgFNCXW79KHCCtK7PwNMZNZgE/i3dceVkj48kp0tAlBlChLXH5wlwnC
        lpRY3N7JNoFRaRaSb2Yh+WAWkg9mISxbwMiyilEstaA4Nz212LDACDmyNzGC06CW2Q7GSW8/
        6B1iZOJgPMQowcGsJMJbEzkvXog3JbGyKrUoP76oNCe1+BCjKTB8JzJLiSbnAxNxXkm8oamR
        sbGxhYmhmamhoZI47x/tjnghgfTEktTs1NSC1CKYPiYOTqkGpu6Uv0XFE37r5te/1VixtTdj
        67uoH0uen7gkavVAQ2139CK/QwurYo8E1O0JC5rW8uBYbdWamCrJmVedPkREBIvrHfE8rSL8
        nVdLseGw8cvLS56WyPWJOr8R7r2onfn5fOf0/WoBWpkMFQe/TqgLmLWNR0vCNiF7w/ow9ebO
        neGXq57c4N021+MEo/DX2tzg5G37KicxtSaZiZnnuIQ7hTKxlkf6ZtgahkfdYvX+FKW5dr/C
        pNrbQTtUs/6fVMhZoH7F+q/+jdof/hbfDfYziM464p/byeurz518YeqWi6uyjbRl9n1wSXvs
        W9F5spNZw5LPIO5pzTF/WaXHvxfOL4zet8vG6pPv5qoFMkJKLMUZiYZazEXFiQBjLKl7DAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnK5a8fx4g++LBS2m/FnOZHF51xw2
        i9uNK9gcmD3uXNvD5tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZH+f+Yyt4yl6xZsNcxgbG
        DWxdjJwcEgImEp2rLrB0MXJxCAnsZpRYeH0CK0RCUmLaxaPMXYwcQLawxOHDxRA1bxklWmfs
        ZAGpERZwkWhonQhmiwiES8xe8J4ZxGYWUJD4dW8TK0TDSUaJhh0XmEASbAJaEvtf3ADbzC+g
        KHH1x2NGEJtXwE7i5sQ+dhCbRUBF4vC/u2BxUYEwiZ1LHjNB1AhKnJz5BGwZp4CDxKuJ29gh
        lqlL/Jl3CWqxuMStJ/OZIGx5ie1v5zBPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWgODc9t9iw
        wDAvtVyvODG3uDQvXS85P3cTIzgmtDR3MG5f9UHvECMTB+MhRgkOZiUR3prIefFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeW8ULowTEkhPLEnNTk0tSC2CyTJxcEo1MBlw390x+8BskRWWs46d
        +jl94ctJT79cm8XDuO/Vjrq/WyOPRyxQye/ju3ZAfPo8x66DGg1V8apmp/bw7zpmNplbYrP+
        sXsCn39e/tof87iU6f2Zp4+XzDPxN2FbVjLV+PaVmGo2O7/nv/wV6mb92n/in/XWT/8Z191f
        WC118tDiLXp3Mi+85/Ep7t1482Dj5Yf1O966iLfHlEkX59nMCywKfbD1fsCV9Kg6s+q/ZY/y
        Av2PXXz9IuNQWWXcFfda1uWWr1OUCzZ6ef6at0w+8fRttg3puzQljRUVjJqiAn1zY3PupB4/
        bDd3vRXHh78672xzLXfW79O9G/C2xe1yv7RgU1mIxaaiH02T5q108DuoxFKckWioxVxUnAgA
        oiyan/gCAAA=
X-CMS-MailID: 20201102024702epcas1p19967141e12133934e780f7eddff70b92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201101004413epcas1p3e630dbf1581ff36176123f9f8ef15be2
References: <20201101004357.1076876-1-linus.walleij@linaro.org>
        <CGME20201101004413epcas1p3e630dbf1581ff36176123f9f8ef15be2@epcas1p3.samsung.com>
        <20201101004357.1076876-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 11/1/20 9:43 AM, Linus Walleij wrote:
> The Texas Instruments TSU6111 is compatible to the
> FSA880/FSA9480.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/extcon/extcon-fsa9480.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
> index 8405512f5199..08bdedbcdb0d 100644
> --- a/drivers/extcon/extcon-fsa9480.c
> +++ b/drivers/extcon/extcon-fsa9480.c
> @@ -364,6 +364,7 @@ MODULE_DEVICE_TABLE(i2c, fsa9480_id);
>  static const struct of_device_id fsa9480_of_match[] = {
>  	{ .compatible = "fcs,fsa9480", },
>  	{ .compatible = "fcs,fsa880", },
> +	{ .compatible = "ti,tsu6111", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, fsa9480_of_match);
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

As I replied from patch1, I'm waiting the review from DT maintainer.
And then, I'll merge it.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
