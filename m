Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BA62D63E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392892AbgLJRpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:45:13 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:46400 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392669AbgLJRox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:44:53 -0500
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id CE73FC2690FEA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:44:10 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id nPz8kmvQAeMJHnPz8ksKCw; Thu, 10 Dec 2020 10:44:10 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=f4tm+t6M c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=gO3XcgjBTiCJpBlu9YMA:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=nlm17XC03S6CtCLSeiRr:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qyxzDhvZS4Bhc2WJFaUh1C2N3GXA1sK9X9ITBoGPVAo=; b=TqqhTruSgTQmB6ThD0nMrwqOyR
        TnngejDFjZs2qU0RydBy11CaJIPA6IqNRKTCZmgNsKgM4UDGXmtw5Ia+2wm+yklygfhcke2hTvsaw
        zMY5pLdLz6Q7SkOkmkertQTSVVcZvmwMdlAmNO/wfNnlMXl4bSKIxvmMZ9/EbYz8LW05HlXrovlqI
        bxC71PFVGX7gZeotGXsnAfdGJaAVgEUw62L/RV770/qxNvQFBu0NJQWCuIvuN6nDCNamgq9grRr3E
        WugdSRKPQFj+4hlsStdePCE4x2+G3mDYXd5UE10QXmcu+YM/TW1MUclAEP0k0tga5XpwpKqDwAG7G
        TrnUJPgQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60460 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1knPz8-001ScC-04; Thu, 10 Dec 2020 17:44:10 +0000
Date:   Thu, 10 Dec 2020 09:44:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 4/5] USB: typec: tcpm: Add a 30ms room for tPSSourceOn in
 PR_SWAP
Message-ID: <20201210174409.GE107395@roeck-us.net>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210160521.3417426-5-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1knPz8-001ScC-04
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:60460
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 26
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:05:20PM +0100, Greg Kroah-Hartman wrote:
> From: Kyle Tso <kyletso@google.com>
> 
> TCPM state machine needs 20-25ms to enter the ErrorRecovery state after
> tPSSourceOn timer timeouts. Change the timer from max 480ms to 450ms to
> ensure that the timer complies with the Spec. In order to keep the
> flexibility for other usecases using tPSSourceOn, add another timer only
> for PR_SWAP.
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
>  include/linux/usb/pd.h        | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d51c45961893..5ed78194a1bd 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3728,7 +3728,7 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  			break;
>  		}
> -		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_ON);
> +		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_ON_PRS);
>  		break;
>  	case PR_SWAP_SRC_SNK_SINK_ON:
>  		/* Set the vbus disconnect threshold for implicit contract */
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 63a66dd5d832..bb9a782e1411 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -466,6 +466,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_T_DRP_SRC		30
>  #define PD_T_PS_SOURCE_OFF	920
>  #define PD_T_PS_SOURCE_ON	480
> +#define PD_T_PS_SOURCE_ON_PRS	450	/* 390 - 480ms */
>  #define PD_T_PS_HARD_RESET	30
>  #define PD_T_SRC_RECOVER	760
>  #define PD_T_SRC_RECOVER_MAX	1000
> -- 
> 2.29.2
> 
