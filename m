Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB428E47C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbgJNQbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgJNQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:31:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838AFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:31:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n9so2322116pgt.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yEsILmCKm0hRP0CDuXEGc8J5t+QTwZ1G0jbK/IVGEU=;
        b=u+lHNhA0jCyKVpHsRJQylUByW/6d565Up3FzoLS2DeENWbTwd6NINIGV5+Xo802SGR
         3SI4cVLxQchfO1lAfgu7+m7Q/CJPgEXKarVxmxDZlzpCINW/GVsuh4sB1ymgLTRS1WoX
         8WMUcMNkoMVjTo2oQn8RfwMthBAouoiKsz75r0ybPqEaoeGNtjZl0EaNRvdsStBAo3bG
         diCANTLBvEhDYIWMiqhjN3iFLugrMRSlfZxVNXutkqp95IjgInL5A39QU3qyvQThDu/y
         PUd/HlAiDnnqDXH4mj4o8Bxn+zkyNSwVCsSVS9RnkfPhRBXi9LxHsMgVAxYWPng/xpDX
         m3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+yEsILmCKm0hRP0CDuXEGc8J5t+QTwZ1G0jbK/IVGEU=;
        b=E61UVG+HLudF+ZVOTp6pbEze5Xo5Phb7L/7wRFHvbkUCGfTcSIlR/28zWr8tQL9e8i
         xc8lBjxSnqsBrfHDycYXaxZtiGLpu3U94MfV6Ff+e2Road7OQD3mTWDZoG9sJ1Qd5Vh4
         J0KTRkwdMlonSrIwm5XNviRTQL6J28zhlMZ6Oa+3IaSGiIIY//Nc2jhUUWKmr1vLzmtc
         TngALOv5X+DXpFEyWkGBJ8NjMFk12rPDxoanxlngqEMYg8IWeQaiIyHIVEW3Cu1jg2av
         eUWn01W5LGPwutEaecGoLIuwWW6Eiga9Z/PHzBvBbrlipxVw5Mdr+BfOsjBVDdM12Ga/
         f8Gw==
X-Gm-Message-State: AOAM531OojMI/XIOjZTqq+kbMsMmy23Z6iv4FsS5jKTdXkkxvzPADtnm
        OKapuAwM1xwa/35bz8ygUtBnZlvNmJB0kNkUI10=
X-Google-Smtp-Source: ABdhPJwyQXihDVRWBXi0WjOtJZqEDftaWw5l/BGfz0TLHIP67jMv4+mMDOtseTATUXKS47KyOWSEgA==
X-Received: by 2002:a63:d257:: with SMTP id t23mr4664803pgi.212.1602693077702;
        Wed, 14 Oct 2020 09:31:17 -0700 (PDT)
Received: from localhost.localdomain ([49.207.205.44])
        by smtp.gmail.com with ESMTPSA id i9sm10919pgc.71.2020.10.14.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 09:31:16 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     anprice@redhat.com, agruenba@redhat.com, rpeterso@redhat.com
Cc:     syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        cluster-devel@redhat.com, anant.thazhemadam@gmail.com,
        foxhlchen@gmail.com,
        syzbot+af90d47a37376844e731@syzkaller.appspotmail.com
Subject: [PATCH v2] fs: gfs2: add validation checks for size of superblock
Date:   Wed, 14 Oct 2020 22:01:09 +0530
Message-Id: <20201014163109.98739-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gfs2_check_sb(), no validation checks are performed with regards to
the size of the superblock.
syzkaller detected a slab-out-of-bounds bug that was primarily caused
because the block size for a superblock was set to zero.
A valid size for a superblock is a power of 2 between 512 and PAGE_SIZE.
Performing validation checks and ensuring that the size of the superblock
is valid fixes this bug.

Reported-by: syzbot+af90d47a37376844e731@syzkaller.appspotmail.com
Tested-by: syzbot+af90d47a37376844e731@syzkaller.appspotmail.com
Suggested-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---

Changes in v2:

	* Completely dropped the changes proposed in v1. Instead,
	  validity checks for superblock size have been introduced. 
	  (Suggested by Andrew Price<anprice@redhat.com>)

	* Addded a "Suggested-by" tag accrediting the patch idea to
	  Andrew. If there's any issue with that, please let me know.

	* Changed the commit header and commit message appropriately.

	* Updated "Reported-by" and "Tested-by" tags to the same instance
	  of the bug that was detected earlier (non consequential change).


 fs/gfs2/ops_fstype.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6d18d2c91add..f0605fae2c4c 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -169,6 +169,13 @@ static int gfs2_check_sb(struct gfs2_sbd *sdp, int silent)
 		return -EINVAL;
 	}
 
+	/* Check if the size of the block is valid - a power of 2 between 512 and  PAGE_SIZE */
+	if (sb->sb_bsize < 512 || sb->sb_bsize > PAGE_SIZE || (sb->sb_bsize & (sb->sb_bsize - 1))) {
+		if (!silent)
+			pr_warn("Invalid superblock size\n");
+		return -EINVAL;
+	}
+
 	/*  If format numbers match exactly, we're done.  */
 
 	if (sb->sb_fs_format == GFS2_FORMAT_FS &&
-- 
2.25.1

