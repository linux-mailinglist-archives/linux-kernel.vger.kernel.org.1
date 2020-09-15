Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF1269ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOBHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:07:34 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55659 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgIOBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:07:32 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200915010727epoutp023f892794bf433de2c8fdc4f9aa0a1f45~0z56M8Xgq0874808748epoutp02R
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:07:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200915010727epoutp023f892794bf433de2c8fdc4f9aa0a1f45~0z56M8Xgq0874808748epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600132047;
        bh=9RPRcnwaA88M4uL+mqJMzRSrgxtOc8ONu/rwhQ4/Ot8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vgXXDZOXkikSWIhjEDDRNUeLpSogSmi366lUlVT/EGKRjak86pF7bFD/D+aL1P3Kb
         eZhrSo8UtcyObWm+GOMRIPWi/6w1AwQ8ha+nWZOzJuxXeja/0cfpZ8kkG0U//L1jyN
         LQcuUkTnWNeKhjtP91oYOm51EynbIcvhkMAzBJVg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200915010727epcas1p29ee1b87ecbbb0c3b23c97a912abfff28~0z55wNVQk0504705047epcas1p2U;
        Tue, 15 Sep 2020 01:07:27 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Br4p431JSzMqYm0; Tue, 15 Sep
        2020 01:07:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.F7.28581.7C3106F5; Tue, 15 Sep 2020 10:07:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200915010718epcas1p206324d14b3b44c1b440a3735ea2b551b~0z5yLxFll0950909509epcas1p2z;
        Tue, 15 Sep 2020 01:07:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200915010718epsmtrp1b5462598a53949e56ac0de8ddb5bd3e3~0z5yEXYgf1202112021epsmtrp1M;
        Tue, 15 Sep 2020 01:07:18 +0000 (GMT)
X-AuditID: b6c32a38-2cdff70000006fa5-09-5f6013c7b387
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.E2.08303.6C3106F5; Tue, 15 Sep 2020 10:07:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200915010718epsmtip24789a8af6441ec925788d072231a07c4~0z5x3t_cB1185511855epsmtip2_;
        Tue, 15 Sep 2020 01:07:18 +0000 (GMT)
Subject: Re: [PATCH 2/4] usb: typec: tps6589x: register as an extcon
 provider
