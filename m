Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B9326B7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgIPA2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:28:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56539 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgIOOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:06:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200915140627euoutp01cbf233db14c37d187791bb974182ba26~0_iD4TYra0105801058euoutp01J
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:06:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200915140627euoutp01cbf233db14c37d187791bb974182ba26~0_iD4TYra0105801058euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600178787;
        bh=DX2AJxvRevFsuNxRqNwb3fz9UrOHkZ9YoJ7dXfMhH5I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=D2+L+SNgVprF91418LzThKBo374bhrDJb4xThoo+iekozj8nFCeNrkNcxKBotHVLv
         6GaND3MQfZXj7PiRq4yZp8f85xFVZ8J2j9g6VklxGJ6d0YId8DQqSZC4MHrGaLAJpo
         xBVb/kXpRWqSPtAy4y2Uz0wagaES15rIIpCwa/pY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200915140626eucas1p14bf0895c384d935833f437ce27c49774~0_iDm8abT1164911649eucas1p1A;
        Tue, 15 Sep 2020 14:06:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A9.9B.06456.26AC06F5; Tue, 15
        Sep 2020 15:06:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200915140626eucas1p1816470b9ea4dd602cdd67c870130f8c0~0_iDNoTt81881118811eucas1p1Q;
        Tue, 15 Sep 2020 14:06:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200915140626eusmtrp219aae91862789ee885842599fa313c0f~0_iDNAfy90752307523eusmtrp2G;
        Tue, 15 Sep 2020 14:06:26 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-7c-5f60ca624615
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F0.65.06017.26AC06F5; Tue, 15
        Sep 2020 15:06:26 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200915140625eusmtip1db7c33c17faec9b250172fd374f65be9~0_iCyJUAO0886608866eusmtip1M;
        Tue, 15 Sep 2020 14:06:25 +0000 (GMT)
Subject: Re: [PATCH 1/2] irqchip/gic: Handle non-standard SGI deactivation
 on Samsung's Franken-GIC
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, kernel-team@android.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d1301d9c-5529-0089-f163-2a728055712c@samsung.com>
Date:   Tue, 15 Sep 2020 16:06:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915133944.1285456-2-maz@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeT1nZ8fR5DiNPawbDAxK8kIWI0PMLkyC6EOfJJ1TX6bopux4
        DclL4GVaipLpEgxRJ1JGx5qbouSIDbXmZWF2pZwEWhZ4oTQvuR0tv/2e5/9c/s/LSxOSDoGM
        TtNlY71OnSGnRKTZvjp2ImkkURXG1YYpStpcpMLSG6jg3FMChauvmVJYm4cFih7uLhFNKc39
        ZoGS66qklMXPx0jlD6dTqOxpK1IucYevUnGisyk4Iy0X60OjEkWpDotdkDV4KL9uqIIqRiap
        AdE0MBFw3xRnQCJawnQiuN3ZThqQ73awjMA6kcILSwi+V9m8gqdhYLZHyAsmBC/KbDvBTwSm
        +UaBpyqAwWDfKPdyIKOB8eYnQg8TTCpsvu6iPEwx4WBYMHhZzERByVuTt55kgmDrG+fN72cS
        wD4yQ/I1/jDcNEt6bPsyp6F+XcGPPAK9C80Ez1J4N9vi4/EDTJcQGl46d1xfgMWvnIDnAJh3
        PBXyfBC2rLsNtxB8cT4S8kE1AldpI+KrIuGDc43ybCaYY/C4L5R/u3PQV6Pl0Q+mF/x5D35Q
        Z75H8GkxVJRJ+BlHwejo/rd1aHySqEVy457DjHuuMe65xvh/7QNEdiEpzmG1GsyG63BeCKvW
        sjk6TUhyppZD279ndNOxaEErk0k2xNBIvk+cmKdSSQTqXLZAa0NAE/JAccyr0QSJOEVdcAPr
        M1X6nAzM2tABmpRLxSdb5+IljEadjdMxzsL6XdWH9pUVo8zVPP9P3PIpsz3mTVZCk3zuT17s
        5LQ72JVV1u+65lauhM9PnG/abA99pkeySlmEfSy6Jd39C6f3Xy+M74is58aLpNi88Ts4Gee3
        doth4OEMaGrWaq5UFQblBlZbYz+nXfa7VFxZu95w52aJrvTix7q4Mz7lPYOW7LD34+SUnGRT
        1eHHCT2r/gtorhBNOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7pJpxLiDWa/ELVoXHKZxWLHdhGL
        TY+vsVpc3jWHzWLnnJOsFps3TWV2YPPYtnsbq8emVZ1sHg0HzrN4vDt3jt1j85J6j8+b5ALY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyju84
        xlqwT7Zi0sEOtgbG5eJdjJwcEgImEnufbGbvYuTiEBJYyihx5OcOdoiEjMTJaQ2sELawxJ9r
        XWwQRW8ZJSa+vAaWEBZIlZj76SwbiC0ikC7x+NoZFhCbWSBD4vzM+6wQDVsZJZp7doEVsQkY
        SnS97QKzeQXsJBpvLgcbxCKgKvH/9SawuKhAnMSZnhdQNYISJ2c+ARrKwcEpYCYx+Y8FxHwz
        iXmbHzJD2PIS29/OgbLFJW49mc80gVFoFpLuWUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE
        3OLSvHS95PzcTYzAiNt27OeWHYxd74IPMQpwMCrx8CaUx8cLsSaWFVfmHmKU4GBWEuF1Ons6
        Tog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgckgryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQ
        QHpiSWp2ampBahFMHxMHp1QDI1/9wvmr3Pp7cqW3bwqz3v095+JV/26B2CfmrS/OH4/cNcWt
        +iXjIZnrFjVB77Yn3jvzUfv/+/i0GVosuSePvzia7WddEv3d5JtZ+FlFWZ0EHlXHZRv+8cYt
        rlSNE4/+XOPFURvy7tzNuzM3Hzv8obbzAOOV6m/uz/pqtEV38a5dnRcYl+I1V4mlOCPRUIu5
        qDgRALnbMSnOAgAA
