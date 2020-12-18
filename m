Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD052DDD54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbgLRDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:33:58 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37456 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgLRDd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:33:57 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201218033313epoutp01e7005531535c215128ace777986bc915~RsiAr7iMg0814508145epoutp016
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 03:33:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201218033313epoutp01e7005531535c215128ace777986bc915~RsiAr7iMg0814508145epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608262393;
        bh=ltRB2anixbs969e5Ri2AoC8AeFMR6KlExIxotGXhGv4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=lk2+GE5uxTSyw+EnsQAH1fnqysSKlAdZc0Iw6k8V6H3oQjWaPQKjDWObezPShj+Qk
         kBtptsWWCC+/Nou7s2DFqek+mqTdnBEB2Pv0Ujv6vlMcTt4Ks2n8lm79g6q3D08er0
         kQTrOsu0TOA7guTiNHYlfSag9bCRjp7IuvjatgQ8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201218033312epcas1p2589d33717232dc6030b05a8d364b7b00~Rsh-36X7y2682026820epcas1p2E;
        Fri, 18 Dec 2020 03:33:12 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CxvZt0wnzzMqYkZ; Fri, 18 Dec
        2020 03:33:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.3B.10463.5F22CDF5; Fri, 18 Dec 2020 12:33:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201218033308epcas1p1ed74d8b9ea3fb366bce465f3e0dfd1f2~Rsh8sLI-R0164001640epcas1p11;
        Fri, 18 Dec 2020 03:33:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201218033308epsmtrp191c3c4ad744bca4cb87a5e57267d0373~Rsh8rllEk3059430594epsmtrp1I;
        Fri, 18 Dec 2020 03:33:08 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-d6-5fdc22f587a9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.C7.08745.4F22CDF5; Fri, 18 Dec 2020 12:33:08 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201218033308epsmtip149dad328a348406a76914ee1e0682dd6~Rsh8ga02Q0268702687epsmtip1D;
        Fri, 18 Dec 2020 03:33:08 +0000 (GMT)
Subject: Re: extcon: add EXTCON_JACK_UNSUPPORTED for external headset jack
To:     mengw@codeaurora.org, myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org, plai@codeaurora.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9f9176a5-fe8b-8eb3-a83c-b31f43aafb55@samsung.com>
Date:   Fri, 18 Dec 2020 12:48:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <001b01d6d4e8$b3cd3680$1b67a380$@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmvu43pTvxBpfFLC7vmsNmMfH8PDaL
        240r2Cw65k5gdGDxuNzXy+TRt2UVo8fnTXIBzFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGm
        ZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAy5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqp
        BSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2Rkdx3cwFywRr2ib28/ewNgs3MXIySEhYCIx
        7fkuli5GLg4hgR2MEv9/fWSHcD4xStxo+QCV+cwocXflcyaYlvuXXjFDJHYxSrx8uoEVJCEk
        8J5R4sr/MhBbWMBLou/1XbAGEQEjiTPTGoHGcnAwC5hKdJ1QBwmzCWhJ7H9xgw3E5hdQlLj6
        4zEjiM0rYCfRdeQNM4jNIqAq8b93C1iNqECYxMltLVA1ghInZz5hAbE5BWwlPmxfAxZnFhCX
        uPVkPhOELS/RvHU22J0SAj/ZJfZ1rIZ6wEXi74Y7ULawxKvjW9ghbCmJl/1tUHa1xMqTR9gg
        mjsYJbbsv8AKkTCW2L90MhPEM5oS63fpQ4QVJXb+ngt1BJ/Eu689rCAlEgK8Eh1tQhAlyhKX
        H9yFWispsbi9k20Co9IsJO/MQvLCLCQvzEJYtoCRZRWjWGpBcW56arFhgQlyZG9iBKdDLYsd
        jHPfftA7xMjEwXiIUYKDWUmEN/TB7Xgh3pTEyqrUovz4otKc1OJDjKbAAJ7ILCWanA9MyHkl
        8YamRsbGxhYmhmamhoZK4rx/tDvihQTSE0tSs1NTC1KLYPqYODilGphYfq00WeekNdOSNVHT
        wV+lbWuIwPW1Ef8Dr31K2/76eFzJ367rhpPqr799cTd0552iSpv73pKi0UUCV7V9DCwfrmyT
        YPjx583SMv+ztQpm7P+WtkXG7tbdv9Pmyv13O8yT5ptvuzlhKu+k06sD20X2qPu5JGxwO1+Z
        enOmz6sPv/alhf+bf++vLHPTtyXSpR4vTb0n+CwJlNnQ+mTVmYofvsalO7me8B8w/WWg9FZ0
        Vk/akoAbMce0PrBnF3b0ftR+G9vkFfLE/9/Zf1vmsyqGmB4/IL8werrNtuu24YcT30WlvfaJ
        esJ1fBJLRND8/we2Bn8SVUnrEpg79cuF8L0nT7dZafwLuL3+5rXrpQddlFiKMxINtZiLihMB
        fLKhghAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO4XpTvxBu9WGVpc3jWHzWLi+Xls
        FrcbV7BZdMydwOjA4nG5r5fJo2/LKkaPz5vkApijuGxSUnMyy1KL9O0SuDI6ju9gLlgiXtE2
        t5+9gbFZuIuRk0NCwETi/qVXzF2MXBxCAjsYJU4sOsQKkZCUmHbxKFCCA8gWljh8uBii5i2j
        xMR9O5lBaoQFvCT6Xt9lArFFBIwkzkxrZAepZxYwleg6oQ5RP4FRYsOTL2Az2QS0JPa/uMEG
        YvMLKEpc/fGYEcTmFbCT6DryBmwmi4CqxP/eLWA1ogJhEjuXPGaCqBGUODnzCQuIzSlgK/Fh
        +xqwXmYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcGxoae1g3LPqg94hRiYOxkOMEhzMSiK8oQ9uxwvx
        piRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAZPfCbLpUz65J
        aROjOOZ0fq53LtL2/LT6lK/nde1/jhLV7x6vrjXuWXAi/J3vThY1jgRFP7W+/QufljIr77uo
        fOzQo/MX039O49vKYpy/3ovb9fkP3qjC8/rvMuuUHBKfPPnceT1gvsiJ76u3Zdx4nzfLXYzN
        W1D10VPvs4H/Mh0i6k6VFbswHBXeGDqR/XDiV82JP5RadteVX3aYdXTzew7Lky/Cqv7wPXln
        c26p/RIW88nsb2u97wlz/sue2vjy456VbtNUlv1JX+TO9e/DZzOb3y/vMDY/qp/TPVlc6WPW
        5m9nPTtrZ9arrK89aDrJ+7BbwvKZ7xazOJhIMO97t8Jz//eLV1ec4l/OmSH56aUSS3FGoqEW
        c1FxIgCgzpqe/AIAAA==
