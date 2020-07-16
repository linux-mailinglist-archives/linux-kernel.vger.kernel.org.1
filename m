Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2321221AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 05:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGPDau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 23:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGPDau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:30:50 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9433220663;
        Thu, 16 Jul 2020 03:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594870250;
        bh=ikmPWI8MAxfltvRswHekPbDid18TOw8D1FrTV++qoHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftG/dT0uCBDXZCXsbDz6ZLWmgFVO5Hfu9oCpJ2P2Hj7t/8PO1Ihi5lbTIw/yHzMhN
         Cx7YZn51zJpKNDe8bRLO52+Ejg07its1yEMp+il9Z4IInXDhsqoPlOQVrN1Slv3jfX
         u5zEiFR3ssQIcAWgDq8v4Kj4oD4wtwQMDxncESco=
Date:   Wed, 15 Jul 2020 20:30:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, mhocko@kernel.org, hdanton@sina.com,
        devel@driverdev.osuosl.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] staging: android: ashmem: Fix lockdep warning for
 write operation
Message-ID: <20200716033048.GG1167@sol.localdomain>
References: <20200716024527.4009170-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716024527.4009170-1-surenb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:45:27PM -0700, Suren Baghdasaryan wrote:
> syzbot report [1] describes a deadlock when write operation against an
> ashmem fd executed at the time when ashmem is shrinking its cache results
> in the following lock sequence:
> 
> Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(fs_reclaim);
>                                 lock(&sb->s_type->i_mutex_key#13);
>                                 lock(fs_reclaim);
>    lock(&sb->s_type->i_mutex_key#13);
> 
> kswapd takes fs_reclaim and then inode_lock while generic_perform_write
> takes inode_lock and then fs_reclaim. However ashmem does not support
> writing into backing shmem with a write syscall. The only way to change
> its content is to mmap it and operate on mapped memory. Therefore the race
> that lockdep is warning about is not valid. Resolve this by introducing a
> separate lockdep class for the backing shmem inodes.
> 
> [1]: https://lkml.kernel.org/lkml/0000000000000b5f9d059aa2037f@google.com/
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Please add proper tags:

Reported-by: syzbot+7a0d9d0b26efefe61780@syzkaller.appspotmail.com
Fixes: ...
Cc: stable@vger.kernel.org


The Reported-by tag to use was given in the original syzbot report.

- Eric