X-CMS-MailID: 20200915140626eucas1p1816470b9ea4dd602cdd67c870130f8c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200915134023eucas1p2d2af4f3690329eb8de61f18700134122
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200915134023eucas1p2d2af4f3690329eb8de61f18700134122
References: <20200915133944.1285456-1-maz@kernel.org>
        <CGME20200915134023eucas1p2d2af4f3690329eb8de61f18700134122@eucas1p2.samsung.com>
        <20200915133944.1285456-2-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.2020 15:39, Marc Zyngier wrote:
> The GIC available on some of Samsung's A9-based platform is
> thankfully one of a kind. On top of not presenting a banked
> programing model (each CPU has its own base addresses for both
> distributor and CPU interface), it also encodes the source CPU
> for SGIs in the INTID read from IAR, and requires this exact
> value to be written back to EOI.
>
> Without this, interrupts are never deactivated, and the kernel
> grinds to a halt.
>
> Work around it by stashing the INTID for in-flight SGIs, and
> using that value on EOI. This only works because we don't nest
> SGIs.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: ac063232d4b0 ("irqchip/gic: Configure SGIs as standard interrupts")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Works fine, thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/irqchip/irq-gic.c | 49 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 4be2b62f816f..84a2d2a1aab7 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -150,10 +150,37 @@ static inline void gic_set_base_accessor(struct gic_chip_data *data,
>   {
>   	data->get_base = f;
>   }
> +
> +static DEFINE_STATIC_KEY_FALSE(frankengic_key);
> +static DEFINE_PER_CPU(u32, sgi_intid);
> +
> +static void enable_frankengic(void)
> +{
> +	static_branch_enable(&frankengic_key);
> +}
> +
> +static inline bool is_frankengic(void)
> +{
> +	return static_branch_unlikely(&frankengic_key);
> +}
> +
> +static inline void set_sgi_intid(u32 intid)
> +{
> +	this_cpu_write(sgi_intid, intid);
> +}
> +
> +static inline u32 get_sgi_intid(void)
> +{
> +	return this_cpu_read(sgi_intid);
> +}
>   #else
>   #define gic_data_dist_base(d)	((d)->dist_base.common_base)
>   #define gic_data_cpu_base(d)	((d)->cpu_base.common_base)
>   #define gic_set_base_accessor(d, f)
> +#define enable_frankengic()	do { } while(0)
> +#define is_frankengic()		false
> +#define set_sgi_intid(i)	do { } while(0)
> +#define get_sgi_intid()		0
>   #endif
>   
>   static inline void __iomem *gic_dist_base(struct irq_data *d)
> @@ -226,7 +253,12 @@ static void gic_unmask_irq(struct irq_data *d)
>   
>   static void gic_eoi_irq(struct irq_data *d)
>   {
> -	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
> +	u32 hwirq = gic_irq(d);
> +
> +	if (is_frankengic() && hwirq < 16)
> +		hwirq = get_sgi_intid();
> +
> +	writel_relaxed(hwirq, gic_cpu_base(d) + GIC_CPU_EOI);
>   }
>   
>   static void gic_eoimode1_eoi_irq(struct irq_data *d)
> @@ -348,8 +380,20 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>   		 *
>   		 * Pairs with the write barrier in gic_ipi_send_mask
>   		 */
> -		if (irqnr <= 15)
> +		if (irqnr <= 15) {
>   			smp_rmb();
> +
> +			/*
> +			 * Samsung's funky GIC encodes the source CPU in
> +			 * GICC_IAR, leading to the deactivation to fail if
> +			 * not written back as is to GICC_EOI.  Stash the
> +			 * INTID away for gic_eoi_irq() to write back.
> +			 * This only works because we don't nest SGIs...
> +			 */
> +			if (is_frankengic())
> +				set_sgi_intid(irqstat);
> +		}
> +
>   		handle_domain_irq(gic->domain, irqnr, regs);
>   	} while (1);
>   }
> @@ -1142,6 +1186,7 @@ static int gic_init_bases(struct gic_chip_data *gic,
>   				gic->raw_cpu_base + offset;
>   		}
>   
> +		enable_frankengic();
>   		gic_set_base_accessor(gic, gic_get_percpu_base);
>   	} else {
>   		/* Normal, sane GIC... */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

