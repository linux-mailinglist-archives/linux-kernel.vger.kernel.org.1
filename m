Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36F2CDA5D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436457AbgLCPtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:49:02 -0500
Received: from gproxy5-pub.mail.unifiedlayer.com ([67.222.38.55]:33021 "EHLO
        gproxy5-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbgLCPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:49:01 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id 705F9140448
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:48:16 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id kqq7ka1PPh41lkqq8kcgM4; Thu, 03 Dec 2020 08:48:16 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=VITzYeHX c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=0iRpWrU2uAA0fdhBvTIA:9
 a=CjuIK1q_8ugA:10:nop_charset_2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M08ccCuLkmt9SxiEPBfhqBt5wI6QNec/OmgnMMLSrrs=; b=oXmHgDyj1nrWCkVCz/Vdci/EdE
        IndxaK0C7wDAG/wmG2WncaKZKOxXbsTOAcjHIve0lu8ZGA/ID9uSlbbfIp5/ZPXwj05NkuEqGQdkr
        89aXEvbyfq7uW01G7QcZLsPlMIX9Z73R5mU51SjeYmU4AeqLdzbHO+tgDN+kvKqHY0EcTT3BXKHCl
        POAEEU84tNhFe5o/9uR7RgDtYw79pup5jZ6a3pE4BBt9vbHiDOPmU1o5K0WFXlI7g1+vdldYkFyca
        DfqerB31ptFB6SrJVTJs3RgCKLJLt5ckzDIwaUIEGOSySR3hqQODuZIQEp486XCZnK4Mbv3s9ixWD
        D/e00UPg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:42744 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kkqq7-000IFU-IO; Thu, 03 Dec 2020 15:48:15 +0000
Date:   Thu, 3 Dec 2020 07:48:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Charles <hsu.yungteng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        alan@redhat.com
Subject: Re: [PATCH v6] hwmon: Add driver for STMicroelectronics PM6764
 Voltage Regulator
Message-ID: <20201203154814.GA85686@roeck-us.net>
References: <20201202132334.GA168086@roeck-us.net>
 <339c66fe-e946-d8b7-1ca7-aa33c3ad1eb3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339c66fe-e946-d8b7-1ca7-aa33c3ad1eb3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kkqq7-000IFU-IO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:42744
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 08:34:32PM +0800, Charles wrote:
[ ... ]
> 
> It's really weird. I sent a mail to myself, and it looks good.
> @@ -220,6 +220,15 @@ config SENSORS_MP2975
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mp2975.
> +config SENSORS_PM6764TR
> 
But the above doesn't look good. The empty line is again missing.
It looks like your e-mail system manipulates/modifies the message
and removes that line.

> I have applied my patch with "git am", and it did work.
> Applying: Add-driver-for-STMicroelectronics-PM6764-Voltage-Regulator
> 
> I think I should use another e-mail system.

That may be a good idea. FWIW, I use msmtp, and git send-email.

Thanks,
Guenter
