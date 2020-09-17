Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49826E677
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIQURS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbgIQURS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600373837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXMrtVIXv7vKfPd7p1LSXdo7LVXu/sjEd6UvyVDVNLE=;
        b=U6EaTXJicC3u4/7nNyLnXC15aAGqPjpCk20IUVHDgpEKQ9DWl6qmqWnHws6gYu1FdQlq5+
        5EPCtrGnHGeJQI6GL0eefkVY1/UTy7tVBVyIwhTvwTD3uSIB8N7sp7AVbJ6e+kv4Xq/oM2
        S98nUdoevrDPYWq+l2n9zMRhnqCuNWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-T61x4WaHP0OWgHIEYuZGdA-1; Thu, 17 Sep 2020 16:16:11 -0400
X-MC-Unique: T61x4WaHP0OWgHIEYuZGdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D3A688EF01;
        Thu, 17 Sep 2020 20:16:10 +0000 (UTC)
Received: from ovpn-66-148.rdu2.redhat.com (ovpn-66-148.rdu2.redhat.com [10.10.66.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D0D655766;
        Thu, 17 Sep 2020 20:16:09 +0000 (UTC)
Message-ID: <2c2d3066f721739050de00293ecdba0b6677ee17.camel@redhat.com>
Subject: Re: slab-out-of-bounds in iov_iter_revert()
From:   Qian Cai <cai@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     torvalds@linux-foundation.org, vgoyal@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 16:16:08 -0400
In-Reply-To: <20200917184558.GX3421308@ZenIV.linux.org.uk>
References: <20200911215903.GA16973@lca.pw>
         <20200911235511.GB3421308@ZenIV.linux.org.uk>
         <87ded87d232d9cf87c9c64495bf9190be0e0b6e8.camel@redhat.com>
         <20200917020440.GQ3421308@ZenIV.linux.org.uk>
         <20200917021439.GA31009@ZenIV.linux.org.uk>
         <e815399a4a123aa7cc096a55055f103874db1e75.camel@redhat.com>
         <20200917164432.GU3421308@ZenIV.linux.org.uk>
         <c68eb9de3579cb56b8c6559a1e610ade631a9d60.camel@redhat.com>
         <20200917184558.GX3421308@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-17 at 19:45 +0100, Al Viro wrote:
> On Thu, Sep 17, 2020 at 01:42:44PM -0400, Qian Cai wrote:
> > > 	How much IO does it take to trigger that on your reproducer?
> > 
> > That is something I don't know for sure because it is always reproducible by
> > running the trinity fuzzer for a few seconds (32 threads). I did another run
> > below (still with your patch applied) and then tried to capture some logs
> > here:
> > 
> > http://people.redhat.com/qcai/iov_iter_revert/
> 
> FWIW, there were several bugs in that patch:
> 	* 'shortened' possibly left uninitialized
> 	* possible error returns with reexpand not done
> 
> Could you try this instead?

This works fine. Thanks for taking care of this, Al.

> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6611ef3269a8..43c165e796da 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3091,11 +3091,10 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter
> *iter)
>  	ssize_t ret = 0;
>  	struct file *file = iocb->ki_filp;
>  	struct fuse_file *ff = file->private_data;
> -	bool async_dio = ff->fc->async_dio;
>  	loff_t pos = 0;
>  	struct inode *inode;
>  	loff_t i_size;
> -	size_t count = iov_iter_count(iter);
> +	size_t count = iov_iter_count(iter), shortened = 0;
>  	loff_t offset = iocb->ki_pos;
>  	struct fuse_io_priv *io;
>  
> @@ -3103,17 +3102,9 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter
> *iter)
>  	inode = file->f_mapping->host;
>  	i_size = i_size_read(inode);
>  
> -	if ((iov_iter_rw(iter) == READ) && (offset > i_size))
> +	if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
>  		return 0;
>  
> -	/* optimization for short read */
> -	if (async_dio && iov_iter_rw(iter) != WRITE && offset + count > i_size)
> {
> -		if (offset >= i_size)
> -			return 0;
> -		iov_iter_truncate(iter, fuse_round_up(ff->fc, i_size - offset));
> -		count = iov_iter_count(iter);
> -	}
> -
>  	io = kmalloc(sizeof(struct fuse_io_priv), GFP_KERNEL);
>  	if (!io)
>  		return -ENOMEM;
> @@ -3129,15 +3120,22 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter
> *iter)
>  	 * By default, we want to optimize all I/Os with async request
>  	 * submission to the client filesystem if supported.
>  	 */
> -	io->async = async_dio;
> +	io->async = ff->fc->async_dio;
>  	io->iocb = iocb;
>  	io->blocking = is_sync_kiocb(iocb);
>  
> +	/* optimization for short read */
> +	if (io->async && !io->write && offset + count > i_size) {
> +		iov_iter_truncate(iter, fuse_round_up(ff->fc, i_size - offset));
> +		shortened = count - iov_iter_count(iter);
> +		count -= shortened;
> +	}
> +
>  	/*
>  	 * We cannot asynchronously extend the size of a file.
>  	 * In such case the aio will behave exactly like sync io.
>  	 */
> -	if ((offset + count > i_size) && iov_iter_rw(iter) == WRITE)
> +	if ((offset + count > i_size) && io->write)
>  		io->blocking = true;
>  
>  	if (io->async && io->blocking) {
> @@ -3155,6 +3153,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter
> *iter)
>  	} else {
>  		ret = __fuse_direct_read(io, iter, &pos);
>  	}
> +	iov_iter_reexpand(iter, iov_iter_count(iter) + shortened);
>  
>  	if (io->async) {
>  		bool blocking = io->blocking;
> 

