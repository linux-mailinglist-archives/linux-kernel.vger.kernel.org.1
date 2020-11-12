Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9E2AFEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgKLFm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbgKLFky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 00:40:54 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D8D92076E;
        Thu, 12 Nov 2020 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605159653;
        bh=9ibzdXZrtU/gfZtcBKAW2NIKugLvAG+ui+6e39ewi8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiKTEyLd7zkM4dAJL0JwkU4r8FD/1zGISnh1O2j6Fgg7nxWHgiYKmk3Ofx5Iv4H8m
         CsVnvtp7UU6/v96eoYFTXpasUuFfJTiwmfNHWYS1DNFFZxwuiaZoheJVlrB8npDOnm
         p8iTb8HE0bzhqzXGbmCRpxFi8RC2S3V/hN+6B/0I=
Date:   Wed, 11 Nov 2020 21:40:51 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Light Hsieh <Light.Hsieh@mediatek.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid race condition for shinker
 count
Message-ID: <20201112054051.GA4092972@google.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <20201112053414.GB3826485@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112053414.GB3826485@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
wrong do_shinker work. Let's avoid to get stale data by using nat_tree_lock.

Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v3:
 - fix to use NM_I(sbi)

 fs/f2fs/shrinker.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index d66de5999a26..555712ba06d8 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -18,7 +18,11 @@ static unsigned int shrinker_run_no;
 
 static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 {
-	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
+	long count;
+
+	down_read(&NM_I(sbi)->nat_tree_lock);
+	count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
+	up_read(&NM_I(sbi)->nat_tree_lock);
 
 	return count > 0 ? count : 0;
 }
-- 
2.29.2.299.gdc1121823c-goog

