Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E7D280A62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbgJAWo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:44:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60877 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgJAWo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:44:26 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1kO7JJ-0000ba-Ab
        for linux-kernel@vger.kernel.org; Thu, 01 Oct 2020 22:44:25 +0000
Received: by mail-qv1-f70.google.com with SMTP id t7so213180qvz.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 15:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4UmiMa5+65rn92Pb5tiRXFetQx5vUZvC8lpatLKDrIg=;
        b=VFdTnBjXpKp315trczN9FP+RIGFZno5mzzhAeWSnUFEf78sfrfAynvv3JhzTh8eAqz
         AAonLTBxA+3T1P5HjkUj3U4y+r7p6VI8ZZFH6g2kgdVkC+EJLYcvxbePcmT8uXypMRbg
         5APgxLGAfbKSQbmEeoshtBAGZM1JD1R96hHxkgWZITcJqUlvButC+6SAHnZlJaL7CVzV
         cbc88msWPq/Q6dyrlpu8UTG/CGYGx94Bd+0WKUmqOwBqPlIMKtl3j6uZezkMT1B52phW
         5kWr6ONK/oOA1gKXXLSSlpJzqwjF6QJS9aIKAVolf+C3dvK5B8Vue4Qh28PI+Ca43Az4
         ypbg==
X-Gm-Message-State: AOAM530P4ozNrL4FFsiEbJFca5AMDy4IMCg1yybh83WTRdhuplQHs2lM
        9k1Sx0A/0FtApwBz402sbkcDQj6UpRadFLcbI26cTOSS6PkqloenAD93LMfwQWvksZ4C2p6xtA7
        9C8SR8COzciDhnWE6YYTLv1UNxihe2tI4jyzWpbyYOw==
X-Received: by 2002:ac8:44a7:: with SMTP id a7mr10192755qto.173.1601592263821;
        Thu, 01 Oct 2020 15:44:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC5f+HxiHqOCRtJqISp6pgF6pi/0P+v1X8FavaTUYtsSJjyki1dqe8i/Jy0juhDtLqtvyfOQ==
X-Received: by 2002:ac8:44a7:: with SMTP id a7mr10192737qto.173.1601592263554;
        Thu, 01 Oct 2020 15:44:23 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id f24sm7321148qkk.136.2020.10.01.15.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 15:44:22 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH] ocfs2: ratelimit the 'max lookup times reached' notice
Date:   Thu,  1 Oct 2020 19:44:17 -0300
Message-Id: <20201001224417.478263-1-mfo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running stress-ng on ocfs2 completely fills the kernel log with
'max lookup times reached, filesystem may have nested directories.'

Let's ratelimit this message as done with others in the code.

Test-case:

  # mkfs.ocfs2 --mount local $DEV
  # mount $DEV $MNT
  # cd $MNT

  # dmesg -C
  # stress-ng --dirdeep 1 --dirdeep-ops 1000
  # dmesg | grep -c 'max lookup times reached'

Before:

  # dmesg -C
  # stress-ng --dirdeep 1 --dirdeep-ops 1000
  ...
  stress-ng: info:  [11116] successful run completed in 3.03s

  # dmesg | grep -c 'max lookup times reached'
  967

After:

  # dmesg -C
  # stress-ng --dirdeep 1 --dirdeep-ops 1000
  ...
  stress-ng: info:  [739] successful run completed in 0.96s

  # dmesg | grep -c 'max lookup times reached'
  10

  # dmesg
  [  259.086086] ocfs2_check_if_ancestor: 1990 callbacks suppressed
  [  259.086092] (stress-ng-dirde,740,1):ocfs2_check_if_ancestor:1091 max lookup times reached, filesystem may have nested directories, src inode: 18007, dest inode: 17940.
  ...

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ocfs2/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 3c908e9416af..0043eddabdb8 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1095,8 +1095,8 @@ static int ocfs2_check_if_ancestor(struct ocfs2_super *osb,
 		child_inode_no = parent_inode_no;
 
 		if (++i >= MAX_LOOKUP_TIMES) {
-			mlog(ML_NOTICE, "max lookup times reached, filesystem "
-					"may have nested directories, "
+			mlog_ratelimited(ML_NOTICE, "max lookup times reached, "
+					"filesystem may have nested directories, "
 					"src inode: %llu, dest inode: %llu.\n",
 					(unsigned long long)src_inode_no,
 					(unsigned long long)dest_inode_no);
-- 
2.17.1

