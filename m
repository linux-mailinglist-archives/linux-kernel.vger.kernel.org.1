Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8262A29C5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgKBLrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgKBLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:46:33 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D46C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:46:32 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i7so8636118pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=onEvuddY7rjjmRNmF3inPaMsobQ6rmeVGOOE4kPhESY=;
        b=Vr5aHR13z2KIKtAwzdZ9s6RuU5nLQfx+2eKHmCn96yKknRT+ZskWrmJ8yaTYMU7fWA
         Duj06UU0FTvBMzrM2Pr/1EXdpd1MkKR4u8DSzE/cXXoIu/RyDBkLJKKUe93TQP2Wm5rf
         hFSWBvw5Qb1z4J3oRSY2qvEi1w86g4+e8BnVTllmTnVFPa87+8BVL0rk0aw9OP0YW0+D
         bwK9KSCqGu+AEQ7O7WhQ7SxBEVE5VEzdhEXC3uirBEKqUUTcFVohi3NdE8QMeghI5cde
         SX0R4CrRZA8D4lI4ATcq/88Bapzxz3tX8ALazIlthY7XTG13blWgKV/JHywhVKn9l2pS
         e8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=onEvuddY7rjjmRNmF3inPaMsobQ6rmeVGOOE4kPhESY=;
        b=WjHaFILNSHiSHPyhNCCQVrXzHXE5yslBKnEaSbj+RD6JmOR5Ql00MVtjPP71Yov3gm
         fuUZoNXqPDwPgAnDwEu76u2yOWwPXDNOx7ZlpA/xqYOOz4AoiGRPqEQffdRfMzrPcJD9
         JWYT/OyFA9dTRhmr4oY+HEnDKommPuzJfu4cbjPSabN4ohc+xfzpT+7BZD2W0Ss4Cski
         pmOTY0v9oY9PwshWyM9A8AjSqH34iqQQMT2mC9W2lNReAHiufXP3gRBeRkjzMGxG9ifU
         lmq10QkTrL+2Ejl3t5VfHCnqVwvXsc7/gJgD0uSpQbtrfED3qAbgHL84vmuUT+fyjArH
         T3UQ==
X-Gm-Message-State: AOAM5329EGVeKge60Cb0uL7fyHmDc7xPgrQYwbeEittjywe2iX6o83Rx
        gx+I7uy/FT0yPP3PM3vBKHdClw==
X-Google-Smtp-Source: ABdhPJz6Klrso4Ngfvn20QS7DmYsk6GOwWNXcIzsTkWC0MaK8geg5GBT9xWeV6BPg/9LlQGCX5EAwA==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr12488404pju.194.1604317591809;
        Mon, 02 Nov 2020 03:46:31 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id y5sm14276184pfq.79.2020.11.02.03.46.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 03:46:31 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        daniel.thompson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v7 6/7] kgdb: Expose default CPUs roundup fallback mechanism
Date:   Mon,  2 Nov 2020 17:14:46 +0530
Message-Id: <1604317487-14543-7-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new API kgdb_smp_call_nmi_hook() to expose default CPUs roundup
mechanism to a particular archichecture as a runtime fallback if it
detects to not support NMI roundup.

Currently such an architecture example is arm64 supporting pseudo NMIs
feature which is only available on platforms which have support for GICv3
or later version.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/linux/kgdb.h      | 12 ++++++++++++
 kernel/debug/debug_core.c |  8 +++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 0d6cf64..4190f13 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -200,6 +200,18 @@ kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
 extern void kgdb_call_nmi_hook(void *ignored);
 
 /**
+ *	kgdb_smp_call_nmi_hook - Provide default fallback mechanism to
+ *				 round-up CPUs
+ *
+ *	If you're using the default implementation of kgdb_roundup_cpus()
+ *	this function will be called.  And if an arch detects at runtime to
+ *	not support NMI based roundup then it can fallback to default
+ *	mechanism using this API.
+ */
+
+extern void kgdb_smp_call_nmi_hook(void);
+
+/**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
  *
  *	On SMP systems, we need to get the attention of the other CPUs
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 1e75a89..ae785d8 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -241,7 +241,7 @@ void __weak kgdb_call_nmi_hook(void *ignored)
 }
 NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
 
-void __weak kgdb_roundup_cpus(void)
+void kgdb_smp_call_nmi_hook(void)
 {
 	call_single_data_t *csd;
 	int this_cpu = raw_smp_processor_id();
@@ -273,6 +273,12 @@ void __weak kgdb_roundup_cpus(void)
 			kgdb_info[cpu].rounding_up = false;
 	}
 }
+NOKPROBE_SYMBOL(kgdb_smp_call_nmi_hook);
+
+void __weak kgdb_roundup_cpus(void)
+{
+	kgdb_smp_call_nmi_hook();
+}
 NOKPROBE_SYMBOL(kgdb_roundup_cpus);
 
 #endif
-- 
2.7.4

