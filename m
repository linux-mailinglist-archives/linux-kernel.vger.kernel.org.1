Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116BE2109DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgGAK7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 06:59:45 -0400
Received: from nautica.notk.org ([91.121.71.147]:48986 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729952AbgGAK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:59:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BCAA5C021; Wed,  1 Jul 2020 12:59:42 +0200 (CEST)
Date:   Wed, 1 Jul 2020 12:59:27 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Steve.Capper@arm.com, Kaly.Xin@arm.com, justin.he@arm.com,
        wei.chen@arm.com
Subject: Re: [PATCH v2] 9p: retrieve fid from file when file instance exist.
Message-ID: <20200701105927.GA20762@nautica>
References: <20200701023821.5387-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701023821.5387-1-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Wed, Jul 01, 2020:
> In the current setattr implementation in 9p, fid is always retrieved
> from dentry no matter file instance exists or not. There may be
> some info related to opened file instance dropped. so it's better
> to retrieve fid from file instance if file instance is passed to setattr.
> 
> for example:
> fd=open("tmp", O_RDWR);
> ftruncate(fd, 10);
> 
> The file context related with fd will be lost as fid is always
> retrieved from dentry, then the backend can't get the info of
> file context. It is against the original intention of user and
> may lead to bug.

Thanks for the commit message - still feels a bit odd but at least
correct enough for me :)

> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  fs/9p/vfs_inode.c      | 6 +++++-
>  fs/9p/vfs_inode_dotl.c | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index c9255d399917..b33574d347fa 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -1100,7 +1100,11 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
>  
>  	retval = -EPERM;
>  	v9ses = v9fs_dentry2v9ses(dentry);
> -	fid = v9fs_fid_lookup(dentry);
> +	if (iattr->ia_valid & ATTR_FILE) {
> +		fid = iattr->ia_file->private_data;
> +		WARN_ON(!fid);

That would crash in 9p_client_wstat a few lines below with the current
else ; so I'm not sure WARN_ON is appropriate with this code.

the snippet I had suggested had v9fs_fid_lookup in a different if, not
as a else statement to avoid this crash (and then warning is OK)

> +	} else
> +		fid = v9fs_fid_lookup(dentry);

-- 
Dominique
