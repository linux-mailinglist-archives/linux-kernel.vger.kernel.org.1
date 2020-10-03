Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786F82821D1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgJCGd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 02:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCGd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 02:33:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97521C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 23:33:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w21so2979797pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6xweXElRWn54OBDJCo2YC9GbaWdrkEkmo/Vva5g7kY=;
        b=gRyh/7gLQF9r16rpR+M8EMzpYdPb3qR33py/EAUTW5uRLLfPN5F8TonZliLI5lpi3S
         RpmUqiBbgY+er99GVU/KZyJOP5y9VBAMs9zNkcxy2uKpjAs92Q5r3N+8Wx7dV8nujcMN
         wmfmZRSBOvSAY9Rmt+l4bk8VxHy2j4dGBrlkamA1Yr++p9bWQAdB4ee0X//7pc03gcsV
         yJKATMSeLW7GWspQUAPCF7Maya9PYU86Y5ZX2CefvwOAQPzggDj4a/vZViflTqOslcAP
         i68QCrhVGs5jiMw0otr9QdJBb0emBB9LgnDUoq36lC1mPhrtLYzE6Vu/jTFLti5xfzu+
         SOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q6xweXElRWn54OBDJCo2YC9GbaWdrkEkmo/Vva5g7kY=;
        b=J87xy8JNiDTUCzaNinoKoqYVTUVUQpilzv4/7hIwjug/kBTr77M9ySeEyeuvHv57/t
         oo2YMdgzQsYO8nLd9ZV3l5LAOSpNdDMvidLdgtmF4hzZ8sHtlDnmGAxJEs99ZVyPBijK
         xfYilYz5Ese69ONzYrj1c1PNG72I49+4ZgLsTe4NMpK7k+P5yIxGVuYWkizB0da9s+ck
         1l9IyTs7EJoMQs3CweNAFnyDmfIjVueweOpqpiwO3jfEIF6R5OzWrhhzdw0sEWP0mFja
         CVMEQjEt9GB/6oDn6R1QsN0jEEIc66iM0WdjD82ySjF/xIRdDBOIwehNNZMm4I0SzIPk
         ihqQ==
X-Gm-Message-State: AOAM533kDhx6y4wxFYa7KOkkMArHdndbzepXca7MjWzru0t2IG+gSJLk
        qYpxwSKjFJxPZcF+ZjqjDTk=
X-Google-Smtp-Source: ABdhPJz+8ZPzDMqkEXY/l6D4yk3KnSI6kGzBe8Rg5VpGXoyWjW5iu7v+AHIDYMO19fXiHdn85yPNsA==
X-Received: by 2002:a63:4d57:: with SMTP id n23mr5523604pgl.43.1601706806975;
        Fri, 02 Oct 2020 23:33:26 -0700 (PDT)
Received: from localhost.localdomain ([223.104.48.15])
        by smtp.gmail.com with ESMTPSA id r1sm3715664pgl.66.2020.10.02.23.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 23:33:26 -0700 (PDT)
From:   Fox Chen <foxhlchen@gmail.com>
To:     rpeterso@redhat.com, agruenba@redhat.com
Cc:     Fox Chen <foxhlchen@gmail.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] gfs2: gfs2_read_sb: put gfs2_assert inside the loop
Date:   Sat,  3 Oct 2020 14:31:43 +0800
Message-Id: <20201003063143.13093-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for (x = 2;; x++) {
        ...
        gfs2_assert(sdp, x <= GFS2_MAX_META_HEIGHT);  <--- after
        ...
        if (d != sdp->sd_heightsize[x - 1] || m)
                break;
        sdp->sd_heightsize[x] = space;
}

sdp->sd_max_height = x
gfs2_assert(sdp, sdp->sd_max_height <= GFS2_MAX_META_HEIGHT) <--- before

Before this patch, gfs2_assert is put outside of the loop of
sdp->sd_heightsize[x] calculation. When something goes wrong,
x exceeds the size of GFS2_MAX_META_HEIGHT, it may already crash inside
the loop when

sdp->sd_heightsize[x] = space

tries to reach the out-of-bound
location, gfs2_assert won't help here.

This patch fixes this by moving gfs2_assert into the loop.
We will check x value each time to see if it exceeds GFS2_MAX_META_HEIGHT.

Signed-off-by: Fox Chen <foxhlchen@gmail.com>
---
 fs/gfs2/ops_fstype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6d18d2c91add..6cc32e3010f2 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -333,6 +333,7 @@ static int gfs2_read_sb(struct gfs2_sbd *sdp, int silent)
 		u64 space, d;
 		u32 m;
 
+		gfs2_assert(sdp, x <= GFS2_MAX_META_HEIGHT);
 		space = sdp->sd_heightsize[x - 1] * sdp->sd_inptrs;
 		d = space;
 		m = do_div(d, sdp->sd_inptrs);
@@ -343,7 +344,6 @@ static int gfs2_read_sb(struct gfs2_sbd *sdp, int silent)
 	}
 	sdp->sd_max_height = x;
 	sdp->sd_heightsize[x] = ~0;
-	gfs2_assert(sdp, sdp->sd_max_height <= GFS2_MAX_META_HEIGHT);
 
 	sdp->sd_max_dents_per_leaf = (sdp->sd_sb.sb_bsize -
 				      sizeof(struct gfs2_leaf)) /
-- 
2.25.1

