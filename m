Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205C12EC820
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbhAGCdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbhAGCdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:33:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E2BC0612EF;
        Wed,  6 Jan 2021 18:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Y/u7YtJmgJ+myd+0PwQt/NtsVGaYOrWxKQtx8mYi/bc=; b=FIXsXBqpw20pAbROFPTssoyBwh
        ATY/ZZRXzkeWVGh3nXBV5BDQ7+ZZg3YM1c6pFWvYcqtnZusMkX5blzzvJt9aR+tnlcjL5+2O9CD22
        3My68g2XA7iC4vs+2V/RyjZy27mSZ7lNQlvWKQU2STUrNnSyGNbIdyPg7ZA5zmqdHcFu9rVZBK4O6
        482onnXK+383lQex+WQkcSsJVR0PpgDPgIU1Qv/y0fQYGUH7+MuDrzd/4fCHG3oAJ7yoXBa3RoJq4
        H7qw85Ll5odK/oBrmW+Ikav5s2xgoFEZcPOrCEBXoT8lW2T73GmIFUCtHKPAVxScFyRyTESGVmXfk
        6NFYKXDw==;
Received: from [2601:1c0:6280:3f0::79df] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxL6s-0007Iy-6K; Thu, 07 Jan 2021 02:33:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mike Turquette <mturquette@linaro.org>,
        Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org
Subject: [PATCH] linux/clk.h: use correct kernel-doc notation for 2 functions
Date:   Wed,  6 Jan 2021 18:33:04 -0800
Message-Id: <20210107023304.24442-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc notation for 2 functions so that the generated
html is correct. Currently it skips all text between the
':' and the '-', so "[un]register a clock rate" is missing.

Fixes: 86bcfa2e87c4 ("clk: add pr_debug & kerneldoc around clk notifiers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org
---
 include/linux/clk.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210105.orig/include/linux/clk.h
+++ linux-next-20210105/include/linux/clk.h
@@ -92,7 +92,7 @@ struct clk_bulk_data {
 #ifdef CONFIG_COMMON_CLK
 
 /**
- * clk_notifier_register: register a clock rate-change notifier callback
+ * clk_notifier_register - register a clock rate-change notifier callback
  * @clk: clock whose rate we are interested in
  * @nb: notifier block with callback function pointer
  *
@@ -103,7 +103,7 @@ struct clk_bulk_data {
 int clk_notifier_register(struct clk *clk, struct notifier_block *nb);
 
 /**
- * clk_notifier_unregister: unregister a clock rate-change notifier callback
+ * clk_notifier_unregister - unregister a clock rate-change notifier callback
  * @clk: clock whose rate we are no longer interested in
  * @nb: notifier block which will be unregistered
  */
