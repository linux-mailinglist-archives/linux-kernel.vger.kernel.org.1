Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6A21E671
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 05:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGNDlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 23:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgGNDlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:41:13 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C8D20890;
        Tue, 14 Jul 2020 03:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594698072;
        bh=SPL3nkj9HvC2j7rtwl00nNXwS53s+StgAz1Rltp3OXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pn4xLHed5UErZazjYs75fzvgnaYZ3py3NH+VTIX724EC9TUqwdfrEv0jCtI5x3vj2
         EcUQBE7VdW1zx031C74H8IiVcL3J+EpURqyQwsT7kCDHC7vukx4ZThuUXuj41Abqg/
         EdHFmTdurMMLft9g//TwoWhWD6R5YzJPHJLQEJCw=
Date:   Mon, 13 Jul 2020 20:41:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, arve@android.com, christian@brauner.io,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        hughd@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: possible deadlock in shmem_fallocate (4)
Message-ID: <20200714034111.GD1696@sol.localdomain>
References: <0000000000000b5f9d059aa2037f@google.com>
 <20200714033252.8748-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714033252.8748-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:32:52AM +0800, Hillf Danton wrote:
> 
> Add FALLOC_FL_NOBLOCK and on the shmem side try to lock inode upon the
> new flag. And the overall upside is to keep the current gfp either in
> the khugepaged context or not.
> 
> --- a/include/uapi/linux/falloc.h
> +++ b/include/uapi/linux/falloc.h
> @@ -77,4 +77,6 @@
>   */
>  #define FALLOC_FL_UNSHARE_RANGE		0x40
>  
> +#define FALLOC_FL_NOBLOCK		0x80
> +

You can't add a new UAPI flag to fix a kernel-internal problem like this.

- Eric
