Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2EE2BC2E7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 01:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgKVA6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 19:58:48 -0500
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:57295 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726544AbgKVA6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 19:58:48 -0500
Received: from CMGW (unknown [10.9.0.13])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id AF54F140528
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 17:58:45 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id gdiHkSOTZi1lMgdiHkRsDG; Sat, 21 Nov 2020 17:58:45 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=D4A3ErZj c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=8nJEP1OIZ-IA:10 a=nNwsprhYR40A:10
 a=evQFzbml-YQA:10 a=iH7RfIX4AAAA:20 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8
 a=45O7cDBGXuf8goJbQyUA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S/pOiXpWjEsaacuWigI3ywSsIkJVWsK1kqJYF6zuk3M=; b=g2jetLwoW4PYEjEn9CpkWgiaPc
        iCUWhOmPnIUPYyZZo0Iow57mdl8eb6tctDL0pFYDoITownskWcYkYHxqimlup695qieQdi90gTWfw
        wubhKNygP59vPinwKUQbN/mgpSYu2Uad2WTaszHML3W45Yp5CXn9iu9c+f5iB9AbKC5bI40m3CbJc
        0W3L7SYmGVC/LZ4aLt4cM+oTnKLh2TsjvLsZ/Ta7rdfrqbk+TgodsXj/HXpsGNALTuO3wKqQ5mDKL
        GVAv5K3Z/8eWwPQX9o/dVTG3g9wgoPjLdOwAOtcKfDDpeXF8Kq9Z/6aLQ6isYOSSorizVwWEaqcxB
        vTwfjMXQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41844 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kgdiG-0018bJ-MI; Sun, 22 Nov 2020 00:58:44 +0000
Date:   Sat, 21 Nov 2020 16:58:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 086/141] hwmon: (corsair-cpro) Fix fall-through warnings
 for Clang
Message-ID: <20201122005843.GA120539@roeck-us.net>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <be5c59f9bc4bac8c968bbd7443d08eaaf8a28ef8.1605896060.git.gustavoars@kernel.org>
 <20201121185010.GB114144@roeck-us.net>
 <7456d8ffa0e980e52964c539081228dff4627ae3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7456d8ffa0e980e52964c539081228dff4627ae3.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kgdiG-0018bJ-MI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:41844
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 12:00:30PM -0800, Joe Perches wrote:
> On Sat, 2020-11-21 at 10:50 -0800, Guenter Roeck wrote:
> > On Fri, Nov 20, 2020 at 12:36:04PM -0600, Gustavo A. R. Silva wrote:
> > > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > > by explicitly adding a break statement instead of letting the code fall
> > > through to the next case.
> > > 
> > > Link: https://github.com/KSPP/linux/issues/115
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> []
> > > diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> []
> > > @@ -310,6 +310,7 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
> > > �		default:
> > > �			break;
> > > �		}
> > > +		break;
> 
> The
> 		default:
> 			break;
> 
> bit above (but not below as it's a switch on an enum) could also be deleted no?
> 

I prefer to keep it the way it is to indicate that the default case was not
forgotten (unless that is against coding style).

Guenter

> > > �	default:
> > > �		break;
> > > �	}
> 
> ---
>  drivers/hwmon/corsair-cpro.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> index 591929ec217a..580173fca0f6 100644
> --- a/drivers/hwmon/corsair-cpro.c
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -299,17 +299,14 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
>  		switch (attr) {
>  		case hwmon_pwm_input:
>  			return set_pwm(ccp, channel, val);
> -		default:
> -			break;
>  		}
>  		break;
>  	case hwmon_fan:
>  		switch (attr) {
>  		case hwmon_fan_target:
>  			return set_target(ccp, channel, val);
> -		default:
> -			break;
>  		}
> +		break;
>  	default:
>  		break;
>  	}
> 
> 
