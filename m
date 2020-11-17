Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D23B2B6C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgKQR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgKQR7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:59:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1B6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cskgDcdHpBtGuT+Q0MiDTgb3wVjrxGdiENrX+l9c/rw=; b=jDbc6ABNYPx0YGwRBsZ8Vx9kP7
        ckNu8og4QwvnfwhIMo7lFoyuscMcxJVToIw9Fx4xt9J0+OAc+aA/BbCfQ79+kXD+MQPkAbxW4g8KA
        urulLHMXEx8PLJCHo7X9CqQ/9qvdOyfDt/AtPqfEg0TDK/rh33mpc/y3eEWMzSEE8dEwkl0zZFrTl
        UgWUQS7/VYSo3Pydwz1ygwo37ImLJZEtXAXzfUZ23X9Yp/hMFy3nbgMYEidkEasY6iyrpBDGMP0AP
        kLABLiTykjONyo6VJ4WT2ED2b6Tv6GOOvhu9NN/pIAhsmRDOxaoBiX2BQW/skP0BqSdyUpgpw52Pd
        nYJf1vaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf5Fs-0007w9-IM; Tue, 17 Nov 2020 17:59:00 +0000
Date:   Tue, 17 Nov 2020 17:59:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117175900.GS29991@casper.infradead.org>
References: <20201117171242.GA120587@rlk>
 <20201117174117.GQ29991@casper.infradead.org>
 <20201117174633.GA158014@rlk>
 <20201117174727.GR29991@casper.infradead.org>
 <20201117175658.GA158143@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117175658.GA158143@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 01:56:58AM +0800, Hui Su wrote:
> On Tue, Nov 17, 2020 at 05:47:27PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 18, 2020 at 01:46:33AM +0800, Hui Su wrote:
> > > On Tue, Nov 17, 2020 at 05:41:17PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Nov 18, 2020 at 01:12:42AM +0800, Hui Su wrote:
> > > > > lru_list lru bit 0 can tell whether the list is
> > > > > avtive lru-list or not.
> > > > > lru_list lru bit 1 can tell whether the list is
> > > > > file lru-list or not.
> > > > > 
> > > > > And fix some define type in shrink_active_list()
> > > > > and get_scan_count().
> > > > > 
> > > > > v1->v2:
> > > > > correct the commit message, and fix the define type.
> > > > 
> > > > No, still incorrect.
> > > 
> > > I am a little confused, can you tell in detail?
> > 
> > Have you booted a kernel with this change?  Have you run any kind of
> > tests on it?
> 
> Yes, I boot it with qemu-system-x86_64-4.1.50 on ubuntu20.04:
> qemu-system-x86_64 -kernel /home/rlk/workspace/compile/out/arch/x86_64/boot/bzImage -hda \
>  /home/rlk/myspace/qemu_build/rootfs.img -append "root=/dev/sda console=ttyS0" -nographic
> 
> using the kernel compiled with ubuntu20.04's default .config.
> 
> It seems nothing abnormal.
> And i did not do other test.

Maybe you should ... how about LTP?  I think that's pretty straightforward
to set up and run.
