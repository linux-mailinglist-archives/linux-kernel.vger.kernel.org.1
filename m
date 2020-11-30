Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C22C8B57
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgK3RiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:38:10 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36965 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgK3RiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:38:09 -0500
Received: by mail-ej1-f68.google.com with SMTP id f9so21150113ejw.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQXoHqLQZy7X5ehxBZf9/3JC9z6lvN7jYEpoD9PHtkE=;
        b=IeEL9yyLW8FSANx2PfhmBVFTUoSfTwfyUr+CwYfsWIR+nZ41S8pDeuUkmzlOk7iti9
         vq1eoX0lnoyBMML96HB1UcEfuRawtF0dBzluff14BTRlsK7m6Wxu5q/h/BLcpNe7XMBd
         herFQS3f/Z+XBYdJkNt8Iwz5vvPFft+q9CAOP7Hj+bRjYSY0BfSczUzsle677faMMNQd
         uje5IqoZ2C87wsSpgOoZZFSTfgw4zYLBnbVqv1Or4OG5NNDMSaUBuT/Mfdr2a5+Wl0ni
         +dpxuSOnHFwctkJAuD6iZhbzWSDgSShJbcnKkoGq17bFGG3CPf7PE/XtiDxTOC8WhdEQ
         ZN5Q==
X-Gm-Message-State: AOAM530H3o9YRYEPjFH8gk7coWvYzgxXu7hXYuokcOeoN8+k/xiDDTSj
        qecdb/PguKY5TkvzMDGkQMcmIylVKllbx0Fz
X-Google-Smtp-Source: ABdhPJzdAZ+RmtAH1sqt7p+n1z38zdvFQXz+F/NCt7Xd8L/Y7KBSoZOB94qxkVscsk79Pfcs+h6Kfw==
X-Received: by 2002:a17:906:7a55:: with SMTP id i21mr6527399ejo.552.1606757847209;
        Mon, 30 Nov 2020 09:37:27 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id qu21sm4959856ejb.95.2020.11.30.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:37:26 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] reboot: hide from sysfs not applicable settings
Date:   Mon, 30 Nov 2020 18:37:17 +0100
Message-Id: <20201130173717.198952-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130173717.198952-1-mcroce@linux.microsoft.com>
References: <20201130173717.198952-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Not all the reboot settings from both the kernel command line or sysfs
interface are available to all platforms.

Filter out reboot_type and reboot_force which are x86 only, and also
remove reboot_cpu on kernels without SMP support.

This saves some space, and avoid confusing the user with settings which
will have no effect.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 kernel/reboot.c | 54 ++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index d80e3d64fe23..f9c192bb49d0 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -662,6 +662,29 @@ static ssize_t mode_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 static struct kobj_attribute reboot_mode_attr = __ATTR_RW(mode);
 
+#ifdef CONFIG_X86
+static ssize_t force_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", reboot_force);
+}
+static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
+			  const char *buf, size_t count)
+{
+	bool res;
+
+	if (!capable(CAP_SYS_BOOT))
+		return -EPERM;
+
+	if (kstrtobool(buf, &res))
+		return -EINVAL;
+
+	reboot_default = 0;
+	reboot_force = res;
+
+	return count;
+}
+static struct kobj_attribute reboot_force_attr = __ATTR_RW(force);
+
 static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	const char *val;
@@ -717,7 +740,9 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 static struct kobj_attribute reboot_type_attr = __ATTR_RW(type);
+#endif
 
+#ifdef CONFIG_SMP
 static ssize_t cpu_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", reboot_cpu);
@@ -745,34 +770,17 @@ static ssize_t cpu_store(struct kobject *kobj, struct kobj_attribute *attr,
 	return count;
 }
 static struct kobj_attribute reboot_cpu_attr = __ATTR_RW(cpu);
-
-static ssize_t force_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d\n", reboot_force);
-}
-static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
-			  const char *buf, size_t count)
-{
-	bool res;
-
-	if (!capable(CAP_SYS_BOOT))
-		return -EPERM;
-
-	if (kstrtobool(buf, &res))
-		return -EINVAL;
-
-	reboot_default = 0;
-	reboot_force = res;
-
-	return count;
-}
-static struct kobj_attribute reboot_force_attr = __ATTR_RW(force);
+#endif
 
 static struct attribute *reboot_attrs[] = {
 	&reboot_mode_attr.attr,
+#ifdef CONFIG_X86
+	&reboot_force_attr.attr,
 	&reboot_type_attr.attr,
+#endif
+#ifdef CONFIG_SMP
 	&reboot_cpu_attr.attr,
-	&reboot_force_attr.attr,
+#endif
 	NULL,
 };
 
-- 
2.28.0

