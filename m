Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242B0275AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgIWOuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:50:10 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6871BC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:50:10 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 3A6C2C009; Wed, 23 Sep 2020 16:50:08 +0200 (CEST)
Date:   Wed, 23 Sep 2020 16:49:53 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, qemu_oss@crudebyte.com,
        groug@kaod.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, justin.he@arm.com
Subject: Re: [PATCH RFC v2 4/4] 9p: fix race issue in fid contention.
Message-ID: <20200923144953.GA1685@nautica>
References: <20200923141146.90046-1-jianyong.wu@arm.com>
 <20200923141146.90046-5-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923141146.90046-5-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Overall looks good; a few comments.

Jianyong Wu wrote on Wed, Sep 23, 2020:
> open-unlink-f*syscall test:
> I have tested for f*syscall include: ftruncate fstat fchown fchmod faccessat.

Given the other thread, what did you test this with?
Since qemu doesn't work apparently do you have a in-house server at arm
I could test?
(I'll try with ganesha otherwise, it keeps files open so it should work
I think...)

> +	atomic_set(&fid->count, 1);

I kind of like the refcount API becauese it has some extra overflow
checks; but it requires a bit more work around clunk (instead of bailing
out early if counter hits 0, you need to have it call a separate
function in case it does)

That's mostly esthetics though I'm not going to fuss over that.

> @@ -74,6 +77,7 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
>  void v9fs_open_fid_add(struct inode *inode, struct p9_fid *fid)
>  {
>  	spin_lock(&inode->i_lock);
> +	atomic_set(&fid->count, 1);

Hm, that should be done at fid creation time in net/9p/client.c
p9_fid_create ; no ?
(you do it there already, I don't see what reseting count here brings
except confusion)

> diff --git a/fs/9p/fid.h b/fs/9p/fid.h
> index dfa11df02818..1fed96546728 100644
> --- a/fs/9p/fid.h
> +++ b/fs/9p/fid.h
> @@ -22,6 +22,14 @@ static inline struct p9_fid *clone_fid(struct p9_fid *fid)
>  }
>  static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
>  {
> -	return clone_fid(v9fs_fid_lookup(dentry));
> +	struct p9_fid *fid, *nfid;
> +
> +	fid = v9fs_fid_lookup(dentry);
> +	if (!fid || IS_ERR(fid))
> +		return fid;
> +
> +	nfid = p9_client_walk(fid, 0, NULL, 1);

I think you clone_fid() here is slightly easier to understand; everyone
doesn't know that a walk with no component is a clone.
The compiler will optimize that IS_ERR(fid) is checked twice, it's fine.

> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index ce7882da8e86..58ed9bd306bd 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -140,10 +140,16 @@ struct p9_client {
>   *
>   * TODO: This needs lots of explanation.
>   */
> +enum fid_source {
> +	FID_FROM_OTHER,
> +	FID_FROM_INODE,
> +	FID_FROM_DENTRY,
> +};

leftovers from previous iteration.


Overall looks good to me.
I'd need to spend some time checking the actual counting part &
hammering the fs a bit then confirming no fid got forgotten (there's a
pr_info at umount time) but I'm happy with this ; thanks!

-- 
Dominique




