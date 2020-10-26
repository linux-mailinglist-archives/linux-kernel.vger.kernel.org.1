Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB0298989
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767683AbgJZJkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:40:16 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46278 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421738AbgJZJkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:40:15 -0400
Received: by mail-qk1-f202.google.com with SMTP id f9so1904634qkg.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=iuncRZU/n/qdgI7S//uwAQmqKe3LmFdZ5wVUdpPMh/w=;
        b=hmJWGdpqiRn4Qj3L1IygZpzGMSUe6R8DMaJrpkXSHQNw39KBa6RMIe5uzIiB6ALHx6
         7mf+S0RUDSiwwxcgUUs2g6tU+OdLYm1nKIqq5KDm6ufIwwB0GIU1jQKNY/1b7RjRCnxP
         5Y4ejCYnwj0alqRFXaHpjum/4p0iNzF2DB9ksst+SKHVKXZqfeJI5gWldJTvvAU/kl2X
         lkvCJ4do2DG/ivLaxOTCeXASrBgPukGqE1x6TWKC+Vm+f8ZGS54j9kCS/fF+YnD1VuPU
         yENvmvyMy1Tn74qP91YQFTRR4CPScRNkvVnq/ITJEE9/ncpgTc1eudPTKtluTEgNMexN
         LKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=iuncRZU/n/qdgI7S//uwAQmqKe3LmFdZ5wVUdpPMh/w=;
        b=GNFHe1EhQwknGY6D0F8HRKwk/Ul2tQGwzNMXGEwFfGpHQvmbcm6YMg/5JQArPqdhHg
         uUM97VX6gYGsm25GnIB/3hsgpDivg7vrJjBk8nRDG426Ok8gLLqoNfGCsXge93zLMhbf
         GPGCt/TTOTKkEcSUrD+holNwoAJdyKwFnIf0mtLZX3/AIAgBUQnXpORjhaFao6dWHYdc
         9JrP8Cdk3v8JW3NR9uCKTOwUlzbtfEpBua42tjUfwYSmfqspY/0dQgcywp1KATbeEBCv
         eujw8huCQiiBHEU9R8iru80vfO5g/h75Qe/K9zDy7tJYCtZjtXK22fgm2NZ7BtN1IyNH
         485A==
X-Gm-Message-State: AOAM533jKaXzUJ109XM0QrgtpaghAcvNTTHPcH2Wp3A5WUYjLMX+WHev
        W6MD4axFiVNDhCbPBx47G1+25gp7I7TX8Q==
X-Google-Smtp-Source: ABdhPJy+mI0vnmKylwtlFsmVxcnM1tY+7eaIo+ulq7WWs25n80yx/lSw9fa2rKak9PfsRXDP0qke3U9F+1cAUQ==
Sender: "robinhsu via sendgmr" <robinhsu@robinhsu-p520.ntc.corp.google.com>
X-Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 (user=robinhsu job=sendgmr) by 2002:a0c:e054:: with SMTP id
 y20mr16670180qvk.30.1603705214218; Mon, 26 Oct 2020 02:40:14 -0700 (PDT)
Date:   Mon, 26 Oct 2020 17:40:00 +0800
Message-Id: <20201026094000.1500425-1-robinhsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH 1/1] f2fs-toos:fsck.f2fs Fix bad return value
From:   Robin Hsu <robinhsu@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' should not have been used here: otherwise, it would be wrongly used
as the error code and then be returned from main().

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 fsck/fsck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index f97e9fb..66e4e3f 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3137,8 +3137,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		char ans[255] = {0};
 
 		printf("\nDo you want to restore lost files into ./lost_found/? [Y/N] ");
-		ret = scanf("%s", ans);
-		ASSERT(ret >= 0);
+		ASSERT(scanf("%s", ans) >= 0);
 		if (!strcasecmp(ans, "y")) {
 			for (i = 0; i < fsck->nr_nat_entries; i++) {
 				if (f2fs_test_bit(i, fsck->nat_area_bitmap))
-- 
2.29.0.rc2.309.g374f81d7ae-goog

