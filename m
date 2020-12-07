Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDAA2D152F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgLGPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:53:19 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:41803 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgLGPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:53:19 -0500
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 3700BC0E0361D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 08:51:56 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mInrkb7EzDlydmInskNUBV; Mon, 07 Dec 2020 08:51:56 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=JpnfUvwC c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=DfNHnWVPAAAA:8
 a=bwPn_-YrvpYwKejdRpEA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=rjTVMONInIDnV1a_A2c_:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4OhFR1YGQnXPhyHt9T/2uXpL2IQ6MJ6nFeb6JRHtjnA=; b=BCcucOppEM31AeUbKq8s9Mo9Sj
        ypzXHcrTiFJN3z3ksm0hvRkOMOwuVdGPdbjZsPc7ZGc+9cf0xcZaE7UABShxDrtXbUq5wfixhEBJH
        X15D0Qb7iJ6tFbi54NfsGYV8Tu6Bn9ASEHxiFBl4UXk2cHwfslv3djlvF6FcSx0SE7Pei11TI0404
        D84t7qHO5A559G6BpJe1GnDgjzZCTM52b0xEG3OD9ysmT+T4cEGLv6MxqJKZLbV9ccpVj2LHPpKmJ
        2zhfv+n63n/fZH/RvtG1HHjWfTPVHyg5ynlXvjL6uiDu/d2N8S4YMQvsTmzrsOqY7MtE9TS2dCEvg
        BZbxLRFw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59860 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmInr-002s9a-7g; Mon, 07 Dec 2020 15:51:55 +0000
Date:   Mon, 7 Dec 2020 07:51:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: ltc2992: fix less than zero comparisons
 with an unsigned integer
Message-ID: <20201207155154.GA43526@roeck-us.net>
References: <20201207142410.168987-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207142410.168987-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmInr-002s9a-7g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:59860
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 8
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:24:10PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several occurrances of a less than zero error check on
> a u32 unsigned integer. These will never be true. Fix this by making
> reg_value a plain int.
> 
> Addresses-Coverity: ("Unsigned comparison against zero")
> Fixes: e126370240e0 ("hwmon: (ltc2992) Add support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ltc2992.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc2992.c b/drivers/hwmon/ltc2992.c
> index 69dbb5aa5dc2..4382105bf142 100644
> --- a/drivers/hwmon/ltc2992.c
> +++ b/drivers/hwmon/ltc2992.c
> @@ -480,7 +480,7 @@ static int ltc2992_read_gpios_in(struct device *dev, u32 attr, int nr_gpio, long
>  
>  static int ltc2992_read_in_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
>  {
> -	u32 reg_val;
> +	int reg_val;
>  	u32 mask;
>  
>  	if (attr == hwmon_in_max_alarm)
> @@ -534,7 +534,7 @@ static int ltc2992_read_in(struct device *dev, u32 attr, int channel, long *val)
>  
>  static int ltc2992_get_current(struct ltc2992_state *st, u32 reg, u32 channel, long *val)
>  {
> -	u32 reg_val;
> +	int reg_val;
>  
>  	reg_val = ltc2992_read_reg(st, reg, 2);
>  	if (reg_val < 0)
> @@ -558,7 +558,7 @@ static int ltc2992_set_current(struct ltc2992_state *st, u32 reg, u32 channel, l
>  
>  static int ltc2992_read_curr_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
>  {
> -	u32 reg_val;
> +	int reg_val;
>  	u32 mask;
>  
>  	if (attr == hwmon_curr_max_alarm)
> @@ -609,7 +609,7 @@ static int ltc2992_read_curr(struct device *dev, u32 attr, int channel, long *va
>  
>  static int ltc2992_get_power(struct ltc2992_state *st, u32 reg, u32 channel, long *val)
>  {
> -	u32 reg_val;
> +	int reg_val;
>  
>  	reg_val = ltc2992_read_reg(st, reg, 3);
>  	if (reg_val < 0)
> @@ -633,7 +633,7 @@ static int ltc2992_set_power(struct ltc2992_state *st, u32 reg, u32 channel, lon
>  
>  static int ltc2992_read_power_alarm(struct ltc2992_state *st, int channel, long *val, u32 attr)
>  {
> -	u32 reg_val;
> +	int reg_val;
>  	u32 mask;
>  
>  	if (attr == hwmon_power_max_alarm)
