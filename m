Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5562D150D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgLGPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:48:16 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:44973 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgLGPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:48:16 -0500
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 0820CC0DFEF50
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 08:47:35 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id mIjekWgPrdCH5mIjeka6Jn; Mon, 07 Dec 2020 08:47:35 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Tu7Iegfh c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=pGLkceISAAAA:8
 a=aUUhapolnoLvr2g7utAA:9 a=CjuIK1q_8ugA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gBytMmuiFgYWYPWFzExR31Z/H0j/t4BFhzTX+2b3O0k=; b=jhKdHOfWP5f1ooxEOCvPg/L6M9
        zDnLo2Tp2pYHW3vL9En+osqEXvE2sU+93g6ktm527fISmpQ3KCO2nLimfPO08pwc/tuZ0qhib6ojp
        YgyYxYeOj5KOBEdOvoOuTsgZogwf954K5cAWz94qus0idUkZH3LWK/w+HSW+jvyrdWGKNgO+eCpH8
        8BSF0bUcWXJJtjy83uhIV86ASlXK0eJmBcwgL8qGibzI90MT6u8VmXqjq7TkNFiwnLYKIQqZglMhf
        EuKpSEz87qAwfLEz5YKRisJqGkuuKZgRg+aM0l2BjMsV84k3zWE0PLgUPzsoWq/PnwnpdCrFsMqeR
        fZ/2BEkQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59828 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kmIjd-002qlk-VR; Mon, 07 Dec 2020 15:47:34 +0000
Date:   Mon, 7 Dec 2020 07:47:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: pmbus: correct title underline length
Message-ID: <20201207154733.GA42429@roeck-us.net>
References: <20201207152658.32444-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207152658.32444-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kmIjd-002qlk-VR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:59828
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:26:58PM +0100, Lukas Bulwahn wrote:
> Commit b722d7b9e4da ("hwmon: (pmbus) Driver for Delta power supplies
> Q54SJ108A2") provides new documentation for DELTA Q54SJ108A2NC* drivers,
> but the title underline was too short.
> 
> make htmldocs warns:
> 
>   Documentation/hwmon/q54sj108a2.rst:4: WARNING: Title underline too short.
> 
> Adjust the title underline to the correct length.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied.

Thanks,
Guenter

> ---
> applies on next-20201207 and the hwmon -next tree
> 
> Guenter, Jean, please pick this minor doc fix on your -next tree.
> 
>  Documentation/hwmon/q54sj108a2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/q54sj108a2.rst b/Documentation/hwmon/q54sj108a2.rst
> index fabce671985a..035312d25c34 100644
> --- a/Documentation/hwmon/q54sj108a2.rst
> +++ b/Documentation/hwmon/q54sj108a2.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later
>  
>  Kernel driver q54sj108a2
> -=====================
> +========================
>  
>  Supported chips:
>  
