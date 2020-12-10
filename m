Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C0A2D63DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392716AbgLJRnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:43:52 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:41909 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392705AbgLJRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:43:20 -0500
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id A55041E083F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 10:42:38 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id nPxek2qv1DlydnPxekobBU; Thu, 10 Dec 2020 10:42:38 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=A9VCwZeG c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=1XWaLZrsAAAA:8
 a=_jlGtV7tAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=D6N0on24dROpF_i51M8A:9
 a=CjuIK1q_8ugA:10:nop_charset_2 a=nlm17XC03S6CtCLSeiRr:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5YmuPWHMOh1EdgGQP6M1KGAXCwcz4J5xaPKG0AP1b4k=; b=gXzub4Ll2eI0H9XXwQ0eH3zg+4
        zskkV1eXoJ+IlcBbXI5u9ZZ8RGiVtB2Jh28Sq9Vfa6qa3n4LLmB9rugZNgGwEOlQ6nEXYekSZ34Fz
        U+2VAPvPJW0WSSZF43O4TTsAHuxzOnmAPzTDg3wF9tmLUc8UARwgBenP87iRXaXWB53WStp9JL/y5
        mmK1VaMCHi1vJVnYVpf+Gso9G69/OfdfPd/uKwQBi2T27nZ6WPGc4Oiyd5uQ9Gwx90UROSa1FShCd
        cwzMQdrjErw73SPylExhcXnHsUBTKL2smWj6BaMuRwoVewpNb4ZgvURU+rK26evDFwmLQvbZ1UTVk
        ptZHEUEw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60448 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1knPxd-001SBJ-Mk; Thu, 10 Dec 2020 17:42:37 +0000
Date:   Thu, 10 Dec 2020 09:42:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 1/5] USB: typec: tcpm: Prevent log overflow by removing
 old entries
Message-ID: <20201210174236.GB107395@roeck-us.net>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
 <20201210160521.3417426-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210160521.3417426-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1knPxd-001SBJ-Mk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:60448
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 05:05:17PM +0100, Greg Kroah-Hartman wrote:
> From: Badhri Jagan Sridharan <badhri@google.com>
> 
> TCPM logs overflow once the logbuffer is full. Clear old entries and
> allow logging the newer ones as the newer would be more relevant to the
> issue being debugged.
> 
> Also, do not reset the logbuffer tail as end users might take back to
> back bugreports which would result in an empty buffer.
> 

Historically, the reason for not doing this was that, once a problem occurs,
the log would fill up quickly (typically with reconnect attempts), and the
actual reason for the problem would be overwritten. Maybe that reasoning
no longer applies; I just wanted to point out that there _was_ a reason for
not clearing old log entries.

Guenter

> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Kyle Tso <kyletso@google.com>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index cedc6cf82d61..0ceeab50ed64 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -470,12 +470,6 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
>  
>  #ifdef CONFIG_DEBUG_FS
>  
> -static bool tcpm_log_full(struct tcpm_port *port)
> -{
> -	return port->logbuffer_tail ==
> -		(port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
> -}
> -
>  __printf(2, 0)
>  static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
>  {
> @@ -495,11 +489,6 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
>  
>  	vsnprintf(tmpbuffer, sizeof(tmpbuffer), fmt, args);
>  
> -	if (tcpm_log_full(port)) {
> -		port->logbuffer_head = max(port->logbuffer_head - 1, 0);
> -		strcpy(tmpbuffer, "overflow");
> -	}
> -
>  	if (port->logbuffer_head < 0 ||
>  	    port->logbuffer_head >= LOG_BUFFER_ENTRIES) {
>  		dev_warn(port->dev,
> @@ -519,6 +508,9 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
>  		  (unsigned long)ts_nsec, rem_nsec / 1000,
>  		  tmpbuffer);
>  	port->logbuffer_head = (port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
> +	if (port->logbuffer_head == port->logbuffer_tail)
> +		port->logbuffer_tail =
> +			(port->logbuffer_tail + 1) % LOG_BUFFER_ENTRIES;
>  
>  abort:
>  	mutex_unlock(&port->logbuffer_lock);
> @@ -622,8 +614,6 @@ static int tcpm_debug_show(struct seq_file *s, void *v)
>  		seq_printf(s, "%s\n", port->logbuffer[tail]);
>  		tail = (tail + 1) % LOG_BUFFER_ENTRIES;
>  	}
> -	if (!seq_has_overflowed(s))
> -		port->logbuffer_tail = tail;
>  	mutex_unlock(&port->logbuffer_lock);
>  
>  	return 0;
> -- 
> 2.29.2
> 
