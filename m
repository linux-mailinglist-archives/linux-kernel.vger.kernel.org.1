Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D62B1412
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgKMB7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:59:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38442 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgKMB7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:59:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id p8so8047067wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k6ZSsQvTM4/Ww6PBO8EgvFtZ/3aeqLR6CWQVbp62AKw=;
        b=f6DnCPUeTHm63PruDgGEmpdWwVOeCiWMSsttx0ILu+jGCqSUlGegAmxVAV6H6rmo9Z
         aV+uLiUlgTHiCy8mFX7dU+W5WcTjStjdgCM9HGJz0P1XUQFtX6KqhQ9SGhIOr0rpFsvC
         jHANZ7LeZVJhBubXqF3BSYvYpy2ijWMRtb6P8PUB3H5byZV8DGRCglcXtsa+xU/UpThR
         uH4tVEUtXkRkD2t98uZNvQf94SaLuDGAbnw4rySEGeEZCfp5I/G4o/Lyw2DXyxH+lWoU
         xRLe2cPKc/BXAk9AuhXfVxFXqCl0RmB0NVI0Zt6GGOKMzzzgw1LDQNXvvUvd24m1mOnS
         tigA==
X-Gm-Message-State: AOAM5336o76ScFgUicx3JE6MSEa6cWs+kwfAqDbQ8lmLnorhxTq6eFdM
        iPRuUfXusdBC1+VAUcTNcHSD4iLc3iZpjvsT
X-Google-Smtp-Source: ABdhPJwfLfnSXJGoURKObCwArNGIjds1l4yiyAM3iAH/+nou7uZWsZwXpkqDR3iiaQmBSFFM7adKgw==
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr62179wrs.331.1605232743874;
        Thu, 12 Nov 2020 17:59:03 -0800 (PST)
Received: from turbo.corp.microsoft.com (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id a131sm8058613wmh.30.2020.11.12.17.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 17:59:03 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>, pmladek@suse.com,
        ndesaulniers@google.com
Subject: [PATCH] reboot: remove cf9_safe from allowed types and rename cf9_force
Date:   Fri, 13 Nov 2020 02:59:00 +0100
Message-Id: <20201113015900.543923-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

BOOT_CF9_SAFE_STR is an internal value used only by the x86 code and
it's not possible to set it from userspace.

Remove it, and rename 'cf9_force' to 'pci', so to make it coherent with
the kernel command line reboot= option.

Tested with this script:

	cd /sys/kernel/reboot/

	for i in cold warm hard soft gpio; do
		echo $i >mode
		read j <mode
		[ $i = $j ] || echo "mode $i != $j"
	done

	for i in bios acpi kbd triple efi pci; do
		echo $i >type
		read j <type
		[ $i = $j ] || echo "type $i != $j"
	done

	for i in $(seq 0 $(nproc --ignore=1)); do
		echo $i >cpu
		read j <cpu
		[ $i = $j ] || echo "cpu $i != $j"
	done

	for i in 0 1; do
		echo $i >force
		read j <force
		[ $i = $j ] || echo "force $i != $j"
	done

Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 kernel/reboot.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 7cab92624267..77c51edc3928 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -609,8 +609,7 @@ __setup("reboot=", reboot_setup);
 #define BOOT_BIOS_STR		"bios"
 #define BOOT_ACPI_STR		"acpi"
 #define BOOT_EFI_STR		"efi"
-#define BOOT_CF9_FORCE_STR	"cf9_force"
-#define BOOT_CF9_SAFE_STR	"cf9_safe"
+#define BOOT_PCI_STR		"pci"
 
 static ssize_t mode_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
@@ -682,10 +681,7 @@ static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char
 		val = BOOT_EFI_STR;
 		break;
 	case BOOT_CF9_FORCE:
-		val = BOOT_CF9_FORCE_STR;
-		break;
-	case BOOT_CF9_SAFE:
-		val = BOOT_CF9_SAFE_STR;
+		val = BOOT_PCI_STR;
 		break;
 	default:
 		val = REBOOT_UNDEFINED_STR;
@@ -709,10 +705,8 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
 		reboot_type = BOOT_ACPI;
 	else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
 		reboot_type = BOOT_EFI;
-	else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
+	else if (!strncmp(buf, BOOT_PCI_STR, strlen(BOOT_PCI_STR)))
 		reboot_type = BOOT_CF9_FORCE;
-	else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
-		reboot_type = BOOT_CF9_SAFE;
 	else
 		return -EINVAL;
 
-- 
2.28.0

