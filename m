Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5325B2D1C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgLGVjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLGVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:39:20 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A586C061749;
        Mon,  7 Dec 2020 13:38:40 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id p126so17124154oif.7;
        Mon, 07 Dec 2020 13:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fp+XSE87F3iLp7Dlxf2aak8AAriStSITfn65Gda9+GE=;
        b=mGAE1jODrID43AIb6FNCpb/ciDI+BgiheYuYFxMZnGYfBmRBukfLPgxaLsaRi6e29a
         cjTKvzt0cg29mOIp6JWrvL6lMxfyOQl5FjXhon4c/Zg+kmjHmGe+xO+D3Do0cq7UFLeN
         PgAxGH28IG5gHyZxKz5PhvGC284/RE2GLmOtQOiZq3ZvGTIHnGBv8pSgww29IUyoFYWj
         EG1Y0sFQ89iSDgUWYligOp7hN4B260FZasbjtw1taH6oz7t679Tz4q2XDndjVrd9wJEp
         Vd7XXG/4bLhTy7V+620ptcjwe0DFKQaqHg1UUzTPMwdq7mY2TLE/TVSviwIOuQf48iRo
         Dugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fp+XSE87F3iLp7Dlxf2aak8AAriStSITfn65Gda9+GE=;
        b=Xa6gz97oECb/Z3hygIk3kOKEgcdQBXm6iAgRv03BeVlpolw7L7F+uQg65d6ZFyGJqt
         Gi/o9xHTb1vPwMT8RgkIVekCYryTfOvnFl6JJ9bmkNga5ib7LqPoRQc7W+XL0uu26nwP
         cA241kbgePGdM61CVAn4ZD0Z3Ks8jYLEPIRrUIVt89c3KNMHOPQ4+M89b5OaF5XWaLKw
         LAsbxYGtx6PT6gjwOH/bHg1r1FoVi76Z+WOK55H7YZqd38pK96HbCCvx/dmkvSuGw1UD
         k60eHyLrewf4XoeV9njxkmCah5mxRheUsRZx3T74MtQKMraq7vRLw96h4kY/g9pzb7jw
         Xm0w==
X-Gm-Message-State: AOAM533pDJ0nwWJMbthrkpvKnsNOYl/jxeKBejn2sTt6Ha9SgQ8mN3+V
        qZOeiOieqLiJROVEno3lvKEIHbfzTrg=
