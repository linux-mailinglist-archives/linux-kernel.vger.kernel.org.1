Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC7128811C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgJIEXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgJIEXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:23:05 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 831B422227;
        Fri,  9 Oct 2020 04:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602217384;
        bh=tXVziVcpOhf6tWJihgW01JnDYKr9Ouw7usaFWe60NHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y5E+tIHg/r/GyohVPGzuGmMAibpmcOJe6E2bjXVrdbp3YWQVNnC8rqLgSlc8QTAoQ
         cg5W4q8g6RbLB/F9grDixegMpJjZFgPJv9guSuf0TODXkv6WhbmSdQJoXqNUoW17T1
         oQcZy4DrDFzcoDMBBYpIbLV5jLSugfr0gQMWrbpk=
Date:   Thu, 8 Oct 2020 21:23:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Fix general protection fault in
 unlink_file_vma()
Message-Id: <20201008212304.e631c002648525a5ce54a102@linux-foundation.org>
In-Reply-To: <8d3d451883a44f608173fe651b7e6718@huawei.com>
References: <8d3d451883a44f608173fe651b7e6718@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Oct 2020 07:17:18 +0000 linmiaohe <linmiaohe@huawei.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Wed, 16 Sep 2020 05:07:33 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
> >
> >> The syzbot reported the below general protection fault:
> >> 
> >> general protection fault, probably for non-canonical address
> >> 0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
> >> KASAN: maybe wild-memory-access in range 
> >> [0x00777770000001d8-0x00777770000001df]
> >> CPU: 1 PID: 10488 Comm: syz-executor721 Not tainted 
> >> 5.9.0-rc3-syzkaller #0
> >> Trace:
> >>  free_pgtables+0x1b3/0x2f0 mm/memory.c:415
> >>  exit_mmap+0x2c0/0x530 mm/mmap.c:3184
> >>  __mmput+0x122/0x470 kernel/fork.c:1076
> >> 
> >> It's because the ->mmap() callback can change vma->vm_file and fput 
> >> the original file. But the commit d70cec898324 ("mm: mmap: merge vma 
> >> after
> >> call_mmap() if possible") failed to catch this case and always fput() 
> >> the original file, hence add an extra fput().
> >> 
>
> ...
>
> >
> >is this using the correct file?  I think it is, but please do check.
> >
> 
> Many thanks for your reply.
> 
> Yes, I think so too. We do deny_write_access and mapping_map_writable on @file, so we should undo all of this on @file.
> Since @file is unchanged over the second vma_merge() time, we'are using the correct @file to undo our temporary denial count.
> 
> But how should I check this explicitly ? I can't find out a way to do this. Could you please figure it out for me?

I meant "please check (review) the code as it now is", not "please add
a check" ;)

