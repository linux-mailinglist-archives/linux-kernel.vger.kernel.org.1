Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FCD22C275
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgGXJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 05:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXJk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:40:26 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AFBB206D7;
        Fri, 24 Jul 2020 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595583626;
        bh=adF6AITJBl04LRgrb+cGHtqKD2RYjqAPWw/sauO4F+E=;
        h=From:To:Cc:Subject:Date:From;
        b=pMMVKXc2FGBC36NWmOQf9DHoIxMcY3aWzDYckFiHwH9ZpmH1LOzkfBlCMJ8/RRGjt
         54LXnHhubpcsCy3a9ywE7HH+BSMGkQ5ADp26A9NuvBpUsSduwnX4Q2YoZgtgSFK9Go
         H2cn8EFu4Kq8JZRQuBeKUqNyrrvTqqWPlw8H57fQ=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH] clk: qcom: Export gdsc_gx_do_nothing_enable() to modules
Date:   Fri, 24 Jul 2020 02:40:25 -0700
Message-Id: <20200724094025.3261266-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A clk driver can be a module but the gdsc code is in the common module.
Export this symbol so that allmodconfig builds keep working.

Cc: Jonathan Marek <jonathan@marek.ca>
Fixes: 0638226dd095 ("clk: qcom: add common gdsc_gx_do_nothing_enable for gpucc drivers")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gdsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 628397703717..7e4273f314f7 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/ktime.h>
@@ -458,3 +459,4 @@ int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
 	/* Do nothing but give genpd the impression that we were successful */
 	return 0;
 }
+EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/

