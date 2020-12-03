Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA72CCEFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgLCGHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgLCGHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:07:45 -0500
Date:   Wed, 2 Dec 2020 22:07:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606975625;
        bh=4kjEtMFrjeavxN2mKqcqGSsSXeUIsDMbjS/Wf+Mx0Pg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNLKdNI9nav5vjFiwqpHfrqa7SXQ6v+4dePorn5Eg16hdtZTBTzPd+tYZWN3U9l44
         vZSmWU1IJVsGnGqIx8p87LRPDCxyE7BkqxfI21iqJjY8lDT1q0CV+3ZMFAiio9gPdC
         lwxr/vFiSI/xOanTRDPbsEQWC8RzrN5438XfqhvGtR2ol0GhOWTVFvdZKYaEzHTye1
         8h18Igg0otkF9koO/n1u1r6ZZ88Pc+1Z4Zjmh2hN5A6Tld/6gWbZ6b2WvFrk7GSnlf
         wBmycrI6GhoEXGUyAbi+Eh0MalQcEuLbLL740WeKgfZGxnhfOMD+4GOOt1zyc7wyGV
         ej9vku+173V2Q==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Light Hsieh <Light.Hsieh@mediatek.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid race condition for shinker
 count
Message-ID: <X8iAh7quYw77O6XC@google.com>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <20201112053414.GB3826485@google.com>
 <20201112054051.GA4092972@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112054051.GA4092972@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11, Jaegeuk Kim wrote:
> Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
> wrong do_shinker work. Let's avoid to get stale data by using nat_tree_lock.
> 
> Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v3:
>  - fix to use NM_I(sbi)
> 
>  fs/f2fs/shrinker.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index d66de5999a26..555712ba06d8 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -18,7 +18,11 @@ static unsigned int shrinker_run_no;
>  
>  static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
>  {
> -	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
> +	long count;
> +
> +	down_read(&NM_I(sbi)->nat_tree_lock);
> +	count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
> +	up_read(&NM_I(sbi)->nat_tree_lock);

I just fosund this can give kernel hang due to the following backtrace.
f2fs_shrink_count
shrink_slab
shrink_node
do_try_to_free_pages
try_to_free_pages
__alloc_pages_nodemask
alloc_pages_current
allocate_slab
__slab_alloc
__slab_alloc
kmem_cache_alloc
add_free_nid
f2fs_flush_nat_entries
f2fs_write_checkpoint

Let me just check like this.

From 971163330224449d90aac90957ea38f77d494f0f Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 6 Nov 2020 13:22:05 -0800
Subject: [PATCH] f2fs: avoid race condition for shrinker count

Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
wrong do_shinker work. Let's avoid to return insane overflowed value.

Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/shrinker.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index d66de5999a26..75b5b4aaed99 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -18,9 +18,9 @@ static unsigned int shrinker_run_no;
 
 static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 {
-	long count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
-
-	return count > 0 ? count : 0;
+	if (NM_I(sbi)->nat_cnt > NM_I(sbi)->dirty_nat_cnt)
+		return NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
+	return 0;
 }
 
 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
-- 
2.29.2.454.gaff20da3a2-goog



>  
>  	return count > 0 ? count : 0;
>  }
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