To:     Angus Ainslie <angus@akkea.ca>, kernel@puri.sm
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8e7247d6-9a4f-dc22-971f-9a253c159a37@samsung.com>
Date:   Tue, 15 Sep 2020 10:19:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200914164639.1487650-3-angus@akkea.ca>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmge5x4YR4g4sNMhaP799mtFjy6hiT
        RfPi9WwWXat3sljMb5vBYnF51xw2i0XLWpktbjeuYHPg8JjatYLR4861PWwe804Geuyfu4bd
        49GOW4wefVtWMXp83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCX
        mJtqq+TiE6DrlpkDdJSSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4
        NC9dLzk/18rQwMDIFKgwITvj8a5tbAVHrSq2fLvO0sC4Ur+LkZNDQsBE4uKdCYxdjFwcQgI7
        GCU23/zPBOF8YpRY+K6TGcL5zCixZP1d9i5GDrCWF1+zIeK7GCXOfjoI1fGeUWJa60s2kLnC
        Av4SK78uZgJpEBEwkrh/NRWkhlngFaPEsrWX2EFq2AS0JPa/uAFWzy+gKHH1x2NGEJtXwE7i
        3cnzLCA2i4CqxP73O8FsUYEwiZPbWqBqBCVOznwCFucUMJP48+0hK4jNLCAucevJfCYIW15i
        +9s5YB9ICGzhkDj19AArxNMuEhcfv2WEsIUlXh3fwg5hS0m87G+DsqslVp48wgbR3MEosWX/
        BahmY4n9SyeDfcYsoCmxfhc0IBUldv6eywixmE/i3dceVkho8Up0tAlBlChLXH5wlwnClpRY
        3N7JNoFRaRaSd2YheWEWkhdmISxbwMiyilEstaA4Nz212LDABDm2NzGCE6yWxQ7GuW8/6B1i
        ZOJgPMQowcGsJMJ7oDE+Xog3JbGyKrUoP76oNCe1+BCjKTCAJzJLiSbnA1N8Xkm8oamRsbGx
        hYmhmamhoZI478NbCvFCAumJJanZqakFqUUwfUwcnFINTJ32ze8ktqZutUmTvBoTrnXrmmPt
        Xef+74oeESYbl3LGyFfk68pu3rfG83P2TyHzul0TyrguX/j8u68lKiMn5ZhvLfddeXGNi5/e
        XvjbFN9yst9BZ7ETQ/E0laCybTuTa9pK5eTrkkP0VnRx7FNzvtLJUSa2uei1+5ett05c/fmi
        96SMrdXk9kUZ6/h47lyVM7h/ruOTcfZR2xDuQwoiDEemHtbL2qmx+92TFyrOgfmP1j02O7F5
        D7Pj/kk8O3mi7cMcny1Ke9YtEdIetbuu6a7HnDMVazoOL1LPsQ5WU8k4LnDbaNeLg905u/1e
        PVOSi13ot2pXbCRHdsfe3/weB2QPzznaZBNy5/RjCb0AJZbijERDLeai4kQA+HpGZzkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO4x4YR4g30dWhaP799mtFjy6hiT
        RfPi9WwWXat3sljMb5vBYnF51xw2i0XLWpktbjeuYHPg8JjatYLR4861PWwe804Geuyfu4bd
        49GOW4wefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlfF41za2gqNWFVu+XWdpYFyp38XIwSEh
        YCLx4mt2FyMXh5DADkaJnzeOsXYxcgLFJSWmXTzKDFEjLHH4cDFEzVtGid7zO9lBaoQFfCWe
        npnIDlIjImAkcf9qKkgNs8AbRoltl24xQTRsZZSYtHYTC0gDm4CWxP4XN9hAbH4BRYmrPx4z
        gti8AnYS706eB6thEVCV2P9+J5gtKhAmsXPJYyaIGkGJkzOfgMU5Bcwk/nx7CHYos4C6xJ95
        l5ghbHGJW0/mM0HY8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5
        XnFibnFpXrpecn7uJkZwpGlp7WDcs+qD3iFGJg7GQ4wSHMxKIrwHGuPjhXhTEiurUovy44tK
        c1KLDzFKc7AoifN+nbUwTkggPbEkNTs1tSC1CCbLxMEp1cB00ucb8//Qf9xX33dp7YzeMili
        5Zyzt+6vvqPhsWbT8Tdzgh7O3mHHkfKRW6z06L8Pp5+tkq94Nv/9xMQN9wKKM+PvnWFV52Ln
        al4umjj77eHHK32LKiaLnUl+YHSJ1Tpz8d2t9zvYI3PTBGNYQ0IS+xccDOr53Dl/3ZT7O0q1
        SsVOm1XcjVz7xu+3+7MIoYLz7z/viT2itf39/AKLDYkSXyNUGeKkQh589F4mI2Xq9Nzy9sXa
        72I79sxNFTz5+IflGleRU/q/veWk/jqdnxL054lKwI6axyZHP0Tfaa1dxTkpXm5936Xs62v2
        y1u1OOyZbHb6Z+NLzYiyZf7KQZal1Q+m/fC/25zEvkhxc9wrASWW4oxEQy3mouJEAFlvhgIj
        AwAA
X-CMS-MailID: 20200915010718epcas1p206324d14b3b44c1b440a3735ea2b551b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200914165842epcas1p2cb6c22eaf5de75678bb08abc8172abc2
References: <20200914164639.1487650-1-angus@akkea.ca>
        <CGME20200914165842epcas1p2cb6c22eaf5de75678bb08abc8172abc2@epcas1p2.samsung.com>
        <20200914164639.1487650-3-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/20 1:46 AM, Angus Ainslie wrote:
