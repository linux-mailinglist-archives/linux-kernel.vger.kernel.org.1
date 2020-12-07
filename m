Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D546C2D154D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgLGP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:57:37 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:41568 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgLGP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:57:36 -0500
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id E4A6F1E173C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 08:56:54 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mIsgkWj8CdCH5mIsgka8yW; Mon, 07 Dec 2020 08:56:54 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Tu7Iegfh c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=kboxpPNCMEio7Cws6XEA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/LiRXLk4I8kRm3j2jsuObOqLcMlnFPGFRm4WYa24Hok=; b=EIH4AJIwcCLyDeXKdZDFVnrmva
        FHGx+qD2cH/XtYe8dMmeTCB75lwKFYYYLTKhwvgF/rol55ITrA2QAm6s2q42Sb07DUO6MlO8qztM+
        x7fNTi47luwYqyAGZXg4yaAbjrFJkhvJUIYCg+dN7rVm5WpJcZeWbaDV/ifRE9T6ftK9ydPvXR6qb
        yPs1gW178ZUyvPw07M5Dm3xwP3mXOb1mT4nuvvNA07KRw2cCRiJjIh9zKiaiUDcgv+V97Q22y48De
        qVHzkBk49O1alHCAxPiQd3l7WWlJuKJP901v1Uyq2heZNF+nhDwhX5D1U9HPrUyqdBy5zyAG30lKW
        oBuPVOcA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59902 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmIsf-002tzq-VD; Mon, 07 Dec 2020 15:56:54 +0000
Date:   Mon, 7 Dec 2020 07:56:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Clear send_discover in
 tcpm_check_send_discover
Message-ID: <20201207155653.GE43600@roeck-us.net>
References: <20201203031908.1491542-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203031908.1491542-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmIsf-002tzq-VD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:59902
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 50
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:19:08PM -0800, Badhri Jagan Sridharan wrote:
> tcpm_check_send_discover does not clear the send_discover flag
> when any of the following conditions are not met.
> 1. data_role is TYPEC_HOST
> 2. link is pd_capable
> 
> Discovery indentity would anyways not be attempted during
> the current session anymore when the above conditions are not
> met. Hence clear the send_discover flag here to prevent
> tcpm_enable_frs_work from rescheduling indefinetly.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3bbc1f10af49..012135ade7b1 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3035,10 +3035,9 @@ static inline enum tcpm_state unattached_state(struct tcpm_port *port)
>  static void tcpm_check_send_discover(struct tcpm_port *port)
>  {
>  	if (port->data_role == TYPEC_HOST && port->send_discover &&
> -	    port->pd_capable) {
> +	    port->pd_capable)
>  		tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
> -		port->send_discover = false;
> -	}
> +	port->send_discover = false;
>  }
>  
>  static void tcpm_swap_complete(struct tcpm_port *port, int result)
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
