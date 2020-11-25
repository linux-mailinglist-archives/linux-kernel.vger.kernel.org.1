Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED662C4202
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgKYORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:17:34 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:41629 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729344AbgKYORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:17:33 -0500
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id 6BAA11AB0D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:17:33 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id hvbwk4RPIdCH5hvbxk9ccG; Wed, 25 Nov 2020 07:17:33 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=CKwEoyjD c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=X1H8zownwjDEwyqyG0IA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6vf0Vvzddvqh1Lb7tQR89btyhOYvwBDVJ+GUnAHdB+A=; b=kn6j38yWamr+Dou88q5BMV/OR8
        l1t/c9r1zH9EV9ukk8An/9/s3VYzyLbCynvJ+Bt/72lEKs/C5+3TG4/w6RWwyNQ7PwAZcJ3n1dM5c
        J3ZwpgHWCJPR8gD4aqsx3E74+YQPjAf1IujUOU4+tlAcpGkVaFD6CYndlsxYGVUhnEibsAr2x2Zgb
        UcVYhsL90I6UY25YOj13ZxsrQJ6YArNoeDACJXREuQvwW7zBc9gRZ8cAiyIXCFxOYu/XUV5CRrs/3
        GjiFj7wBX3jfcFyaIeNYaouY7VTcbO5JCJWlCv+A/wzfanmHC84qItsjMDT282gosddOZUInGcpy9
        h0w4ZvHw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34424 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1khvbw-002JL1-Fg; Wed, 25 Nov 2020 14:17:32 +0000
Date:   Wed, 25 Nov 2020 06:17:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Stay in
 SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS till Rp is seen
Message-ID: <20201125141731.GC97010@roeck-us.net>
References: <20201125014804.1596719-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125014804.1596719-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1khvbw-002JL1-Fg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:34424
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 36
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 05:48:04PM -0800, Badhri Jagan Sridharan wrote:
> TD.4.7.3. Try SNK DRP Connect Try.SRC DRP fails. The compliance
> tester mimics being a Try.SRC USB-C port.
> The failure is due to TCPM exiting SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS
> when VBUS is not present eventhough when SNK.Rp is seen. Exit to
> SRC_TRYWAIT from SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS only when SNK.Rp
> is not seen for PD_T_TRY_CC_DEBOUNCE.
> 
> From the spec:
> The port shall then transition to Attached.SNK when the SNK.Rp state
> is detected on exactly one of the CC1 or CC2 pins for at least
> tTryCCDebounce and VBUS is detected. Alternatively, the port shall
> transition to TryWait.SRC if SNK.Rp state is not detected for
> tTryCCDebounce.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 18 +++++++++++++-----
>  include/linux/usb/pd.h        |  1 +
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4aac0efdb720..b2cffa00d737 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3124,15 +3124,13 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case SNK_TRY_WAIT_DEBOUNCE:
>  		tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS,
> -			       PD_T_PD_DEBOUNCE);
> +			       PD_T_TRY_CC_DEBOUNCE);
>  		break;
>  	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
> -		if (port->vbus_present && tcpm_port_is_sink(port)) {
> +		if (port->vbus_present && tcpm_port_is_sink(port))
>  			tcpm_set_state(port, SNK_ATTACHED, 0);
> -		} else {
> -			tcpm_set_state(port, SRC_TRYWAIT, 0);
> +		else
>  			port->max_wait = 0;
> -		}
>  		break;
>  	case SRC_TRYWAIT:
>  		tcpm_set_cc(port, tcpm_rp_cc(port));
> @@ -4053,6 +4051,12 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
>  		if (!tcpm_port_is_sink(port))
>  			tcpm_set_state(port, SNK_TRYWAIT_DEBOUNCE, 0);
>  		break;
> +	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
> +		if (!tcpm_port_is_sink(port))
> +			tcpm_set_state(port, SRC_TRYWAIT, PD_T_TRY_CC_DEBOUNCE);
> +		else
> +			tcpm_set_state(port, SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS, 0);
> +		break;
>  	case SNK_TRYWAIT:
>  		/* Do nothing, waiting for tCCDebounce */
>  		break;
> @@ -4139,6 +4143,10 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
>  	case SNK_TRYWAIT_DEBOUNCE:
>  		/* Do nothing, waiting for Rp */
>  		break;
> +	case SNK_TRY_WAIT_DEBOUNCE_CHECK_VBUS:
> +		if (port->vbus_present && tcpm_port_is_sink(port))
> +			tcpm_set_state(port, SNK_ATTACHED, 0);
> +		break;
>  	case SRC_TRY_WAIT:
>  	case SRC_TRY_DEBOUNCE:
>  		/* Do nothing, waiting for sink detection */
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 3a805e2ecbc9..63a66dd5d832 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -484,6 +484,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  
>  #define PD_T_CC_DEBOUNCE	200	/* 100 - 200 ms */
>  #define PD_T_PD_DEBOUNCE	20	/* 10 - 20 ms */
> +#define PD_T_TRY_CC_DEBOUNCE	15	/* 10 - 20 ms */
>  
>  #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
>  #define PD_N_HARD_RESET_COUNT	2
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
