Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97349275927
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIWNwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:52:25 -0400
Received: from out28-124.mail.aliyun.com ([115.124.28.124]:46049 "EHLO
        out28-124.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgIWNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:52:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09110986|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0116857-0.00287512-0.985439;FP=0|0|0|0|0|-1|-1|-1;HT=e01l04362;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.IbEOa8W_1600869136;
Received: from 192.168.10.195(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IbEOa8W_1600869136)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 23 Sep 2020 21:52:17 +0800
Subject: Re: [PATCH v5 2/2] PHY: Ingenic: Add USB PHY driver using generic PHY
 framework.
To:     Vinod Koul <vkoul@kernel.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        paul@crapouillou.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
References: <20200921162417.52004-1-zhouyanjie@wanyeetech.com>
 <20200921162417.52004-3-zhouyanjie@wanyeetech.com>
 <20200923053500.GD2968@vkoul-mobl>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <cf9537d3-3b86-aa23-74fe-9cd49987c845@wanyeetech.com>
Date:   Wed, 23 Sep 2020 21:52:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200923053500.GD2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vinod,

在 2020/9/23 下午1:35, Vinod Koul 写道:
> On 22-09-20, 00:24, 周琰杰 (Zhou Yanjie) wrote:
>
>> +#define USBPCR_IDPULLUP_LSB	28
>> +#define USBPCR_IDPULLUP_MASK		GENMASK(29, USBPCR_IDPULLUP_LSB)
>> +#define USBPCR_IDPULLUP_ALWAYS		(0x2 << USBPCR_IDPULLUP_LSB)
>> +#define USBPCR_IDPULLUP_SUSPEND		(0x1 << USBPCR_IDPULLUP_LSB)
>> +#define USBPCR_IDPULLUP_OTG			(0x0 << USBPCR_IDPULLUP_LSB)
> why not define these as 0, 1, 2 and then use
> FIELD_PREP(value, USBPCR_IDPULLUP_MASK), please do this for rest as
> well.


Sure.

>> +static int ingenic_usb_phy_set_mode(struct phy *phy,
>> +				  enum phy_mode mode, int submode)
>> +{
>> +	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
>> +	u32 reg;
>> +
>> +	switch (mode) {
>> +	case PHY_MODE_USB_HOST:
>> +		reg = readl(priv->base + REG_USBPCR_OFFSET);
>> +		reg &= ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE);
> use u32_encode_bits or u32p_replace_bit to program registers using mask
> defined


Sure.

Thanks and best regards!

