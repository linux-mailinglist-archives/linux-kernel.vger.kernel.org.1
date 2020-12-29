Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793162E6F32
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgL2I45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgL2I4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:56:51 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB1FC0617A5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:54 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id f33so7295450qtb.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3bO6YItz9vvTQJgokX465W6GGn8iDP/PMw/J2QDO/So=;
        b=qt4nW1TtN3vSNgIGdyu19lUtFHsVWuR3MeUBrUmhT19aLj3ZcPjez61n26uGT+H95h
         5tcLJ1375oK/zFIjSjeC3fAN/INVwBSIq9Nm5ScVlw7t84DRqEg8YYiRDYRDt4TPArRK
         oBB6wXkztBTuST2NYqsfxqsityuBpstl9esliPLnYtnFQjHHaYkYbfZb9WjANtuhJ07c
         FaUdCvUnjkxdCiYr2KHr1MNLyPFQ3P0Ngr+09MDIv4q770sHyuU5dNIPUIllfyrixLSG
         NPkAW501swO4Gq3RzVJodfbT+qPUZhDyNDZceY5LVNjRs5w06RHC5vV4mE+5YM5w59Jz
         Ue5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3bO6YItz9vvTQJgokX465W6GGn8iDP/PMw/J2QDO/So=;
        b=OOHzKYctOPC6GHYwGWm3d7TpH6fLFbenQBu5ISRvkplmUuRaNGAy4fRvyonzgEHvj/
         t/6mfBRW82rlanJovkboHCJJzd7x20EfTKYhZ37ABcxL+wIHTXr3T+l9Jbq5RbMPTVwM
         9jRtmEK+dlls8PE3OK7mhFwMjtPCfuipGusVNPJGSBbqWGu9tY9nR0v4dyZ9b4UWAosr
         7KhVHxl5j7HuV+qW7g9gVFndAgql+s5Xtgx7C7uDbzu6r4MwsMOD97+TqcFxOKYqxDqV
         Y4ejxT/S114i/JmOQibpA7s/5A2vTMnAO+KVnr83uf0iGOcFTeMNGyKWiwvNPECY7Tii
         5YVw==
X-Gm-Message-State: AOAM530jTG4cK9+ls0qlDWzgFg1qx5tdH//hf6NC7zEMispBSO685cGh
        jSXOYW+qrvBKyiLm7bcJL4WNaUk0pP4=
X-Google-Smtp-Source: ABdhPJxhU4q7GN5C1Z1AyzKVyRUGN5znZ+v3G/MJUPuiA4RVAhWGOcFupFszWQEI8exuXS9BJFU+l6WmdIw=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:99c8:: with SMTP id y8mr50020306qve.35.1609232154123;
 Tue, 29 Dec 2020 00:55:54 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:55:24 +0000
In-Reply-To: <20201229085524.2795331-1-satyat@google.com>
Message-Id: <20201229085524.2795331-7-satyat@google.com>
Mime-Version: 1.0
References: <20201229085524.2795331-1-satyat@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v3 6/6] dm: set DM_TARGET_PASSES_CRYPTO feature for some targets
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm-linear and dm-flakey obviously can pass through inline crypto support.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 drivers/md/dm-flakey.c | 4 +++-
 drivers/md/dm-linear.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index a2cc9e45cbba..30c6bc151213 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -482,8 +482,10 @@ static struct target_type flakey_target = {
 	.name   = "flakey",
 	.version = {1, 5, 0},
 #ifdef CONFIG_BLK_DEV_ZONED
-	.features = DM_TARGET_ZONED_HM,
+	.features = DM_TARGET_ZONED_HM | DM_TARGET_PASSES_CRYPTO,
 	.report_zones = flakey_report_zones,
+#else
+	.features = DM_TARGET_PASSES_CRYPTO,
 #endif
 	.module = THIS_MODULE,
 	.ctr    = flakey_ctr,
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 00774b5d7668..fc9c4272c10d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -229,10 +229,11 @@ static struct target_type linear_target = {
 	.version = {1, 4, 0},
 #ifdef CONFIG_BLK_DEV_ZONED
 	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
-		    DM_TARGET_ZONED_HM,
+		    DM_TARGET_ZONED_HM | DM_TARGET_PASSES_CRYPTO,
 	.report_zones = linear_report_zones,
 #else
-	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT,
+	.features = DM_TARGET_PASSES_INTEGRITY | DM_TARGET_NOWAIT |
+		    DM_TARGET_PASSES_CRYPTO,
 #endif
 	.module = THIS_MODULE,
 	.ctr    = linear_ctr,
-- 
2.29.2.729.g45daf8777d-goog

