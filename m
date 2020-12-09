Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6B2D3D4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgLII0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:26:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgLII0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:26:12 -0500
Date:   Wed, 9 Dec 2020 00:25:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607502332;
        bh=PMrNU6Eh4JPyhHMH2Ub8x5UyuXOYpcnLJSiXjTAHbXM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdowoOGBSvtDu6ax5/aLZsyKfM+igJDhhFfUVKGlMwjvoKHFI/I2pke6RWdkZm0//
         4QyK/myuXZstBgiEtXuR+RKyuyx9TVbAEw6zSpV7A5IZHuhtIPCMIzs1+rcDvmZcDX
         bxE8sHBL41JTgyVDFxEr1yJQ416ALgRIfN8y5tGvBrmUu2iM7e+NpONxkyREskBikI
         ejmYmH2Z/XSWg1V7yi8sTN6ctQ38WeWa6FDCTq7978gI17Bon+l4UcMNFXDsannTey
         uODEePtPU9XWGuak++Opi5/dMXAp/rj6zA7DtJixCdhzsmWm8wmHUeHsYSR8ASi3Wr
         a0bSP48j9zAHQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
Message-ID: <X9CJ+skrzIekm0lk@google.com>
References: <20201203065615.402494-1-daeho43@gmail.com>
 <86651979-2c6a-59de-a03d-9c0437703de5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86651979-2c6a-59de-a03d-9c0437703de5@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09, Chao Yu wrote:
> On 2020/12/3 14:56, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > +	f2fs_balance_fs(F2FS_I_SB(inode), true);
> 
> Trivial cleanup:
> 
> f2fs_balance_fs(sbi, true);
> 
> > +	f2fs_balance_fs(F2FS_I_SB(inode), true);
> 
> Ditto,
> 
> Jaegeuk could fix this directly?

Let's fix this later, since I'd like to freeze -next branch as much as possible.

> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
