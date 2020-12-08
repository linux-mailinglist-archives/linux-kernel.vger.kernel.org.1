Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD62D338F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgLHUVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:21:48 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:38172 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgLHUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:21:47 -0500
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id 4120D1AB5B1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:33:15 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mijakToBNwNNlmijbker8V; Tue, 08 Dec 2020 12:33:15 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=TZu4SyYh c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=28yfb_kLK31jltWp05oA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0qCCFEs/7pdUdK8Yset4kvmIX2L4dqEY08RzILSu25E=; b=1dumLrh9NvJFg/wiHGWtHUtU/h
        LMyNL85HKQODThfDYSdHhLqCY7Cs4hnZh1l7wGkWlLB5JPXhepe1De3ezrcCM74M7XA3EcJ5FUBTe
        RPIMl1HtjIdkAgwGtjJFRqyDjZzaDKoIRNWMSMM+LGmVNE7U8PCrlje51khHsEe8+b8hNwlcCzoqg
        bY0hkN4p0eeujxJ9NdGTGxclfRc4bBOoChkAAdzN+QBImJoTIr8ctopbwZz6b4Nzvx82Ab8bVmfBZ
        vUC+XNtOIKSqROD7L3STyHNosN7zE+DcUUfk9wbiPfaWj/55aphqkkTnDQQu/zaEgrWbrWfqZEsCC
        wLpaqfWQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40874 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmija-001tOQ-8X; Tue, 08 Dec 2020 19:33:14 +0000
Date:   Tue, 8 Dec 2020 11:33:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: tcpci_maxim: Enable VSAFE0V signalling
Message-ID: <20201208193313.GC71189@roeck-us.net>
References: <20201202040840.663578-1-badhri@google.com>
 <20201202040840.663578-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202040840.663578-3-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmija-001tOQ-8X
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:40874
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 11
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:08:40PM -0800, Badhri Jagan Sridharan wrote:
> Unmask EXTENDED_STATUS_MASK.vSafe0V, ALERT.Extended_Status
> and set vbus_vsafe0v to enable VSAFE0V signalling.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
> - Setting auto_discharge_disconnect to true instead of 1 as
>   suggested by Guenter.
> ---
>  drivers/usb/typec/tcpm/tcpci_maxim.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index c1797239bf08..319266329b42 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -112,11 +112,18 @@ static void max_tcpci_init_regs(struct max_tcpci_chip *chip)
>  		return;
>  	}
>  
> +	/* Enable VSAFE0V detection */
> +	ret = max_tcpci_write8(chip, TCPC_EXTENDED_STATUS_MASK, TCPC_EXTENDED_STATUS_VSAFE0V);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Unable to unmask TCPC_EXTENDED_STATUS_VSAFE0V ret:%d\n", ret);
> +		return;
> +	}
> +
>  	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_TX_FAILED |
>  		TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_RX_STATUS | TCPC_ALERT_CC_STATUS |
>  		TCPC_ALERT_VBUS_DISCNCT | TCPC_ALERT_RX_BUF_OVF | TCPC_ALERT_POWER_STATUS |
>  		/* Enable Extended alert for detecting Fast Role Swap Signal */
> -		TCPC_ALERT_EXTND;
> +		TCPC_ALERT_EXTND | TCPC_ALERT_EXTENDED_STATUS;
>  
>  	ret = max_tcpci_write16(chip, TCPC_ALERT_MASK, alert_mask);
>  	if (ret < 0) {
> @@ -315,6 +322,12 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
>  		}
>  	}
>  
> +	if (status & TCPC_ALERT_EXTENDED_STATUS) {
> +		ret = max_tcpci_read8(chip, TCPC_EXTENDED_STATUS, (u8 *)&reg_status);
> +		if (ret >= 0 && (reg_status & TCPC_EXTENDED_STATUS_VSAFE0V))
> +			tcpm_vbus_change(chip->port);
> +	}
> +
>  	if (status & TCPC_ALERT_RX_STATUS)
>  		process_rx(chip, status);
>  
> @@ -442,6 +455,7 @@ static int max_tcpci_probe(struct i2c_client *client, const struct i2c_device_id
>  	chip->data.init = tcpci_init;
>  	chip->data.frs_sourcing_vbus = max_tcpci_frs_sourcing_vbus;
>  	chip->data.auto_discharge_disconnect = true;
> +	chip->data.vbus_vsafe0v = true;
>  
>  	max_tcpci_init_regs(chip);
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
