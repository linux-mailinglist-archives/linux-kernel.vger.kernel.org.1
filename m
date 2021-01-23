Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56189301825
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbhAWUD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 15:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbhAWUCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 15:02:36 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5AC06174A;
        Sat, 23 Jan 2021 12:01:54 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m13so2281109oig.8;
        Sat, 23 Jan 2021 12:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sSFxrwccIA6nA6eNeAwDwFwmaBJAImwDdSSEc08nxvo=;
        b=X1OcpTSe4jCAu1BTSEqa/voi3MK8NDHanLQlKLKFyO85c1T51mxMr4qtF2GRHlZuLh
         68qcsF/b1z3z+MY6x8H9xzdyM/26yAtVBqsTibndgDtonLC8uwhPAQYwsr052jO5nH71
         X+jLunUSbqwp+IiV4qUd5mZZ66uqcjLuEcFmKKaAtB8ab1c9pVSfYcKeYt0KRn90WVHX
         gb2SIsrqRPiKvcW7JGZ4Slqvo7EUJiDx3GfrCG6QwMiXG4gfxqv9NVScLuoAfanPSdtq
         3KMPRRrcAZDpiZBZoVcC989vqOHggxzL90Itl68UU9to2sJs878TgQrd//ItFQzaoSor
         B9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sSFxrwccIA6nA6eNeAwDwFwmaBJAImwDdSSEc08nxvo=;
        b=Yhlxx5CAmM4TJIPNUbnysr8djfKOg2mx8i1tfnR21UIbECzGRuiAvnbbquPXsnEM6k
         +c2I+4Nyoxhpn2F59iDjn/yTUR+CCq4RgW1RE1X5GfdkMWmikVp+GJNulyKiJPS4nFDo
         7smrTG3MsrpZR9nuUjVT5jgm7E1Lt1RUjMwVAzThen3RkubmVFqxeNbnGuivgopvURMr
         dnSJ+nWdrrMRq/etbGmBhILs5qZXQ42QimK2AyNfhosbn/AzodZMgpG5Nm9QQFmddTj7
         V5NRrZkOEAvwhkNDJj+0krhyEjzRUq/ALQnqz53cfW2mxJXyoBR3OQyNzmn3xipBqSOw
         yU6g==
X-Gm-Message-State: AOAM533IIKF5U1CkerMU4E/YyS7k7AC2KoHWOCZgM6UrVGo3dvfaexyw
        kHk8Hxw8xHgkCdew7PPcajvgqGxc+ZGq8g==
X-Google-Smtp-Source: ABdhPJyJiA0HeIrb7PAbeMUbtKRGXiXVmYZHhZU+fHbgIxgm59dsla1X/VP8F/ISWPiAqOdMcgLa/Q==
X-Received: by 2002:aca:b909:: with SMTP id j9mr7105871oif.113.1611432113820;
        Sat, 23 Jan 2021 12:01:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q26sm1022836otg.28.2021.01.23.12.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 12:01:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Create legacy PDOs for PD2 connection
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210115163311.391332-1-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <6a38dedc-ac11-99db-8b7b-4ef5e5e17780@roeck-us.net>
Date:   Sat, 23 Jan 2021 12:01:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115163311.391332-1-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 8:33 AM, Kyle Tso wrote:
> If the port partner is PD2, the PDOs of the local port should follow the
> format defined in PD2 Spec. Dynamically modify the pre-defined PD3 PDOs
> and transform them into PD2 format before sending them to the PD2 port
> partner.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

I don't like this too much, but I don't have a better idea. Thus,

Reviewed-by: Guenter Roeck <linux@roeckus.net>

