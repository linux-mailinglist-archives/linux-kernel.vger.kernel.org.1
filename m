Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB0279C00
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 21:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgIZTEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 15:04:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B0C0613CE;
        Sat, 26 Sep 2020 12:04:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so3017444ejf.6;
        Sat, 26 Sep 2020 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=el9DZyLyFdP/+cP0w9X7FpHYnAdbkFSV+0r7utpIGhE=;
        b=ApMqTlo7oj7ATCcxJY1+KT3ll5lzWpGPHTGizNww9rzX/Jgx9nZZ6C/xRB2ED86+Bq
         0yyAmAxSjtSw9pfFHLvuls0u0OWOpazPwditpdS+xo6pGiyUCJxuqX7SBhNxiPRKGFu6
         FwH7L2rhVeHl8qH5Rw6/VSDjx74nHWnyjEEZ8qasdyJLRDnsWd1uR8b3kE5vzY1ZyZZg
         FMX7HGRyQQCBMcrqZT/D7Tbiv0yEuN+OqNZLW3iJchPhcuAufc5J6XwOojqJzSrquQC5
         M0nHXA8RFALPRxHtBUZfXbx3yMoM34lrTMmEM/GDlnWJ0ZQ/THg2myEJRU4E6uYKNWdT
         3KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=el9DZyLyFdP/+cP0w9X7FpHYnAdbkFSV+0r7utpIGhE=;
        b=Pe0kJ8DAP/vkcW+NYHpzJ76pqR7HjJZv75USvjD+i2UNHP/WZ1UrZlyFxylOdJR2Q9
         q6SJFZfFkM9FeluOcCJHAJ9qPIB1k2GVo3DaOzfla7hZosOU4dZOSEQeGcs0TiBTpQOP
         Attde5RZZMR+KA1Xdtbw0/aFSLMSgyhhv8ieM4vEHjYRyADkycWWLHCIMgbzZJ9dD6+0
         apMnzgpyP0woXzpOu6lsTEh//EpvfKePNJ0TxQG/3WBo7/DZMPeDCAbofxKW8aoQgd26
         732BRFZ2gZ2tRk4xchjxDlvBV9eVGmQezrW0Qft5BY+LdQzGjMDe/xeNbrOZOpudJdkA
         kVuw==
X-Gm-Message-State: AOAM532CI6TRGwHfXV+XbCXcfrJhpNC3aT6QH3YZsRwu4FtHnn8LHIsH
        83XL+RpFd1KPD7K0Iqc6r5k=
X-Google-Smtp-Source: ABdhPJwi+J6K7E2UiXyKZLRsNtL2mkCX87NkmDhC2O7Hf1rAkDD7DifU6M6L/32UPJbIUV/seDOK+w==
X-Received: by 2002:a17:906:3e08:: with SMTP id k8mr8321644eji.480.1601147043197;
        Sat, 26 Sep 2020 12:04:03 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2daa:2000:30ed:2765:20d9:efd3])
        by smtp.gmail.com with ESMTPSA id o23sm4592634eju.17.2020.09.26.12.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 12:04:02 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scripts/spdxcheck.py: handle license identifiers in XML comments
Date:   Sat, 26 Sep 2020 21:03:54 +0200
Message-Id: <20200926190354.13194-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cc9539e7884c ("media: docs: use the new SPDX header for GFDL-1.1 on
*.svg files") adds SPDX-License-Identifiers enclosed in XML comments,
i.e., <!-- ... -->, for svg files.

Unfortunately, ./scripts/spdxcheck.py does not handle
SPDX-License-Identifiers in XML comments, so it simply fails on checking
these files with 'Invalid License ID: --'.

Strip the XML comment ending simply by copying how it was done for comments
in C. With that, ./scripts/spdxcheck.py handles the svg files properly.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20200925

Greg, please pick this quick minor patch for your spdx tree. thanks.

 scripts/spdxcheck.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 6374e078a5f2..bc87200f9c7c 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -180,6 +180,9 @@ class id_parser(object):
                 # Remove trailing comment closure
                 if line.strip().endswith('*/'):
                     expr = expr.rstrip('*/').strip()
+                # Remove trailing xml comment closure
+                if line.strip().endswith('-->'):
+                    expr = expr.rstrip('-->').strip()
                 # Special case for SH magic boot code files
                 if line.startswith('LIST \"'):
                     expr = expr.rstrip('\"').strip()
-- 
2.17.1

