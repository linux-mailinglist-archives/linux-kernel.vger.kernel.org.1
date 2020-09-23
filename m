Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63230275052
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgIWFfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgIWFfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:35:08 -0400
Received: from localhost (unknown [122.171.175.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DCC121941;
        Wed, 23 Sep 2020 05:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600839308;
        bh=hTSh7qO88VKPRymrehhoxetyDUSrBV1c5QP63btuvjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4qWTiTR8GjSbbpNPGNXfZsbwH61S5EfNAA6rFFvVvKtgG5bLR5YaU99RfTKiINkZ
         0+agSqQ7Bxtz0rY+YC5dtVci8i6zz3jGz3knISpTA2OH6o0BwCStYU6cwA3g6R1eW1
         uV/qIg1FvmXWMQt7smHta4aFS7WMa5MxkSyj7Obw=
Date:   Wed, 23 Sep 2020 11:05:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        paul@crapouillou.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: Re: [PATCH v5 2/2] PHY: Ingenic: Add USB PHY driver using generic
 PHY framework.
Message-ID: <20200923053500.GD2968@vkoul-mobl>
References: <20200921162417.52004-1-zhouyanjie@wanyeetech.com>
 <20200921162417.52004-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200921162417.52004-3-zhouyanjie@wanyeetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-20, 00:24, 周琰杰 (Zhou Yanjie) wrote:

> +#define USBPCR_IDPULLUP_LSB	28
> +#define USBPCR_IDPULLUP_MASK		GENMASK(29, USBPCR_IDPULLUP_LSB)
> +#define USBPCR_IDPULLUP_ALWAYS		(0x2 << USBPCR_IDPULLUP_LSB)
> +#define USBPCR_IDPULLUP_SUSPEND		(0x1 << USBPCR_IDPULLUP_LSB)
> +#define USBPCR_IDPULLUP_OTG			(0x0 << USBPCR_IDPULLUP_LSB)

why not define these as 0, 1, 2 and then use
FIELD_PREP(value, USBPCR_IDPULLUP_MASK), please do this for rest as
well.

> +static int ingenic_usb_phy_set_mode(struct phy *phy,
> +				  enum phy_mode mode, int submode)
> +{
> +	struct ingenic_usb_phy *priv = phy_get_drvdata(phy);
> +	u32 reg;
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +		reg = readl(priv->base + REG_USBPCR_OFFSET);
> +		reg &= ~(USBPCR_VBUSVLDEXT | USBPCR_VBUSVLDEXTSEL | USBPCR_OTG_DISABLE);

use u32_encode_bits or u32p_replace_bit to program registers using mask
defined
-- 
~Vinod
