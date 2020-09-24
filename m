Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF332764E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIXAIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 20:08:43 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:33352 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgIXAIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 20:08:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600906122; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=eyjFT2SFuhu/vOff1LvuDvKanm9dHwCnn7IY9td+E7I=; b=riY1GyaV0J7wnQRJFMBRiR67Tnp6HjqgFZt2SqPcITsi1JLjL6H0urZM3pA39GOzepdq7Dk4
 pQqN/Y+ccVM6R7mWjtpKr4pVrkwq0hacqGDBbz7mYGO2i1vN6l0EbkKto1x0N0c6/3bR6xqn
 86NiykfvNwSg+YSpo/Gn4VuRsVE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f6be38a722ceb032757767c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 00:08:42
 GMT
Sender: psodagud=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91B3FC433F1; Thu, 24 Sep 2020 00:08:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from th-lint-038.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 541DBC433CA;
        Thu, 24 Sep 2020 00:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 541DBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=psodagud@codeaurora.org
From:   Prasad Sodagudi <psodagud@codeaurora.org>
To:     rostedt@goodmis.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: [PATCH 2/2] printk: Make the console flush configurable in hotplug path
Date:   Wed, 23 Sep 2020 17:08:32 -0700
Message-Id: <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohammed Khajapasha <mkhaja@codeaurora.org>

The thread which initiates the hot plug can get scheduled
out, while trying to acquire the console lock,
thus increasing the hot plug latency. This option
allows to selectively disable the console flush and
in turn reduce the hot plug latency.

Signed-off-by: Mohammed Khajapasha <mkhaja@codeaurora.org>
Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
---
 init/Kconfig           | 10 ++++++++++
 kernel/printk/printk.c | 10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index d6a0b31..9ce39ba 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -699,6 +699,16 @@ config LOG_BUF_SHIFT
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config CONSOLE_FLUSH_ON_HOTPLUG
+	bool "Enable console flush configurable in hot plug code path"
+	depends on HOTPLUG_CPU
+	def_bool n
+	help
+	In cpu hot plug path console lock acquire and release causes the
+	console to flush. If console lock is not free hot plug latency
+	increases. So make console flush configurable in hot plug path
+	and default disabled to help in cpu hot plug latencies.
+
 config LOG_CPU_MAX_BUF_SHIFT
 	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
 	depends on SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9b75f6b..f02d3ef 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2283,6 +2283,8 @@ void resume_console(void)
 	console_unlock();
 }
 
+#ifdef CONFIG_CONSOLE_FLUSH_ON_HOTPLUG
+
 /**
  * console_cpu_notify - print deferred console messages after CPU hotplug
  * @cpu: unused
@@ -2302,6 +2304,8 @@ static int console_cpu_notify(unsigned int cpu)
 	return 0;
 }
 
+#endif
+
 /**
  * console_lock - lock the console system for exclusive use.
  *
@@ -2974,7 +2978,7 @@ void __init console_init(void)
 static int __init printk_late_init(void)
 {
 	struct console *con;
-	int ret;
+	int ret = 0;
 
 	for_each_console(con) {
 		if (!(con->flags & CON_BOOT))
@@ -2996,13 +3000,15 @@ static int __init printk_late_init(void)
 			unregister_console(con);
 		}
 	}
+#ifdef CONFIG_CONSOLE_FLUSH_ON_HOTPLUG
 	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
 					console_cpu_notify);
 	WARN_ON(ret < 0);
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
 					console_cpu_notify, NULL);
 	WARN_ON(ret < 0);
-	return 0;
+#endif
+	return ret;
 }
 late_initcall(printk_late_init);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

