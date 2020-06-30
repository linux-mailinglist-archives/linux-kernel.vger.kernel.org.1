Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF84E20ECC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 06:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgF3Epa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 00:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgF3Ep3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 00:45:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:45:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t7so6349310ybk.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 21:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vSqeEeckvpRbZGibNjwUaMyXm8VkQnSd56e/epMHyVQ=;
        b=gyNi5aATe8TqHE7u6B+wIEwHg193GUJBNOD+RzKybJOneonjln50tdgpwT43fJ/Ths
         8dFI5YKs37yghC22E/N+87q5OGQUfcGqRPEuzA2jrf8AQ+hlNUnYSSxNLePtmV7PQemM
         /YDnZE9BBFUxFo9T2OEttT/2WczcCMclSAM1gnLmg1VU2LbaUV0JN8t9ovWkuasnGbTe
         6RglnmmOKNPkyucnT56IJXlkjCwDXBUvd7ypX5cTWV1EdocXxIbZFOz6T63wT+Lh6KOW
         0JrJozUoxWuPBBQXzwzzBQai85mW3u1RNbD49V3jotfI9QHsoE0opMlsUwvXc72e0oY8
         Xn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vSqeEeckvpRbZGibNjwUaMyXm8VkQnSd56e/epMHyVQ=;
        b=r2g9/laZktO0KsY2V1PIix6X8JEs4GgoSse2deXFzxSMc0MXN3mpSudltTpRFUjSJL
         jVInY3eGqDfOxLbmpSqngTRkL6SJDLRge+f1tjXe8p89l5lhE9OfziJJIV9DA1rZvnsP
         U4/IDrYuzIqXUEhNgW7a5mTmjMIYQD4KgzUtoxohHbPueq9UQFOu8YuHZtPWmEI/O731
         dvS5Ako+tITq/jMgZnmfUxGefLem17CGJS0QhLpGXm/mZPQLOmqSCxieCdTZ0s1trKEN
         S0YIw27s7h88MrEooZpBexKBh4OfmTeFpgapf8zDk/IoGKa0q+lo/QPXLuo4zqndQ5q2
         k74Q==
X-Gm-Message-State: AOAM531BbbZQhWEBX5pz3QhWlY79or0czfUoLQurTLcWI7JytHJ2/QPe
        ARFEndjbs12WEfe2fr/o25rc/d9FWULBLg==
X-Google-Smtp-Source: ABdhPJyU53scu18O26IxLx2seqo1666FrNwEmW6JQE0uTUsyEEKPzVYVNeqyTCA7tMSuyMdT+nkhBbNQt05sKQ==
X-Received: by 2002:a25:f509:: with SMTP id a9mr32741555ybe.227.1593492328741;
 Mon, 29 Jun 2020 21:45:28 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:45:17 -0700
Message-Id: <20200630044518.1084468-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] clk: staging: Specify IOMEM dependency for Xilinx Clocking
 Wizard driver
From:   David Gow <davidgow@google.com>
To:     Soren Brinkmann <soren.brinkmann@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, devel@driverdev.osuosl.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx Clocking Wizard driver uses the devm_ioremap_resource
function, but does not specify a dependency on IOMEM in Kconfig. This
causes a build failure on architectures without IOMEM, for example, UML
(notably with make allyesconfig).

Fix this by making CONFIG_COMMON_CLK_XLNX_CLKWZRD depend on CONFIG_IOMEM.

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/staging/clocking-wizard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/clocking-wizard/Kconfig b/drivers/staging/clocking-wizard/Kconfig
index 04be22dca9b6..69cf51445f08 100644
--- a/drivers/staging/clocking-wizard/Kconfig
+++ b/drivers/staging/clocking-wizard/Kconfig
@@ -5,6 +5,6 @@
 
 config COMMON_CLK_XLNX_CLKWZRD
 	tristate "Xilinx Clocking Wizard"
-	depends on COMMON_CLK && OF
+	depends on COMMON_CLK && OF && IOMEM
 	help
 	  Support for the Xilinx Clocking Wizard IP core clock generator.
-- 
2.27.0.212.ge8ba1cc988-goog

