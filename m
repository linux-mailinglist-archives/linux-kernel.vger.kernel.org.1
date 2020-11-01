Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458802A1B9E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 02:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgKABkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 21:40:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49729 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726335AbgKABkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 21:40:41 -0400
Received: (qmail 1428690 invoked by uid 1000); 31 Oct 2020 21:40:40 -0400
Date:   Sat, 31 Oct 2020 21:40:40 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in do_set_interface
Message-ID: <20201101014040.GA1428475@rowland.harvard.edu>
References: <CAEAjamsqOfgS6-7mt4SGd9rou-QRxzRDfQ_wD6dB3veueXtqgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamsqOfgS6-7mt4SGd9rou-QRxzRDfQ_wD6dB3veueXtqgw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 04:51:09PM -0400, Kyungtae Kim wrote:
> We report a bug (in linux-5.8.13) found by FuzzUSB (a modified version
> of syzkaller).
> 
> The bug happened when accessing a freed instance of struct fsg_dev
> (i.e., fsg->bulk_in) in do_set_interface() (line 2245).
> 
> ==================================================================
> BUG: KASAN: use-after-free in do_set_interface.part.7+0xa6b/0xd90
> drivers/usb/gadget/function/f_mass_storage.c:2245
> Read of size 8 at addr ffff88806bc940f8 by task file-storage/2063
> 
> CPU: 3 PID: 2063 Comm: file-storage Not tainted 5.8.13 #4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xa7/0xea lib/dump_stack.c:118
>  print_address_description.constprop.8+0x3f/0x60 mm/kasan/report.c:383
>  kasan_report.cold.11+0x20/0x37 mm/kasan/report.c:513
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:146
>  do_set_interface.part.7+0xa6b/0xd90
> drivers/usb/gadget/function/f_mass_storage.c:2245
>  do_set_interface drivers/usb/gadget/function/f_mass_storage.c:2202 [inline]
>  handle_exception drivers/usb/gadget/function/f_mass_storage.c:2426 [inline]
>  fsg_main_thread+0x12c7/0x59f1 drivers/usb/gadget/function/f_mass_storage.c:2466
>  kthread+0x374/0x480 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Is this reproducible?  Can you test patches?

Alan Stern
