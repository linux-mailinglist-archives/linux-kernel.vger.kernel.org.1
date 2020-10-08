Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7E6287E88
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgJHWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHWLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:11:33 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6EE22241;
        Thu,  8 Oct 2020 22:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602195092;
        bh=5cwnMyQhKUP3d82WK3IQRFD3LayprBJ/26VCNg9TYjI=;
        h=From:To:Cc:Subject:Date:From;
        b=s5KO77zHEHTrjhoGLQRAFkidlXW0qvk0fmxgztaroiU7PbCWpTewDIobEef1OeBOj
         FP7rjSApa4gqsoLNwDRlqvVo44nsfu4NKriQDnL2cHMxK4TSMHc+uWABfbjQSxqnMk
         GpYECZNvpdpQb093O8Vcb+y0r435FywMC/+yh/Lw=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix memory alignment to support 32bit
Date:   Thu,  8 Oct 2020 15:11:31 -0700
Message-Id: <20201008221131.925195-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 32bit system, 64-bits key breaks memory alignment.
This fixes the commit "f2fs: support 64-bits key in f2fs rb-tree node entry".

Reported-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 713ab95223ef6..ce79b9b5b1eff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -617,7 +617,7 @@ struct rb_entry {
 			unsigned int len;	/* length of the entry */
 		};
 		unsigned long long key;		/* 64-bits key */
-	};
+	} __packed;
 };
 
 struct extent_info {
-- 
2.28.0.1011.ga647a8990f-goog

