Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3572C8C47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgK3SMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgK3SMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:12:08 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC1E20789;
        Mon, 30 Nov 2020 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606759887;
        bh=7e7+SBM2J+NolPFM4F9UZ//nzhmt92jdOSBYye2Blxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KhG2M4cfdNTD8JPugl1EYr7EV8BoXU3K+ZSBNZ0irt7OsAH4vPmbELGk04Pi75ZSs
         lRXADg3NNZnZ24u3CK7vHXASbHPT9iQm2fi99eyvAB8a64eSYBq6xRxFHkt0iFT2X6
         qu59WKuEIuShOAkWomSA2oag6biAtaouIRFleD6E=
Date:   Mon, 30 Nov 2020 10:11:25 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: add compress_inode to
 cache compressed blocks
Message-ID: <X8U1zbBa4IaaSYXV@sol.localdomain>
References: <20201126103709.80006-1-yuchao0@huawei.com>
 <X7/sCLnVPOjkC9DI@sol.localdomain>
 <7ecb947e-2f8c-abd7-c116-c82c474fded7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ecb947e-2f8c-abd7-c116-c82c474fded7@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 09:01:47AM +0800, Chao Yu wrote:
> On 2020/11/27 1:55, Eric Biggers wrote:
> > On Thu, Nov 26, 2020 at 06:37:09PM +0800, Chao Yu wrote:
> > > Support to use address space of inner inode to cache compressed block,
> > > in order to improve cache hit ratio of random read.
> > > 
> > > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > 
> > If the file is also encrypted, are the compressed pages that are cached still
> > encrypted, or are they decrypted?
> 
> In current implementation, they are decrypted in cache.
> 

One of the things the FS_IOC_REMOVE_ENCRYPTION key ioctl is supposed to
accomplish is evicting all the pagecache pages for all encrypted files that were
using a particular key.  This happens as a consequence of the ioctl evicting the
inodes that were using that key.  If the user is also using the init_on_free=1
kernel command-line option to enable automatic zeroing of all freed memory, that
should cause those inode's pagecache pages (which contain decrypted data) to be
zeroed, so that they can't be compromised later by an online attack.

This new filesystem-wide cache containing decrypted pages might break that.  It
sounds like when an inode is evicted, its cached pages won't necessarily be
evicted from this new filesystem-wide cache.

Can you ensure that pages get evicted from this new cache when the inode to
which they belong is evicted?

- Eric
