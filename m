Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC52D63E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392880AbgLJRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:44:46 -0500
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:33998 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387836AbgLJRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:44:33 -0500
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id B9ADF4010F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:43:49 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id nPynk2rEBDlydnPynkobTs; Thu, 10 Dec 2020 10:43:49 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=A9VCwZeG c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=cOPUhUyyOuhHbND_QhoA:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=nlm17XC03S6CtCLSeiRr:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DJPibpTBI7ibES47Gz9om6shkGvNBtaQ4yr+2oUWILs=; b=Q6adGXIOQorfAD2KGYjHgscRi4
        29PK73BFnvitInNkn0YKR4XA79OIuQmB7+NYFQmLpzWT2yd18gsSgurPQ/I/zsMhCrS6HGo9gSEFB
        73RYB/Dj1Xt+J4dl9VY3qMsdjJmyzI8lVXuvbMBL0dWNeR4Opl+0fRNJB4DR39O2Nk0J+s0HUIfEq
        ZNXAQk3zAXXhHIAQsJevchWUHxIniugQV2Eg0koDmLGX4wyctqmRrGLl8j3ap+C5LW+uBUwfAulFu
        C6TifT8GC8Xjg2/7+jgexyWGshV7jKzEdGbOYibKWI+n6gOB45GscoF+9E39zqLyEpHFYmIoptLEF
        lrxWI6Ow==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60456 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1knPym-001SVA-T7; Thu, 10 Dec 2020 17:43:49 +0000
Date:   Thu, 10 Dec 2020 09:43:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 3/5] USB: typec: tcpm: Fix PR_SWAP error handling
Message-ID: <20201210174348.GD107395@roeck-us.net>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-4-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210160521.3417426-4-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1knPym-001SVA-T7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:60456
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 19
X-Org:  HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:05:19PM +0100, Greg Kroah-Hartman wrote:
> From: Kyle Tso <kyletso@google.com>
> 
> PD rev3.0 8.3.3.16.3.6 PE_PRS_SRC_SNK_Wait_Source_on State
> The Policy Enging Shall transition to the ErrorRecovery state when the
> PSSourceOnTimer times out ...
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Kyle Tso <kyletso@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0efda59bb104..d51c45961893 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3728,7 +3728,7 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  			break;
>  		}
> -		tcpm_set_state_cond(port, SNK_UNATTACHED, PD_T_PS_SOURCE_ON);
> +		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_ON);
>  		break;
>  	case PR_SWAP_SRC_SNK_SINK_ON:
>  		/* Set the vbus disconnect threshold for implicit contract */
> -- 
> 2.29.2
> 
