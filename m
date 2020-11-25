Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D82C41FA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgKYOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:16:07 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:57261 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729891AbgKYOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:16:07 -0500
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 45669175B2E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:16:06 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id hvaXk4QlgdCH5hvaYk9bzL; Wed, 25 Nov 2020 07:16:06 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=CKwEoyjD c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=txeGkxVLtmbwJ2GW8KkA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HpvN089oDJuv87eGkCkmLlvGEAAHAH1QAjy9aTSr5GE=; b=JqS3TsiHSZc1Zu/x7Muu+0ihW+
        ZwKLRglXyW0DUuSlAIPUgFmuQR38ZFLc9t/q5fYQ6h0ph+FopQuoKz3ygl4KAMsByDOoKbD14agbT
        vBZKxawHVrsSsPWuxWF8IqM68NqN1f3X21U+MNJGj2ov7RmMViuqmTxwzuk5fTh7dMHYu+N1rD/Lk
        G6VHrHZ/BQ0jYV6MNhgw1B40Gs3Kxz+sX+hUTBbBVMa/7wshgAjNHtUrgAQ7HLgLUC/pOhLx0jyLU
        WpuSwBVvF32i3s4ztXYETIKM8bw7Hi+etJEsCBjnQoVEV3uzD1cQPGinB5/vyowgG31YtUhgr3+2I
        7N2YazSw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34404 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1khvaX-002IiQ-AV; Wed, 25 Nov 2020 14:16:05 +0000
Date:   Wed, 25 Nov 2020 06:16:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Disregard vbus off while in
 PR_SWAP_SNK_SRC_SOURCE_ON
Message-ID: <20201125141604.GB97010@roeck-us.net>
References: <20201125020703.1604979-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125020703.1604979-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1khvaX-002IiQ-AV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:34404
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 31
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 06:07:03PM -0800, Badhri Jagan Sridharan wrote:
> During PR_SWAP sequence, when TCPM is waiting in PR_SWAP_SNK_SRC_SOURCE_ON
> for the vbus source to ramp up, TCPM would prematurely exit
> PR_SWAP_SNK_SRC_SOURCE_ON and transition to SNK_UNATTACHED state when a
> vbus off notification is received. This should not be the case as vbus
> can still be off while in PR_SWAP_SNK_SRC_SOURCE_ON and the vbus source
> has PD_T_NEWSRC to ramp up.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4aac0efdb720..277b9d4d9c84 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4218,6 +4218,14 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  		/* Do nothing, expected */
>  		break;
>  
> +	case PR_SWAP_SNK_SRC_SOURCE_ON:
> +		/*
> +		 * Do nothing when vbus off notification is received.
> +		 * TCPM can wait for PD_T_NEWSRC in PR_SWAP_SNK_SRC_SOURCE_ON
> +		 * for the vbus source to ramp up.
> +		 */
> +		break;
> +
>  	case PORT_RESET_WAIT_OFF:
>  		tcpm_set_state(port, tcpm_default_state(port), 0);
>  		break;
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
