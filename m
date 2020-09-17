Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE526DFD1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgIQPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbgIQPYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:24:04 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08302075B;
        Thu, 17 Sep 2020 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600356243;
        bh=VQrKB0M8C0OLRLnfDiXt9ur+vgkb9cWELt8+8NHidwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYOe6ostHpqNNmiFVi+8ZXveTAMe1riUHwnmGMoAmpMgX6sSEXmzTXV9DPVAFjBpV
         RdtP75lLcmfjKrnQGW3mGfRWPclQiqTEBPYrYrf+MlZMvk7rDFO3nz7s0mI31Zl62C
         6OZmVLYgJIwSd9uTD1b3r0oVYGa/FQ0YP0lNmbuU=
Date:   Thu, 17 Sep 2020 08:24:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "\\xcH3332\\" <ch3332xr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: memory leak in getname_flags ( 5.9.0-rc5)
Message-ID: <20200917152402.GA855@sol.localdomain>
References: <CAJ5WPnFq5TrRT9uyjnZdVB_V6doXVGYQQJ3h98cnuRYY6xueQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ5WPnFq5TrRT9uyjnZdVB_V6doXVGYQQJ3h98cnuRYY6xueQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 07:32:12PM +0530, \xcH3332\ wrote:
> Syzkaller hit 'memory leak in getname_flags' bug.
> 
> 
>  5.9.0-rc5
> 
> 
> 2020/09/17 10:31:39 executed programs: 195
> 2020/09/17 10:31:45 executed programs: 204
> 2020/09/17 10:31:50 executed programs: 226
> 2020/09/17 10:31:56 executed programs: 239
> BUG: memory leak
> unreferenced object 0xffff8ba9f42fa000 (size 4096):
>   comm "syz-executor.4", pid 5686, jiffies 4295939335 (age 12.397s)
>   hex dump (first 32 bytes):
>     20 a0 2f f4 a9 8b ff ff 40 02 00 20 00 00 00 00   ./.....@.. ....
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000084fbe16c>] getname_flags+0x57/0x260
>     [<00000000a25b6483>] __io_openat_prep+0x76/0x100
>     [<0000000030fd3f89>] io_openat2_prep.part.0+0x5b/0xb0
>     [<00000000e274bfc6>] io_issue_sqe+0x445/0x1940
>     [<00000000bad7fba6>] __io_queue_sqe+0x189/0x540
>     [<000000000d09a5ef>] io_queue_sqe+0x28f/0x440
>     [<00000000c36c4e95>] io_submit_sqes+0x7e9/0xa90
>     [<00000000a15f6a28>] __x64_sys_io_uring_enter+0x23e/0x350
>     [<00000000449792f4>] do_syscall_64+0x33/0x40
>     [<00000000bdacf1c3>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> 
> Syzkaller reproducer:
> # {Threaded:true Collide:true Repeat:true RepeatTimes:0 Procs:8
> Sandbox:none Fault:false FaultCall:-1 FaultNth:0 Leak:true
> NetInjection:false NetDevices:true NetReset:true Cgroups:true
> BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkPCI:false USB:false
> VhciInjection:false UseTmpDir:true HandleSegv:true Repro:false
> Trace:false}
> r0 = syz_io_uring_setup(0x5bfa, &(0x7f0000000080)={0x0, 0x0, 0x0, 0x2,
> 0x0, 0x0, 0x0}, &(0x7f00000a0000)=nil, &(0x7f00000b0000)=nil,
> &(0x7f0000000100)=<r1=>0x0, &(0x7f0000000140)=<r2=>0x0)
> syz_io_uring_submit(r1, r2,
> &(0x7f00000001c0)=@IORING_OP_OPENAT2={0x1c, 0x0, 0x0,
> 0xffffffffffffff9c, &(0x7f0000000200)={0x42},
> &(0x7f0000000240)='./file1\x00', 0x18, 0x0, 0x12345}, 0x0)
> io_uring_enter(r0, 0x1, 0x1, 0x1, 0x0, 0x0)

You need to send this to the appropriate maintainers:

$ ./scripts/get_maintainer.pl fs/io_uring.c
Jens Axboe <axboe@kernel.dk> (maintainer:IO_URING)
Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and infrastructure))
io-uring@vger.kernel.org (open list:IO_URING)
linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
linux-kernel@vger.kernel.org (open list)
