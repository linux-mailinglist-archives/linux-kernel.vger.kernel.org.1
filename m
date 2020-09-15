Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498F7269AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgIOBFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:05:43 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54722 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgIOBFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:05:42 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200915010538epoutp02394691f3b0bef55288cbccfd9fcf495b~0z4UXgESl0874808748epoutp02N
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:05:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200915010538epoutp02394691f3b0bef55288cbccfd9fcf495b~0z4UXgESl0874808748epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600131938;
        bh=7cG9MyWGNwhBGZW4n3v7v7+PSj/Cs4aYSzQytH3+M1c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lqBhElr6A4KvCCkAVQjnhXzjEm7cY/FPQ0ye9dc/FohioKV8sS6NrFGGun75WEr1D
         Y9B8IwpQZv3rQioUMPW+QmGea4r8HSq5UNUj4waAalj9oZ+4XVWSStql9UIfbIsAjW
         TgxcJcsSCh6awRau4X+q2EQcyykhBAn0puq56oJI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200915010536epcas1p2c42d3884a5b8706df0f1fef293ce5797~0z4SiGtWv0119101191epcas1p2Z;
        Tue, 15 Sep 2020 01:05:36 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Br4lx6RsjzMqYks; Tue, 15 Sep
        2020 01:05:33 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.28.29173.953106F5; Tue, 15 Sep 2020 10:05:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200915010529epcas1p34e3c68a606252fd079a8c72055b1e958~0z4MGFYXh0370203702epcas1p3A;
        Tue, 15 Sep 2020 01:05:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200915010529epsmtrp15aad051a12a55fb29e4887e4d7227b86~0z4MFSq4B1118711187epsmtrp1b;
        Tue, 15 Sep 2020 01:05:29 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-2f-5f601359ded1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.B2.08303.953106F5; Tue, 15 Sep 2020 10:05:29 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200915010528epsmtip18bae177a6c5b134aaa6762c3fd0da5a8~0z4Ly_myB0862308623epsmtip1x;
        Tue, 15 Sep 2020 01:05:28 +0000 (GMT)
Subject: Re: [PATCH 0/3] extcon: Add Type-C Virtual PD
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ce889395-d4f8-b8bb-0288-54f3628d8a02@samsung.com>
Date:   Tue, 15 Sep 2020 10:17:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200914231533.GA429337@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmvm6kcEK8wbX7Rhbzj5xjtfj/6DWr
        xZdNE9gslk/Yx2ax6fE1VovLu+awWXx68J/Z4nbjCjaL/3t2sFuseLuU2YHLY+3H+6wem1Z1
        snlsXlLvsXi5oUffllWMHtuvzWP2+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xtHWVvaCi8IVW7fMYG5g3MffxcjJISFgIrH/
        RQ97FyMXh5DADkaJ7XOfMEM4nxgl+jbPZoNwPjNKbNqzghmmZVH3AxaIxC5Gibnn9rJCOO8Z
        JTr3XGcDqRIWMJPY/fMhK4gtIlAn8WjBSbAiZoEvjBJfjt1hB0mwCWgBbb8B1sAvoChx9cdj
        xi5GDg5eATuJXWfBDmQRUJX48GAXE4gtKhAmcXJbCyOIzSsgKHFy5hMWEJtTQEdiQu8hsF3M
        AuISt57MZ4Kw5SWat84G+0dC4ACHxILtjxkhXnCRePLzMRuELSzx6vgWdghbSuJlfxuUXS2x
        8uQRNojmDkaJLfsvsEIkjCX2L53MBHIos4CmxPpd+hBhRYmdv+cyQizmk3j3tYcVpERCgFei
        o00IokRZ4vKDu0wQtqTE4vZOtgmMSrOQvDMLyQuzkLwwC2HZAkaWVYxiqQXFuempxYYFxsjR
        vYkRnHS1zHcwTnv7Qe8QIxMH4yFGCQ5mJRHeA43x8UK8KYmVValF+fFFpTmpxYcYTYEBPJFZ
        SjQ5H5j280riDU2NjI2NLUwMzUwNDZXEeR/eUogXEkhPLEnNTk0tSC2C6WPi4JRqYFr+xnD6
        4zYPju+dWz8573Zd//rC/QkF8Rw1Fa8eH+vLFZr1zepo9tyHu//G2rGGy6y0N5eyDJ7Gu0Hx
        IHvyjN4V25LP+fjesip0tK188LXZb8nnv5+7jwg8t6mLlBGrEpLce2uxX3hRg2TVwa7j19xY
        nHQni6uZXfasfJiyMX+y6Oq4MwtTfz2Kq7/f2bnlSvHF7uKoHLMfLpu+ttYyVm9xipeZIa1+
        SfZRtk4RF/fLtj/HxXOSFjws9C+/sp/jSJh37Nmj2X//CWltzrk/Ob915qmGboW4mzHhW8/9
        fvHG91rM2U+KRqWMe5etSO3bxrtqk53cfRM+o19TmPu2VO2beva4kSnTtBDjv5d1nJVYijMS
        DbWYi4oTAcRHb99DBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG6kcEK8wd2tnBbzj5xjtfj/6DWr
        xZdNE9gslk/Yx2ax6fE1VovLu+awWXx68J/Z4nbjCjaL/3t2sFuseLuU2YHLY+3H+6wem1Z1
        snlsXlLvsXi5oUffllWMHtuvzWP2+LxJLoA9issmJTUnsyy1SN8ugSvjaGsre8FF4YqtW2Yw
        NzDu4+9i5OSQEDCRWNT9gKWLkYtDSGAHo8SeS33MEAlJiWkXjwLZHEC2sMThw8UQNW8ZJbZN
        vMsCUiMsYCax++dDVhBbRKBO4uWTW0wgRcwCXxgl1h07yAbRcZlR4sPvPWwgVWwCWhL7X9wA
        s/kFFCWu/njMCLKBV8BOYtdZsItYBFQlPjzYxQRiiwqESexc8hjM5hUQlDg58wnYYk4BHYkJ
        vYfAFjMLqEv8mXeJGcIWl7j1ZD4ThC0v0bx1NvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuK
        c9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNPS2sH455VH/QOMTJxMB5ilOBgVhLhPdAYHy/E
        m5JYWZValB9fVJqTWnyIUZqDRUmc9+ushXFCAumJJanZqakFqUUwWSYOTqkGJvXHKfK8XcL8
        Twp8GHqebmI6tShK14WHS3T7uwk9Xix3Aw7d3vag/m/C5SOLTjV6vwyrn7Bc+NPyoBvshZ6v
        urv9Qu3FPi6e+Wuu88ecM/dSH6ol7hA8HsarZ3P9WeNXbbOqD5Kn7mWueihbuPkqU+O3x3On
        dr3wF9U/FLXZdVP0lm0xPUmCi5tPz2U63RvOIryfY4NXrcLUo1v9G/KuLvl/+lhsce2UhT6C
        b0Ua+HmzWY8qlYrsKC/ZrnvLPS/iPdeJ5crZMcbFvj1v7V6WM9fXGuxs2z9he7HSFN9fP/Xf
        cIo2tCYxrdi5/lmA2vaCrzechadX/i3WqrjS3T93v/Fir1cRH8T8bQ2kZHQ+KbEUZyQaajEX
        FScCADTd9VMtAwAA
