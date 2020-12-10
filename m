Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F192D6C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394420AbgLJXpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:45:14 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:40878 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727292AbgLJXoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:44:30 -0500
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id B856917B91F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 16:43:43 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id nVb5kn3fBwNNlnVb5kxmmK; Thu, 10 Dec 2020 16:43:43 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=A7FCwZeG c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=zTNgK-yGK50A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=_jlGtV7tAAAA:8
 a=RcD0jx__AeWK_duEVygA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=V1my39vNJ58GKwk4v9/5Bd7Ox89LQp+0nB3otc2qSOo=; b=Tox/STY5h8aDoVSXRoqQxczIqq
        9u1nSImS2AfMcovqFd0/InnoYl0niI/LA4r+jkpIaA2aPRB1+D0Gws9AcMKLePe5Z0AUYClzQ6xTZ
        LgbTdOdX39tvkx90eGZ5iS5D40i0TALj6wNoYX8Sj3XOCMEMcqsCAFKkENMpg1GIVFCDFwCULOqaR
        Lzb6DsBnSi4xwbBHOAs6CkMEPW9e0ewPjKOKqXsiNFeuI+1leNa7Hz4JUSG+2pueg0Q0dy7qsAarJ
        W9/9MAprLwU5mS7WHFFewLU/AgRszYwOES01ATmMjj6E8JlPwqewM5IPCWZMbSF2is41ZLjC4LZ1D
        bE5b4O9A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34624 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1knVb4-0044Mu-QN; Thu, 10 Dec 2020 23:43:42 +0000
Date:   Thu, 10 Dec 2020 15:43:41 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/45] 4.9.248-rc1 review
Message-ID: <20201210234341.GA259082@roeck-us.net>
References: <20201210142602.361598591@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210142602.361598591@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1knVb4-0044Mu-QN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:34624
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 9
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 03:26:14PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.248 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 12 Dec 2020 14:25:47 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 168 pass: 168 fail: 0
Qemu test results:
	total: 382 pass: 382 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
