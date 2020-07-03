Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C821365A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:26:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:50890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCI0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:26:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A99AACF2;
        Fri,  3 Jul 2020 08:26:18 +0000 (UTC)
Date:   Fri, 3 Jul 2020 10:26:17 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Krzysztof Halasa <khalasa@piap.pl>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/2] soc: ixp4xx: List the whole directory in MAINTAINERS
Message-ID: <20200703102617.0b9f933e@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention the whole directory containing the ixp4xx soc drivers in
MAINTAINERS instead of each driver separately. Otherwise changes
done to Makefile and Kconfig will fail to find a matching entry.
This will also let future drivers match without having to update
the entry each time.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Krzysztof Halasa <khalasa@piap.pl>
---
 MAINTAINERS |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- linux-5.7.orig/MAINTAINERS	2020-06-23 13:03:34.728650310 +0200
+++ linux-5.7/MAINTAINERS	2020-06-23 13:04:14.045055597 +0200
@@ -8654,10 +8654,8 @@ M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
 F:	drivers/net/ethernet/xscale/ixp4xx_eth.c
 F:	drivers/net/wan/ixp4xx_hss.c
-F:	drivers/soc/ixp4xx/ixp4xx-npe.c
-F:	drivers/soc/ixp4xx/ixp4xx-qmgr.c
-F:	include/linux/soc/ixp4xx/npe.h
-F:	include/linux/soc/ixp4xx/qmgr.h
+F:	drivers/soc/ixp4xx/
+F:	include/linux/soc/ixp4xx/
 
 INTEL IXP4XX RANDOM NUMBER GENERATOR SUPPORT
 M:	Deepak Saxena <dsaxena@plexity.net>


-- 
Jean Delvare
SUSE L3 Support
