Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC27241D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgHKPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbgHKPmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFB622BEF;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160523;
        bh=MH1bvUjYC37bx2LZsXr1vc95Xh18NFGKlhDeP1Az7Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ne2AATSqvUwCaTCBEffuGfszrPPJo4jrBKmiSWfbrKy6N4ntwa+ZBPc+ISdYbXpbj
         OyTndNisM5gFqEcsTlt5pKnb/H1otR3X8i3b2Z0LiCUEbU+6ZS1i6DMJd4WWGN+ivA
         5bB26PFsxqFLiJFMsa3KU6VsBLLWJBqaT6XGe/pM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bms-P0; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/33] mfd: Kconfig: fix a typo
Date:   Tue, 11 Aug 2020 17:41:41 +0200
Message-Id: <103447d4642f0560edbb814088d5158e4d853299.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

individul -> individual

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index a37d7d171382..e42d11849947 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -493,7 +493,7 @@ config MFD_HI6421_PMIC
 	  Add support for HiSilicon Hi6421 PMIC. Hi6421 includes multi-
 	  functions, such as regulators, RTC, codec, Coulomb counter, etc.
 	  This driver includes core APIs _only_. You have to select
-	  individul components like voltage regulators under corresponding
+	  individual components like voltage regulators under corresponding
 	  menus in order to enable them.
 	  We communicate with the Hi6421 via memory-mapped I/O.
 
-- 
2.26.2

