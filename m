Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D070C2BC19E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgKUSvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:51:54 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:36476 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728319AbgKUSvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:51:54 -0500
Received: from CMGW (unknown [10.9.0.13])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 92E86175C7E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 11:51:52 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id gXzEkRSCWi1lMgXzEkQyJJ; Sat, 21 Nov 2020 11:51:52 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=D4A3ErZj c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10
 a=evQFzbml-YQA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=G9OVi-XX-SaVrF5UqbQA:9
 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HotaPkXnnpv3O3DIEezLBKrXxNiD0dVLa4OpYyJGbVE=; b=rXxT8kLIjYMFJ0NTHFNeIef7W8
        nBClDWJC3f/IkYwxtWppURf5lc3RrmUJQgUD8VM4qjArsm9h1vFEYlcXubvxcOPPz9ETeScoxnigF
        RKisfl1BNXu9PSa8gQSekgmkTdGba2v4rt+JabvcyS/pnSPMM60nZMmu/f2u31+3T6vswIjYqW7c0
        F5CUCXX7TAtIVPGjfvY8UErrPXjjKsoBxt8pqKxF0dDtmys35Y8694DBA4I8oXgUT0nbegtxecfTC
        za1hKfrL50JZ4Xpkt8zCVC/R2XlooYLQ6m3DJUXEBsPAEPt7Djd+Q2Ew1ZPE2MHBnSTsMkuwRTVpy
        AJvA1LkA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40998 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kgXzD-003D3U-Gp; Sat, 21 Nov 2020 18:51:51 +0000
Date:   Sat, 21 Nov 2020 10:51:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH v2 0/3] occ: Add support for P10
Message-ID: <20201121185150.GD114144@roeck-us.net>
References: <20201120010315.190737-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120010315.190737-1-joel@jms.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kgXzD-003D3U-Gp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:40998
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 74
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:33:12AM +1030, Joel Stanley wrote:
> Hi Guenter, here's v2 of this series on behalf of Eddie. I made the
> change to the compatible string that we spoke about in v2, and I'm happy
> for these to go through the hwmon tree.
> 

I'll be happy to do that, as soon as we get a Reviewed-by: tag for the DT
change.

Thanks,
Guenter

> v1: https://lore.kernel.org/linux-hwmon/20200501150833.5251-1-eajames@linux.ibm.com/
> 
> The OCC in the P10 has a number of differences from the P9. Add some logic to
> handle the differences in accessing the OCC from the service processor, and
> support the new temperature sensor type.
> 
> Eddie James (3):
>   dt-bindings: fsi: Add P10 OCC device documentation
>   fsi: occ: Add support for P10
>   hwmon: (occ) Add new temperature sensor type
> 
>  .../devicetree/bindings/fsi/ibm,p9-occ.txt    |  12 +-
>  drivers/fsi/fsi-occ.c                         | 125 +++++++++++++-----
>  drivers/hwmon/occ/common.c                    |  75 +++++++++++
>  3 files changed, 172 insertions(+), 40 deletions(-)
> 
> -- 
> 2.29.2
> 
