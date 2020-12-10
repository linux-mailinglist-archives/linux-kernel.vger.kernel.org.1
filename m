Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63622D63E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392808AbgLJRoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:44:22 -0500
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:33331 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392468AbgLJRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:44:10 -0500
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id C5C23215CC4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:43:27 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id nPyRkkkpZwNNlnPyRkvWD8; Thu, 10 Dec 2020 10:43:27 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=A7FCwZeG c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=dVhFLFTkof1kBHoGy50A:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=nlm17XC03S6CtCLSeiRr:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fa7+K/xpNSS5LcaiVBLzSNpxCsT90qLMzDg/wyKeclQ=; b=VxoT0IGBZU1F9+JVvP2nGv942n
        snkKMNWW1yf9ohs4AZCdZI/YM5Q+WGX08KSAWRxxSZLyJdIHxSTGhgWN9NCvpvO+SuO3fi0KpIMxB
        /D22V3MNWpKhBjldXh4RSYfRqVy3IIlooRisVoHttrb6jLJSVCe+HaRgXSM9oNe8W2oFFTYeCiXP/
        2u36Pmuqcnfuts7Wi4/JFsjZYHGIbNBK/rDy5l7iQvC/JE/HCK95jhk4Xjr3Q6zGtzOVzv2uKhTla
        d+X6ZstbY3xUDeQ76U1y4L4pvnEZL2o64iaQNUYJPNza9aNI3Vgv+vM4Tp6a3KXsBi6Vye+jgrNip
        U/84MDnA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60452 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1knPyQ-001SPp-Rn; Thu, 10 Dec 2020 17:43:26 +0000
Date:   Thu, 10 Dec 2020 09:43:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, pumahsu <pumahsu@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 2/5] USB: typec: tcpm: Hard Reset after not receiving a
 Request
Message-ID: <20201210174326.GC107395@roeck-us.net>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-3-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210160521.3417426-3-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1knPyQ-001SPp-Rn
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:60452
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:05:18PM +0100, Greg Kroah-Hartman wrote:
> From: pumahsu <pumahsu@google.com>
> 
> PD 3.0 spec 8.3.3.2.3, A Get_Source_Cap message is sent
> to a UUT that is in the PE_SRC_Ready state. After sending
> a Source_Capabilities message, the UUT should then expect
> a Request message in response. When one is not received,
> the UUT should timeout to PE_SRC_Hard_Reset.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: pumahsu <pumahsu@google.com>
> Signed-off-by: Kyle Tso <kyletso@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0ceeab50ed64..0efda59bb104 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2218,6 +2218,7 @@ static int tcpm_pd_send_control(struct tcpm_port *port,
>  static bool tcpm_send_queued_message(struct tcpm_port *port)
>  {
>  	enum pd_msg_request queued_message;
> +	int ret;
>  
>  	do {
>  		queued_message = port->queued_message;
> @@ -2237,7 +2238,16 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
>  			tcpm_pd_send_sink_caps(port);
>  			break;
>  		case PD_MSG_DATA_SOURCE_CAP:
> -			tcpm_pd_send_source_caps(port);
> +			ret = tcpm_pd_send_source_caps(port);
> +			if (ret < 0) {
> +				tcpm_log(port,
> +					 "Unable to send src caps, ret=%d",
> +					 ret);
> +				tcpm_set_state(port, SOFT_RESET_SEND, 0);
> +			} else if (port->pwr_role == TYPEC_SOURCE) {
> +				tcpm_set_state(port, HARD_RESET_SEND,
> +					       PD_T_SENDER_RESPONSE);
> +			}
>  			break;
>  		default:
>  			break;
> -- 
> 2.29.2
> 
