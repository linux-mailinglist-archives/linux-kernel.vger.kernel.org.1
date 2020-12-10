Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C9B2D63ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392916AbgLJRq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:46:56 -0500
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:33133 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392031AbgLJRqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:46:30 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 09640215C27
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:45:50 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id nQ0jkV80Nh41lnQ0jkWk7F; Thu, 10 Dec 2020 10:45:49 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=JNUVTfCb c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=h6dpbDeaCvH9cfnFbJwA:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=nlm17XC03S6CtCLSeiRr:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mSi37/KpQzHqxnLEaea2i61ySgFWJyTbS2I2jXpx2RM=; b=dyB7ImVu+uo/rGuqR0DETKUOZ9
        sJ5HGIBXYbcJfkiGfWBDDnKtrlzKyLaawoVcKUKDEl6pPdwwez6COUrz+8QOCAawseoihM7GSyocD
        kNYcSAq7RxZnn4ZI0B1S5fOGn6xacsJNzvXuGMbYG3sRUoD7U323sttv0TjgbXY3WHyqWN37Ct+qm
        AVTEYQkYsasYMmwr6fW1CKz/Ets6aDz0VIDSSy9gp4UAMco27EL66V3Hb0LRfyGKgeqZNQORhd68G
        CNjQWcceOSJxUNBrQDJxk4jZ/8mYSG7SUsM7hgoEJzgyLxQ5mxeYbv8mRxoKcpeE+VtDY5M5i+O/i
        Wyrk8f0w==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60464 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1knQ0j-001TFC-5D; Thu, 10 Dec 2020 17:45:49 +0000
Date:   Thu, 10 Dec 2020 09:45:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 5/5] USB: typec: tcpci: Add Bleed discharge to
 POWER_CONTROL definition
Message-ID: <20201210174548.GF107395@roeck-us.net>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-6-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210160521.3417426-6-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1knQ0j-001TFC-5D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:60464
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 33
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:05:21PM +0100, Greg Kroah-Hartman wrote:
> From: Badhri Jagan Sridharan <badhri@google.com>
> 
> "Table 4-19. POWER_CONTROL Register Definition" from tcpci spec
> defines BIT(3) as the control bit for bleed discharge.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Kyle Tso <kyletso@google.com>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Just wondering - is that going to be used in a follow-up commit ?

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/usb/typec/tcpm/tcpci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 116a69c85e38..c3c7d07d9b4e 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -72,6 +72,7 @@
>  
>  #define TCPC_POWER_CTRL			0x1c
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
> +#define TCPC_POWER_CTRL_BLEED_DISCHARGE	BIT(3)
>  #define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
>  #define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
>  
> -- 
> 2.29.2
> 
