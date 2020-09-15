Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9E926A4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIOMPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:15:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:7457 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIOMMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:12:49 -0400
IronPort-SDR: mp8ew39PG/JY9hTpAjxheHcaR031G1kj/MEoyvlBavRueG4/0jNZ+zUCNfhyJ3oPHhrZUumw0B
 H3dw3v8yXELQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="223427217"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="223427217"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 05:11:38 -0700
IronPort-SDR: EWk3CrOWwytj+n/jfixJoDsSNngy7reLxXjm6xvpMXl4qGO7DoaxCnOZmmEwlvbMnMUMo7elLw
 MZCacKUAOaTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="409182703"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 05:11:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 15:11:34 +0300
Date:   Tue, 15 Sep 2020 15:11:34 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/14] usb: typec: tcpci: Add support when hidden tx
 registers are inaccessible
Message-ID: <20200915121134.GC1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
 <20200901025927.3596190-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-3-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:15PM -0700, Badhri Jagan Sridharan wrote:
> TCPCI spec forbids direct access of TX_BUF_BYTE_x register.
> The existing version of tcpci driver assumes that those registers
> are directly addressible. Add support for tcpci chips which do
> not support direct access to TX_BUF_BYTE_x registers. TX_BUF_BYTE_x
> can only be accessed by I2C_WRITE_BYTE_COUNT.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
>  - Refactored the code to check for TX_BUF_BYTE_x_hidden as suggested by
>    Heikki.
>  - Not formatting the tcpci_pd_transmit to follow the 100 character/line
>    limit as suggested by Heikki. (Should be a separate change).
>  - Changing patch version to v6 to fix version number confusion.
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 46 ++++++++++++++++++++++++++--------
>  drivers/usb/typec/tcpm/tcpci.h |  8 ++++++
>  2 files changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index bd80e03b2b6f..7d36d5e2d3f7 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -330,23 +330,47 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
>  	int ret;
>  
>  	cnt = msg ? pd_header_cnt(header) * 4 : 0;
> -	ret = regmap_write(tcpci->regmap, TCPC_TX_BYTE_CNT, cnt + 2);
> -	if (ret < 0)
> -		return ret;
> +	/**
> +	 * TCPCI spec forbids direct access of TCPC_TX_DATA.
> +	 * But, since some of the chipsets offer this capability,
> +	 * it's fair to support both.
> +	 */
> +	if (tcpci->data->TX_BUF_BYTE_x_hidden) {
> +		u8 buf[TCPC_TRANSMIT_BUFFER_MAX_LEN] = {0,};
> +		u8 pos = 0;
>  
> -	ret = tcpci_write16(tcpci, TCPC_TX_HDR, header);
> -	if (ret < 0)
> -		return ret;
> +		/* Payload + header + TCPC_TX_BYTE_CNT */
> +		buf[pos++] = cnt + 2;
> +
> +		if (msg)
> +			memcpy(&buf[pos], &msg->header, sizeof(msg->header));
> +
> +		pos += sizeof(header);
>  
> -	if (cnt > 0) {
> -		ret = regmap_raw_write(tcpci->regmap, TCPC_TX_DATA,
> -				       &msg->payload, cnt);
> +		if (cnt > 0)
> +			memcpy(&buf[pos], msg->payload, cnt);
> +
> +		pos += cnt;
> +		ret = regmap_raw_write(tcpci->regmap, TCPC_TX_BYTE_CNT, buf, pos);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret = regmap_write(tcpci->regmap, TCPC_TX_BYTE_CNT, cnt + 2);
>  		if (ret < 0)
>  			return ret;
> +
> +		ret = tcpci_write16(tcpci, TCPC_TX_HDR, header);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (cnt > 0) {
> +			ret = regmap_raw_write(tcpci->regmap, TCPC_TX_DATA, &msg->payload, cnt);
> +			if (ret < 0)
> +				return ret;
> +		}
>  	}
>  
> -	reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) |
> -		(type << TCPC_TRANSMIT_TYPE_SHIFT);
> +	reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) | (type << TCPC_TRANSMIT_TYPE_SHIFT);
>  	ret = regmap_write(tcpci->regmap, TCPC_TRANSMIT, reg);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index fd26ca35814c..cf9d8b63adcb 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -128,9 +128,17 @@
>  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
>  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
>  
> +/* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
> +#define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
> +
> +/*
> + * @TX_BUF_BYTE_x_hidden
> + *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
> + */
>  struct tcpci;
>  struct tcpci_data {
>  	struct regmap *regmap;
> +	unsigned char TX_BUF_BYTE_x_hidden:1;
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>  	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
>  			 bool enable);
> -- 
> 2.28.0.402.g5ffc5be6b7-goog

-- 
heikki
