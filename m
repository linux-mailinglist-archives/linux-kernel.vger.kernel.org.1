Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0FF26954D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgINTNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:13:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43469 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgINTNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:13:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200914191302euoutp02820d913f3c97a7428beb399588146aa4~0vEd6hERd1415914159euoutp02u
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:13:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200914191302euoutp02820d913f3c97a7428beb399588146aa4~0vEd6hERd1415914159euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600110782;
        bh=fP9QMXdbuLNBl4oeiPp8QcMQCAxsDI2S/KFNXBuW1ZU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ES3Iq+ueNyo255r9mApgyrg2yEWWNzz7G+3SGxiz00Qv/w6TvrFVb5eIKVDyrLTj0
         H7RIRIY1KxwHNCah+ZHdCIEOyUfLsqaFwpa8poOPT4q3PWMv6/vaU+6v/CRtxJ5z/q
         +X+kkjm/7Y87ke8AwIyKT4dtfIvlzqIKIhux2Y4I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200914191301eucas1p10774cbab0bd065ae5293551e313d81f0~0vEcuLZZs0355103551eucas1p1M;
        Mon, 14 Sep 2020 19:13:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 76.0E.06456.DB0CF5F5; Mon, 14
        Sep 2020 20:13:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200914191300eucas1p1690684814f22581f1f83c928036abf60~0vEcEACDl0294802948eucas1p11;
        Mon, 14 Sep 2020 19:13:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200914191300eusmtrp1a5f026abfeda482709f825ddade07744~0vEcDJlmg0597905979eusmtrp1P;
        Mon, 14 Sep 2020 19:13:00 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-71-5f5fc0bd5773
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.3F.06314.CB0CF5F5; Mon, 14
        Sep 2020 20:13:00 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200914191259eusmtip1bd2a8d43acd55e5ad020438ec650728c~0vEbHS1Ar2190121901eusmtip1a;
        Mon, 14 Sep 2020 19:12:59 +0000 (GMT)
Subject: Re: [PATCH v3 10/16] irqchip/bcm2836: Configure mailbox interrupts
 as standard interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Saravana Kannan <saravanak@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d62e71b5-78c7-dabe-6d20-74e533549db3@samsung.com>
Date:   Mon, 14 Sep 2020 21:13:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e99cc81b24475c54e173e6dd0d9d827b@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUYRTl25mdGa2xz83wYg9xqcAePqhgKJGMiCEi+mEEQq5bDlqtu7bj
        Iy3IXDNdtqgV0VZxrczMzHR9a5ot4WKSiopZ6Y82hQpU0srUjFxHy3/n3HsO5x64DKGYk/sw
        57QJgl6r1igpd7K+Y7Znd2u7ShWUWbmR6xmxE9xkqQlxcxOvaK6wLIW7VtJPco0NXpzt06Cc
        628upLg7H6po7kM/yzUVdso5o32B4irbblFcjS2X4BqsswSXMbzvIObrW+rlfEVRBeIzDCaK
        L6q4zDdZRmi+2JbI28qzKT6tvYfkhwefU/xEdzfN15Rc5Zsap2X8tG3LCTbCPSRa0JxLEvSB
        oVHusd/aH9Px8+wla+aQLA29WGNEbgzgvZDjdNJG5M4ocBmCKuu0XCLfEYw5bxAulQJPIygv
        PLni+JZ2b9nxCEFrcSkhkUkEN9NHSZdqPY6GhnID7cJe2A+mejuRS0TgtyTkdzQi14LCwWAc
        N1IuzOJQGHW8WzKQeBuU/iqWu/AGHAkdr52kpPGEzrtSgBveDw+ybyx5CewLhroCQsLe8H7U
        KnOFAX7IwJOe30i6+zD0DS4s4/Xw1VFLS3gTdOWYSMlgQPCx+yktEROC/vT8ZccBGO6eW4xj
        FiP84VlzoDQOg5qW10tjwB4wNO4pHeEB5vo8QhqzkJWpkNTbweKo/Bf7srePuI2UllXVLKvq
        WFbVsfzPLUZkOfIWEsW4GEEM1grJAaI6TkzUxgSc1cXZ0OJHdv1xTDWiH31n7AgzSLmWjUpW
        qRRydZKYEmdHwBBKL/bQm65IBRutTkkV9DqVPlEjiHa0kSGV3uye+19OK3CMOkG4IAjxgn5l
        K2PcfNJQ6HyrZtdsQJRpZLjtellvnkadXVDluy782U9e5wz291XMmM3WgmqntjZL3GxNkV2P
        1R0ZCDtaN6BK2NywcyLVqArrG7sVdH7G2p6eeyzcsS5iwEweH3nn5Yz0u0h9nrEo50O2lsTH
        78kNN1zZ8ObHKd1Tn6mpwAzzUNCF6sGqEiUpxqqDdxB6Uf0XXixtT40DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42I5/e/4Xd09B+LjDSZ+1bQ4f/cQs8X7ZT2M
        Fr/eHWG3mLOi0qJxyWUWix3bRSw2Pb7GanF51xw2i4m3N7Bb3L7Ma7FzzklWi65Df9ks1u3r
        Y7PYvGkqs8X2+T+ZLVrumDoIeGzbvY3VY828NYweLc09bB7z1lR77Jx1l91jwaZSj02rOtk8
        Gg6cZ/G4c20Pm8e7c+fYPTYvqffYueMzk8fnTXIBvFF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
        ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GR8PrGQv+M1bMb/tBlMD437uLkZODgkBE4mP
        DQvZQWwhgaWMEof/i0HEZSROTmtghbCFJf5c62LrYuQCqnnLKLFk9QIWkISwQIrEqQ/HwYpE
        BBQlPl04yQhSxCxwk0ViatsSZoiO2UwSJ9+DOJwcbAKGEl1vQUZxcvAK2Ek8OX4TbDWLgKrE
        sh8LwCaJCsRJnOl5AVUjKHFy5hOwbZwCVhKLO9vB4swCZhLzNj9khrDlJZq3zoayxSVuPZnP
        NIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwJSw7djPzTsY
        L20MPsQowMGoxMObUB4fL8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZA
        z01klhJNzgemq7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYxt
        twUcX+c56cctNVRk8nyxbsHE9eeKH+eEvRc6+b7+2aWqv3rWuu/4a9knTSiaV88gJ6I6XWW5
        RcT30v/lzStMPJ6LXCm/kSF44dwqN5fKEv0Urc3PecM2zXPf4PFThqlwM8+CfVePJfZvsu1m
        nC1yzkdtTnEvJ0t2d1ncsiv9T5drqaVtPKPEUpyRaKjFXFScCAAHJyeEHwMAAA==
