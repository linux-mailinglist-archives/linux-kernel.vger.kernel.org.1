Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F9E2ED38F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbhAGPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbhAGPcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:32:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BA82224B0;
        Thu,  7 Jan 2021 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610033527;
        bh=NZtyObdR8HefKUjaAfSACqgjP6+9Z8dsbVFTUCoYr/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUmZx35wHdbvCyanvjhILu995ykmq/VmJyAfrzvzV6G6FyV+zHIeEp52zP1IBi01k
         0aoDqiAqg1okw32W7F4R6rN1GN6xm556wRjoHf34kmD6FsmQblo/b6PWOf204fxRoc
         ZGexQp8YD9cWF+GQMA7Ct/kbTZs1lhZwZ5y7/HJM=
Date:   Thu, 7 Jan 2021 16:33:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Yan.Gao" <gao.yanB@h3c.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        tian.xianting@h3c.com
Subject: Re: [PATCH] tty: Protect disc_data in n_tty_close and
 n_tty_flush_buffer
Message-ID: <X/cpxtrOkeq1QTMJ@kroah.com>
References: <20201209095921.40248-1-gao.yanB@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209095921.40248-1-gao.yanB@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 05:59:21PM +0800, Yan.Gao wrote:
> n_tty_flush_buffer can happen in parallel with n_tty_close that the
> tty->disc_data will be set to NULL. n_tty_flush_buffer accesses
> tty->disc_data, so we must prevent n_tty_close clear tty->disc_data
> while n_tty_flush_buffer  has a non-NULL view of tty->disc_data.
> 
> So we need to make sure that accesses to disc_data are atomic using
> spinlock.
> 
> There is an example I meet:
> When n_tty_flush_buffer accesses tty struct, the disc_data is right.
> However, then reset_buffer_flags accesses tty->disc_data, disc_data
> become NULL, So kernel crash when accesses tty->disc_data->real_tail.
> I guess there could be another thread change tty->disc_data to NULL,
> and during N_TTY line discipline, n_tty_close will set tty->disc_data
> to be NULL. So add spinlock to protect disc_data between close and
> flush_buffer.
> 
> IP: reset_buffer_flags+0x9/0xf0
> PGD 0 P4D 0
> Oops: 0002 [#1] SMP
> CPU: 23 PID: 2087626 Comm: (agetty) Kdump: loaded Tainted: G
> Hardware name: UNISINSIGHT X3036P-G3/ST01M2C7S, BIOS 2.00.13 01/11/2019
> task: ffff9c4e9da71e80 task.stack: ffffb30cfe898000
> RIP: 0010:reset_buffer_flags+0x9/0xf0
> RSP: 0018:ffffb30cfe89bca8 EFLAGS: 00010246
> RAX: ffff9c4e9da71e80 RBX: ffff9c368d1bac00 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff9c4ea17b50f0 RDI: 0000000000000000
> RBP: ffffb30cfe89bcc8 R08: 0000000000000100 R09: 0000000000000001
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff9c368d1bacc0
> R13: ffff9c20cfd18428 R14: ffff9c4ea17b50f0 R15: ffff9c368d1bac00
> FS:  00007f9fbbe97940(0000) GS:ffff9c375c740000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000002260 CR3: 0000002f72233003 CR4: 00000000007606e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> ? n_tty_flush_buffer+0x2a/0x60
> tty_buffer_flush+0x76/0x90
> tty_ldisc_flush+0x22/0x40
> vt_ioctl+0x5a7/0x10b0
> ? n_tty_ioctl_helper+0x27/0x110
> tty_ioctl+0xef/0x8c0
> do_vfs_ioctl+0xa7/0x5e0
> ? __audit_syscall_entry+0xaf/0x100
> ? syscall_trace_enter+0x1d0/0x2b0
> SyS_ioctl+0x79/0x90
> do_syscall_64+0x6c/0x1b0
> entry_SYSCALL64_slow_path+0x25/0x25
> 
> n_tty_flush_buffer			--->tty->disc_data is OK
> 	->reset_buffer_flags		 -->tty->disc_data is NULL
> 
> Signed-off-by: Yan.Gao <gao.yanB@h3c.com>
> Reviewed-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  drivers/tty/n_tty.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 7e5e36315..f4b152f20 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -87,6 +87,8 @@
>  # define n_tty_trace(f, args...)	no_printk(f, ##args)
>  #endif
>  
> +static DEFINE_SPINLOCK(disc_data_lock);

Single static locks for individual structures are not ok.

We lock data, not code.

thanks,

greg k-h
