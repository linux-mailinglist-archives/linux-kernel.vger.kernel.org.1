Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B712D05B0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 16:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgLFPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 10:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLFPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 10:24:57 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760CC0613D2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 07:24:17 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v3so5787133plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 07:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3Ae2sgvqkoZXp5i3Cerbk2Tw31uQ8GglIS/QTIatns=;
        b=WsUKtZW38rRtzfcZQo6FIRiF4JYnnKe9UHQZJ/U2iV5QvQ8vLTZ8cvqPCF+fg7Ek91
         YGpLRv/VKRw9dS7zq5spTNG2/mZkrbXSDnASwtZXyPQZ49Ts1HEDkP9aVbaFxbrlxVkq
         rCTLti1/r9sBwzPvqZY/3BWsCFpECMlX3/1R29XCQn4eAWJsc45Cf3EbBW22aBeEgGkk
         rJP41SHZNWlBOZm/IMcD0Hz+J8twEaviAEeCLJYCJ4ykiqFyjPRY27CcycIjv624FWQP
         8Ru3frKOIF6kO9Y+MixbkUaNbVSdeEU2MihJw1m+GhxJJs7du6zV50YERy0hfm92GBN4
         juIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3Ae2sgvqkoZXp5i3Cerbk2Tw31uQ8GglIS/QTIatns=;
        b=V60VI2mzstCNB9THao2QQqP+/Z6kXPlmbNezvm03x94neqchZeBBgNpShQIDHZx21b
         oL2PFEc5zZJIXfAfe/V3g+JbPlUt74aKZr2LIbagjEZJjH910hH6/r3mCOERR2+ScNTC
         MeOJbWZK6qgwuWPvYv59YfYrUYr7wa8MRhZq7/ipgvVFusjqL1fW1WUvHRkjL+Rgdchz
         SMrBle2K9oaHvz33NSL+h24qFJQ6ATpbZCJfnfxqBCqdHwhg1tmexLfPxg8W2lQ3CCmK
         E+tfjcoyRo2GjYfLll2/8UZ9AC+zMDqPihZShg14R8ZrqKNwnJB7CReWHp49hmDWbIk3
         3ksA==
X-Gm-Message-State: AOAM532NPwaErkgI55ixWW6RuZ6rq4NeWoKKJXrb6aPey23/kGdmtvMm
        7eXZZQGb96ZdtUhdPTiKorg=
X-Google-Smtp-Source: ABdhPJwlGa/1BAFkTLHvDDyth1ifQyMiDlweqBP35eHkvHonneWefUHcNZfrhLKbM2TMmFrgoHneUw==
X-Received: by 2002:a17:902:ba8b:b029:d7:e6da:cd21 with SMTP id k11-20020a170902ba8bb02900d7e6dacd21mr12231554pls.38.1607268256572;
        Sun, 06 Dec 2020 07:24:16 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:681b:efb7:be26:4d99:7d44])
        by smtp.gmail.com with ESMTPSA id m4sm12432863pfd.203.2020.12.06.07.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 07:24:15 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH v3] checkpatch: add --fix option to include linux checks
Date:   Sun,  6 Dec 2020 20:53:52 +0530
Message-Id: <20201206152352.35026-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fix option to INCLUDE_LINUX and ARCH_INCLUDE_LINUX
checks to replace asm includes.

Macros of type:
 #include <asm/percpu.h>
 #include <asm/processor.h>

are corrected to:
 #include <linux/percpu.h>
 #include <linux/processor.h>

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
Changes in v3:
- Add --fix option to ARCH_INCLUDE_LINUX check

Changes in v2:
- Use \Q..\E quoting
- Use @ as regex delimiter

 scripts/checkpatch.pl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b086d1cd6c2..4aecc237ed38 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5558,11 +5558,17 @@ sub process {
 				my $asminclude = `grep -Ec "#include\\s+<asm/$file>" $root/$checkfile`;
 				if ($asminclude > 0) {
 					if ($realfile =~ m{^arch/}) {
-						CHK("ARCH_INCLUDE_LINUX",
-						    "Consider using #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
+						if (CHK("ARCH_INCLUDE_LINUX",
+							"Consider using #include <linux/$file> instead of <asm/$file>\n" . $herecurr) &&
+						    $fix) {
+							$fixed[$fixlinenr] =~ s@\Q<asm/$file>\E@<linux/$file>@;
+						}
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

