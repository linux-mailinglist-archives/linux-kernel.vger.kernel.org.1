Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D5D2D3E36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgLIJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:07:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:47324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbgLIJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:07:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78D9BAB63;
        Wed,  9 Dec 2020 09:07:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 26FBD1E133E; Wed,  9 Dec 2020 10:07:00 +0100 (CET)
Date:   Wed, 9 Dec 2020 10:07:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: quota: fix array-index-out-of-bounds bug by passing
 correct argument to vfs_cleanup_quota_inode()
Message-ID: <20201209090700.GA18595@quack2.suse.cz>
References: <20201208194338.7064-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208194338.7064-1-anant.thazhemadam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-12-20 01:13:38, Anant Thazhemadam wrote:
> When dquot_resume() was last updated, the argument that got passed
> to vfs_cleanup_quota_inode was incorrectly set.
> 
> If type = -1 and dquot_load_quota_sb() returns a negative value,
> then vfs_cleanup_quota_inode() gets called with -1 passed as an
> argument, and this leads to an array-index-out-of-bounds bug.
> 
> Fix this issue by correctly passing the arguments.
> 
> Fixes: ae45f07d47cc ("quota: Simplify dquot_resume()")
> Reported-by: syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
> Tested-by: syzbot+2643e825238d7aabb37f@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>

Thanks for the fix! I've just queued the very same fix I wrote yesterday to
my tree. But yours has better changelog so let me pick your patch instead
;)

For next time, how can we avoid collisions like this? Did you work on the fix
based on the syzbot email sent to the list so if I actually reply to the
syzbot email that I'm working on / already have a fix you'd see it?

								Honza

> ---
> If type = -1 is passed as an argument to vfs_cleanup_quota_inode(),
> it causes an array-index-out-of-bounds error since dqopt->files[-1]
> can be potentially attempted to be accessed.
> Before the bisected commit introduced this bug, vfs_load_quota_inode()
> was being directly called in dquot_resume(), and subsequently 
> vfs_cleanup_quota_inode() was called with the cnt value as argument.
> 
>  fs/quota/dquot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index bb02989d92b6..4f1373463766 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2455,7 +2455,7 @@ int dquot_resume(struct super_block *sb, int type)
>  		ret = dquot_load_quota_sb(sb, cnt, dqopt->info[cnt].dqi_fmt_id,
>  					  flags);
>  		if (ret < 0)
> -			vfs_cleanup_quota_inode(sb, type);
> +			vfs_cleanup_quota_inode(sb, cnt);
>  	}
>  
>  	return ret;
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
