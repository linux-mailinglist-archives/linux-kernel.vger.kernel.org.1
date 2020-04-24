Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9EA1B72BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 13:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgDXLLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:11:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04F6C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so3613179pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iZlX3qI3DOrQp2dXg0tXmAB1b4Jn5t/S/MWmmmiRunE=;
        b=CVZnPFr9kE70O15FetLKinvjuz8SOPjO0QhwdMblhDxZ9Id5IeVNj7VVnd8hElz/sF
         AG1K68EzIIT1QBeciWSUX1tRXiBkRLrXW+yqqrS88Q6sUEI1yNOwrf9jdHlMJL8sehBB
         6w9hYV3EcVhFehuZslXH5yMUZpmA/rSNol6qhUtkJSqbWu7QnuGBnVXFNX8oq3vjXiqq
         kd8MHcAy6KgjwqLgbODiJn8IQ2GpMsYoXiQZu4MRPvC4xvN+hyEKyzG3SEazdUlxP9T6
         PC1SmBNgKCeGjDh+kQg7pNH9UeOwkWlYzVnNfmIxCFhb0BlVf4mAIGSwg7RU9spXUljF
         wDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iZlX3qI3DOrQp2dXg0tXmAB1b4Jn5t/S/MWmmmiRunE=;
        b=FJxCbKVKWnpPBlq4hAlvs2zGOmPTSWES3HnqTbFAi9UNbSJtnW+aSjQRE0qAYwd9Li
         UwxjunzSwal6L0GRHbr2XbiNKP391GqbjdShMY4QrXW0OU1CEhkxRDC3dkcXWiry5Sti
         qFJiHWxz3hxhDrtlYZzRhIJa2bZco3EnQBbTULoEw6J0Wtxn1k5bLKTzJQVO6UueABsy
         kl5zCnP7IOJhttD8cH1w9oNEfhJeTEC/PVN6NPSplEfI5ESo8YNT52Ajzs1a37MPWMVj
         DUQblT5wba6GMrE/bG7eH46HAE/lVsZ0/1T0E5lZUheKQKTpQxcBGHzLwI3jQFKHwt5Z
         iEYg==
X-Gm-Message-State: AGi0PuaXtoeZnU6uFlE5QkQXd8OBjTdEJjEOxu4clX7S1yNtwV73zl/g
        wV+K+3L27nvUb89ohcuqeiI4mg==
X-Google-Smtp-Source: APiQypIPAwj21VAG16p5qy62FUaJZAsNJzTP5WGLYMy0GUrRu2nsXVPQnqKsEw1+588tI2FpCpc0Hg==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr5614004pju.1.1587726699499;
        Fri, 24 Apr 2020 04:11:39 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.186])
        by smtp.gmail.com with ESMTPSA id o11sm4637628pgd.58.2020.04.24.04.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 04:11:38 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as pseudo NMI
Date:   Fri, 24 Apr 2020 16:39:12 +0530
Message-Id: <1587726554-32018-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pseudo NMIs enabled, interrupt controller can be configured to
deliver SGI as a pseudo NMI. So add corresponding handling for SGIs.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d7006ef..be361bf 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -609,17 +609,29 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 	if (irqs_enabled)
 		nmi_enter();
 
-	if (static_branch_likely(&supports_deactivate_key))
-		gic_write_eoir(irqnr);
 	/*
 	 * Leave the PSR.I bit set to prevent other NMIs to be
 	 * received while handling this one.
 	 * PSR.I will be restored when we ERET to the
 	 * interrupted context.
 	 */
-	err = handle_domain_nmi(gic_data.domain, irqnr, regs);
-	if (err)
-		gic_deactivate_unhandled(irqnr);
+	if (likely(irqnr > 15)) {
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_eoir(irqnr);
+
+		err = handle_domain_nmi(gic_data.domain, irqnr, regs);
+		if (err)
+			gic_deactivate_unhandled(irqnr);
+	} else {
+		gic_write_eoir(irqnr);
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_dir(irqnr);
+#ifdef CONFIG_SMP
+		handle_IPI(irqnr, regs);
+#else
+		WARN_ONCE(true, "Unexpected SGI received!\n");
+#endif
+	}
 
 	if (irqs_enabled)
 		nmi_exit();
-- 
2.7.4

