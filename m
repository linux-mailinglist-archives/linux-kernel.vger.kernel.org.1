Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CC92C391C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgKYGbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:31:35 -0500
Received: from mail.loongson.cn ([114.242.206.163]:41818 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbgKYGbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:31:35 -0500
Received: from [10.130.0.80] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9Mz+r1fSWkWAA--.45318S3;
        Wed, 25 Nov 2020 14:31:16 +0800 (CST)
Subject: Re: [PATCH] phy/mediatek: Make PHY_MTK_XSPHY depend on HAS_IOMEM and
 OF_ADDRESS to fix build errors
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <1606211233-7425-1-git-send-email-yangtiezhu@loongson.cn>
 <1606271044.32484.20.camel@mhfsdcap03>
 <d3cee8b0-b699-a51a-ff33-568e10cb2df7@infradead.org>
 <1606285623.7284.8.camel@mhfsdcap03>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a11b628a-ee7d-e1f0-2d5f-3ff4ff45d9ec@loongson.cn>
Date:   Wed, 25 Nov 2020 14:31:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1606285623.7284.8.camel@mhfsdcap03>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxL9Mz+r1fSWkWAA--.45318S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fWw47WF1kAw1DWr45Wrg_yoW8tr13pr
        ZxtF4jkF1DJryDGFWIqa4DWF1aya93try7Wrn3G3sxZrn0yry7Awn8ta429FWDZrs7uw10
        qry0ga43W3WUA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUjkpnJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/2020 02:27 PM, Chunfeng Yun wrote:
> On Tue, 2020-11-24 at 19:31 -0800, Randy Dunlap wrote:
>> On 11/24/20 6:24 PM, Chunfeng Yun wrote:
>>> Hi Tiezhu,
>>>
>>> On Tue, 2020-11-24 at 17:47 +0800, Tiezhu Yang wrote:
>>>> devm_ioremap_resource() will be not built in lib/devres.c if
>>>> CONFIG_HAS_IOMEM is not set, of_address_to_resource() will be
>>>> not built in drivers/of/address.c if CONFIG_OF_ADDRESS is not
>>>> set, and then there exists two build errors about undefined
>>>> reference to "devm_ioremap_resource" and "of_address_to_resource"
>>>> in phy-mtk-xsphy.c under COMPILE_TEST and CONFIG_PHY_MTK_XSPHY,
>>>> make PHY_MTK_XSPHY depend on HAS_IOMEM and OF_ADDRESS to fix it.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> ---
>>>>   drivers/phy/mediatek/Kconfig | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
>>>> index 50c5e93..66df045 100644
>>>> --- a/drivers/phy/mediatek/Kconfig
>>>> +++ b/drivers/phy/mediatek/Kconfig
>>>> @@ -30,6 +30,8 @@ config PHY_MTK_XSPHY
>>>>   	tristate "MediaTek XS-PHY Driver"
>>>>   	depends on ARCH_MEDIATEK || COMPILE_TEST
>>>>   	depends on OF
> Hi Tiezhu,
>
> Would you please help to put OF and OF_ADDRESS into one line as
> following:
> depends on OF && OF_ADDRESS.
>
> Also please help to add them for PHY_MTK_TPHY.
> And change the tile 'phy/mediatek: ...' as 'phy: mediatek: ...'

OK, no problem, I will do it.

Thanks,
Tiezhu

>
> Thank you
>
>
>>>> +	depends on HAS_IOMEM
>>>> +	depends on OF_ADDRESS
>>> Why not add them into deconfig but here? In fact I don't know which way
>>> is better and follow the kernel rule.
>>>
>>> Vinod and Kishon, do you have any suggestion about this?
>> Putting them into a defconfig won't prevent random build errors
>> while putting them here will (or at least should).
> hi Randy,
>
> Got it, thank you
>
>>>>   	select GENERIC_PHY
>>>>   	help
>>>>   	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
>> The patch LGTM.
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> thanks.