> The tps6598x type C chip can negotiate the VBUS sink/source status as
> well as the VBUS voltage and current. Notify the extcon consumers of
> these changes.
> 
> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> ---
>  drivers/usb/typec/tps6598x.c | 138 +++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index 3db33bb622c3..3b06d43c810d 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -8,6 +8,8 @@
>  
>  #include <linux/i2c.h>
>  #include <linux/acpi.h>
> +#include <linux/extcon.h>
> +#include <linux/extcon-provider.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/interrupt.h>
> @@ -95,7 +97,12 @@ struct tps6598x {
>  	struct typec_port *port;
>  	struct typec_partner *partner;
>  	struct usb_pd_identity partner_identity;
> +
>  	struct usb_role_switch *role_sw;
> +
> +#ifdef CONFIG_EXTCON

Is it necessary of 'ifdef CONFIG_EXTCON'?
If you just add 'select EXTCON' for this driver,
you don't need to check CONFIG_EXTCON.

If any device driver need some framework, 
we can add the 'select EXTCON'.

> +	struct extcon_dev *edev;
> +#endif
>  };
>  
>  /*
> @@ -209,6 +216,62 @@ static void tps6598x_set_data_role(struct tps6598x *tps,
>  	typec_set_data_role(tps->port, role);
>  }
>  
> +#ifdef CONFIG_EXTCON
> +static void tps6589x_set_extcon_state(struct tps6598x *tps,
> +				      u32 status, u16 pwr_status, bool state)
> +{
> +	union extcon_property_value val;
> +	int max_current;
> +
> +	if (TPS_STATUS_DATAROLE(status)) {
> +		extcon_set_state(tps->edev, EXTCON_USB, false);
> +		extcon_set_state(tps->edev, EXTCON_USB_HOST, state);
> +	} else {
> +		extcon_set_state(tps->edev, EXTCON_USB, state);
> +		extcon_set_state(tps->edev, EXTCON_USB_HOST, false);
> +	}
> +
> +	val.intval = TPS_STATUS_PORTROLE(status);
> +	extcon_set_property(tps->edev, EXTCON_USB_HOST,
> +			    EXTCON_PROP_USB_VBUS_SRC,
> +			    val);
> +
> +	extcon_set_property(tps->edev, EXTCON_USB,
> +			    EXTCON_PROP_USB_VBUS_SRC,
> +			    val);
> +
> +	switch (TPS_POWER_STATUS_PWROPMODE(pwr_status)) {
> +	case TYPEC_PWR_MODE_USB:
> +		max_current = 500;
> +		extcon_set_state(tps->edev, EXTCON_CHG_USB_SDP, state);
> +		extcon_set_state(tps->edev, EXTCON_CHG_USB_SLOW, state);
> +		break;
> +	case TYPEC_PWR_MODE_1_5A:
> +		max_current = 1500;
> +		break;
> +	case TYPEC_PWR_MODE_3_0A:
> +		max_current = 3000;
> +		break;
> +	case TYPEC_PWR_MODE_PD:
> +		max_current = 500;
> +		break;
> +	}
> +
> +	val.intval = max_current;
> +	extcon_set_property(tps->edev, EXTCON_USB,
> +			    EXTCON_PROP_USB_VBUS_CURRENT,
> +			    val);
> +	extcon_set_property(tps->edev, EXTCON_USB_HOST,
> +			    EXTCON_PROP_USB_VBUS_CURRENT,
> +			    val);
> +
> +	extcon_sync(tps->edev, EXTCON_USB);
> +	extcon_sync(tps->edev, EXTCON_USB_HOST);
> +	extcon_sync(tps->edev, EXTCON_CHG_USB_SDP);
> +	extcon_sync(tps->edev, EXTCON_CHG_USB_SLOW);
> +}
> +#endif
> +
>  static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  {
>  	struct typec_partner_desc desc;
> @@ -248,18 +311,41 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  	if (desc.identity)
>  		typec_partner_set_identity(tps->partner);
>  
> +#ifdef CONFIG_EXTCON
> +	tps6598x_set_extcon_state(tps, status, pwr_status, true);
> +#endif
> +
>  	return 0;
>  }
>  
>  static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  {
> +	enum typec_pwr_opmode mode;
> +	u16 pwr_status;
> +	int ret;
> +
>  	if (!IS_ERR(tps->partner))
>  		typec_unregister_partner(tps->partner);
>  	tps->partner = NULL;
>  	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
>  	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
>  	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
> +	typec_set_data_role(tps->port, TPS_STATUS_DATAROLE(status));
>  	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), false);
> +
> +	ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &pwr_status);
> +	if (ret < 0)
> +		return;
> +
> +	mode = TPS_POWER_STATUS_PWROPMODE(pwr_status);
> +
> +	dev_dbg(tps->dev, "%s: mode 0x%x pwr_role %d vconn_role %d data_role %d\n",
> +		__func__, mode, TPS_STATUS_PORTROLE(status),
> +		TPS_STATUS_VCONN(status), TPS_STATUS_DATAROLE(status));
> +
> +#ifdef CONFIG_EXTCON
> +	tps6598x_set_extcon_state(tps, status, 0, false);
> +#endif
>  }
>  
>  static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
> @@ -407,6 +493,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  		goto err_unlock;
>  	}
>  
> +	dev_dbg(tps->dev, "Received irq event: 0x%llx: 0x%x 0x%x", event1,
> +	       (u32)((event1 & 0xFFFFFFFF00000000) >> 32), (u32)(event1 & 0xFFFFFFFF));
> +
>  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
>  	if (ret) {
>  		dev_err(tps->dev, "%s: failed to read status\n", __func__);
> @@ -467,6 +556,18 @@ static const struct regmap_config tps6598x_regmap_config = {
>  	.max_register = 0x7F,
>  };
>  
> +#ifdef CONFIG_EXTCON
> +/* List of detectable cables */
> +static const unsigned int tps6598x_extcon_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +	EXTCON_CHG_USB_SDP,
> +	EXTCON_CHG_USB_SLOW,
> +	EXTCON_CHG_USB_FAST,
> +	EXTCON_NONE,
> +};
> +#endif
> +
>  static int tps6598x_probe(struct i2c_client *client)
>  {
>  	struct typec_capability typec_cap = { };
> @@ -567,10 +668,47 @@ static int tps6598x_probe(struct i2c_client *client)
>  	}
>  	fwnode_handle_put(fwnode);
>  
> +#ifdef CONFIG_EXTCON
> +	/* Allocate extcon device */
> +	tps->edev = devm_extcon_dev_allocate(tps->dev, tps6598x_extcon_cable);
> +	if (IS_ERR(tps->edev)) {
> +		dev_err(tps->dev, "failed to allocate memory for extcon\n");
> +		typec_unregister_port(tps->port);
> +		return -ENOMEM;
> +	}
> +
> +	/* Register extcon device */
> +	ret = devm_extcon_dev_register(tps->dev, tps->edev);
> +	if (ret) {
> +		dev_err(tps->dev, "failed to register extcon device\n");
> +		typec_unregister_port(tps->port);
> +		return ret;
> +	}
> +
> +	extcon_set_property_capability(tps->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(tps->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS_SRC);
> +	extcon_set_property_capability(tps->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS_VOLTAGE);
> +	extcon_set_property_capability(tps->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS_CURRENT);
> +	extcon_set_property_capability(tps->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(tps->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS_SRC);
> +	extcon_set_property_capability(tps->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS_VOLTAGE);
> +	extcon_set_property_capability(tps->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS_CURRENT);
> +#endif
> +
>  	if (status & TPS_STATUS_PLUG_PRESENT) {
>  		ret = tps6598x_connect(tps, status);
>  		if (ret)
>  			dev_err(&client->dev, "failed to register partner\n");
> +	} else {
> +		tps6598x_disconnect(tps, status);
>  	}
>  
>  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
