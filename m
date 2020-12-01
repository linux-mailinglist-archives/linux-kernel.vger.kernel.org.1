Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3481B2C944D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgLAAto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:49:44 -0500
Received: from gproxy10-pub.mail.unifiedlayer.com ([69.89.20.226]:43509 "EHLO
        gproxy10-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731157AbgLAAtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:49:43 -0500
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy10.mail.unifiedlayer.com (Postfix) with ESMTP id 49D86140488
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 17:49:02 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id jtqnkXOT5eMJHjtqokeEo8; Mon, 30 Nov 2020 17:49:02 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Ff8ZOq26 c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=KKAkSRfTAAAA:8
 a=OPsBkE8w8ii4HYlIn34A:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=cvBusfyB2V15izCimMoJ:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zI3joqWDlNyPs6bVf8+a9QgpBtZydGTR6Q0nqoSqJCs=; b=cl4NLuzgmlSGV9w23vnsynMSUL
        ctsX3/w9j3MfI3v6w4EIM5h9OX7ud/5AZarOsFP586oGUmmKh36IDJBHqIMj0sJpS6SHZ9KfpCpDz
        /orhtrALNcb7H7NMPcIRlJK+MRCOBq8zFKC1BcHonTwELhFTmoFTLT6wcYVX/8unox1UGULGpLu0N
        rTVBFxBf8iPB+TV/oimZOULk+CTuZFjxSJ3WCQ4iXBH51puuD/cdJYPl6VQ9RlJvlRsZxgJd04J1G
        W80J5BrB+E1DfjT54TN+3ykKGDR9RTN7A6DTwEfwAKr0PiZIc4kK0JjLxXeUCch8FKMpnpVfZnMLu
        aDlVc55g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57206 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kjtqn-002dFx-AB; Tue, 01 Dec 2020 00:49:01 +0000
Date:   Mon, 30 Nov 2020 16:49:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     b.zolnierkie@samsung.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: hwmon: pwm-fan: fix warning unused variable
 'ctx'
Message-ID: <20201201004900.GA48095@roeck-us.net>
References: <20201201003118.2219422-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201003118.2219422-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kjtqn-002dFx-AB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57206
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 1
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:31:18AM +0100, Anders Roxell wrote:
> When building hwmon/pwm-fan the following unused-variable warning shows
> up:
> 
> /tmp/drivers/hwmon/pwm-fan.c: In function ‘pwm_fan_is_visible’:
> /tmp/drivers/hwmon/pwm-fan.c:167:22: warning: unused variable ‘ctx’ [-Wunused-variable]
> 
> Remove the unneeded variable declaration 'ctx'.
> 
> Fixes: 439ed83acc19 ("hwmon: (pwm-fan) Convert to hwmon_device_register_with_info API")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I already folded this change into the original patch.

Guenter
