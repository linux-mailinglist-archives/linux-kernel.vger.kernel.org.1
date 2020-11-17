Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E942B58B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 05:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKQEFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 23:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgKQEFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:05:16 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4354C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 20:05:16 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so16268564pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 20:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I688tyMrUECz3Frpf8w9gFQ0EdIWy0ytmS8RkPZw0Mg=;
        b=NbmxhkUKRzMT8hScAfRQUTJW9Sn8/avBZ7d8k1Gw+54QqE/5NnjsWTdDllCt0v1jCv
         7JTbf8CzTp3HnOmW6nOgcUWfuek+utuanzoBIegeolaGzlh+eAGk3qD3TeNdPMjHyOnh
         5D3DA/0qjVaJRjYSTMAR9zkZOHl6xLoB/VgViy8xSr4MlQgaL/QZApGgMEO4NEheEwOR
         CoI9h7ZBDiIy+5GXHzEGqq3siG1kVr/uqLU4Tw/DLmR3YSK2WI/mFGYXT5RZyZpolLrG
         0ontYtf0Cb7SdjwRZYn/TyJMnqkom4TeEx2aYIm0mU3h1bopwXgkaIZ7hyPJ4UrUSMET
         la9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I688tyMrUECz3Frpf8w9gFQ0EdIWy0ytmS8RkPZw0Mg=;
        b=AE6KUHg51Qx0JYZJNF6Mt0SxVrs6fR1vpVFElLTDYEBCgAQhzLFrrj55b4H+o8w9Vj
         g4UORC7X7At/JEqqQ5aEL+g324EU840i/Bjx4YzUK13BmqVrymNKToBBiF8L9FvBcGnG
         SVVAsW9P/I+rVZ66t1gYIwOJBNQN0MNd+zg66+LtUCIGqeZrrTtjg1WkQfRSmUN1kqqm
         xnbBHyVZONVBXu7XxcViW9osntBYKpx9PL7QH+3F/enYG4u8x+bYVRwUVoktE4m8axGl
         DW8Us6mmKLyMT6VlM7zN4kOp3M06TDD/bkrybeUyjujrsCKS5dwYY9HQXsmEigChogur
         WR3Q==
X-Gm-Message-State: AOAM530sdmLAA5pNw6DiPq+P5s9FNra6esPTuE7I4DQJEXJoy+j2DHO/
        /ocquMc7xlQPydaC7MoFIXc=
X-Google-Smtp-Source: ABdhPJyrScfLB+qADQXCSJhpKsCuHaCyfLTn1C/KAfW7yV4X7H0X8yzrY+O8+w7TZ2rFl+0F8RazDg==
X-Received: by 2002:a17:90a:f00a:: with SMTP id bt10mr2364426pjb.91.1605585916285;
        Mon, 16 Nov 2020 20:05:16 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:43e:59af:bc1b:1de0:7718:e8a1])
        by smtp.googlemail.com with ESMTPSA id b7sm1068019pjp.13.2020.11.16.20.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 20:05:15 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: [PATCH v3] checkpatch: add fix option for MAINTAINERS_STYLE
Date:   Tue, 17 Nov 2020 09:35:01 +0530
Message-Id: <20201117040501.21914-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch expects entries in MAINTAINERS file in a specific order and
warns if the changes made do not follow the specified order.

E.g., running checkpatch on commit b33bc2b878e0 ("nexthop: Add entry to
MAINTAINERS") reports this warning:

WARNING: Misordered MAINTAINERS entry - list file patterns in
alphabetic order
+F:	include/uapi/linux/nexthop.h
+F:	include/net/netns/nexthop.h

Provide a simple fix by swapping the unordered lines, if both the lines
are additions (start with '+')

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
modified commit message

Changes in v3:
add check if both the lines are additions(ie start with '+')

 scripts/checkpatch.pl | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2749f32dffe9..7ee3f05c354d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3299,13 +3299,22 @@ sub process {
 					     "Unknown MAINTAINERS entry type: '$cur'\n" . $herecurr);
 				} else {
 					if ($previndex >= 0 && $curindex < $previndex) {
-						WARN("MAINTAINERS_STYLE",
-						     "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev);
+						if (WARN("MAINTAINERS_STYLE",
+							 "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev) &&
+						    $fix && $prevrawline =~ /^\+[A-Z]:/) {
+							# swap these lines
+							$fixed[$fixlinenr - 1] = $rawline;
+							$fixed[$fixlinenr] = $prevrawline;
+						}
 					} elsif ((($prev eq 'F' && $cur eq 'F') ||
 						  ($prev eq 'X' && $cur eq 'X')) &&
 						 ($prevval cmp $curval) > 0) {
-						WARN("MAINTAINERS_STYLE",
-						     "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev);
+						if (WARN("MAINTAINERS_STYLE",
+							 "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev) &&
+						    $fix && $prevrawline =~ /^\+[A-Z]:/) {
+							$fixed[$fixlinenr - 1] = $rawline;
+							$fixed[$fixlinenr] = $prevrawline;
+						}
 					}
 				}
 			}
-- 
2.17.1