X-CMS-MailID: 20200914191300eucas1p1690684814f22581f1f83c928036abf60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4
References: <20200901144324.1071694-1-maz@kernel.org>
        <20200901144324.1071694-11-maz@kernel.org>
        <CGME20200914143236eucas1p17e8849c67d01db2c5ebb3b6a126aebf4@eucas1p1.samsung.com>
        <3e52be78-1725-a3a2-c97c-625d46017a4b@samsung.com>
        <e99cc81b24475c54e173e6dd0d9d827b@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 14.09.2020 18:10, Marc Zyngier wrote:
> On 2020-09-14 15:32, Marek Szyprowski wrote:
>> On 01.09.2020 16:43, Marc Zyngier wrote:
>>> In order to switch the bcm2836 driver to privide standard interrupts
>>> for IPIs, it first needs to stop lying about the way things work.
>>>
>>> The mailbox interrupt is actually a multiplexer, with enough
>>> bits to store 32 pending interrupts per CPU. So let's turn it
>>> into a chained irqchip.
>>>
>>> Once this is done, we can instanciate the corresponding IPIs,
>>> and pass them to the architecture code.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>
>> This one also fails. It breaks booting of Raspberry Pi 3b boards (both
>> in ARM and ARM64 mode):
>
> Damn. This used to work. Looks like I was eager to delete stuff at
> some point. Can you give this a go and let me know if that works
> for you (only tested in QEMU with the raspi2 model):
>
> diff --git a/drivers/irqchip/irq-bcm2836.c 
> b/drivers/irqchip/irq-bcm2836.c
> index 85df6ddad9be..97838eb705f9 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -193,6 +193,8 @@ static void 
> bcm2836_arm_irqchip_ipi_send_mask(struct irq_data *d,
>
>  static struct irq_chip bcm2836_arm_irqchip_ipi = {
>      .name        = "IPI",
> +    .irq_mask    = bcm2836_arm_irqchip_dummy_op,
> +    .irq_unmask    = bcm2836_arm_irqchip_dummy_op,
>      .irq_eoi    = bcm2836_arm_irqchip_ipi_eoi,
>      .ipi_send_mask    = bcm2836_arm_irqchip_ipi_send_mask,
>  };
>
>
> Thanks again,

This fixes boot on my RPi3b. Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

