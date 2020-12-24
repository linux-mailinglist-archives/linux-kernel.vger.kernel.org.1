Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0542E2436
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 05:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgLXEun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 23:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLXEun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 23:50:43 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A71C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 20:50:02 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id n16so812148pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 20:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ntto0REEo/mIE2Mt+Mq78tbyDspwuPQ1ayD5dtmBR7g=;
        b=NJGvN7ALxQMN2zM8MqG58sWguw2zAaFtG8HsCOWqUYLHNtLwLj5Q4hIydcVeMKrHVz
         0nOy8pQtErV3Ue5K0G04Me7qAyuwAWjbJsafmOYBjLU7bNzCM6gK0yvBzN+gZ5ilh4AP
         EO0u5j1JWp/q7/tVwR/O6c+rz46houel/LQp+X714H7LYtW487EUKis1rQ0tBYKjoLX+
         9DmQJX9uPCYbcd7aJPu+yzn/AjWHiUB5G0HDQBs8AbY7lyUvpuFUutDCy+QKC03HPefG
         7dPV5cmdTunmeauKO82xSPH+qMBDTfOOGNWsuGH+eL/4gWi1vT15/7+mY7vpwbfPgk7+
         mZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ntto0REEo/mIE2Mt+Mq78tbyDspwuPQ1ayD5dtmBR7g=;
        b=n3N4PnaMmSN5qdUKM9iJNCIoW+3kWZ5JXrM0HuB/WfrZiadVFldToH3B2bkMo1QQCz
         NEbjpXr5ceHdfCKS404SnAP9wCx5l7islHHuiA+GuLA0zP3VJJRlB8eTF9zGKa9kESg8
         0TH5HFsu4fO5BSflHg/ZpBjmnk6TXMmuI5TydYAoeBIJN4wLsZLGX8Z0nh++M/WV5hbP
         xY3FHaR+MCCVmma3zYYtLaij/Gz2S1T0MyJHnWTBVY5NY+aDu3gZjs3F1Ewo/LcQnjd2
         xl7abji8sPiskawD2obbRdjcZWHWeDIiiBEbT6tUCYMPrE3WSLuQjv0LMT9IkrsEtvpo
         frPA==
X-Gm-Message-State: AOAM532abGAx8MeFqvz192C7wKRuHmMZX0tG4Brks1XHjjAzCrnBj876
        YXqPUrwt8R2GPKuRccXiv4UUT5AwAKs=
X-Google-Smtp-Source: ABdhPJw/t/hmdzMjOOcuRIc99sMUz7ICBakutS45TUV+RJgvRnbrXaCpowX2o/ccjMy+RdCs6/hDp3471PY=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:90a:1706:: with SMTP id
 z6mr648286pjd.0.1608785401864; Wed, 23 Dec 2020 20:50:01 -0800 (PST)
Date:   Thu, 24 Dec 2020 04:49:54 +0000
Message-Id: <20201224044954.1349459-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb
From:   Satya Tangirala <satyat@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

freeze/thaw_bdev() currently use bdev->bd_fsfreeze_count to infer
whether or not bdev->bd_fsfreeze_sb is valid (it's valid iff
bd_fsfreeze_count is non-zero). thaw_bdev() doesn't nullify
bd_fsfreeze_sb.

But this means a freeze_bdev() call followed by a thaw_bdev() call can
leave bd_fsfreeze_sb with a non-null value, while bd_fsfreeze_count is
zero. If freeze_bdev() is called again, and this time
get_active_super() returns NULL (e.g. because the FS is unmounted),
we'll end up with bd_fsfreeze_count > 0, but bd_fsfreeze_sb is
*untouched* - it stays the same (now garbage) value. A subsequent
thaw_bdev() will decide that the bd_fsfreeze_sb value is legitimate
(since bd_fsfreeze_count > 0), and attempt to use it.

Fix this by always setting bd_fsfreeze_sb to NULL when
bd_fsfreeze_count is successfully decremented to 0 in thaw_sb().
Alternatively, we could set bd_fsfreeze_sb to whatever
get_active_super() returns in freeze_bdev() whenever bd_fsfreeze_count
is successfully incremented to 1 from 0 (which can be achieved cleanly
by moving the line currently setting bd_fsfreeze_sb to immediately
after the "sync:" label, but it might be a little too subtle/easily
overlooked in future).

This fixes the currently panicking xfstests generic/085.

Fixes: 040f04bd2e82 ("fs: simplify freeze_bdev/thaw_bdev")
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/block_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e56ee1f2652..12a811a9ae4b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -606,6 +606,8 @@ int thaw_bdev(struct block_device *bdev)
 		error = thaw_super(sb);
 	if (error)
 		bdev->bd_fsfreeze_count++;
+	else
+		bdev->bd_fsfreeze_sb = NULL;
 out:
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 	return error;
-- 
2.29.2.729.g45daf8777d-goog

