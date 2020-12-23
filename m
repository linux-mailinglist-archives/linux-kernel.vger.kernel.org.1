Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352592E1D58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgLWOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:16:25 -0500
Received: from out28-99.mail.aliyun.com ([115.124.28.99]:48463 "EHLO
        out28-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgLWOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:16:23 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08652065|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.496146-0.000596255-0.503258;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.JAd2Ezk_1608732932;
Received: from 192.168.10.118(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.JAd2Ezk_1608732932)
          by smtp.aliyun-inc.com(10.147.44.118);
          Wed, 23 Dec 2020 22:15:32 +0800
Subject: Re: [PATCH] phy: ingenic: Remove useless field .version
To:     Paul Cercueil <paul@crapouillou.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     =?UTF-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>,
        linux-kernel@vger.kernel.org
References: <20201223124505.40792-1-paul@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <67564e1e-a5a8-9e0f-6dc1-5e2ce1df5e5b@wanyeetech.com>
Date:   Wed, 23 Dec 2020 22:15:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201223124505.40792-1-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2020/12/23 下午8:45, Paul Cercueil wrote:
> Remove the useless field .version from the private structure, which is
> set but never read.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>   drivers/phy/ingenic/phy-ingenic-usb.c | 23 -----------------------
>   1 file changed, 23 deletions(-)


Reviewed-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>


Thanks and best regards!


>
> diff --git a/drivers/phy/ingenic/phy-ingenic-usb.c b/drivers/phy/ingenic/phy-ingenic-usb.c
> index 4d1587d82286..ea127b177f46 100644
> --- a/drivers/phy/ingenic/phy-ingenic-usb.c
> +++ b/drivers/phy/ingenic/phy-ingenic-usb.c
> @@ -82,18 +82,7 @@
>   #define USBPCR1_PORT_RST			BIT(21)
>   #define USBPCR1_WORD_IF_16BIT		BIT(19)
>   
> -enum ingenic_usb_phy_version {
> -	ID_JZ4770,
> -	ID_JZ4775,
> -	ID_JZ4780,
> -	ID_X1000,
> -	ID_X1830,
> -	ID_X2000,
> -};
> -
>   struct ingenic_soc_info {
> -	enum ingenic_usb_phy_version version;
> -
>   	void (*usb_phy_init)(struct phy *phy);
>   };
>   
> @@ -300,38 +289,26 @@ static void x2000_usb_phy_init(struct phy *phy)
>   }
>   
>   static const struct ingenic_soc_info jz4770_soc_info = {
> -	.version = ID_JZ4770,
> -
>   	.usb_phy_init = jz4770_usb_phy_init,
>   };
>   
>   static const struct ingenic_soc_info jz4775_soc_info = {
> -	.version = ID_JZ4775,
> -
>   	.usb_phy_init = jz4775_usb_phy_init,
>   };
>   
>   static const struct ingenic_soc_info jz4780_soc_info = {
> -	.version = ID_JZ4780,
> -
>   	.usb_phy_init = jz4780_usb_phy_init,
>   };
>   
>   static const struct ingenic_soc_info x1000_soc_info = {
> -	.version = ID_X1000,
> -
>   	.usb_phy_init = x1000_usb_phy_init,
>   };
>   
>   static const struct ingenic_soc_info x1830_soc_info = {
> -	.version = ID_X1830,
> -
>   	.usb_phy_init = x1830_usb_phy_init,
>   };
>   
>   static const struct ingenic_soc_info x2000_soc_info = {
> -	.version = ID_X2000,
> -
>   	.usb_phy_init = x2000_usb_phy_init,
>   };
>   
