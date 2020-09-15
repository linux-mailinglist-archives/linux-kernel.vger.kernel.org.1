Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862DB26B7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIPAdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:33:35 -0400
Received: from node.akkea.ca ([192.155.83.177]:32806 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgIONm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:42:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id CEB424E2058;
        Tue, 15 Sep 2020 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600176773; bh=W/EoS2mL7h2HrtkbP52JfusURqiS2FGXfXRqLggxE20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=iyKyaZdhQpR4Z1MLzZahoazEd75mFyw/dU0nyRjgcFp4d0VgkxNmDEYIAVg5ePB3u
         KNRiP9JwcpNNuDv2V8vBWvEFPIWAxrx42SEnkm75IhGinczudOM6nED2IQE4YVynde
         QLQrGDa55vSGpqOCOAXF05uCfG16EKMKTtqK75qI=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J_eV-NfgbEku; Tue, 15 Sep 2020 13:32:53 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id 596B04E200E;
        Tue, 15 Sep 2020 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1600176773; bh=W/EoS2mL7h2HrtkbP52JfusURqiS2FGXfXRqLggxE20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=iyKyaZdhQpR4Z1MLzZahoazEd75mFyw/dU0nyRjgcFp4d0VgkxNmDEYIAVg5ePB3u
         KNRiP9JwcpNNuDv2V8vBWvEFPIWAxrx42SEnkm75IhGinczudOM6nED2IQE4YVynde
         QLQrGDa55vSGpqOCOAXF05uCfG16EKMKTtqK75qI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Sep 2020 06:32:51 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kernel@puri.sm, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: Re: [PATCH 2/4] usb: typec: tps6589x: register as an extcon provider
In-Reply-To: <8e7247d6-9a4f-dc22-971f-9a253c159a37@samsung.com>
References: <20200914164639.1487650-1-angus@akkea.ca>
 <CGME20200914165842epcas1p2cb6c22eaf5de75678bb08abc8172abc2@epcas1p2.samsung.com>
 <20200914164639.1487650-3-angus@akkea.ca>
 <8e7247d6-9a4f-dc22-971f-9a253c159a37@samsung.com>
Message-ID: <b2e011b9d565bf73975a746d02429b9d@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-09-14 18:19, Chanwoo Choi wrote:
> Hi,
> 
> On 9/15/20 1:46 AM, Angus Ainslie wrote:
>> The tps6598x type C chip can negotiate the VBUS sink/source status as
>> well as the VBUS voltage and current. Notify the extcon consumers of
>> these changes.
>> 
>> Signed-off-by: Angus Ainslie <angus@akkea.ca>
>> ---
>>  drivers/usb/typec/tps6598x.c | 138 
>> +++++++++++++++++++++++++++++++++++
>>  1 file changed, 138 insertions(+)
>> 
>> diff --git a/drivers/usb/typec/tps6598x.c 
>> b/drivers/usb/typec/tps6598x.c
>> index 3db33bb622c3..3b06d43c810d 100644
>> --- a/drivers/usb/typec/tps6598x.c
>> +++ b/drivers/usb/typec/tps6598x.c
>> @@ -8,6 +8,8 @@
>> 
>>  #include <linux/i2c.h>
>>  #include <linux/acpi.h>
>> +#include <linux/extcon.h>
>> +#include <linux/extcon-provider.h>
>>  #include <linux/module.h>
>>  #include <linux/regmap.h>
>>  #include <linux/interrupt.h>
>> @@ -95,7 +97,12 @@ struct tps6598x {
>>  	struct typec_port *port;
>>  	struct typec_partner *partner;
>>  	struct usb_pd_identity partner_identity;
>> +
>>  	struct usb_role_switch *role_sw;
>> +
>> +#ifdef CONFIG_EXTCON
> 
> Is it necessary of 'ifdef CONFIG_EXTCON'?
> If you just add 'select EXTCON' for this driver,
> you don't need to check CONFIG_EXTCON.
> 
> If any device driver need some framework,
> we can add the 'select EXTCON'.
> 

Sure I can change that for v2

Angus

>> +	struct extcon_dev *edev;
>> +#endif
>>  };
>> 
>>  /*
>> @@ -209,6 +216,62 @@ static void tps6598x_set_data_role(struct 
>> tps6598x *tps,
>>  	typec_set_data_role(tps->port, role);
>>  }
>> 
>> +#ifdef CONFIG_EXTCON
>> +static void tps6589x_set_extcon_state(struct tps6598x *tps,
>> +				      u32 status, u16 pwr_status, bool state)
>> +{
>> +	union extcon_property_value val;
>> +	int max_current;
>> +
>> +	if (TPS_STATUS_DATAROLE(status)) {
>> +		extcon_set_state(tps->edev, EXTCON_USB, false);
>> +		extcon_set_state(tps->edev, EXTCON_USB_HOST, state);
>> +	} else {
>> +		extcon_set_state(tps->edev, EXTCON_USB, state);
>> +		extcon_set_state(tps->edev, EXTCON_USB_HOST, false);
>> +	}
>> +
>> +	val.intval = TPS_STATUS_PORTROLE(status);
>> +	extcon_set_property(tps->edev, EXTCON_USB_HOST,
>> +			    EXTCON_PROP_USB_VBUS_SRC,
>> +			    val);
>> +
>> +	extcon_set_property(tps->edev, EXTCON_USB,
>> +			    EXTCON_PROP_USB_VBUS_SRC,
>> +			    val);
>> +
>> +	switch (TPS_POWER_STATUS_PWROPMODE(pwr_status)) {
>> +	case TYPEC_PWR_MODE_USB:
>> +		max_current = 500;
>> +		extcon_set_state(tps->edev, EXTCON_CHG_USB_SDP, state);
>> +		extcon_set_state(tps->edev, EXTCON_CHG_USB_SLOW, state);
>> +		break;
>> +	case TYPEC_PWR_MODE_1_5A:
>> +		max_current = 1500;
>> +		break;
>> +	case TYPEC_PWR_MODE_3_0A:
>> +		max_current = 3000;
>> +		break;
>> +	case TYPEC_PWR_MODE_PD:
>> +		max_current = 500;
>> +		break;
>> +	}
>> +
>> +	val.intval = max_current;
>> +	extcon_set_property(tps->edev, EXTCON_USB,
>> +			    EXTCON_PROP_USB_VBUS_CURRENT,
>> +			    val);
>> +	extcon_set_property(tps->edev, EXTCON_USB_HOST,
>> +			    EXTCON_PROP_USB_VBUS_CURRENT,
>> +			    val);
>> +
>> +	extcon_sync(tps->edev, EXTCON_USB);
>> +	extcon_sync(tps->edev, EXTCON_USB_HOST);
>> +	extcon_sync(tps->edev, EXTCON_CHG_USB_SDP);
>> +	extcon_sync(tps->edev, EXTCON_CHG_USB_SLOW);
>> +}
>> +#endif
>> +
>>  static int tps6598x_connect(struct tps6598x *tps, u32 status)
>>  {
>>  	struct typec_partner_desc desc;
>> @@ -248,18 +311,41 @@ static int tps6598x_connect(struct tps6598x 
>> *tps, u32 status)
>>  	if (desc.identity)
>>  		typec_partner_set_identity(tps->partner);
>> 
>> +#ifdef CONFIG_EXTCON
>> +	tps6598x_set_extcon_state(tps, status, pwr_status, true);
>> +#endif
>> +
>>  	return 0;
>>  }
>> 
>>  static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>>  {
>> +	enum typec_pwr_opmode mode;
>> +	u16 pwr_status;
>> +	int ret;
>> +
>>  	if (!IS_ERR(tps->partner))
>>  		typec_unregister_partner(tps->partner);
>>  	tps->partner = NULL;
>>  	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
>>  	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
>>  	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
>> +	typec_set_data_role(tps->port, TPS_STATUS_DATAROLE(status));
>>  	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), false);
>> +
>> +	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	mode = TPS_POWER_STATUS_PWROPMODE(pwr_status);
>> +
>> +	dev_dbg(tps->dev, "%s: mode 0x%x pwr_role %d vconn_role %d data_role 
>> %d\n",
>> +		__func__, mode, TPS_STATUS_PORTROLE(status),
>> +		TPS_STATUS_VCONN(status), TPS_STATUS_DATAROLE(status));
>> +
>> +#ifdef CONFIG_EXTCON
>> +	tps6598x_set_extcon_state(tps, status, 0, false);
>> +#endif
>>  }
>> 
>>  static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
>> @@ -407,6 +493,9 @@ static irqreturn_t tps6598x_interrupt(int irq, 
>> void *data)
>>  		goto err_unlock;
>>  	}
>> 
>> +	dev_dbg(tps->dev, "Received irq event: 0x%llx: 0x%x 0x%x", event1,
>> +	       (u32)((event1 & 0xFFFFFFFF00000000) >> 32), (u32)(event1 & 
>> 0xFFFFFFFF));
>> +
>>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>>  	if (ret) {
>>  		dev_err(tps->dev, "%s: failed to read status\n", __func__);
>> @@ -467,6 +556,18 @@ static const struct regmap_config 
>> tps6598x_regmap_config = {
>>  	.max_register = 0x7F,
>>  };
>> 
>> +#ifdef CONFIG_EXTCON
>> +/* List of detectable cables */
>> +static const unsigned int tps6598x_extcon_cable[] = {
>> +	EXTCON_USB,
>> +	EXTCON_USB_HOST,
>> +	EXTCON_CHG_USB_SDP,
>> +	EXTCON_CHG_USB_SLOW,
>> +	EXTCON_CHG_USB_FAST,
>> +	EXTCON_NONE,
>> +};
>> +#endif
>> +
>>  static int tps6598x_probe(struct i2c_client *client)
>>  {
>>  	struct typec_capability typec_cap = { };
>> @@ -567,10 +668,47 @@ static int tps6598x_probe(struct i2c_client 
>> *client)
>>  	}
>>  	fwnode_handle_put(fwnode);
>> 
>> +#ifdef CONFIG_EXTCON
>> +	/* Allocate extcon device */
>> +	tps->edev = devm_extcon_dev_allocate(tps->dev, 
>> tps6598x_extcon_cable);
>> +	if (IS_ERR(tps->edev)) {
>> +		dev_err(tps->dev, "failed to allocate memory for extcon\n");
>> +		typec_unregister_port(tps->port);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* Register extcon device */
>> +	ret = devm_extcon_dev_register(tps->dev, tps->edev);
>> +	if (ret) {
>> +		dev_err(tps->dev, "failed to register extcon device\n");
>> +		typec_unregister_port(tps->port);
>> +		return ret;
>> +	}
>> +
>> +	extcon_set_property_capability(tps->edev, EXTCON_USB,
>> +				       EXTCON_PROP_USB_VBUS);
>> +	extcon_set_property_capability(tps->edev, EXTCON_USB,
>> +				       EXTCON_PROP_USB_VBUS_SRC);
>> +	extcon_set_property_capability(tps->edev, EXTCON_USB,
>> +				       EXTCON_PROP_USB_VBUS_VOLTAGE);
>> +	extcon_set_property_capability(tps->edev, EXTCON_USB,
>> +				       EXTCON_PROP_USB_VBUS_CURRENT);
>> +	extcon_set_property_capability(tps->edev, EXTCON_USB_HOST,
>> +				       EXTCON_PROP_USB_VBUS);
>> +	extcon_set_property_capability(tps->edev, EXTCON_USB_HOST,
>> +				       EXTCON_PROP_USB_VBUS_SRC);
>> +	extcon_set_property_capability(tps->edev, EXTCON_USB_HOST,
>> +				       EXTCON_PROP_USB_VBUS_VOLTAGE);
>> +	extcon_set_property_capability(tps->edev, EXTCON_USB_HOST,
>> +				       EXTCON_PROP_USB_VBUS_CURRENT);
>> +#endif
>> +
>>  	if (status & TPS_STATUS_PLUG_PRESENT) {
>>  		ret = tps6598x_connect(tps, status);
>>  		if (ret)
>>  			dev_err(&client->dev, "failed to register partner\n");
>> +	} else {
>> +		tps6598x_disconnect(tps, status);
>>  	}
>> 
>>  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> 
