Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAC26A6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIOOKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:10:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56671 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgIOOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:06:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200915140643euoutp01fa58ebab2c4aa8bfcbc243f793a2f18f~0_iSxaGXc3255032550euoutp01X
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:06:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200915140643euoutp01fa58ebab2c4aa8bfcbc243f793a2f18f~0_iSxaGXc3255032550euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600178803;
        bh=me6QU5dLYgL7wLxZgM4gmm2FoSruI2seIqjtZ2YICJc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fjPy0hF/qJsahbM2vIFw9DY4WML7EPGCdyD8jkj6cuASm9UD+0aQVGvByNF7/rzQK
         odimh8h5O3SZ+ZaQLdXRImZrb6CXbIynCMvMCxdio04lMsi7GPJg9QwHkBkAL8P2B1
         sti8wi5+GqK710YzPtkMreLZMQDOWCuZVTba5ihY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200915140642eucas1p12c51a50b9c7ccb03c227b7fee66c7e7b~0_iSpgp410395703957eucas1p1Y;
        Tue, 15 Sep 2020 14:06:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5E.D6.05997.27AC06F5; Tue, 15
        Sep 2020 15:06:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200915140642eucas1p1a1be18079e24b39128da6df445052234~0_iSZURZC0395703957eucas1p1X;
        Tue, 15 Sep 2020 14:06:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200915140642eusmtrp1667eaccab6f380887991fffe48193cfe~0_iSYvLZr2933029330eusmtrp1j;
        Tue, 15 Sep 2020 14:06:42 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-3a-5f60ca727da8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.B5.06314.27AC06F5; Tue, 15
        Sep 2020 15:06:42 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200915140642eusmtip1f190eec810584e7ce42a8213e98a40f9~0_iSBhmnD1047510475eusmtip1k;
        Tue, 15 Sep 2020 14:06:42 +0000 (GMT)
Subject: Re: [PATCH 2/2] irqchip/gic: Cleanup Franken-GIC handling
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, kernel-team@android.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e3080423-61b3-5999-96a4-c1b49dffe0e9@samsung.com>
Date:   Tue, 15 Sep 2020 16:06:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915133944.1285456-3-maz@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7pFpxLiDZqnWFs0LrnMYrFju4jF
        psfXWC0u75rDZrFzzklWi82bpjI7sHls272N1WPTqk42j4YD51k83p07x+6xeUm9x+dNcgFs
        UVw2Kak5mWWpRfp2CVwZLV/eshS8kqk4tW8bYwPjYvEuRk4OCQETibnHn7B1MXJxCAmsYJTY
        t+IalPOFUaLt/QQmCOczo8Sq87/YYVpm/5rDApFYziix//ZLqJb3jBLHXi8AqxIWcJLYeWwe
        M4gtIpAucWHORrA4s0CGxL8rq9hAbDYBQ4mut11gNq+AncTSB4+BbA4OFgFVib8H80DCogJx
        EsdOPWKBKBGUODnzCQtICaeAmUTPw1yIifIS29/OYYawxSVuPZkPdrSEwDp2oJEtUEe7SKw/
        u5QNwhaWeHV8C1RcRuL05B4WiIZmRomH59ayQzg9jBKXm2YwQlRZS9w59wvsOGYBTYn1u/Qh
        wo4S33pvsYKEJQT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlIPpuF
        5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMD0c/rf8S87GHf9STrE
        KMDBqMTDm1AeHy/EmlhWXJl7iFGCg1lJhNfp7Ok4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzG
        i17GCgmkJ5akZqemFqQWwWSZODilGhhdypZN1b6nan85dZWt1rq3B6s3s91cJLNuinpv1ZU+
        uaKfpeu9F/N77PC6MXP6bztH7nxZ1o7blgyH1c/OvPapIr/21ukqfrdNC3nEVGac5v5bEy/I
        uk7W3qF7q8t1jY73RTN2pa3aWi1ifaWAb8HTTf+z7hQ53DwjfGDupdy5e/cGBW+9/N5aiaU4
        I9FQi7moOBEAE2kkkDsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xu7pFpxLiDWbu0LJoXHKZxWLHdhGL
        TY+vsVpc3jWHzWLnnJOsFps3TWV2YPPYtnsbq8emVZ1sHg0HzrN4vDt3jt1j85J6j8+b5ALY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyWr68
        ZSl4JVNxat82xgbGxeJdjJwcEgImErN/zWHpYuTiEBJYyiixYupHdoiEjMTJaQ2sELawxJ9r
        XWwQRW8ZJV5e3csGkhAWcJLYeWweM4gtIpAu8fjaGRYQm1kgQ+L8zPtgzUICWxklvjcagNhs
        AoYSXW+7wHp5Bewklj54DGRzcLAIqEr8PZgHEhYViJM40/MCqkRQ4uTMJywgJZwCZhI9D3Mh
        pptJzNv8kBnClpfY/nYOlC0ucevJfKYJjEKzkHTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvq
        FSfmFpfmpesl5+duYgRG27ZjPzfvYLy0MfgQowAHoxIPb0J5fLwQa2JZcWXuIUYJDmYlEV6n
        s6fjhHhTEiurUovy44tKc1KLDzGaAr02kVlKNDkfmAjySuINTQ3NLSwNzY3Njc0slMR5OwQO
        xggJpCeWpGanphakFsH0MXFwSjUwzjAQFu+9/OJt4JV/jx/nqNdbcnN6OE/fbXpMRqXrI0f6
        1IQpP888LnVwE1dT6fsWYHvkh2Ryzs5X2+Zs/rtuxq60ZU7THzNbfZ8izjv3/vfE3dYWX69c
        Pm+n8DmyIZP79uvJTrIeuftyOCb3x7/rr/ybNvtu0vEA+/ehha4asud3p/sz/JoVoMRSnJFo
        qMVcVJwIAKCoZsnMAgAA
