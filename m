Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421521B2F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgDUSuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgDUSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:50:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA758C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 11:50:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQxxl-007lIL-Bu; Tue, 21 Apr 2020 18:49:41 +0000
Date:   Tue, 21 Apr 2020 19:49:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200421184941.GD23230@ZenIV.linux.org.uk>
References: <20200421154204.252921-1-hch@lst.de>
 <20200421154204.252921-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421154204.252921-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:41:58PM +0200, Christoph Hellwig wrote:

>  static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
>  				   size_t len, loff_t *pos)
>  {
>  	struct spu_context *ctx = file->private_data;
> +	struct spu_proxydma_info info;
>  	int ret;
>  
> +	if (len < sizeof(info))
> +		return -EINVAL;
> +	if (!access_ok(buf, len))
> +		return -EFAULT;
> +
>  	ret = spu_acquire_saved(ctx);
>  	if (ret)
>  		return ret;
>  	spin_lock(&ctx->csa.register_lock);
> -	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
> +	__spufs_proxydma_info_read(ctx, &info);
> +	ret = simple_read_from_buffer(buf, len, pos, &info, sizeof(info));

IDGI...  What's that access_ok() for?  If you are using simple_read_from_buffer(),
the damn thing goes through copy_to_user().  Why bother with separate access_ok()
here?
