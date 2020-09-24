Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169A22764E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 02:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgIXAIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 20:08:51 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:33352 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgIXAIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 20:08:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600906130; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gHJxs2l+8DkIwFFuCqfo/80lF8RViasP12nXn2L5uSE=; b=U8M3vP2R8setAwlfKwxELm8vSkXN7Tttj/pQYBGnvEl3w56JO+U/D8u9cRR8lgYlPdW/X0P2
 iTbGgUfFhEppM1IWUzpH5wgVKGVDvxdy+ZdBdeVwwp5XOwoqfrUr/4cCAONvDTJY/0FZiApP
 muEvK9Hb6HAJaoQlueJAHQbpmI8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f6be387429250c1ddadff0a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 00:08:39
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16C77C433CB; Thu, 24 Sep 2020 00:08:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5CCDC433CB;
        Thu, 24 Sep 2020 00:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5CCDC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     rostedt@goodmis.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 1/2] genirq/cpuhotplug: Reduce logging level for couple of prints
Date:   Wed, 23 Sep 2020 17:08:31 -0700
Message-Id: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the cpu hot plug stress testing, couple of messages
continuous flooding on to the console is causing timers
migration delay. Delayed time migrations from hot plugging
core is causing device instability with watchdog. So reduce
log level for couple of prints in cpu hot plug flow.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 arch/arm64/kernel/smp.c | 2 +-
 kernel/irq/cpuhotplug.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 355ee9e..08da6e3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -338,7 +338,7 @@ void __cpu_die(unsigned int cpu)
 		pr_crit("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
-	pr_notice("CPU%u: shutdown\n", cpu);
+	pr_info("CPU%u: shutdown\n", cpu);
 
 	/*
 	 * Now that the dying CPU is beyond the point of no return w.r.t.
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 02236b1..82802e0 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -42,7 +42,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
 		 * If this happens then there was a missed IRQ fixup at some
 		 * point. Warn about it and enforce fixup.
 		 */
-		pr_warn("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
+		pr_info("Eff. affinity %*pbl of IRQ %u contains only offline CPUs after offlining CPU %u\n",
 			cpumask_pr_args(m), d->irq, cpu);
 		return true;
 	}
@@ -166,7 +166,7 @@ void irq_migrate_all_off_this_cpu(void)
 		raw_spin_unlock(&desc->lock);
 
 		if (affinity_broken) {
-			pr_warn_ratelimited("IRQ %u: no longer affine to CPU%u\n",
+			pr_info_ratelimited("IRQ %u: no longer affine to CPU%u\n",
 					    irq, smp_processor_id());
 		}
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

