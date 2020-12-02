Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF72CB4A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgLBFnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:43:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgLBFnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:43:04 -0500
Date:   Wed, 2 Dec 2020 06:42:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606887743;
        bh=HbG+x30kbOrygkg5sexkj7WcPpceKosMRoLa5l3XhcQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJUgzw9FI0iexqKCQsPbw4glZsF6l3lV/YCm3d1CT7llv7nkpgNwUBaIRbNc3dJAV
         WCdV9FePi5rzLxU6fICuI4j1eoL3Jq5meiQKbx9YW4ptZdrnoA6AjFvO04JwBTPTO/
         7s4lPXYb6XFkK9anes8HzwPy0NNNbpbDJE0t4Y0w=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ertza Warraich <ertza.afzal@gmail.com>
Cc:     balbi@kernel.org, sorganov@gmail.com, mirq-linux@rere.qmqm.pl,
        fabrice.gasnier@st.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kt0755@gmail.com,
        dave.jing.tian@gmail.com
Subject: Re: memory leak in gs_start_io
Message-ID: <X8cpO9caQCX6XGU9@kroah.com>
References: <CAD+hOzs6To=P7z=fYNLDHW-9ZksnykJW2cAWCCVhUGne5C21iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+hOzs6To=P7z=fYNLDHW-9ZksnykJW2cAWCCVhUGne5C21iA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:45:20PM -0500, Ertza Warraich wrote:
> We report a memory leak bug (in linux-5.8.13) found by FuzzUSB (a modified
> version of syzkaller).
> 
> The bug report is as follows:
> ==================================================================
> BUG: memory leak
> unreferenced object 0xffff888069c12000 (size 128):
>  comm "c4_fuzz", pid 2628, jiffies 4294945547 (age 774.450s)
>  hex dump (first 32 bytes):
>   b8 80 48 65 80 88 ff ff 00 7c f9 5b 80 88 ff ff ..He.....|.[....
>   00 7c af 64 80 88 ff ff 00 02 00 00 00 00 00 00 .|.d............
>  backtrace:
>   [<000000008f105b01>] kmemleak_alloc_recursive include/linux/kmemleak.h:43
> [inline]
>   [<000000008f105b01>] slab_post_alloc_hook mm/slab.h:588 [inline]
>   [<000000008f105b01>] slab_alloc_node mm/slub.c:2824 [inline]
>   [<000000008f105b01>] slab_alloc mm/slub.c:2832 [inline]
>   [<000000008f105b01>] kmem_cache_alloc_trace+0xfe/0x330 mm/slub.c:2849
>   [<0000000081072efc>] kmalloc include/linux/slab.h:555 [inline]
>   [<0000000081072efc>] kzalloc include/linux/slab.h:669 [inline]
>   [<0000000081072efc>] dummy_alloc_request+0xa0/0x190
> drivers/usb/gadget/udc/dummy_hcd.c:663
>   [<00000000b14438ed>] usb_ep_alloc_request+0x65/0x2c0
> drivers/usb/gadget/udc/core.c:178
>   [<000000006b6ab221>] gs_alloc_req+0x28/0xd0
> drivers/usb/gadget/function/u_serial.c:166
>   [<00000000999f9b54>] gs_alloc_requests+0x207/0x2f0
> drivers/usb/gadget/function/u_serial.c:517
>   [<00000000eae934b0>] gs_start_io+0x134/0x2a0
> drivers/usb/gadget/function/u_serial.c:555
>   [<00000000eec10774>] gs_open+0x323/0x440
> drivers/usb/gadget/function/u_serial.c:640
>   [<00000000c27493c6>] tty_open+0x23c/0x870 drivers/tty/tty_io.c:2048
>   [<0000000001954030>] chrdev_open+0x1e9/0x5b0 fs/char_dev.c:414
>   [<000000002321ec1f>] do_dentry_open+0x434/0xf40 fs/open.c:828
>   [<000000000de9bc50>] vfs_open+0x9a/0xc0 fs/open.c:942
>   [<00000000b1e25f2d>] do_open fs/namei.c:3243 [inline]
>   [<00000000b1e25f2d>] path_openat+0x1658/0x2570 fs/namei.c:3360
>   [<00000000b7cea3b5>] do_filp_open+0x15e/0x210 fs/namei.c:3387
>   [<00000000793cea2f>] do_sys_openat2+0x2e0/0x570 fs/open.c:1179
>   [<0000000067f289f1>] do_sys_open+0x88/0xc0 fs/open.c:1195
>   [<00000000937c31df>] ksys_open include/linux/syscalls.h:1388 [inline]
>   [<00000000937c31df>] __do_sys_open fs/open.c:1201 [inline]
>   [<00000000937c31df>] __se_sys_open fs/open.c:1199 [inline]
>   [<00000000937c31df>] __x64_sys_open+0x79/0xb0 fs/open.c:1199
> ==================================================================

Nice, care to make up a fix for this now that you have a reproducer?

thanks,

greg k-h
