Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB632A3B01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 04:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKCDXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 22:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgKCDXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 22:23:30 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26346207BB;
        Tue,  3 Nov 2020 03:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604373809;
        bh=p9rQmVDxvvOszEjaGQDBK6m2fDZWjD12qwvk598JVQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=romb8T+KHa9yqXJuEAfFU3ZMyx5vMFDr8jG5yMmi3f1CJQh5/UdbHkmS8/wva9xGW
         FXqFwCR7K3E77PkmywIWEGD2zzhLB6FWqwJ7g1+vQdYKegYya+CnEinjvmEMDdpubY
         GFvyoxxslp+X639eSvUxjnlHalzaOr7kNDvcT9gQ=
Date:   Mon, 2 Nov 2020 19:23:27 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Robin Hsu <robinhsu@google.com>,
        linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs-toos:fsck.f2fs Fix bad return value
Message-ID: <20201103032327.GA3655802@google.com>
References: <20201026094000.1500425-1-robinhsu@google.com>
 <20201103025247.GA2875@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103025247.GA2875@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02, Eric Biggers wrote:
> On Mon, Oct 26, 2020 at 05:40:00PM +0800, Robin Hsu via Linux-f2fs-devel wrote:
> > 'ret' should not have been used here: otherwise, it would be wrongly used
> > as the error code and then be returned from main().
> > 
> > Signed-off-by: Robin Hsu <robinhsu@google.com>
> > ---
> >  fsck/fsck.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fsck/fsck.c b/fsck/fsck.c
> > index f97e9fb..66e4e3f 100644
> > --- a/fsck/fsck.c
> > +++ b/fsck/fsck.c
> > @@ -3137,8 +3137,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
> >  		char ans[255] = {0};
> >  
> >  		printf("\nDo you want to restore lost files into ./lost_found/? [Y/N] ");
> > -		ret = scanf("%s", ans);
> > -		ASSERT(ret >= 0);
> > +		ASSERT(scanf("%s", ans) >= 0);
> >  		if (!strcasecmp(ans, "y")) {
> >  			for (i = 0; i < fsck->nr_nat_entries; i++) {
> >  				if (f2fs_test_bit(i, fsck->nat_area_bitmap))
> 
> This patch causes a compiler warning:
> 
> 	In file included from f2fs.h:33,
> 			 from fsck.h:14,
> 			 from fsck.c:11:
> 	fsck.c: In function 'fsck_verify':
> 	../include/f2fs_fs.h:197:11: warning: format '%s' expects a matching 'char *' argument [-Wformat=]
> 	    printf("[ASSERT] (%s:%4d) " #exp"\n",  \
> 		   ^~~~~~~~~~~~~~~~~~~~
> 	fsck.c:3151:3: note: in expansion of macro 'ASSERT'
> 	   ASSERT(scanf("%s", ans) >= 0);
> 	   ^~~~~~

Urg. Fixed by this.

From c986140e3c5abb9eb7a08928a88acb8273f1bd52 Mon Sep 17 00:00:00 2001
From: Robin Hsu <robinhsu@google.com>
Date: Mon, 26 Oct 2020 17:40:00 +0800
Subject: [PATCH] f2fs-toos: fsck.f2fs Fix bad return value

'ret' should not have been used here: otherwise, it would be wrongly used
as the error code and then be returned from main().

Signed-off-by: Robin Hsu <robinhsu@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 647523397f3e..e52672032d2c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3146,10 +3146,11 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 #ifndef WITH_ANDROID
 	if (nr_unref_nid && !c.ro) {
 		char ans[255] = {0};
+		int res;
 
 		printf("\nDo you want to restore lost files into ./lost_found/? [Y/N] ");
-		ret = scanf("%s", ans);
-		ASSERT(ret >= 0);
+		res = scanf("%s", ans);
+		ASSERT(res >= 0);
 		if (!strcasecmp(ans, "y")) {
 			for (i = 0; i < fsck->nr_nat_entries; i++) {
 				if (f2fs_test_bit(i, fsck->nat_area_bitmap))
-- 
2.29.1.341.ge80a0c044ae-goog

