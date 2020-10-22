Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98422295714
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgJVEW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgJVEW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:22:59 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F58223C7;
        Thu, 22 Oct 2020 04:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603340578;
        bh=abK6GnFdkR0gb+0CmFFSKSBybEXxiaGX7kjbc9XN674=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vp/iU+WQQk/3dF0vOi29eutcyfki6Gh3RadGlE+BrR4V8jSmn7zOw0T5ovw6+w4IR
         Vb1D8MuHqywZqN7Q+cNJ5x0jVoFx0Xbwe80fUMNUpEObV4AXiJQTxPBuJcqeBfA4yg
         m21uPK4QSjDz99Z6xksAMK4f1hBpamMHmLSEXEqA=
Date:   Wed, 21 Oct 2020 21:22:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION
 ioctl
Message-ID: <20201022042257.GA857@sol.localdomain>
References: <20201022035848.976286-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022035848.976286-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:58:47PM +0900, Daeho Jeong wrote:
> +	if (!f2fs_compressed_file(inode)) {
> +		inode_unlock(inode);
> +		return -EINVAL;
> +	}

How about using ENODATA here?  EINVAL tends to be used for lots of different
reasons, and it's not always clear what it means.

Note that FS_IOC_GET_ENCRYPTION_POLICY fails with ENODATA when called on an
unencrypted file, which is a similar case.

- Eric
