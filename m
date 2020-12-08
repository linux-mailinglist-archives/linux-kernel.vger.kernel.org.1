Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED16B2D3428
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgLHUbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:31:44 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:59692 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgLHUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:31:43 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 5EA70C17A8F0F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:32:47 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mij8kEAXqh41lmij9kG4He; Tue, 08 Dec 2020 12:32:47 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=O5cXQi1W c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=38KwAB6pZVTB5d0M5wMA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=celeI7BAwb3saL5Jcd38eO0ob4H5Jz7CGRjTmFIRp1o=; b=Ld03cWmsj3PcFBuDPDCEsNIx6v
        6ri4cBP0yi1G2g5ZyOWth99Q8/MJSeshkSZ4vcnDdBGL5nDDKUxRhjdK8xGrmkD2Bc3VTkWMu8e0D
        4BevcESS7KIeEhzug0AX0BEVLZCCxX0X0Z1rQBeDM4H+n8INRjVvCXClTuqc4I+LxytEsqUeRsKc/
        7iKzpi0X1kQE+SESQCzNymSYsLWGgFQhBAR+N8BH2rZYevmdc/gWIJHbsQd8juAH8QA9LxEIMJN7+
        j+QjxSUeLHu+uWNZMraP1wYCcQhG8Ax6HF8WfxWqeGgnkJCnmmXQAWU9qJ4/j0qIkuINCIBYJIFJo
        QjR4Hjdg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40866 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmij8-001tFs-Ec; Tue, 08 Dec 2020 19:32:46 +0000
Date:   Tue, 8 Dec 2020 11:32:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: tcpci: Add support to report vSafe0V
Message-ID: <20201208193245.GB71189@roeck-us.net>
References: <20201202040840.663578-1-badhri@google.com>
 <20201202040840.663578-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202040840.663578-2-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmij8-001tFs-Ec
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:40866
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 6
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:08:39PM -0800, Badhri Jagan Sridharan wrote:
> This change adds vbus_vsafe0v which when set, makes TCPM
> query for VSAFE0V by assigning the tcpc.is_vbus_vsafe0v callback.
> Also enables ALERT.ExtendedStatus which is triggered when
> status of EXTENDED_STATUS.vSafe0V changes.
> EXTENDED_STATUS.vSafe0V is set when vbus is at vSafe0V and
> cleared otherwise.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
> - Removed logic for checking TCPC_POWER_STATUS_MASK reg
>   read in the irq handler. Sending that as a separate patch.
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 39 +++++++++++++++++++++++++++++-----
>  drivers/usb/typec/tcpm/tcpci.h |  6 ++++++
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 12d983a75510..f938d9876ce9 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -402,6 +402,19 @@ static int tcpci_get_vbus(struct tcpc_dev *tcpc)
>  	return !!(reg & TCPC_POWER_STATUS_VBUS_PRES);
>  }
>  
> +static bool tcpci_is_vbus_vsafe0v(struct tcpc_dev *tcpc)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &reg);
> +	if (ret < 0)
> +		return false;
> +
> +	return !!(reg & TCPC_EXTENDED_STATUS_VSAFE0V);
> +}
> +
>  static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -554,12 +567,22 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>  		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS;
>  	if (tcpci->controls_vbus)
>  		reg |= TCPC_ALERT_POWER_STATUS;
> +	/* Enable VSAFE0V status interrupt when detecting VSAFE0V is supported */
> +	if (tcpci->data->vbus_vsafe0v) {
> +		reg |= TCPC_ALERT_EXTENDED_STATUS;
> +		ret = regmap_write(tcpci->regmap, TCPC_EXTENDED_STATUS_MASK,
> +				   TCPC_EXTENDED_STATUS_VSAFE0V);
> +		if (ret < 0)
> +			return ret;
> +	}
>  	return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
>  }
>  
>  irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  {
>  	u16 status;
> +	int ret;
> +	unsigned int raw;
>  
>  	tcpci_read16(tcpci, TCPC_ALERT, &status);
>  
> @@ -575,15 +598,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  		tcpm_cc_change(tcpci->port);
>  
>  	if (status & TCPC_ALERT_POWER_STATUS) {
> -		unsigned int reg;
> -
> -		regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &reg);
> -
> +		regmap_read(tcpci->regmap, TCPC_POWER_STATUS_MASK, &raw);
>  		/*
>  		 * If power status mask has been reset, then the TCPC
>  		 * has reset.
>  		 */
> -		if (reg == 0xff)
> +		if (raw == 0xff)
>  			tcpm_tcpc_reset(tcpci->port);
>  		else
>  			tcpm_vbus_change(tcpci->port);
> @@ -622,6 +642,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
>  		tcpm_pd_receive(tcpci->port, &msg);
>  	}
>  
> +	if (status & TCPC_ALERT_EXTENDED_STATUS) {
> +		ret = regmap_read(tcpci->regmap, TCPC_EXTENDED_STATUS, &raw);
> +		if (!ret && (raw & TCPC_EXTENDED_STATUS_VSAFE0V))
> +			tcpm_vbus_change(tcpci->port);
> +	}
> +
>  	if (status & TCPC_ALERT_RX_HARD_RST)
>  		tcpm_pd_hard_reset(tcpci->port);
>  
> @@ -699,6 +725,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  			tcpci_set_auto_vbus_discharge_threshold;
>  	}
>  
> +	if (tcpci->data->vbus_vsafe0v)
> +		tcpci->tcpc.is_vbus_vsafe0v = tcpci_is_vbus_vsafe0v;
> +
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
>  		return ERR_PTR(err);
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 3fe313655f0c..116a69c85e38 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -49,6 +49,9 @@
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
>  #define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
>  
> +#define TCPC_EXTENDED_STATUS		0x20
> +#define TCPC_EXTENDED_STATUS_VSAFE0V	BIT(0)
> +
>  #define TCPC_ROLE_CTRL			0x1a
>  #define TCPC_ROLE_CTRL_DRP		BIT(6)
>  #define TCPC_ROLE_CTRL_RP_VAL_SHIFT	4
> @@ -155,11 +158,14 @@ struct tcpci;
>   *		is sourcing vbus.
>   * @auto_discharge_disconnect:
>   *		Optional; Enables TCPC to autonously discharge vbus on disconnect.
> + * @vbus_vsafe0v:
> + *		optional; Set when TCPC can detect whether vbus is at VSAFE0V.
>   */
>  struct tcpci_data {
>  	struct regmap *regmap;
>  	unsigned char TX_BUF_BYTE_x_hidden:1;
>  	unsigned char auto_discharge_disconnect:1;
> +	unsigned char vbus_vsafe0v:1;
>  
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>  	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
