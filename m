Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865822B9565
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgKSOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:44:11 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:42097 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgKSOoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605797041; x=1637333041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODOE2kIkgZGI3tHS05FNlvmfmNJrwKtpsxbo9DmSxmo=;
  b=GuJmXDDodMxpNnBeo6v8tbCan+6/CGSKA1H53SpXUdW5HXcA8ANXWDBT
   6DdbvhOEFWHUu6u+tUUm9V61dS37ITt9q3RUzsCCWmPgibDEn0+k88EXP
   6X4BW9Nho3TDgWiQKorSWqJJBwVSXcJ5RzjG2TicgwIy2+h6PXmU+XK+D
   HtsrQC5U/Tkbpy8pxtcar9WGuX1Pj18ifzcfzYOK/23V9EY/wr3/pYBls
   lVgVisV3LHPhiHjJF+JB+LAYkTOhnTFGQvKCrAnh2l6OIoQW5xvbrNcfh
   I0XrYCHKV9dQuZ9RE4fXdFfXj/ssPUD60dO2UXaw4PEmEYtDZmSLab66u
   w==;
IronPort-SDR: lqN/zlpZ7diKaDwUdOCSNeNK8VxuGnzUCjZUpG4U2/tZExBugUdfB274HdscUwnTdv6ZDJMuGn
 7k4YRAJy9tbBMC/VSKNGEAGLs7e3693niPMxmsYfXoa2vhWfQPofkXINASj7MKQtEzV1zsJUfO
 YPuG/mKrxfSJJPcVti7/QWWEX9ULh3qtbXJdxKZFc7QrhJbFYZnqJjUymM2BKqZ0jY0uWSPOA/
 2hD3n0JTjBmxm140hQFx2q9bVlDtiArAqK2nHyA8ELaamV37P7i6S0UghkW67t4shmg36XwGtY
 lxY=
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="94238519"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Nov 2020 07:44:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 19 Nov 2020 07:44:00 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 19 Nov 2020 07:44:00 -0700
Date:   Thu, 19 Nov 2020 15:43:59 +0100
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] phy: Add ethernet serdes configuration option
Message-ID: <20201119144359.y5scnscmb7nvptnv@mchp-dev-shegelun>
References: <20201110144910.558164-1-steen.hegelund@microchip.com>
 <20201110144910.558164-3-steen.hegelund@microchip.com>
 <20201119060727.GA50232@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20201119060727.GA50232@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2020 11:37, Vinod Koul wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>On 10-11-20, 15:49, Steen Hegelund wrote:
>> Provide a new ethernet phy configuration structure, that
>> allow PHYs used for ethernet to be configured with
>> speed, media type and clock information.
>>
>> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
>> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
>> ---
>>  include/linux/phy/phy-ethernet-serdes.h | 49 +++++++++++++++++++++++++
>>  include/linux/phy/phy.h                 |  4 ++
>>  2 files changed, 53 insertions(+)
>>  create mode 100644 include/linux/phy/phy-ethernet-serdes.h
>>
>> diff --git a/include/linux/phy/phy-ethernet-serdes.h b/include/linux/phy/phy-ethernet-serdes.h
>> new file mode 100644
>> index 000000000000..04f496855b00
>> --- /dev/null
>> +++ b/include/linux/phy/phy-ethernet-serdes.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Microchip Sparx5 Ethernet SerDes driver
>> + *
>> + * Copyright (c) 2020 Microschip Inc
>> + */
>> +#ifndef __PHY_ETHERNET_SERDES_H_
>> +#define __PHY_ETHERNET_SERDES_H_
>> +
>> +#include <linux/phy.h>
>> +
>> +enum ethernet_media_type {
>> +     ETH_MEDIA_DEFAULT,
>> +     ETH_MEDIA_SR,
>> +     ETH_MEDIA_DAC,
>> +};
>> +
>> +/**
>> + * struct phy_configure_opts_eth_serdes - Ethernet SerDes
>> + *
>> + * This structure is used to represent the configuration state of a
>> + * Ethernet Serdes PHY.
>> + */
>> +struct phy_configure_opts_eth_serdes {
>> +     /**
>> +      * @speed
>> +      *
>> +      * Speed of the serdes interface in Mbps
>> +      */
>
>Can we have this in kernel-doc style pls
>
I will update the documentation.
>> +     u32                        speed;
>> +
>> +     /**
>> +      * @media_type
>> +      *
>> +      * Specifies which media the serdes will be using
>> +      */
>> +     enum ethernet_media_type   media_type;
>> +
>> +     /**
>> +      * @clk
>> +      *
>> +      * Specifies the serdes clock in MHz
>> +      * Default: 0 will provide the highest supported clock.
>> +      */
>> +     u32                        clk;
>
>Why not use std clk interface for this..?

I am not familiar with that.  Is that the max_link_rate in struct phy_attrs?

>
>> +};
>> +
>> +#endif
>> +
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index e435bdb0bab3..78ecb375cede 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -18,6 +18,7 @@
>>
>>  #include <linux/phy/phy-dp.h>
>>  #include <linux/phy/phy-mipi-dphy.h>
>> +#include <linux/phy/phy-ethernet-serdes.h>
>>
>>  struct phy;
>>
>> @@ -49,11 +50,14 @@ enum phy_mode {
>>   *
>>   * @mipi_dphy:       Configuration set applicable for phys supporting
>>   *           the MIPI_DPHY phy mode.
>> + * @eth_serdes: Configuration set applicable for phys supporting
>> + *           the ethernet serdes.
>>   * @dp:              Configuration set applicable for phys supporting
>>   *           the DisplayPort protocol.
>>   */
>>  union phy_configure_opts {
>>       struct phy_configure_opts_mipi_dphy     mipi_dphy;
>> +     struct phy_configure_opts_eth_serdes    eth_serdes;
>
>Kishon, does this look okay for you..?
>
>>       struct phy_configure_opts_dp            dp;
>>  };
>>
>> --
>> 2.29.2
>
>--
>~Vinod

BR
Steen

---------------------------------------
Steen Hegelund
steen.hegelund@microchip.com
