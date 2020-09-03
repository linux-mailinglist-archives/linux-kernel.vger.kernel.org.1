Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5525BA94
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 07:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgICFnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 01:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgICFnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:43:41 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8AF2071B;
        Thu,  3 Sep 2020 05:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599111821;
        bh=bVGHzeaQ+zZ2rlm9O/+KZJBG/FaDbOPzPAd0MPbfmhY=;
        h=From:To:Cc:Subject:Date:From;
        b=sEglWioFqagWCPvGthokN5gicayXpn8RQmnujvYNxeYwh66BODsXrI1N+657nwPCG
         NZ0UPaNrAqRwQRAokUsdxkJHVKHrVb7QihDiee01s0qq9PZdyuFPmTOrfbNax4RzG+
         ldUGAj1r71Y2pABIL/HdntnAAjoqmXhZ6nw6hbQU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ben Dooks <ben-linux@fluff.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mmc: s3cmci: Drop unused variables in dbg_dumpregs
Date:   Thu,  3 Sep 2020 07:43:33 +0200
Message-Id: <20200903054333.18331-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'imask' and 'bsize' are not used in dbg_dumpregs:

  drivers/mmc/host/s3cmci.c:149:36: warning: variable 'imask' set but not used [-Wunused-but-set-variable]
  drivers/mmc/host/s3cmci.c:148:63: warning: variable 'bsize' set but not used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/s3cmci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index ac94f926624d..40329aeacfdf 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -145,8 +145,8 @@ static void s3cmci_reset(struct s3cmci_host *host);
 
 static void dbg_dumpregs(struct s3cmci_host *host, char *prefix)
 {
-	u32 con, pre, cmdarg, cmdcon, cmdsta, r0, r1, r2, r3, timer, bsize;
-	u32 datcon, datcnt, datsta, fsta, imask;
+	u32 con, pre, cmdarg, cmdcon, cmdsta, r0, r1, r2, r3, timer;
+	u32 datcon, datcnt, datsta, fsta;
 
 	con 	= readl(host->base + S3C2410_SDICON);
 	pre 	= readl(host->base + S3C2410_SDIPRE);
@@ -158,12 +158,10 @@ static void dbg_dumpregs(struct s3cmci_host *host, char *prefix)
 	r2 	= readl(host->base + S3C2410_SDIRSP2);
 	r3 	= readl(host->base + S3C2410_SDIRSP3);
 	timer 	= readl(host->base + S3C2410_SDITIMER);
-	bsize 	= readl(host->base + S3C2410_SDIBSIZE);
 	datcon 	= readl(host->base + S3C2410_SDIDCON);
 	datcnt 	= readl(host->base + S3C2410_SDIDCNT);
 	datsta 	= readl(host->base + S3C2410_SDIDSTA);
 	fsta 	= readl(host->base + S3C2410_SDIFSTA);
-	imask   = readl(host->base + host->sdiimsk);
 
 	dbg(host, dbg_debug, "%s  CON:[%08x]  PRE:[%08x]  TMR:[%08x]\n",
 				prefix, con, pre, timer);
-- 
2.17.1

