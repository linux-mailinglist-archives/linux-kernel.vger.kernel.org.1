Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0E2C8B55
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgK3RiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:38:08 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:40717 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgK3RiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:38:07 -0500
Received: by mail-ej1-f67.google.com with SMTP id x16so16212445ejj.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 09:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zc7DV524QvmBD7bkWDO+IOfplbpwK2hZRFNo2cBf0+Q=;
        b=J88kDY/u80y8pAQ1rk0LvbyimxiJjOzzS4/2uM6KzXg5M7BNWfj1EphgL0m075P6V7
         VSOxx3W3HwuZchkWJN4HtqL86lBznsFi1InmHAoGoo9L+KggSPNan1IE98NZl9Gw69IL
         4QGu7q/HS83pSuku8iO0B8U4UQ2Znr3tw+JPi1VYDkF6kYufYMQaHLAWXcpY/UrX19ls
         8NDv12mgN2g1siaWuGy3rG8Wr0xO8fVa4jVM1v5yg8Nuvii6+OukF1vaLwkvV7bQHWBc
         6YAQkYIXowR9fAf0GSMOV+9VkM3NIT+FYG/EUbrJRHQOnW8cafR3Uyialc/FtVAsEEGn
         0lbg==
X-Gm-Message-State: AOAM532NnO+IB6Ooye1DErXlX3M1jDyyK9ziFnMpVoiT5CAzrTD9PwmE
        bY7pMdEpkvF4l5Vp0Rp5v7+vg8A9H/RRrqz9
X-Google-Smtp-Source: ABdhPJxAHrYZ2oEi3HLsOLfS0kIwVrPBjZVtzuN9U6J7hDx3Qc77Ult7/7ETAEL4lg7Z9RMvE5sR3w==
X-Received: by 2002:a17:906:8c7:: with SMTP id o7mr22965129eje.413.1606757845182;
        Mon, 30 Nov 2020 09:37:25 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id qu21sm4959856ejb.95.2020.11.30.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 09:37:24 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] reboot: allow to override reboot type if quirks are found
Date:   Mon, 30 Nov 2020 18:37:16 +0100
Message-Id: <20201130173717.198952-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130173717.198952-1-mcroce@linux.microsoft.com>
References: <20201130173717.198952-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

On some machines a quirk can force a specific reboot type.
Quirks are found during a DMI scan, the list of machines which need
special reboot handling is defined in reboot_dmi_table.

The kernel command line reboot= option overrides this via a global
variable `reboot_default`, so that the reboot type requested in
the command line is really performed.

This was not true when setting the reboot type via the new sysfs
interface. Fix this by setting reboot_default upon the first change,
like reboot_setup() does for the command line.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 kernel/reboot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ea6347b99b14..d80e3d64fe23 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -656,6 +656,8 @@ static ssize_t mode_store(struct kobject *kobj, struct kobj_attribute *attr,
 	else
 		return -EINVAL;
 
+	reboot_default = 0;
+
 	return count;
 }
 static struct kobj_attribute reboot_mode_attr = __ATTR_RW(mode);
@@ -710,6 +712,8 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
 	else
 		return -EINVAL;
 
+	reboot_default = 0;
+
 	return count;
 }
 static struct kobj_attribute reboot_type_attr = __ATTR_RW(type);
@@ -735,6 +739,7 @@ static ssize_t cpu_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (cpunum >= num_possible_cpus())
 		return -ERANGE;
 
+	reboot_default = 0;
 	reboot_cpu = cpunum;
 
 	return count;
@@ -756,6 +761,7 @@ static ssize_t force_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (kstrtobool(buf, &res))
 		return -EINVAL;
 
+	reboot_default = 0;
 	reboot_force = res;
 
 	return count;
-- 
2.28.0

