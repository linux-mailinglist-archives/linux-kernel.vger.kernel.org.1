Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067EB2A3A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgKCCwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCCwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:52:49 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD91122275;
        Tue,  3 Nov 2020 02:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604371968;
        bh=i6IyOgCMzRWTKNhC5dgaZ4TTYmnKxd5SmoeXUWUlkwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qTdLaUHI838Jt8XGj1TXxWzCHg/MAbW0kmWL3BlHJNpAOxAfu/SohmpbfnA8WhA+e
         bNt85xLEci+pfIXtTBPRArCfASlHjalW50XwJGmGXvdU7Xh34SjNnT3bQQVQY7tKuW
         sv2gU8ga44TvH5fPLYMK9kNsBxEDWM6lqyeLDcMQ=
Date:   Mon, 2 Nov 2020 18:52:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Robin Hsu <robinhsu@google.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs-toos:fsck.f2fs Fix bad return value
Message-ID: <20201103025247.GA2875@sol.localdomain>
References: <20201026094000.1500425-1-robinhsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026094000.1500425-1-robinhsu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:40:00PM +0800, Robin Hsu via Linux-f2fs-devel wrote:
> 'ret' should not have been used here: otherwise, it would be wrongly used
> as the error code and then be returned from main().
> 
> Signed-off-by: Robin Hsu <robinhsu@google.com>
> ---
>  fsck/fsck.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index f97e9fb..66e4e3f 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -3137,8 +3137,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
>  		char ans[255] = {0};
>  
>  		printf("\nDo you want to restore lost files into ./lost_found/? [Y/N] ");
> -		ret = scanf("%s", ans);
> -		ASSERT(ret >= 0);
> +		ASSERT(scanf("%s", ans) >= 0);
>  		if (!strcasecmp(ans, "y")) {
>  			for (i = 0; i < fsck->nr_nat_entries; i++) {
>  				if (f2fs_test_bit(i, fsck->nat_area_bitmap))

This patch causes a compiler warning:

	In file included from f2fs.h:33,
			 from fsck.h:14,
			 from fsck.c:11:
	fsck.c: In function 'fsck_verify':
	../include/f2fs_fs.h:197:11: warning: format '%s' expects a matching 'char *' argument [-Wformat=]
	    printf("[ASSERT] (%s:%4d) " #exp"\n",  \
		   ^~~~~~~~~~~~~~~~~~~~
	fsck.c:3151:3: note: in expansion of macro 'ASSERT'
	   ASSERT(scanf("%s", ans) >= 0);
	   ^~~~~~
