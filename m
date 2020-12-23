Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A722E1D63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgLWOS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:18:56 -0500
Received: from out28-5.mail.aliyun.com ([115.124.28.5]:35731 "EHLO
        out28-5.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgLWOSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:18:54 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09277304|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0114677-0.0031451-0.985387;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.JAd1WJ3_1608733087;
Received: from 192.168.10.118(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.JAd1WJ3_1608733087)
          by smtp.aliyun-inc.com(10.147.43.230);
          Wed, 23 Dec 2020 22:18:07 +0800
Subject: Re: [PATCH phy] PHY: Ingenic: fix unconditional build of
 phy-ingenic-usb
To:     Alexander Lobakin <alobakin@pm.me>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20201222131021.4751-1-alobakin@pm.me>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <8b34319d-b085-853a-c2f8-384bd60f50ff@wanyeetech.com>
Date:   Wed, 23 Dec 2020 22:18:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201222131021.4751-1-alobakin@pm.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 2020/12/22 下午9:10, Alexander Lobakin wrote:
> Currently drivers/phy/ingenic/Makefile adds phy-ingenic-usb to targets
> not depending on actual Kconfig symbol CONFIG_PHY_INGENIC_USB, so this
> driver always gets built[-in] on every system.
> Add missing dependency.
>
> Fixes: 31de313dfdcf ("PHY: Ingenic: Add USB PHY driver using generic PHY framework.")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>   drivers/phy/ingenic/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Apologize for my carelessness, and

Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>


Thanks and best regards!


> diff --git a/drivers/phy/ingenic/Makefile b/drivers/phy/ingenic/Makefile
> index 65d5ea00fc9d..1cb158d7233f 100644
> --- a/drivers/phy/ingenic/Makefile
> +++ b/drivers/phy/ingenic/Makefile
> @@ -1,2 +1,2 @@
>   # SPDX-License-Identifier: GPL-2.0
> -obj-y		+= phy-ingenic-usb.o
> +obj-$(CONFIG_PHY_INGENIC_USB)		+= phy-ingenic-usb.o
