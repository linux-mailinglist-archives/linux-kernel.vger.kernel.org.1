Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8525A2AFF03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgKLFmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbgKLFeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 00:34:16 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8EE2076E;
        Thu, 12 Nov 2020 05:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605159255;
        bh=RR8tEZfeMTPWIeuF8jnjdhsKpk0uEkjI9YIlVtLy2Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJHcsZG4oqKpJ00Cxo0SuPCErWUj06VNCY3Gcpn7Wy0coE6ebLG7pseJYOjMh0nMi
         TrZsYyVXrEHh0cRpK+LsOFtf3UjqZFrEwhFIJyxd0Mo4f5jnZvBtF2sqx3fs/hqVQ3
         2ld478cO5eA1b+vc89TLNJa3VmUu5zI1ttlPX6fI=
Date:   Wed, 11 Nov 2020 21:34:14 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Light Hsieh <Light.Hsieh@mediatek.com>
Subject: Re: [PATCH v2] f2fs: avoid race condition for shinker count
Message-ID: <20201112053414.GB3826485@google.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109170012.2129411-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
wrong do_shinker work. Let's avoid to get stale data by using nat_tree_lock.

Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/shrinker.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index d66de5999a26..d42245ab07f4 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -18,7 +18,11 @@ static unsigned int shrinker_run_no;
 
 static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 {
-	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
+	long count;
+
+	down_read(&nm_i->nat_tree_lock);
+	count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
+	up_read(&nm_i->nat_tree_lock);
 
 	return count > 0 ? count : 0;
 }
-- 
2.29.2.299.gdc1121823c-goog