X-CMS-MailID: 20201218033308epcas1p1ed74d8b9ea3fb366bce465f3e0dfd1f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201218025143epcas1p390da75dfe1938decce72ba2728595d9e
References: <CGME20201218025143epcas1p390da75dfe1938decce72ba2728595d9e@epcas1p3.samsung.com>
        <001b01d6d4e8$b3cd3680$1b67a380$@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/20 11:51 AM, mengw@codeaurora.org wrote:
>  
> 
>  
> 
> From dac7b15dbdd4c327083fff97f22cf0c6ddfcf31a Mon Sep 17 00:00:00 2001
> 
> From: Meng Wang <mengw@codeaurora.org>
> 
> Date: Wed, 9 Dec 2020 12:35:54 +0800
> 
> Subject: [PATCH] extcon: add EXTCON_JACK_UNSUPPORTED for external headset jack
> 
>  
> 
> This patch adds the new extcon type EXTCON_JACK_UNSUPPORTED. This
> 
> type would be used when Euro headset is inserted into US jack and
> 
> vice versa. When EU headset is inserted into US jack and there's
> 
> no switch to switch the MIC_GND, EXTCON_JACK_UNSUPPORTED
> 
> would be reported to usespace.

Actually, I don't understand why this definition is needed.
Until now, I had not been heard like this name for external connector.
We have to use the correct connector name.

Instead of defining new type, you can use EXTCON_MECHANICAL
type in order to notify something to user-space
when unsupported external connector is inserted or vice-versa.
[1] http://lkml.iu.edu/hypermail/linux/kernel/1205.0/00538.html

> 
>  
> 
> Signed-off-by: Meng Wang <mengw@codeaurora.org>
> 
> ---
> 
> drivers/extcon/extcon.c | 5 +++++
> 
> include/linux/extcon.h  | 1 +
> 
> 2 files changed, 6 insertions(+)
> 
>  
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> 
> index 0a6438c..cfe2404 100644
> 
> --- a/drivers/extcon/extcon.c
> 
> +++ b/drivers/extcon/extcon.c
> 
> @@ -135,6 +135,11 @@ static const struct __extcon_info {
> 
>                                .id = EXTCON_JACK_SPDIF_OUT,
> 
>                                .name = "SPDIF-OUT",
> 
>                },
> 
> +             [EXTCON_JACK_UNSUPPORTED] = {
> 
> +                             .type = EXTCON_TYPE_JACK,
> 
> +                             .id = EXTCON_JACK_UNSUPPORTED,
> 
> +                             .name = "UNSUPPORTED",
> 
> +             },

> 
>                 /* Display external connector */
> 
>                [EXTCON_DISP_HDMI] = {
> 
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> 
> index fd183fb..5b47dae 100644
> 
> --- a/include/linux/extcon.h
> 
> +++ b/include/linux/extcon.h
> 
> @@ -68,6 +68,7 @@
> 
> #define EXTCON_JACK_VIDEO_OUT       25
> 
> #define EXTCON_JACK_SPDIF_IN             26           /* Sony Philips Digital InterFace */
> 
> #define EXTCON_JACK_SPDIF_OUT         27
> 
> +#define EXTCON_JACK_UNSUPPORTED 28
> 
>  /* Display external connector */
> 
> #define EXTCON_DISP_HDMI    40           /* High-Definition Multimedia Interface */
> 
> -- 
> 
> 2.7.4
> 
>  
> 
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