X-CMS-MailID: 20200915010529epcas1p34e3c68a606252fd079a8c72055b1e958
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200914231545epcas1p32532a8bee9c5100e4f45fc0681735e82
References: <20200904191830.387296-1-jagan@amarulasolutions.com>
        <6955091.ERBjKZ0CLf@diego>
        <CGME20200914231545epcas1p32532a8bee9c5100e4f45fc0681735e82@epcas1p3.samsung.com>
        <20200914231533.GA429337@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 9/15/20 8:15 AM, Rob Herring wrote:
> On Fri, Sep 04, 2020 at 11:23:21PM +0200, Heiko Stübner wrote:
>> Hi Jagan,
>>
>> Am Freitag, 4. September 2020, 21:18:27 CEST schrieb Jagan Teki:
>>> USB Type-C protocol supports various modes of operations
>>> includes PD, USB3, and Altmode. If the platform design
>>> supports a Type-C connector then configuring these modes
>>> can be done via enumeration.
>>>
>>> However, there are some platforms that design these modes
>>> of operations as separate protocol connectors like design
>>> Display Port from on-chip USB3 controller. So accessing
>>> Type-C Altmode Display Port via onboard Display Port 
>>> connector instead of a Type-C connector.
>>>  
>>> These kinds of platforms require an explicit extcon driver
>>> in order to handle Power Delivery and Port Detection.
>>>
>>> This series support this Type-C Virtual PD and enable the
>>> same in ROCK Pi 4C SBC.
>>>
>>> Any inputs?
>>
>> I tend to disagree on the design via an extcon.
> 
> I don't accept new extcon bindings or users of it either. It's a 
> poorly thought out collection of Linux driver properties. Use the usb 
> connector binding.

I agree the prior binding format of extcon with 'extcon' property name
is not proper. So, I'll try to bind new style. But, I have a question.
Do you have the objection of the use of extcon like 'users of it either' 
of your comment?

> 
>>
>> That the Rockchip rk3399 currently carries that extcon thingy is unfortunate
>> and only works for ChromeOS devices based on the rk3399.
>>
>> The kernel now has a real type-c framework so we should not extend this
>> extcon hack any further, because that will make it even harder to roll back
>> later. Also simply because other Rockchip boards currently can't really make
>> use of type-c due to this, as they use the fsusb302 phys directly connected.
>>
>> ChromeOS actually spend some time to make the cros-ec pd part of the type-c
>> framework if I remember correctly, so a viable battle plan would be to:
>>
>> (1) move the Rockchip type-c phy driver to actually be part of the type-c
>>     framework, with the extcon being a deprecated fallback for old DTs.
>> (2) implement your gpio-altmode as part of the type-c framework
>>     (which may even already exist)
>>
>>
>> In short, please don't extend the rk3399 type-c extcon hack.
>>
>> Thanks
>> Heiko
>>
>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
