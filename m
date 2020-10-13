Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C3728D135
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbgJMP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389307AbgJMP05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:26:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F15C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:26:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so10886401pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59HsEt/qRATYcWGWkuFwFGhFUgu5MJlwW4EIEwWX704=;
        b=XFGW2HPcF0bwYa4rREkERsaYSG9qW8MjsUxPPxWUdIuswX1vrlj9/BcvWU161hj2Kw
         UUwiCVMXAfk1Vo2cdkrBJeR7xxf3eG2Q5wCzjMu6Z20azV6h9P9OVxA/7v/wb0ecBynM
         2nQ7aMxsW1kiNYg1oFTfUg3RSZVVrGlSCaUjeicNO4TNd6PJ6Qmw1o+StpDcGH3i3cC9
         6np4gaGiIa71OfUJUlXkFXfHwYP5cbnf7SoTR2AkaZdAjtPAMysG7zXrtrAT39eT6MAm
         +ZcB+/kpgaO9qDL1deE2njmPQEm0cfYEVq+5L2hhzdnbhmWUN92RGNgDIRQ1cOuSTVpN
         JEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=59HsEt/qRATYcWGWkuFwFGhFUgu5MJlwW4EIEwWX704=;
        b=I86wPWFSu0wg0uw9Qy/pUADVc2e6SKe2SKyLOoQ35Q1GuaQzgxjd+wr/Hm18+qq7du
         BIdiwbT/fjnf09n3v61ypV2BI3fGK37kwduStuEm7DFyQOMvSdYr8mp8zk7PcCAAbBm5
         o8zQfaahEd3j7TZd8fsT6F7urQgDnUEAtO+V4sKSGuqZhfiBx5fZVwh/gC8n2AyuNKI3
         BZJkOZLJAcGefrwqmJStIvyc8km8SX3NkB5e7qgwwSBrfxkeLNs5Xa+i8UEtaD7vl2wt
         2NVUSdU5s+UUkNAdpFbwYtSWX5a1kycMrvSV9x2vsnBYIxJxbYkNPWeGMhZhLelkPgoU
         NlPQ==
X-Gm-Message-State: AOAM532zIBEoeGY0e/pu6Swea0KrZ71WnFGmrH12LNzWx0boPrtcrwlP
        nBt/cMuH0zXYbV6z0P5pdHs=
X-Google-Smtp-Source: ABdhPJxxkc2XNHdUqAyT+6mTSLMdWeQ+/wMyG2H1zQOiyaZ972G084d2ZeNANQpUZBGYnk25yE4X5g==
X-Received: by 2002:a17:902:8c8b:b029:d2:42fe:370a with SMTP id t11-20020a1709028c8bb02900d242fe370amr20231plo.83.1602602816797;
        Tue, 13 Oct 2020 08:26:56 -0700 (PDT)
Received: from localhost.localdomain ([49.207.205.44])
        by smtp.gmail.com with ESMTPSA id 78sm23768794pfz.211.2020.10.13.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 08:26:56 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        anant.thazhemadam@gmail.com,
        syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com
Subject: [PATCH] fs: gfs2: prevent OOB access in gfs2_read_sb()
Date:   Tue, 13 Oct 2020 20:56:48 +0530
Message-Id: <20201013152648.438887-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gfs2_read_sb(), if the condition
	(d != sdp->sd_heightsize[x - 1] || m)
isn't satisfied (in the first 11 iterations), the loop continues,
and begins to perform out-of-bounds access.
Fix this out-of-bounds access by introducing a condition in the for loop
that ensures that no more than GFS2_MAX_META_HEIGHT + 1 elements are
accessed.

