Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A75562B8050
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgKRPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:23:07 -0500
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:45701 "EHLO
        gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgKRPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:23:06 -0500
Received: from CMGW (unknown [10.9.0.13])
        by gproxy8.mail.unifiedlayer.com (Postfix) with ESMTP id 2049A1AB108
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:23:01 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id fPISk98t4i1lMfPISk97L2; Wed, 18 Nov 2020 08:23:01 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=Xe759Mx5 c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10
 a=evQFzbml-YQA:10 a=_jlGtV7tAAAA:8 a=aJUM6Ip1E-EkNpXXufMA:9 a=CjuIK1q_8ugA:10
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4WNmf6/8ToMlUmc0C09D4x6MkiwPyz/86bXEMQSxUUI=; b=C6TIpXXJ7WMbddsTHySsjeqm+A
        BSX81hnSn/q3+RoXoSrx/Hj+iB3AUZKIe+2LkZIy9ZMDIxDlbIATRr98eaXkm1wvY9mvnDYNHuFuV
        exRalVPW/QKLmNS27IuOc376fqyUgud1y9ybDUjd34uQR+qBxVHhTI1e82tf+V8qGusBVVF9pVqiH
        t3p1G3WugLRrSbF5skkBAslgrytc+xO54qXXRV3CC292bkm/Je6xLHKCJ8PZZWblkVKrk45PW1X07
        /AU6lgF+wI4IgkRRK7QMTLdZycEZQrZTNFePl2v55Z1hCDZ9/B8/soGv5Y+qU7QwQnLfKjGxPKJOJ
        tHt7OwTw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54758 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kfPIS-000zek-6W; Wed, 18 Nov 2020 15:23:00 +0000
Date:   Wed, 18 Nov 2020 07:22:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/85] 4.14.207-rc1 review
Message-ID: <20201118152259.GE174391@roeck-us.net>
References: <20201117122111.018425544@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117122111.018425544@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kfPIS-000zek-6W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:54758
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 42
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 02:04:29PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.207 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Nov 2020 12:20:51 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 168 pass: 168 fail: 0
Qemu test results:
	total: 404 pass: 404 fail: 0

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
