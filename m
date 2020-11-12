Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B822AFE51
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgKLFhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbgKLDus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 22:50:48 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A052C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 19:50:48 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d28so4114724qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 19:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6k/RG28tR3+DRUe4wGoTt/OmaAc1uq98xFm5rH3UNA8=;
        b=j9Udvc3XaNxf5p0gUZlbpCbiuJbBJXbceLYdVDUwEIGe3lFvA6dd0D7jKFSoRrXUPZ
         aWjBHS0YUPUG19XJbJnM6spwqvUKtaGxAPLWv2Lu4KoHMG9S4SI9z3GCQu0N2p7Eb/C2
         uIkF3u5ynLkGW4ACtgsuhL6AwRE8NKlOAvT4WGwBNuppiWa5LI9zQ5+H35OrIjTmrkxD
         EF7Li4Y2N0HaJNNH2ouNZC5lQECG5TTVqRqkt+KWMrRfZj1lbr3wGnYX/udiGs4jHS30
         k/otB2wFyrhUTAeIMifQkYuuX+nAX5DcWBtQQD6B1Y2vRgsxpxGothF/DaqaLMnO7zEg
         N7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6k/RG28tR3+DRUe4wGoTt/OmaAc1uq98xFm5rH3UNA8=;
        b=Q4n6ZQHvPo5Oe6DYONEvKcaoykz/ueQaYg1Z2SVKQl72rEcawtXOdg/pZ4PpoEc7NU
         7mPOCQmh5jAInw5XRj/ZFArL+RuFCCT4JFc90E1RYHg1a6jjRqQPzOrEA9Ri3lat34Tm
         24lne8gwqeS2CX1T5xu59YtGipdZnUcC1fo4FLO/b8WC27lF058crxfcRB76SVNcO6Ok
         KYN7sKpUG0S79V1FWtNWXPgMm77qXJkVPa8dNyu3LsPKj7HYyqkOjlGa5yMnN3ErESYu
         mmjO9HLk42hjhvMNTvY6oP1ji590iv/11J4k9cqasSIaIq3QFfvfaxuRPDbRcfUX9Q9p
         nwUw==
X-Gm-Message-State: AOAM531itCq2gZ/6IZtKM8Pfp3PqQQrHr4gh5i4E8e1TOQKNprs298Tx
        ZSOxi7R53mVK95IaPdj2oi8=
X-Google-Smtp-Source: ABdhPJz0qS1fBRGhk1WfZq3qQDhVa8ngpW430mNHS5rq79x3gZ2NP+5xy9I/JoUKmm9phkoyfEjmVw==
X-Received: by 2002:a37:6511:: with SMTP id z17mr29939485qkb.186.1605153047030;
        Wed, 11 Nov 2020 19:50:47 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id a1sm3972381qtw.11.2020.11.11.19.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 19:50:45 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     mcroce@linux.microsoft.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net,
        pasha.tatashin@soleen.com, pmladek@suse.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] reboot: Fix variable assignments in type_store
Date:   Wed, 11 Nov 2020 20:50:23 -0700
Message-Id: <20201112035023.974748-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110202746.9690-1-mcroce@linux.microsoft.com>
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

kernel/reboot.c:707:17: warning: implicit conversion from enumeration
type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
[-Wenum-conversion]
                reboot_mode = BOOT_TRIPLE;
                            ~ ^~~~~~~~~~~
kernel/reboot.c:709:17: warning: implicit conversion from enumeration
type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
[-Wenum-conversion]
                reboot_mode = BOOT_KBD;
                            ~ ^~~~~~~~
kernel/reboot.c:711:17: warning: implicit conversion from enumeration
type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
[-Wenum-conversion]
                reboot_mode = BOOT_BIOS;
                            ~ ^~~~~~~~~
kernel/reboot.c:713:17: warning: implicit conversion from enumeration
type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
[-Wenum-conversion]
                reboot_mode = BOOT_ACPI;
                            ~ ^~~~~~~~~
kernel/reboot.c:715:17: warning: implicit conversion from enumeration
type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
[-Wenum-conversion]
                reboot_mode = BOOT_EFI;
                            ~ ^~~~~~~~
kernel/reboot.c:717:17: warning: implicit conversion from enumeration
type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
[-Wenum-conversion]
                reboot_mode = BOOT_CF9_FORCE;
                            ~ ^~~~~~~~~~~~~~
kernel/reboot.c:719:17: warning: implicit conversion from enumeration
type 'enum reboot_type' to different enumeration type 'enum reboot_mode'
[-Wenum-conversion]
                reboot_mode = BOOT_CF9_SAFE;
                            ~ ^~~~~~~~~~~~~
7 warnings generated.

It seems that these assignment should be to reboot_type, not
reboot_mode. Fix it so there are no more warnings and the code works
properly.

Fixes: eab8da48579d ("reboot: allow to specify reboot mode via sysfs")
Link: https://github.com/ClangBuiltLinux/linux/issues/1197
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 kernel/reboot.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index deba133a071b..8599d0d44aec 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -704,19 +704,19 @@ static ssize_t type_store(struct kobject *kobj, struct kobj_attribute *attr,
 		return -EPERM;
 
 	if (!strncmp(buf, BOOT_TRIPLE_STR, strlen(BOOT_TRIPLE_STR)))
-		reboot_mode = BOOT_TRIPLE;
+		reboot_type = BOOT_TRIPLE;
 	else if (!strncmp(buf, BOOT_KBD_STR, strlen(BOOT_KBD_STR)))
-		reboot_mode = BOOT_KBD;
+		reboot_type = BOOT_KBD;
 	else if (!strncmp(buf, BOOT_BIOS_STR, strlen(BOOT_BIOS_STR)))
-		reboot_mode = BOOT_BIOS;
+		reboot_type = BOOT_BIOS;
 	else if (!strncmp(buf, BOOT_ACPI_STR, strlen(BOOT_ACPI_STR)))
-		reboot_mode = BOOT_ACPI;
+		reboot_type = BOOT_ACPI;
 	else if (!strncmp(buf, BOOT_EFI_STR, strlen(BOOT_EFI_STR)))
-		reboot_mode = BOOT_EFI;
+		reboot_type = BOOT_EFI;
 	else if (!strncmp(buf, BOOT_CF9_FORCE_STR, strlen(BOOT_CF9_FORCE_STR)))
-		reboot_mode = BOOT_CF9_FORCE;
+		reboot_type = BOOT_CF9_FORCE;
 	else if (!strncmp(buf, BOOT_CF9_SAFE_STR, strlen(BOOT_CF9_SAFE_STR)))
-		reboot_mode = BOOT_CF9_SAFE;
+		reboot_type = BOOT_CF9_SAFE;
 	else
 		return -EINVAL;
 

base-commit: 3e14f70c05cda4794901ed8f976de3a88deebcc0
-- 
2.29.2

