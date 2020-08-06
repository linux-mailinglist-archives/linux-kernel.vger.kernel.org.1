Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0B23E137
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 20:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgHFSmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 14:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbgHFSXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:23:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7680622CF7;
        Thu,  6 Aug 2020 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738116;
        bh=jkHktbppRvONf+xJVWmfSCc2eQC8JATnpI2A2T7cDPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=myqjfk5TqieOfDTqf9vLXeOC0RvfTRnK4oPV3KF2Mi25rXjpnyj89EYEB/pv3E6oD
         hX+zM779/ialBivqyBVc5q9adJbuO7yXflyYpaJyjYiFP0b4Ky4Q9mBCUgof7rc4uz
         lDAEWR85hJEmUil1JhdfzQKn8uqDhADiCt+ymd5c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 04/41] ARM: s3c24xx: iotiming: make functions static
Date:   Thu,  6 Aug 2020 20:20:21 +0200
Message-Id: <20200806182059.2431-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are two functions in this file that are never called from
anywhere else, so they should be static to allow the compiler
to optimize it better and not pollute the global namespace.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index 9f90aaf70bf3..39081c41958c 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -129,7 +129,7 @@ static unsigned int calc_0124(unsigned int cyc, unsigned long hclk_tns,
 	return 0;
 }
 
-int calc_tacp(unsigned int cyc, unsigned long hclk, unsigned long *v)
+static int calc_tacp(unsigned int cyc, unsigned long hclk, unsigned long *v)
 {
 	/* Currently no support for Tacp calculations. */
 	return 0;
@@ -288,8 +288,8 @@ static unsigned int get_0124(unsigned long hclk_tns,
  * Given the BANKCON setting in @bt and the current frequency settings
  * in @cfg, update the cycle timing information.
  */
-void s3c2410_iotiming_getbank(struct s3c_cpufreq_config *cfg,
-			      struct s3c2410_iobank_timing *bt)
+static void s3c2410_iotiming_getbank(struct s3c_cpufreq_config *cfg,
+				     struct s3c2410_iobank_timing *bt)
 {
 	unsigned long bankcon = bt->bankcon;
 	unsigned long hclk = cfg->freq.hclk_tns;
-- 
2.17.1

