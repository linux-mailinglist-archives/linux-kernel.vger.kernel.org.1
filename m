Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533E297CB4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761840AbgJXOBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 10:01:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34385 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761831AbgJXOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 10:01:21 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kWK6g-0002N1-GE
        for linux-kernel@vger.kernel.org; Sat, 24 Oct 2020 14:01:18 +0000
Received: by mail-wr1-f71.google.com with SMTP id 31so2368612wrg.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 07:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/4dnRbgtO5meSxIccl+sy9toA1tYJ9rK+hI6ilGPRo4=;
        b=XubVY0CpFm/YcSTbMs1kbYX54z4rt55K8uY8SJ9agkpWvH5mCqbaFiEhJ9CDHvTOqC
         N6cWAqwclEI4nxTa5T+SGY22ToSu1xAZz9QNAnff/pzKhin4tygLHZEoYmMc+Slfepkn
         s51sPODz2x/aS9bGlQOxV6DfgUDyzFdN+yUJRkS+oj5lObEaMu3BDQPmhnn8qD4iU7nX
         JCHAu3Z7K5yZGF2FTjPcLGMdDpFnRvfNdWZfj0ul+fj6TTO50xCF5YaUQBOKsY3iSLqP
         L8EM9fdbhhNmSIJ1WLbtv096cNuwRNOYsf/m6kK8Xuc/UrcVaTenKYro3EO6KCrWgpMH
         LPgQ==
X-Gm-Message-State: AOAM530XYneumeLI81yrQHzsEKlp0+iXCcXi6yrQmu/bcH9bmPsyK417
        N6L8kRC7RtlPV9Wmfy7zfSt5W+05e0oi8vXgKsR7whg5BatSXwC5EDg0cHP0inSQRu0TfJe7N+I
        rfxN3q8Q4p8yUQAYpcxASxJlvWLp1unTRdzU9MyfwJg==
X-Received: by 2002:adf:8bd4:: with SMTP id w20mr7778116wra.391.1603548078085;
        Sat, 24 Oct 2020 07:01:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl5aHCrBCmQWQvMRVyFFJyBfnEfh6V+Dl+qBJLj2fgLt4sE+1k4yNyDkYldshGsfPL7KrF5g==
X-Received: by 2002:adf:8bd4:: with SMTP id w20mr7778085wra.391.1603548077822;
        Sat, 24 Oct 2020 07:01:17 -0700 (PDT)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id o4sm10476690wrv.8.2020.10.24.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 07:01:17 -0700 (PDT)
Date:   Sat, 24 Oct 2020 16:01:15 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: properly check for dirty state in
 ext4_inode_datasync_dirty()
Message-ID: <20201024140115.GA35973@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ext4_inode_datasync_dirty() needs to return 'true' if the inode is
dirty, 'false' otherwise, but the logic seems to be incorrectly changed
by commit aa75f4d3daae ("ext4: main fast-commit commit path").

This introduces a problem with swap files that are always failing to be
activated, showing this error in dmesg:

 [   34.406479] swapon: file is not committed

Simple test case to reproduce the problem:

  # fallocate -l 8G swapfile
  # chmod 0600 swapfile
  # mkswap swapfile
  # swapon swapfile

Fix the logic to return the proper state of the inode.

Link: https://lore.kernel.org/lkml/20201024131333.GA32124@xps-13-7390
Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 fs/ext4/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 03c2253005f0..a890a17ab7e1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3308,8 +3308,8 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 	if (journal) {
 		if (jbd2_transaction_committed(journal,
 					EXT4_I(inode)->i_datasync_tid))
-			return true;
-		return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) >=
+			return false;
+		return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
 			EXT4_I(inode)->i_fc_committed_subtid;
 	}
 
-- 
2.27.0

