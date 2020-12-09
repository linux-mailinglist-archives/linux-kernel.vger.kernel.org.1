Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC02D4DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbgLIW1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388803AbgLIW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:26:18 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3122C0613D6;
        Wed,  9 Dec 2020 14:25:37 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id v29so2239068pgk.12;
        Wed, 09 Dec 2020 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8wQM6SGZhatAmTI9tOUrGWUVSmmno5n0WNRbEje9OEI=;
        b=mknZQBlUBpIaNmmNfvrzMywLKXW4Mw/vpLFSF0lCvqdUXWAbNTm6tJpl1wSsvVVn1p
         rfOHDGKYlBc3jpgydISN+WfsMekyHOepRVQuW4ZF2LqzlHoBZ3ypp52MJdrXtUa2gn+H
         pGfyNBh2DI537zi05lWJXgZR4Ed6EGm29VuhvKL61xa3nkhPnIbG+BlqybWBiIPkHZsx
         A39rfywAUbdFqRGkZ1S/nDWr0bpmBrC0PhPPoojGO8lTmq8BnFMICRei04QLHP5J3wgb
         w+JK2dj44tukjDJs9x6PUsqZ+JvSs+XIVgif168fbGvwLUKzXoYXuMUDLt/qxs/dR5mG
         tuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8wQM6SGZhatAmTI9tOUrGWUVSmmno5n0WNRbEje9OEI=;
        b=qXPLPF3PtrOK3VWt7E8l7aHotNgg1Gbw52YJ5KAK4F/5M6DP7713P+r8y/q54hQcM7
         pS0+OGTyxyqVXdJVIoWVwPIYJ9qdSqNtdbghMk2lVRqxmyGUAD9DVzojGC75QHOPbGry
         lqxuBn3sLfd31zI/wbwvXdgg4KQ3bvLADKcfjp54iUuiWRNYqNAusoUPDZGhdLNwxBIN
         X5exRxcvVsRM/4fAiaqtm200yp9wXJdO6OutDX9ZOlQ6BsPVLrbiND/Q7K7g7GS28BWW
         pIiBMh9VvAiYfV9klmBkDjGIxU+i3EkmZWlVaicOxEzLr1zdkiRuycGOUnEyN7ncEE/I
         h2JQ==
X-Gm-Message-State: AOAM530acbeWAyWUfh++lIvajnqPCQFSFpaWY1b0+otq9/PlIpiYIic2
        /cML1Ns8Q+vdSQ5tY0ejieOkXI2j0d8=
X-Google-Smtp-Source: ABdhPJznvhhpyWlDx7682efPuFdhMhmC1lWUmG5RBtjvgiP+xc32sqH+zpu3kYPVZPFGsaj+IL4HQQ==
X-Received: by 2002:a63:1c21:: with SMTP id c33mr3854626pgc.161.1607552737093;
        Wed, 09 Dec 2020 14:25:37 -0800 (PST)
Received: from carrot.localdomain (i118-19-12-158.s42.a014.ap.plala.or.jp. [118.19.12.158])
        by smtp.gmail.com with ESMTPSA id c66sm3902852pfa.0.2020.12.09.14.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 14:25:36 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/nilfs2: remove some unused macros to tame gcc
Date:   Thu, 10 Dec 2020 07:25:33 +0900
Message-Id: <1607552733-24292-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alex.shi@linux.alibaba.com>

There some macros are unused and cause gcc warning. Remove them.

fs/nilfs2/segment.c:137:0: warning: macro "nilfs_cnt32_gt" is not used
[-Wunused-macros]
fs/nilfs2/segment.c:144:0: warning: macro "nilfs_cnt32_le" is not used
[-Wunused-macros]
fs/nilfs2/segment.c:143:0: warning: macro "nilfs_cnt32_lt" is not used
[-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index e3726aca28ed..cd4da9535aed 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -134,14 +134,9 @@ struct nilfs_sc_operations {
 static void nilfs_segctor_do_immediate_flush(struct nilfs_sc_info *);
 static void nilfs_dispose_list(struct the_nilfs *, struct list_head *, int);
 
-#define nilfs_cnt32_gt(a, b)   \
-	(typecheck(__u32, a) && typecheck(__u32, b) && \
-	 ((__s32)(b) - (__s32)(a) < 0))
 #define nilfs_cnt32_ge(a, b)   \
 	(typecheck(__u32, a) && typecheck(__u32, b) && \
 	 ((__s32)(a) - (__s32)(b) >= 0))
-#define nilfs_cnt32_lt(a, b)  nilfs_cnt32_gt(b, a)
-#define nilfs_cnt32_le(a, b)  nilfs_cnt32_ge(b, a)
 
 static int nilfs_prepare_segment_lock(struct super_block *sb,
 				      struct nilfs_transaction_info *ti)
-- 
1.8.3.1