Guenter

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 62 +++++++++++++++++++++++++++++------
>  include/linux/usb/pd.h        |  1 +
>  2 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 22a85b396f69..1220ab1ed47d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -911,13 +911,47 @@ static int tcpm_set_pwr_role(struct tcpm_port *port, enum typec_role role)
>  	return 0;
>  }
>  
> +/*
> + * Transform the PDO to be compliant to PD rev2.0.
> + * Return 0 if the PDO type is not defined in PD rev2.0.
> + * Otherwise, return the converted PDO.
> + */
> +static u32 tcpm_forge_legacy_pdo(struct tcpm_port *port, u32 pdo, enum typec_role role)
> +{
> +	switch (pdo_type(pdo)) {
> +	case PDO_TYPE_FIXED:
> +		if (role == TYPEC_SINK)
> +			return pdo & ~PDO_FIXED_FRS_CURR_MASK;
> +		else
> +			return pdo & ~PDO_FIXED_UNCHUNK_EXT;
> +	case PDO_TYPE_VAR:
> +	case PDO_TYPE_BATT:
> +		return pdo;
> +	case PDO_TYPE_APDO:
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>  {
>  	struct pd_message msg;
> -	int i;
> +	u32 pdo;
> +	unsigned int i, nr_pdo = 0;
>  
>  	memset(&msg, 0, sizeof(msg));
> -	if (!port->nr_src_pdo) {
> +
> +	for (i = 0; i < port->nr_src_pdo; i++) {
> +		if (port->negotiated_rev >= PD_REV30) {
> +			msg.payload[nr_pdo++] =	cpu_to_le32(port->src_pdo[i]);
> +		} else {
> +			pdo = tcpm_forge_legacy_pdo(port, port->src_pdo[i], TYPEC_SOURCE);
> +			if (pdo)
> +				msg.payload[nr_pdo++] = cpu_to_le32(pdo);
> +		}
> +	}
> +
> +	if (!nr_pdo) {
>  		/* No source capabilities defined, sink only */
>  		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
>  					  port->pwr_role,
> @@ -930,10 +964,8 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>  					  port->data_role,
>  					  port->negotiated_rev,
>  					  port->message_id,
> -					  port->nr_src_pdo);
> +					  nr_pdo);
>  	}
> -	for (i = 0; i < port->nr_src_pdo; i++)
> -		msg.payload[i] = cpu_to_le32(port->src_pdo[i]);
>  
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
> @@ -941,10 +973,22 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>  static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>  {
>  	struct pd_message msg;
> -	int i;
> +	u32 pdo;
> +	unsigned int i, nr_pdo = 0;
>  
>  	memset(&msg, 0, sizeof(msg));
> -	if (!port->nr_snk_pdo) {
> +
> +	for (i = 0; i < port->nr_snk_pdo; i++) {
> +		if (port->negotiated_rev >= PD_REV30) {
> +			msg.payload[nr_pdo++] =	cpu_to_le32(port->snk_pdo[i]);
> +		} else {
> +			pdo = tcpm_forge_legacy_pdo(port, port->snk_pdo[i], TYPEC_SINK);
> +			if (pdo)
> +				msg.payload[nr_pdo++] = cpu_to_le32(pdo);
> +		}
> +	}
> +
> +	if (!nr_pdo) {
>  		/* No sink capabilities defined, source only */
>  		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
>  					  port->pwr_role,
> @@ -957,10 +1001,8 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>  					  port->data_role,
>  					  port->negotiated_rev,
>  					  port->message_id,
> -					  port->nr_snk_pdo);
> +					  nr_pdo);
>  	}
> -	for (i = 0; i < port->nr_snk_pdo; i++)
> -		msg.payload[i] = cpu_to_le32(port->snk_pdo[i]);
>  
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index bb9a782e1411..88f64bce5dea 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -225,6 +225,7 @@ enum pd_pdo_type {
>  #define PDO_FIXED_EXTPOWER		BIT(27) /* Externally powered */
>  #define PDO_FIXED_USB_COMM		BIT(26) /* USB communications capable */
>  #define PDO_FIXED_DATA_SWAP		BIT(25) /* Data role swap supported */
> +#define PDO_FIXED_UNCHUNK_EXT		BIT(24) /* Unchunked Extended Message supported (Source) */
>  #define PDO_FIXED_FRS_CURR_MASK		(BIT(24) | BIT(23)) /* FR_Swap Current (Sink) */
>  #define PDO_FIXED_FRS_CURR_SHIFT	23
>  #define PDO_FIXED_VOLT_SHIFT		10	/* 50mV units */
> 

