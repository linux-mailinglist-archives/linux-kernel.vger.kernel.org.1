Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09E1FFC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 22:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgFRUFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbgFRUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:05:29 -0400
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Jun 2020 13:05:29 PDT
Received: from mta02.hs-regensburg.de (mta02.hs-regensburg.de [IPv6:2001:638:a01:1096::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827EC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:05:29 -0700 (PDT)
Received: from E16S02.hs-regensburg.de (e16s02.hs-regensburg.de [IPv6:2001:638:a01:8013::92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S02", Issuer "E16S02" (not verified))
        by mta02.hs-regensburg.de (Postfix) with ESMTPS id 49nt2w1wJRzy4D;
        Thu, 18 Jun 2020 21:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1592510136;
        bh=Of0GwQchv+P8YWeKdVxPE3NR+Pqpw5RU32LW53xV0aI=;
        h=From:To:CC:Subject:Date:From;
        b=G1zRClibCiJ8BVL7KynrwyLpHyv44wPwN11Ah2s2Usg+bXcYSv1LEi6goKcSJycv0
         kYPQ3jYtZiJV7FW08BPWlXAUgEV154T+cb2wM6aan1MoMf/sSUyn7KZjxHJx6h8LhY
         9bI2/S5xjjuHYKKN6Fgpnz/sPDt0suh/fftzJh0mNxlHRH+X1eA9UGKXpinS2LMQVq
         UITl5gy5P8M2NE8xLX10QlSsmLA03rRrmuYLzLYHD/T3kid9XpAYF+JJSTWGF2/W8u
         UFHEmHssqCoV/iFRUvP8PEmI4FKEIOYVHKca46nQFkPV5ftBDdPVzSsdw5Nv+Dee8y
         9GfyVOCGU5V7A==
Received: from omega.binary.kitchen (194.95.106.138) by
 E16S02.hs-regensburg.de (2001:638:a01:8013::92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 21:55:35 +0200
From:   Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
To:     Lubomir Rintel <lkundrak@v3.sk>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: fix incorrect directory reference
Date:   Thu, 18 Jun 2020 21:55:27 +0200
Message-ID: <20200618195527.162034-1-ralf.ramsauer@oth-regensburg.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [194.95.106.138]
X-ClientProxiedBy: E16S03.hs-regensburg.de (2001:638:a01:8013::93) To
 E16S02.hs-regensburg.de (2001:638:a01:8013::92)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the below-mentioned commit moved headers to inlucde/linux/soc/mmp. MAINTAINERS
was updated, but include/ was omitted.

Fixes: 32adcaa010 ("ARM: mmp: move cputype.h to include/linux/soc/")
Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..20d897b5be4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11492,7 +11492,7 @@ S:	Odd Fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
 F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
-F:	linux/soc/mmp/
+F:	include/linux/soc/mmp/
 
 MMP USB PHY DRIVERS
 R:	Lubomir Rintel <lkundrak@v3.sk>
-- 
2.27.0

