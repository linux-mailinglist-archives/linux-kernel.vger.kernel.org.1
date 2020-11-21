Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C652BC07B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 17:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgKUQRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 11:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgKUQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 11:17:39 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94506C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 08:17:37 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 81so10177714pgf.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTLpqp7Aal91RYPJOEsqEB7xHK/i1gxcmA4vDgFrBlM=;
        b=c9KqRypuwX8EZSFaXesWM6JD4yA0cJ8DtxKCw5viXMvf6Su/16pEhzJg09gDDKx+wl
         9AYvL163o59c3Om3hfdBTOxoCMbHipPxQfQ2ANUlN+Tfrtp0x+f2+OrpvSqC0jc0YVoF
         hgp3MS7X9xDesjF5Yg0860TdCgNrnN9CrvhrLK0jOg5z3mhpqcEjvVBHCaLFmO3B8Bm6
         cZQnWfFdNeUWtiS3nQflKrU+a28kPHKgAS75KwxgGOotnI7gh8HoHJSrc3rys4EIUeS3
         YUbsfUB9rXU9bpBjsZ9BpejPPkgRvo3QITi7/2dOyjTPLBZTp+debhzVXqhX6NOHQtfb
         +qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTLpqp7Aal91RYPJOEsqEB7xHK/i1gxcmA4vDgFrBlM=;
        b=t7IFfYe5t1jT6hS8yc5FsqwbIoqc6/GHJWMh6SVywTLjcnHWNh9E0103ezdXo06XKg
         S31KvpobSE4dqJz4EMgOmnHiNx41m+wJinNIyeaX5K99c4OEXrjSUl69b7zz+969P+nW
         ogrIHsuJBbgnR+ATqj4YT91MBsYZZ/wJnqtKmFKConkTAefftskwVyyE31xgUKHTst0N
         hOcxGE/a7oo5EXKImiBJSlk3Cob179GhWgUgQWqpo/7UXNH0uILEA3hm0Q9xZGym5I/Q
         bCpFj0fwBWW+M/WZdvh+ROAm9IrSWBOqDMEYPX/h4BvAcrqPxTQKFQ1pcjxPsYbVmtFb
         8TBQ==
X-Gm-Message-State: AOAM530m8tZgDAKASLY9RfI+ZDd4Cbh6F5UNdme/lNyLGghNEYc1DZI3
        JhfWI9i2C53/OBaBtABpVcg=
X-Google-Smtp-Source: ABdhPJxd2xklANTvIuKL/UQpwphHJomdXZxXUwfOl+1XJL8WICOjvn1z1rHNP9rjFc7KeUcRD1OIUQ==
X-Received: by 2002:aa7:9e90:0:b029:18b:a94:3498 with SMTP id p16-20020aa79e900000b029018b0a943498mr18983836pfq.54.1605975456964;
        Sat, 21 Nov 2020 08:17:36 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:6897:89ae:e2b0:e24b:73e9])
        by smtp.gmail.com with ESMTPSA id y201sm7011342pfb.2.2020.11.21.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 08:17:36 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: add --fix option for INCLUDE_LINUX
Date:   Sat, 21 Nov 2020 21:47:06 +0530
Message-Id: <20201121161706.104631-1-dwaipayanray1@gmail.com>
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
 scripts/checkpatch.pl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0da6422cd0fd..f852f130e065 100755
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
+							$fixed[$fixlinenr] =~ s/\<asm\/$file\>/\<linux\/$file\>/;
+						}
 					}
 				}
 			}
-- 
2.27.0

