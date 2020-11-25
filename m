Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4712C37A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 04:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgKYDbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 22:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgKYDbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 22:31:19 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AE4C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 19:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Q+qJl/9t8h7AnV78msTDTm5ihOt81igPQbotI3Sr0s4=; b=UyFZx+mOElChhPnb3tSSDkRtrf
        NE0Yck57d6YkQrcaDFnJejtJwR+6JSaMRGxEMJQzkqMtNc0U1I0bG4L8TRj00ZQdXf5cfUG7/tGha
        ALfhL7+dxSA2aZCJyRO8uRmiADC8ytLPaITUSsbDYJQIIJsYzuKNvZJmSs3m261h3i7OniEvJGG0o
        a2MUXzbp198/6EZBAhgbEgI1HJDmsGpFlAneXLqIjRPOQFvA/qS75VBBwTimYSRPKl+uDU0U134Y1
        dhr71dr8E7iWyIe1/whQwghWcBbBU/jk7Ox2ghpB3XVMeV4ixjfpFL2/5QebXBR+YifQ12MOYUWn4
        BxuqdKKA==;
Received: from [2601:1c0:6280:3f0::cc1f]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khlWU-00006x-ET; Wed, 25 Nov 2020 03:31:14 +0000
Subject: Re: [PATCH] phy/mediatek: Make PHY_MTK_XSPHY depend on HAS_IOMEM and
 OF_ADDRESS to fix build errors
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1606211233-7425-1-git-send-email-yangtiezhu@loongson.cn>
 <1606271044.32484.20.camel@mhfsdcap03>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d3cee8b0-b699-a51a-ff33-568e10cb2df7@infradead.org>
Date:   Tue, 24 Nov 2020 19:31:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606271044.32484.20.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 6:24 PM, Chunfeng Yun wrote:
> Hi Tiezhu,
> 
> On Tue, 2020-11-24 at 17:47 +0800, Tiezhu Yang wrote:
>> devm_ioremap_resource() will be not built in lib/devres.c if
>> CONFIG_HAS_IOMEM is not set, of_address_to_resource() will be
>> not built in drivers/of/address.c if CONFIG_OF_ADDRESS is not
>> set, and then there exists two build errors about undefined
>> reference to "devm_ioremap_resource" and "of_address_to_resource"
>> in phy-mtk-xsphy.c under COMPILE_TEST and CONFIG_PHY_MTK_XSPHY,
>> make PHY_MTK_XSPHY depend on HAS_IOMEM and OF_ADDRESS to fix it.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  drivers/phy/mediatek/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
>> index 50c5e93..66df045 100644
>> --- a/drivers/phy/mediatek/Kconfig
>> +++ b/drivers/phy/mediatek/Kconfig
>> @@ -30,6 +30,8 @@ config PHY_MTK_XSPHY
>>  	tristate "MediaTek XS-PHY Driver"
>>  	depends on ARCH_MEDIATEK || COMPILE_TEST
>>  	depends on OF
>> +	depends on HAS_IOMEM
>> +	depends on OF_ADDRESS
> Why not add them into deconfig but here? In fact I don't know which way
> is better and follow the kernel rule.
> 
> Vinod and Kishon, do you have any suggestion about this?

Putting them into a defconfig won't prevent random build errors
while putting them here will (or at least should).

>>  	select GENERIC_PHY
>>  	help
>>  	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
> 

The patch LGTM.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy

