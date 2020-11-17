Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDF42B6C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgKQR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:58:52 -0500
Received: from m12-17.163.com ([220.181.12.17]:39457 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgKQR6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=zYfSK
        VqhkOwN92ARjGk5n2dO2Y2pWB7jMUjWrrx7zIM=; b=XplTe1URYIydFZOHgokrZ
        SwmT2Z0xzc8PEIcpg7A22AE7LrKdKM8lPi4nuIYdqsVCL5fK1Wn+RQ6wRqGju/hF
        kOcLBAn2a91Bhf9zA1mDZBO09iqdYWNJ9tASlgesYMz4ab4QISdkmxgvUDgkitZ8
        FAlsgMYSz+A9B3fb4fg+eQ=
Received: from localhost (unknown [101.86.213.141])
        by smtp13 (Coremail) with SMTP id EcCowACHA7bqDrRf3jfcUQ--.61818S2;
        Wed, 18 Nov 2020 01:56:58 +0800 (CST)
Date:   Wed, 18 Nov 2020 01:56:58 +0800
From:   Hui Su <sh_def@163.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117175658.GA158143@rlk>
References: <20201117171242.GA120587@rlk>
 <20201117174117.GQ29991@casper.infradead.org>
 <20201117174633.GA158014@rlk>
 <20201117174727.GR29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117174727.GR29991@casper.infradead.org>
X-CM-TRANSID: EcCowACHA7bqDrRf3jfcUQ--.61818S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF48Ar45GryUGFy8CF18Grg_yoWkXFcEqr
        yj9a9Fyw45JrZF9wnxCw4rXrsYka1DtFnIq34fJrykAr9xtFZ3KFWkXryFvrnYya1ftrs3
        uw1Yv3sI93W7tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1wZ2PUUUUU==
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiORTfX1XlverpvgABsc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 05:47:27PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 18, 2020 at 01:46:33AM +0800, Hui Su wrote:
> > On Tue, Nov 17, 2020 at 05:41:17PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 18, 2020 at 01:12:42AM +0800, Hui Su wrote:
> > > > lru_list lru bit 0 can tell whether the list is
> > > > avtive lru-list or not.
> > > > lru_list lru bit 1 can tell whether the list is
> > > > file lru-list or not.
> > > > 
> > > > And fix some define type in shrink_active_list()
> > > > and get_scan_count().
> > > > 
> > > > v1->v2:
> > > > correct the commit message, and fix the define type.
> > > 
> > > No, still incorrect.
> > 
> > I am a little confused, can you tell in detail?
> 
> Have you booted a kernel with this change?  Have you run any kind of
> tests on it?

Yes, I boot it with qemu-system-x86_64-4.1.50 on ubuntu20.04:
qemu-system-x86_64 -kernel /home/rlk/workspace/compile/out/arch/x86_64/boot/bzImage -hda \
 /home/rlk/myspace/qemu_build/rootfs.img -append "root=/dev/sda console=ttyS0" -nographic

using the kernel compiled with ubuntu20.04's default .config.

It seems nothing abnormal.
And i did not do other test.