In addition to this, if the above condition is satisfied when
x = GFS2_MAX_META_HEIGHT (which = 10), and the flow of control breaks
out of the loop, then an out-of-bounds access is performed again while
assigning sdp->sd_heightsize[x] = ~0 (since x would be 11 now.), and
also the assertion that spd->sd_max_height <= GFS2_MAX_META_HEIGHT would
fail.
Fix this out-of-bounds access and ensure that the assertion doesn't fail
by introducing another variable "index", which keeps track of the last
valid value of x (pre-increment) that can be used.

Reported-by: syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com
Tested-by: syzbot+a5e2482a693e6b1e444b@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---

I have one question here (potentially a place where I suspect this
patch could have a fatal flaw and might need some rework).

	sdp->sd_max_height = x;
	sdp->sd_heightsize[x] = ~0;

Were these lines written with the logic that the value of x would be
equal to (sdp->sd_heightsize[]'s last index filled in by the loop) + 1?
Or, is the expected value of x at these lines equal to 
(sdp->sd_heightsize[]'s last index as filled in by the loop)?
I would appreciate it if someone could clarify for me, how this would 
hold against the second potential out-of-bounds access I mentioned in my
commit message.

An additional comment (which I feel is of some significance) on this.
Reproducing the crash locally, I could infer that sdp->sd_fsb2bb_shift
sdp->sd_sb.sb_bsize, sdp->sd_sb.sb_bsize_shift, and sdp->sd_inptrs
were all 0.
This by extension also means that in gfs2_read_sb(), all the attributes
whose values were determined by performing some sort of calculation 
involving any one of these variables all resulted in either 0 or a 
negative value.
Simply doing the math will also show how this was also the primary reason
this OOB access occured in the first place. 
However, I still feel that gfs2_read_sb() could do with this bit of checking, 
since it fundamentally prevents OOB accesses from occuring in gfs2_read_sb()
in all scenarios.
Anyways, coming back to my initial point. Can having values like that be 
considered unacceptable and as something that needs to be handled (at 
gfs2_fill_super() maybe?) or is this non-anomalous behaviour and okay?

 fs/gfs2/ops_fstype.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6d18d2c91add..66ee8fb06ab9 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -281,7 +281,7 @@ static int gfs2_read_sb(struct gfs2_sbd *sdp, int silent)
 {
 	u32 hash_blocks, ind_blocks, leaf_blocks;
 	u32 tmp_blocks;
-	unsigned int x;
+	unsigned int x, index;
 	int error;
 
 	error = gfs2_read_super(sdp, GFS2_SB_ADDR >> sdp->sd_fsb2bb_shift, silent);
@@ -329,20 +329,21 @@ static int gfs2_read_sb(struct gfs2_sbd *sdp, int silent)
 	sdp->sd_heightsize[0] = sdp->sd_sb.sb_bsize -
 				sizeof(struct gfs2_dinode);
 	sdp->sd_heightsize[1] = sdp->sd_sb.sb_bsize * sdp->sd_diptrs;
-	for (x = 2;; x++) {
+	for (x = 2; x <= GFS2_MAX_META_HEIGHT; x++) {
 		u64 space, d;
 		u32 m;
 
-		space = sdp->sd_heightsize[x - 1] * sdp->sd_inptrs;
+		index = x;
+		space = sdp->sd_heightsize[index - 1] * sdp->sd_inptrs;
 		d = space;
 		m = do_div(d, sdp->sd_inptrs);
 
-		if (d != sdp->sd_heightsize[x - 1] || m)
+		if (d != sdp->sd_heightsize[index - 1] || m)
 			break;
-		sdp->sd_heightsize[x] = space;
+		sdp->sd_heightsize[index] = space;
 	}
-	sdp->sd_max_height = x;
-	sdp->sd_heightsize[x] = ~0;
+	sdp->sd_max_height = index;
+	sdp->sd_heightsize[index] = ~0;
 	gfs2_assert(sdp, sdp->sd_max_height <= GFS2_MAX_META_HEIGHT);
 
 	sdp->sd_max_dents_per_leaf = (sdp->sd_sb.sb_bsize -
-- 
2.25.1

