Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0572745AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIVPqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:46:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB58FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:46:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b124so12797323pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9AQrDvOJ4B882Sq7uQ4Kp3Mhc6ZZV9HLHcMLFE6TOhI=;
        b=Jhw9NoPhISjFnb2iyTpxw6h+RYVNiIfyIRhkX8YbMIZ9JUlIwbdADjHuei8PTMc8/4
         o7qJ2esrUt0uK60odGA6j87/5evujlQU3jLhrLXuT3LMK8CV6VbFHzMYr3K3PEq5LNkU
         vQhDg4EXVsK9vbUG4dZfwGp/Yn3qZjjaENRAHyXuKY/cDDLfXbMoYLPpA0G8jXoUEF8N
         l3kuOQ/RmOAWo59vgRpHHhwDUWAWCeuxesm3e/f09wCj6rBfeG0MHJmLhwxdy+7AO48R
         e8PUWOJEmTjqHOFJGWB5+7qCKHJE77bDIhNPWKChZbspvdayn6C03yz07pA7CjoGqaHQ
         SOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9AQrDvOJ4B882Sq7uQ4Kp3Mhc6ZZV9HLHcMLFE6TOhI=;
        b=ctxz/42yD8QrbA++hDb6ENNHxb6Om44/P0KhdRaweJaqyw4xQ7qP/4ZZq1YvIQq7S5
         YdnhImq55R0c7i1b0Pc8pvFllrJbXIxqw0OaBWkdETFXi+chvZwCd8hIwx/x1t6WehTS
         FY66NNUJVvrCKXgITWpAy8l5PElxi6ujFDCEeLDvOmnUD+L4LvCqkk+0A/EV2Ozit9IC
         1lRI1PYJe0iJOwdjr3KltOfb5DHBjMxC3GEMFSp/7Q8sJOpo47U0BM5+ohTGB7F24qzq
         fkyb/3VOBAtYG5DUFHOohh9u1GdFQyACg/Ohd1AAJKhdtDGAfhb92jznmpMvqWFM3yfl
         dSAw==
X-Gm-Message-State: AOAM531xTKIphF1QPNFkXR7W/J8wiMjFkhnpHCsspK/sFLVVUg8vpJyK
        24qjtNFSBJGXUFcB6Lm4Cw==
X-Google-Smtp-Source: ABdhPJypkqDqkgeFFBXubtAf7952MvxcTfvzT0LhQl5JNUIgU2hJ7zgsdZIPQXmZ5GbuiVCSjyvMew==
X-Received: by 2002:a63:2ca:: with SMTP id 193mr3929260pgc.336.1600789567483;
        Tue, 22 Sep 2020 08:46:07 -0700 (PDT)
Received: from localhost.localdomain (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id f10sm15731901pfk.195.2020.09.22.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:46:06 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jan Kara <jack@suse.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] udf: Fix memory leak in udf_process_sequence()
Date:   Tue, 22 Sep 2020 11:45:31 -0400
Message-Id: <20200922154531.153922-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000004c1f4d05afcff2f4@google.com>
References: <0000000000004c1f4d05afcff2f4@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

udf_process_sequence() is leaking memory. Free `data.part_descs_loc`
before returning.

Cc: stable@vger.kernel.org
Fixes: 7b78fd02fb19 ("udf: Fix handling of Partition Descriptors")
Reported-and-tested-by: syzbot+128f4dd6e796c98b3760@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=c5ec4e6f5d818f3c4afd4d59342468eec08a38da
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 fs/udf/super.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c42f544096d..b0d862ab3024 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1698,7 +1698,8 @@ static noinline int udf_process_sequence(
 					"Pointers (max %u supported)\n",
 					UDF_MAX_TD_NESTING);
 				brelse(bh);
-				return -EIO;
+				ret = -EIO;
+				goto out;
 			}
 
 			vdp = (struct volDescPtr *)bh->b_data;
@@ -1718,7 +1719,8 @@ static noinline int udf_process_sequence(
 			curr = get_volume_descriptor_record(ident, bh, &data);
 			if (IS_ERR(curr)) {
 				brelse(bh);
-				return PTR_ERR(curr);
+				ret = PTR_ERR(curr);
+				goto out;
 			}
 			/* Descriptor we don't care about? */
 			if (!curr)
@@ -1740,28 +1742,32 @@ static noinline int udf_process_sequence(
 	 */
 	if (!data.vds[VDS_POS_PRIMARY_VOL_DESC].block) {
 		udf_err(sb, "Primary Volume Descriptor not found!\n");
-		return -EAGAIN;
+		ret = -EAGAIN;
+		goto out;
 	}
 	ret = udf_load_pvoldesc(sb, data.vds[VDS_POS_PRIMARY_VOL_DESC].block);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	if (data.vds[VDS_POS_LOGICAL_VOL_DESC].block) {
 		ret = udf_load_logicalvol(sb,
 				data.vds[VDS_POS_LOGICAL_VOL_DESC].block,
 				fileset);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
 	/* Now handle prevailing Partition Descriptors */
 	for (i = 0; i < data.num_part_descs; i++) {
 		ret = udf_load_partdesc(sb, data.part_descs_loc[i].rec.block);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree(data.part_descs_loc);
+	return ret;
 }
 
 /*
-- 
2.25.1