X-CMS-MailID: 20200915140642eucas1p1a1be18079e24b39128da6df445052234
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200915134024eucas1p2dfda1916e755787bb7a5c324eb6b5063
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200915134024eucas1p2dfda1916e755787bb7a5c324eb6b5063
References: <20200915133944.1285456-1-maz@kernel.org>
        <CGME20200915134024eucas1p2dfda1916e755787bb7a5c324eb6b5063@eucas1p2.samsung.com>
        <20200915133944.1285456-3-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.2020 15:39, Marc Zyngier wrote:
> Now that we have a static key identifying Samsung's unique creation,
> let's replace the indirect call to compute the base addresses by
> a simple test on the static key.
>
> Faster, cheaper, negative diffstat.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/irqchip/irq-gic.c | 48 +++++++++------------------------------
>   1 file changed, 11 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 84a2d2a1aab7..98743afdaea6 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -83,9 +83,6 @@ struct gic_chip_data {
>   #endif
>   	struct irq_domain *domain;
>   	unsigned int gic_irqs;
> -#ifdef CONFIG_GIC_NON_BANKED
> -	void __iomem *(*get_base)(union gic_base *);
> -#endif
>   };
>   
>   #ifdef CONFIG_BL_SWITCHER
> @@ -125,32 +122,6 @@ static struct gic_chip_data gic_data[CONFIG_ARM_GIC_MAX_NR] __read_mostly;
>   static struct gic_kvm_info gic_v2_kvm_info;
>   
>   #ifdef CONFIG_GIC_NON_BANKED
> -static void __iomem *gic_get_percpu_base(union gic_base *base)
> -{
> -	return raw_cpu_read(*base->percpu_base);
> -}
> -
> -static void __iomem *gic_get_common_base(union gic_base *base)
> -{
> -	return base->common_base;
> -}
> -
> -static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
> -{
> -	return data->get_base(&data->dist_base);
> -}
> -
> -static inline void __iomem *gic_data_cpu_base(struct gic_chip_data *data)
> -{
> -	return data->get_base(&data->cpu_base);
> -}
> -
> -static inline void gic_set_base_accessor(struct gic_chip_data *data,
> -					 void __iomem *(*f)(union gic_base *))
> -{
> -	data->get_base = f;
> -}
> -
>   static DEFINE_STATIC_KEY_FALSE(frankengic_key);
>   static DEFINE_PER_CPU(u32, sgi_intid);
>   
> @@ -173,10 +144,20 @@ static inline u32 get_sgi_intid(void)
>   {
>   	return this_cpu_read(sgi_intid);
>   }
> +
> +static inline void __iomem *__get_base(union gic_base *base)
> +{
> +	if (is_frankengic())
> +		return raw_cpu_read(*base->percpu_base);
> +
> +	return base->common_base;
> +}
> +
> +#define gic_data_dist_base(d)	__get_base(&(d)->dist_base)
> +#define gic_data_cpu_base(d)	__get_base(&(d)->cpu_base)
>   #else
>   #define gic_data_dist_base(d)	((d)->dist_base.common_base)
>   #define gic_data_cpu_base(d)	((d)->cpu_base.common_base)
> -#define gic_set_base_accessor(d, f)
>   #define enable_frankengic()	do { } while(0)
>   #define is_frankengic()		false
>   #define set_sgi_intid(i)	do { } while(0)
> @@ -741,11 +722,6 @@ static int gic_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
>   	int i;
>   
>   	for (i = 0; i < CONFIG_ARM_GIC_MAX_NR; i++) {
> -#ifdef CONFIG_GIC_NON_BANKED
> -		/* Skip over unused GICs */
> -		if (!gic_data[i].get_base)
> -			continue;
> -#endif
>   		switch (cmd) {
>   		case CPU_PM_ENTER:
>   			gic_cpu_save(&gic_data[i]);
> @@ -1187,7 +1163,6 @@ static int gic_init_bases(struct gic_chip_data *gic,
>   		}
>   
>   		enable_frankengic();
> -		gic_set_base_accessor(gic, gic_get_percpu_base);
>   	} else {
>   		/* Normal, sane GIC... */
>   		WARN(gic->percpu_offset,
> @@ -1195,7 +1170,6 @@ static int gic_init_bases(struct gic_chip_data *gic,
>   		     gic->percpu_offset);
>   		gic->dist_base.common_base = gic->raw_dist_base;
>   		gic->cpu_base.common_base = gic->raw_cpu_base;
> -		gic_set_base_accessor(gic, gic_get_common_base);
>   	}
>   
>   	/*

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

