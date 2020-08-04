Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E323BD03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 17:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgHDPPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 11:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgHDPOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:14:03 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9FE2086A;
        Tue,  4 Aug 2020 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596554043;
        bh=my56wxLmosOxgUWMEuXlQ1fGu46KvIHPU4Touu/yTO0=;
        h=From:To:Cc:Subject:Date:From;
        b=RN0qvKJiOD4wbeapTVHeb9VjpHCEBQefF/0YxmV+YJHmszpRmWME6NqPifgakw+8d
         E9XJtGLhBK/PigFplW5i1MY0kUFK/l9p3Gy1kuty4gLsidyW/K5DNNeVawzie501/N
         ORM0Of/X0DA2WwC5gciFKnrae8B36aFEcbP8QcZU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ben Dooks <ben-linux@fluff.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mmc: s3cmci: remove empty kerneldoc comment
Date:   Tue,  4 Aug 2020 17:13:45 +0200
Message-Id: <20200804151345.28005-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove empty comment to fix W=1 compile warning:

    drivers/mmc/host/s3cmci.c:400: warning: Cannot understand  *
     on line 400 - I thought it was a doc line

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/s3cmci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 444b2769ae2c..b5df948f8155 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -396,9 +396,6 @@ static void s3cmci_enable_irq(struct s3cmci_host *host, bool more)
 	local_irq_restore(flags);
 }
 
-/**
- *
- */
 static void s3cmci_disable_irq(struct s3cmci_host *host, bool transfer)
 {
 	unsigned long flags;
-- 
2.17.1

