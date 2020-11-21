Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F492BC241
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgKUVYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 16:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgKUVYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 16:24:47 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB534C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 13:24:46 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so10493800pga.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 13:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BnOxX7b4mm9G8VJucOKIpWfXVT3cs4YugHsWF2jIPCc=;
        b=HWcI8iwbMHgmD1ojn/Y2aoCGdhDGGxzTID6QwMVCR5CdW8ePLBQISPOqAA0K2+bS+b
         u6dhxOpZmCCG//axZ73G223ihwtFoJt0iA5XzIwcoi9z13mp2V29T+q/bQzZEA+SdoaU
         xgjUMJiUiTAfUZAEjeeD+Dhzhzly9BjuLQyMMVqwTEtzrjzfEBPpL41V4TK8oLVh5KQq
         YhkzEdR42N4JXsxWOfh9IT2oljHFZGcNG7ZGWGvF6ci5JfPAj+XdYreoUJ5N9Tqg9teb
         oZYOgryGb7WlTZvyiHb3Mw2tW1mwkesn+O3n1zRQTicyWk0sgoedlZYaT3oW7pK7+Hfq
         d/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BnOxX7b4mm9G8VJucOKIpWfXVT3cs4YugHsWF2jIPCc=;
        b=NoknvM6Jpjhcb7LybUUMl6VMmjGljQkWLwyFXazi5YigXvXDFb5SXH20o2pXTQzZiz
         xSN+KOuERZQf/MRqX+Fr4/b9kxsGPu0XSx32TBqhwIMKb0qFn73Oik49fk8zkd9eU86e
         gqyv9mbMq319DSHGInVBPXSMexdtQNrJZRNs5zE5Hs/2hXvV8aGBlK6ZkNlSbovVXlZw
         /TiT6TM4GDuS2hHeZWszVjrI2nThIT9qLiLo/Se0mMusoxjIG39Pygq8IwkeegkrpTat
         wv9nRuOs+a1F8bKRxmEgzQ5psGehG4NkbMc1KCKlPGY0X9C4Wgml4gcuB8ttSBG4DvGQ
         UXsg==
X-Gm-Message-State: AOAM531noXn0DErWdJTwlkFciez10gwWbGiXAK1q1akhqNITC6PXyw8T
        8KrZSK+a8e2KquIjD1n3NLk=
X-Google-Smtp-Source: ABdhPJxgnlgJMm8+94QBVkRw+f835GSA1rrXa9iTK14keVvOKKig+B2+qra9RzXwbrBt1iZIpph71g==
X-Received: by 2002:a63:33c9:: with SMTP id z192mr2789015pgz.52.1605993886166;
        Sat, 21 Nov 2020 13:24:46 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6897:89ae:e2b0:e24b:73e9])
        by smtp.gmail.com with ESMTPSA id d68sm7190134pfd.32.2020.11.21.13.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 13:24:45 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v2] checkpatch: add --fix option for INCLUDE_LINUX
Date:   Sun, 22 Nov 2020 02:54:14 +0530
Message-Id: <20201121212414.170840-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide fix option to INCLUDE_LINUX check to replace asm
includes.

Macros of type:
 #include <asm/percpu.h>

are corrected to:
 #include <linux/percpu.h>

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---

Changes in v2:
- Use \Q..\E quoting
- Use @ as regex delimiter

 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0da6422cd0fd..e4feb91a0fe4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5468,8 +5468,11 @@ sub process {
 						CHK("ARCH_INCLUDE_LINUX",
 						    "Consider using #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
 					} else {
-						WARN("INCLUDE_LINUX",
-						     "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
+						if (WARN("INCLUDE_LINUX",
+							 "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr) &&
+						    $fix) {
+							$fixed[$fixlinenr] =~ s@\Q<asm/$file>\E@<linux/$file>@;
+						}
 					}
 				}
 			}
-- 
2.27.0

