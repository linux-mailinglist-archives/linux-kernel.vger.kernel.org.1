Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15D42A5742
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbgKCVkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:40:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43223 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbgKCVkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:40:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id g12so19959590wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrlBOqYl21Spg3fV6VYfetBuZ3g6VLuCK3+/RimKnUk=;
        b=oyyIsptt3K8ll9EO3Qm8Snmg+9LCv5wWmLcHU0kXQfnO+bNxIPQ4g+XzgzqYCbM8QH
         moCQcDiLTFuWUgt8vwVTOWFpuW8QrPl6RlSNkzJMx3W3VH3Qq1a/HBiLLGVlEI1PvKUr
         40eUBUlYfAlVDcZqjJmkbbC0H6uPRWfhB8vSy5u2lnkiucWLChUbQlshHMP3o+N77kKX
         1I2NrEtAl7rDm5YvZenHFGlRolIXQ6UgMN7ow2k/Zd9OQ2D/3y+4eU5W9KnLTAZ34Lat
         Cne/t2Q7DZ7SL0HwGWylqsID8cXbGC3Oqjjui09UGfXwGIhZlBgjP8SexucfgqwMqM2G
         qrYw==
X-Gm-Message-State: AOAM532T8K3Xg9Gn0/RY4UXotrt6VtAJToy/2YvKy1js3kj4t20Gn9Sp
        wGKgzyREkkabPPZ7blKzWeui0KiOYFaftd50
X-Google-Smtp-Source: ABdhPJyhEKcqxOIrWs89KMGm4Y0c2IYLtq+3NSC44v25rBOyu7YlkzG89HCBJhzpx5ZHSwK8xYffPg==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr29983453wrj.410.1604439641405;
        Tue, 03 Nov 2020 13:40:41 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-5-95-179-145.cust.vodafonedsl.it. [5.95.179.145])
        by smtp.gmail.com with ESMTPSA id o63sm84450wmo.2.2020.11.03.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:40:40 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/3] Revert "kernel/reboot.c: convert simple_strtoul to kstrtoint"
Date:   Tue,  3 Nov 2020 22:40:23 +0100
Message-Id: <20201103214025.116799-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103214025.116799-1-mcroce@linux.microsoft.com>
References: <20201103214025.116799-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

This reverts commit 616feab753972b9751308f3cd2a68fc57eae8edb.

kstrtoint() and simple_strtoul() have a subtle difference which makes
them non interchangeable: if a non digit character is found amid the
parsing, the former will return an error, while the latter will just
stop parsing, e.g. simple_strtoul("123xyx") = 123.

The kernel cmdline reboot= argument allows to specify the CPU used
for rebooting, with the syntax `s####` among the other flags,
e.g. "reboot=warm,s31,force", so if this flag is not the last given,
it's silently ignored as well as the subsequent ones.

Fixes: 616feab75397 ("kernel/reboot.c: convert simple_strtoul to kstrtoint")
Cc: stable@vger.kernel.org
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 kernel/reboot.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index e7b78d5ae1ab..8fbba433725e 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -551,22 +551,15 @@ static int __init reboot_setup(char *str)
 			break;
 
 		case 's':
-		{
-			int rc;
-
-			if (isdigit(*(str+1))) {
-				rc = kstrtoint(str+1, 0, &reboot_cpu);
-				if (rc)
-					return rc;
-			} else if (str[1] == 'm' && str[2] == 'p' &&
-				   isdigit(*(str+3))) {
-				rc = kstrtoint(str+3, 0, &reboot_cpu);
-				if (rc)
-					return rc;
-			} else
+			if (isdigit(*(str+1)))
+				reboot_cpu = simple_strtoul(str+1, NULL, 0);
+			else if (str[1] == 'm' && str[2] == 'p' &&
+							isdigit(*(str+3)))
+				reboot_cpu = simple_strtoul(str+3, NULL, 0);
+			else
 				*mode = REBOOT_SOFT;
 			break;
-		}
+
 		case 'g':
 			*mode = REBOOT_GPIO;
 			break;
-- 
2.28.0

