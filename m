Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247842B6C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgKQSFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:05:45 -0500
Received: from m12-12.163.com ([220.181.12.12]:46198 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730057AbgKQSFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=MVroN
        eXjqiHKOjoaIdggDaedJ91hejn+ECzeDN+2NXM=; b=mLWBy7MZS0UpQcsliziUt
        cdvGfn8Qro3Qk0Xt/D+TrutzZ3L54asv4b697OTM8iVsWlGbPSgbB3YTTa35mhIf
        MRW2qdEETPmphcSIXLFIGOwOe6EnCQJ6jHpi5D9cmQo1TXT5uB8LyNJZY8QX0BUg
        2lF1S93uoqgJV33rFRI0r0=
Received: from localhost (unknown [101.86.213.141])
        by smtp8 (Coremail) with SMTP id DMCowADXpdrmELRfacYSCQ--.53909S2;
        Wed, 18 Nov 2020 02:05:26 +0800 (CST)
Date:   Wed, 18 Nov 2020 02:05:26 +0800
From:   Hui Su <sh_def@163.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117180526.GA158333@rlk>
References: <20201117171242.GA120587@rlk>
 <20201117174117.GQ29991@casper.infradead.org>
 <20201117174633.GA158014@rlk>
 <20201117174727.GR29991@casper.infradead.org>
 <20201117175658.GA158143@rlk>
 <20201117175900.GS29991@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117175900.GS29991@casper.infradead.org>
X-CM-TRANSID: DMCowADXpdrmELRfacYSCQ--.53909S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW3Xr17AFyDGryktw43KFg_yoW8XFy7pr
        yrta13tF4DXr1FyayvyF1kury0qa17Kr1UZr98Zr1UKF90vr1S9w4fKr1F9a42g3Z7uw10
        9FWUXa43ZFZrAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5ManUUUUU=
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWQbfX1WBtcWV3gABsx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 05:59:00PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 18, 2020 at 01:56:58AM +0800, Hui Su wrote:
> > On Tue, Nov 17, 2020 at 05:47:27PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 18, 2020 at 01:46:33AM +0800, Hui Su wrote:
> > > > On Tue, Nov 17, 2020 at 05:41:17PM +0000, Matthew Wilcox wrote:
> > > > > On Wed, Nov 18, 2020 at 01:12:42AM +0800, Hui Su wrote:
> > > > > > lru_list lru bit 0 can tell whether the list is
> > > > > > avtive lru-list or not.
> > > > > > lru_list lru bit 1 can tell whether the list is
> > > > > > file lru-list or not.
> > > > > > 
> > > > > > And fix some define type in shrink_active_list()
> > > > > > and get_scan_count().
> > > > > > 
> > > > > > v1->v2:
> > > > > > correct the commit message, and fix the define type.
> > > > > 
> > > > > No, still incorrect.
> > > > 
> > > > I am a little confused, can you tell in detail?
> > > 
> > > Have you booted a kernel with this change?  Have you run any kind of
> > > tests on it?
> > 
> > Yes, I boot it with qemu-system-x86_64-4.1.50 on ubuntu20.04:
> > qemu-system-x86_64 -kernel /home/rlk/workspace/compile/out/arch/x86_64/boot/bzImage -hda \
> >  /home/rlk/myspace/qemu_build/rootfs.img -append "root=/dev/sda console=ttyS0" -nographic
> > 
> > using the kernel compiled with ubuntu20.04's default .config.
> > 
> > It seems nothing abnormal.
> > And i did not do other test.
> 
> Maybe you should ... how about LTP?  I think that's pretty straightforward
> to set up and run.

Thanks for your advice, Matthew.

I will set up an ltp test envirment, thanks again.

And Please ignore this change for now.

