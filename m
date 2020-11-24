Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E8B2C2371
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbgKXLAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:00:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:17580 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgKXLAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:00:24 -0500
IronPort-SDR: 4fuxdfLH0cANVwLD8F0+W8vnP4OZL0xNUORJ5CuQfPSTNiwoSMUM1zfE5OOJvFoTLLfYerib5h
 AjdMLwDKlzbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="158968018"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="158968018"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 03:00:24 -0800
IronPort-SDR: 7Srde/6ru/0gKKhg+a+Vrj08hTovIQC5xtCaacSiSQcJ8H2T99Wr45V/NZ3sm1b9cR3ZOb3aLW
 JxOhQOHourbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="432568841"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 Nov 2020 03:00:21 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 24 Nov 2020 13:00:20 +0200
Date:   Tue, 24 Nov 2020 13:00:20 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Message-ID: <20201124110020.GA1008337@kuha.fi.intel.com>
References: <20201123115051.30047-1-rogerq@ti.com>
 <20201124064242.GA32310@b29397-desktop>
 <89067b6a-5b94-d7d2-b07a-f434c9e5e2bd@ti.com>
 <DBBPR04MB797982E6E190F0C0E0980F258BFB0@DBBPR04MB7979.eurprd04.prod.outlook.com>
 <bdb2b4cb-686e-9283-bc66-78808b92c349@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb2b4cb-686e-9283-bc66-78808b92c349@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:33:34PM +0200, Roger Quadros wrote:
> +Heikki
> 
> Peter,
> 
> On 24/11/2020 11:57, Peter Chen wrote:
> > 
> > 
> > 
> > Best regards,
> > Peter Chen
> > 
> > > -----Original Message-----
> > > From: Roger Quadros <rogerq@ti.com>
> > > Sent: 2020年11月24日 17:39
> > > To: Peter Chen <peter.chen@nxp.com>
> > > Cc: pawell@cadence.com; gregkh@linuxfoundation.org; balbi@kernel.org;
> > > linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch class"
> > > 
> > > Peter,
> > > 
> > > On 24/11/2020 08:43, Peter Chen wrote:
> > > > On 20-11-23 13:50:51, Roger Quadros wrote:
> > > > > This reverts commit 50642709f6590fe40afa6d22c32f23f5b842aed5.
> > > > > 
> > > > > This commit breaks hardware based role switching on TI platforms.
> > > > > cdns->role_sw is always going to be non-zero as it is a pointer
> > > > > to the usb_role_switch instance. Some other means needs to be used if
> > > > > hardware based role switching is not required by the platform.
> > > > > 
> > > > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > > > ---
> > > > >    drivers/usb/cdns3/core.c | 4 ----
> > > > >    1 file changed, 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > > > > index a0f73d4711ae..4c1445cf2ad0 100644
> > > > > --- a/drivers/usb/cdns3/core.c
> > > > > +++ b/drivers/usb/cdns3/core.c
> > > > > @@ -280,10 +280,6 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
> > > > >    	enum usb_role real_role, current_role;
> > > > >    	int ret = 0;
> > > > > 
> > > > > -	/* Depends on role switch class */
> > > > > -	if (cdns->role_sw)
> > > > > -		return 0;
> > > > > -
> > > > >    	pm_runtime_get_sync(cdns->dev);
> > > > > 
> > > > >    	current_role = cdns->role;
> > > > > --
> > > > 
> > > > Hi Roger,
> > > > 
> > > > I am sorry about that. Do you use role switch /sys entry, if you have
> > > > used, I prefer using "usb-role-switch" property at dts to judge if SoC
> > > > OTG signals or external signals for role switch. If you have not used
> > > > it, I prefer only setting cdns->role_sw for role switch use cases.
> > > > 
> > > 
> > > We use both hardware role switch and /sys entries for manually forcing a
> > > certain role.
> > > 
> > > We do not set any "usb-role-switch" property at DTS.
> > > 
> > > Currently cdns->role_sw is being always set by driver irrespective of any DT
> > > property, so this patch is clearly wrong and needs to be reverted.
> > > 
> > > What do you think?
> > > 
> > 
> > Could you accept below fix?
> > 
> > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > index 2e469139769f..fdd52e87a7b2 100644
> > --- a/drivers/usb/cdns3/core.c
> > +++ b/drivers/usb/cdns3/core.c
> > @@ -280,8 +280,8 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
> >          enum usb_role real_role, current_role;
> >          int ret = 0;
> > 
> > -       /* Depends on role switch class */
> > -       if (cdns->role_sw)
> > +       /* quit if switch role through external signals */
> > +       if (device_property_read_bool(cdns->dev, "usb-role-switch"))
> >                  return 0;
> > 
> >          pm_runtime_get_sync(cdns->dev);
> 
> Although this will fix the issue I don't think this is making the driver to behave
> as expected with usb-role-switch property.
> 
> Now, even if usb-role-switch property is not present the driver will still register
> the role switch driver.
> 
> I think we need to register the role switch driver only if usb-role-switch property
> is present. We would also need to set the default role if role-switch-default-mode is present.
> 
> How about the following? It still doesn't handle role-switch-default-mode property though.
> 
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 4c1445cf2ad0..986b56a9940c 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -532,11 +532,13 @@ static int cdns3_probe(struct platform_device *pdev)
>  	if (device_property_read_bool(dev, "usb-role-switch"))
>  		sw_desc.fwnode = dev->fwnode;
> -	cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
> -	if (IS_ERR(cdns->role_sw)) {
> -		ret = PTR_ERR(cdns->role_sw);
> -		dev_warn(dev, "Unable to register Role Switch\n");
> -		goto err3;
> +	if (device_property_read_bool(cdns->dev, "usb-role-switch")) {
> +		cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
> +		if (IS_ERR(cdns->role_sw)) {
> +			ret = PTR_ERR(cdns->role_sw);
> +			dev_warn(dev, "Unable to register Role Switch\n");
> +			goto err3;
> +		}
>  	}
>  	if (cdns->wakeup_irq) {

Makes sense to me. FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