X-Google-Smtp-Source: ABdhPJxKqkp8WCyD3OCJKpdGT6S1dQt8iDXaCbyB65Muv3BDsdq0Dnx/7nGqAcLQJE1FXXlyV1GmKQ==
X-Received: by 2002:aca:df83:: with SMTP id w125mr574954oig.165.1607377119581;
        Mon, 07 Dec 2020 13:38:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q18sm2615194ood.35.2020.12.07.13.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 13:38:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Pass down negotiated rev to update
 retry count
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201202031733.647808-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <6caf1208-06cb-739e-c19c-adf4a453f242@roeck-us.net>
Date:   Mon, 7 Dec 2020 13:38:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202031733.647808-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 7:17 PM, Badhri Jagan Sridharan wrote:
> nRetryCount was updated from 3 to 2 between PD2.0 and PD3.0 spec.
> nRetryCount in "Table 6-34 Counter parameters" of the PD 2.0
> spec is set to 3, whereas, nRetryCount in "Table 6-59 Counter
> parameters" is set to 2.
> 
> Pass down negotiated rev in pd_transmit so that low level chip
> drivers can update the retry count accordingly before attempting
> packet transmission.
> 
> This helps in passing "TEST.PD.PORT.ALL.02" of the
> "Power Delivery Merged" test suite which was initially failing
> with "The UUT did not retransmit the message nReryCount times"
> 
> In fusb302 & tcpci drivers, by default the driver sets the retry
> count to 3 (Default for PD 2.0). Update this to 2,
> if the negotiated rev is PD 3.0.
> 
> In wcove, since the retry count is intentionally set to max, leaving
> it as is.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since V1:
> -Squashed tcpm and client patches to one as suggested by Heikki.
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 16 +++++++++++-----
>  drivers/usb/typec/tcpm/tcpci.c   | 12 +++++++-----
>  drivers/usb/typec/tcpm/tcpm.c    |  2 +-
>  drivers/usb/typec/tcpm/wcove.c   |  3 ++-
>  include/linux/usb/tcpm.h         |  2 +-
>  5 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 99562cc65ca6..ebc46b9f776c 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -343,12 +343,11 @@ static int fusb302_sw_reset(struct fusb302_chip *chip)
>  	return ret;
>  }
>  
> -static int fusb302_enable_tx_auto_retries(struct fusb302_chip *chip)
> +static int fusb302_enable_tx_auto_retries(struct fusb302_chip *chip, u8 retry_count)
>  {
>  	int ret = 0;
>  
> -	ret = fusb302_i2c_set_bits(chip, FUSB_REG_CONTROL3,
> -				   FUSB_REG_CONTROL3_N_RETRIES_3 |
> +	ret = fusb302_i2c_set_bits(chip, FUSB_REG_CONTROL3, retry_count |
>  				   FUSB_REG_CONTROL3_AUTO_RETRY);
>  
>  	return ret;
> @@ -399,7 +398,7 @@ static int tcpm_init(struct tcpc_dev *dev)
>  	ret = fusb302_sw_reset(chip);
>  	if (ret < 0)
>  		return ret;
> -	ret = fusb302_enable_tx_auto_retries(chip);
> +	ret = fusb302_enable_tx_auto_retries(chip, FUSB_REG_CONTROL3_N_RETRIES_3);
>  	if (ret < 0)
>  		return ret;
>  	ret = fusb302_init_interrupt(chip);
> @@ -1017,7 +1016,7 @@ static const char * const transmit_type_name[] = {
>  };
>  
>  static int tcpm_pd_transmit(struct tcpc_dev *dev, enum tcpm_transmit_type type,
> -			    const struct pd_message *msg)
> +			    const struct pd_message *msg, unsigned int negotiated_rev)
>  {
>  	struct fusb302_chip *chip = container_of(dev, struct fusb302_chip,
>  						 tcpc_dev);
> @@ -1026,6 +1025,13 @@ static int tcpm_pd_transmit(struct tcpc_dev *dev, enum tcpm_transmit_type type,
>  	mutex_lock(&chip->lock);
>  	switch (type) {
>  	case TCPC_TX_SOP:
> +		/* nRetryCount 3 in P2.0 spec, whereas 2 in PD3.0 spec */
> +		ret = fusb302_enable_tx_auto_retries(chip, negotiated_rev > PD_REV20 ?
> +						     FUSB_REG_CONTROL3_N_RETRIES_2 :
> +						     FUSB_REG_CONTROL3_N_RETRIES_3);
> +		if (ret < 0)
> +			fusb302_log(chip, "Cannot update retry count ret=%d", ret);
> +
>  		ret = fusb302_pd_send_message(chip, msg);
>  		if (ret < 0)
>  			fusb302_log(chip,
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 12d983a75510..98a2455f779f 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -18,7 +18,8 @@
>  
>  #include "tcpci.h"
>  
> -#define	PD_RETRY_COUNT				3
> +#define	PD_RETRY_COUNT_DEFAULT			3
> +#define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
>  #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
>  #define	AUTO_DISCHARGE_PD_HEADROOM_MV		850
>  #define	AUTO_DISCHARGE_PPS_HEADROOM_MV		1250
> @@ -447,9 +448,8 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
>  	return 0;
>  }
>  
> -static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
> -			     enum tcpm_transmit_type type,
> -			     const struct pd_message *msg)
> +static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type,
> +			     const struct pd_message *msg, unsigned int negotiated_rev)
>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>  	u16 header = msg ? le16_to_cpu(msg->header) : 0;
> @@ -497,7 +497,9 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
>  		}
>  	}
>  
> -	reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) | (type << TCPC_TRANSMIT_TYPE_SHIFT);
> +	/* nRetryCount is 3 in PD2.0 spec where 2 in PD3.0 spec */
> +	reg = ((negotiated_rev > PD_REV20 ? PD_RETRY_COUNT_3_0_OR_HIGHER : PD_RETRY_COUNT_DEFAULT)
> +	       << TCPC_TRANSMIT_RETRY_SHIFT) | (type << TCPC_TRANSMIT_TYPE_SHIFT);
>  	ret = regmap_write(tcpci->regmap, TCPC_TRANSMIT, reg);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3bbc1f10af49..c73bc3a8356a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -667,7 +667,7 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
>  		tcpm_log(port, "PD TX, type: %#x", type);
>  
>  	reinit_completion(&port->tx_complete);
> -	ret = port->tcpc->pd_transmit(port->tcpc, type, msg);
> +	ret = port->tcpc->pd_transmit(port->tcpc, type, msg, port->negotiated_rev);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
> index 9b745f432c91..79ae63950050 100644
> --- a/drivers/usb/typec/tcpm/wcove.c
> +++ b/drivers/usb/typec/tcpm/wcove.c
> @@ -356,7 +356,8 @@ static int wcove_set_pd_rx(struct tcpc_dev *tcpc, bool on)
>  
>  static int wcove_pd_transmit(struct tcpc_dev *tcpc,
>  			     enum tcpm_transmit_type type,
> -			     const struct pd_message *msg)
> +			     const struct pd_message *msg,
> +			     unsigned int negotiated_rev)
>  {
>  	struct wcove_typec *wcove = tcpc_to_wcove(tcpc);
>  	unsigned int info = 0;
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index e68aaa12886f..efaedd7e8a18 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -121,7 +121,7 @@ struct tcpc_dev {
>  			      enum typec_cc_status cc);
>  	int (*try_role)(struct tcpc_dev *dev, int role);
>  	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
> -			   const struct pd_message *msg);
> +			   const struct pd_message *msg, unsigned int negotiated_rev);
>  	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
>  	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
>  	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
> 

