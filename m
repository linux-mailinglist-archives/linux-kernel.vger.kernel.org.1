Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF82B94B0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgKSOda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:33:30 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:2466 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgKSOd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605796409; x=1637332409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EryXLtksqUTjCr90l+ELQYDzcQvepnCIxru6lel/q0E=;
  b=oPoFIcaJGF+qGgI450zML+AlocTpufvtWFIzCoyOE/5zlqwkSMTPMVI9
   MekxrxWqQmzVNHG+wn6kywZDeZ9owasV5sOYPuS0XMzVj0rKVqYedv+Ta
   8S6ZeDanzWUmGiLhidf+L+ZRIFhNT0e1Agqkj55qYqEND8ubr0L8Op4bU
   5qnv/yiuI2IcKw7TsLA5s8/dmsI7lps+QsVBOivMptoJ1QAAaNCEMMzO4
   KQxW8YuEaTEV8chkB6OlH2ZDWd1q+sS0ANAKJSWTCfBOmnA53XVw68XuW
   9spv6m5+4mKRR3jTkNYGCsqTSj982QGCIbsNFEdRTjoRX0CYsTergZmqn
   A==;
IronPort-SDR: OdCWfTHBDJVQQL5ZZmW6ySzM3O6dHpZ4p6kF/1MJaPn6pEwOgkYXvjmVNRNlhv8aDFKYJ5ysIP
 i32L2ehtFc0f3j0xonFGEQxYKQthnFi/KEtOczGklMtrOJ1AI9id8oiSkbYEJOneNlGj2StYpi
 qvR/TqbE5Z4/z++WBiplI4iEKnShQFiJK5JwmkoPox7gqbMFQFoRhvpC8H17vYFTBmgP7dCezL
 2KOZ+uuDl+jaYvG4XWJXxOKZuECJUqGWFHJ2r6DCPvid+4JdJkk40T4fmEm69BwMyX12Wvq6Hj
 GSY=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="96923968"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:33:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:33:28 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 19 Nov 2020 07:33:28 -0700
Date:   Thu, 19 Nov 2020 15:33:27 +0100
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] phy: Add Sparx5 ethernet serdes PHY driver
Message-ID: <20201119143327.z7hnl5ajedarvkhx@mchp-dev-shegelun>
References: <20201110144910.558164-1-steen.hegelund@microchip.com>
 <20201110144910.558164-4-steen.hegelund@microchip.com>
 <20201119061401.GB50232@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20201119061401.GB50232@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2020 11:44, Vinod Koul wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>On 10-11-20, 15:49, Steen Hegelund wrote:
>> Add the Microchip Sparx5 ethernet serdes PHY driver for the 6G, 10G and 25G
>> interfaces available in the Sparx5 SoC.
>>
>> Signed-off-by: Bjarni Jonasson <bjarni.jonasson@microchip.com>
>> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
>> ---
>>  drivers/phy/Kconfig                        |    1 +
>>  drivers/phy/Makefile                       |    1 +
>>  drivers/phy/microchip/Kconfig              |   12 +
>>  drivers/phy/microchip/Makefile             |    6 +
>>  drivers/phy/microchip/sparx5_serdes.c      | 2464 +++++++++++++++++
>>  drivers/phy/microchip/sparx5_serdes_regs.h | 2773 ++++++++++++++++++++
>>  6 files changed, 5257 insertions(+)
>>  create mode 100644 drivers/phy/microchip/Kconfig
>>  create mode 100644 drivers/phy/microchip/Makefile
>>  create mode 100644 drivers/phy/microchip/sparx5_serdes.c
>>  create mode 100644 drivers/phy/microchip/sparx5_serdes_regs.h
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index 01b53f86004c..ef0d17829610 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -71,6 +71,7 @@ source "drivers/phy/marvell/Kconfig"
>>  source "drivers/phy/mediatek/Kconfig"
>>  source "drivers/phy/motorola/Kconfig"
>>  source "drivers/phy/mscc/Kconfig"
>> +source "drivers/phy/microchip/Kconfig"
>
>Sorted please

I will update the list.
>
>>  source "drivers/phy/qualcomm/Kconfig"
>>  source "drivers/phy/ralink/Kconfig"
>>  source "drivers/phy/renesas/Kconfig"
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index 6eb2916773c5..822040e1aaa7 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -21,6 +21,7 @@ obj-y                                       += allwinner/   \
>>                                          mediatek/    \
>>                                          motorola/    \
>>                                          mscc/        \
>> +                                        microchip/   \
>
>Here as well

OK
>
>>                                          qualcomm/    \
>>                                          ralink/      \
>>                                          renesas/     \

...


>> 2.29.2
>
>--
>~Vinod

BR
Steen

---------------------------------------
Steen Hegelund
steen.hegelund@microchip.com
