Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258382C61B6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgK0JaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:30:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54552 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgK0JaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:30:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AR9UCLO048364;
        Fri, 27 Nov 2020 03:30:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606469412;
        bh=lHEin1UNZLFaGOvIOKjpzGEcFVTMutU0s11Moh+HW4Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZN+ueHWpTTVoglr2FEsw+N+LvpC3bk5ZD8I0W3P+OBkcFqyW4i3a0RtH2OG95CsGj
         GuP8mjyhQqf+63yKKucGUf8wELnfy6+keY6DDbNaJYYMbHXjHuSTLvTQ9omfKj1aIZ
         NmGqu+Mg2VuVxBK8E1j+LNRXk20hvWPvNO4U4mIY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AR9UCpb041067
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 03:30:12 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 27
 Nov 2020 03:30:11 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 27 Nov 2020 03:30:11 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AR9U9W6019490;
        Fri, 27 Nov 2020 03:30:10 -0600
Subject: Re: [PATCH] usb: cdns3: Fix hardware based role switch
To:     <peter.chen@nxp.com>, <pawell@cadence.com>
CC:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201125124936.5929-1-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <520dd6e0-d3d4-b471-6c65-143e094a4f74@ti.com>
Date:   Fri, 27 Nov 2020 11:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125124936.5929-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 25/11/2020 14:49, Roger Quadros wrote:
> Hardware based role switch is broken as the driver always skips it.
> Fix this by registering for  SW role switch only if 'usb-role-switch'
> property is present in the device tree.
> 
> Fixes: 50642709f659 ("usb: cdns3: core: quit if it uses role switch class")
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Can you please pick this up for -rc cycle, else otg will be broken for us in v5.10 release.
Thanks.

cheers,
-roger

> ---
>   drivers/usb/cdns3/core.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index a0f73d4711ae..170deb3eacf0 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -427,7 +427,6 @@ static irqreturn_t cdns3_wakeup_irq(int irq, void *data)
>    */
>   static int cdns3_probe(struct platform_device *pdev)
>   {
> -	struct usb_role_switch_desc sw_desc = { };
>   	struct device *dev = &pdev->dev;
>   	struct resource	*res;
>   	struct cdns3 *cdns;
> @@ -529,18 +528,21 @@ static int cdns3_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err2;
>   
> -	sw_desc.set = cdns3_role_set;
> -	sw_desc.get = cdns3_role_get;
> -	sw_desc.allow_userspace_control = true;
> -	sw_desc.driver_data = cdns;
> -	if (device_property_read_bool(dev, "usb-role-switch"))
> +	if (device_property_read_bool(dev, "usb-role-switch")) {
> +		struct usb_role_switch_desc sw_desc = { };
> +
> +		sw_desc.set = cdns3_role_set;
> +		sw_desc.get = cdns3_role_get;
> +		sw_desc.allow_userspace_control = true;
> +		sw_desc.driver_data = cdns;
>   		sw_desc.fwnode = dev->fwnode;
>   
> -	cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
> -	if (IS_ERR(cdns->role_sw)) {
> -		ret = PTR_ERR(cdns->role_sw);
> -		dev_warn(dev, "Unable to register Role Switch\n");
> -		goto err3;
> +		cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
> +		if (IS_ERR(cdns->role_sw)) {
> +			ret = PTR_ERR(cdns->role_sw);
> +			dev_warn(dev, "Unable to register Role Switch\n");
> +			goto err3;
> +		}
>   	}
>   
>   	if (cdns->wakeup_irq) {
> @@ -582,7 +584,8 @@ static int cdns3_probe(struct platform_device *pdev)
>   	return 0;
>   err4:
>   	cdns3_drd_exit(cdns);
> -	usb_role_switch_unregister(cdns->role_sw);
> +	if (cdns->role_sw)
> +		usb_role_switch_unregister(cdns->role_sw);
>   err3:
>   	set_phy_power_off(cdns);
>   err2:
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
