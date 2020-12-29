Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF72E7255
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgL2QeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:34:21 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43798 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL2QeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:34:20 -0500
Received: by mail-il1-f198.google.com with SMTP id p6so13086706ils.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 08:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=EFfgNxkfZjI3W05xP8woi9UafXhF5/XF3WHVCjqhRsM=;
        b=pcSRxZ3dx5Q0XK38Yb0//Jz6U8eWQcTkB5lSIo7KSTdK85DjL1tVwu9bpDz+fa1dYN
         C+hFwC++fZAh8TSQQdp1OOIxccQFghMIrpiPm4aIUy2n1LmELqjWmbh9nLp82VvY7rhM
         yj0BknmcM4WqrhVEFDK9RRMQrNAqqxPM81XPtHrjMafYLIXaXnEWeTXvVRkABuzY4fAV
         60a/UncH5umTLGlruOb7PSImz7g8vaEfVCllu8J40mLAwgjDGiTgPU3EpshBhh3brqdx
         8lGoTImMtmkZYmOSmx7ttEzRrFrcuiDdWRgr+EG+nK7FgjsC4JgDHXc0u+Lh6Xw8sk70
         +1eQ==
X-Gm-Message-State: AOAM530L/o8E2TS22WkoC4j9mN9jfvSL8iNyf/1yL2tCtUrMSeucC9HL
        2qSBXZFlugi4rg6koeWvdapIlGVRkGDkDwQd2997xo+UhQJW
X-Google-Smtp-Source: ABdhPJyq1+OtYNfYLP0Onprkr7aVagzh41XCaqAluLFJV79jzsGVe0S9IpEOyZwAGm5SE8SY1iZ8cpgmzAjcVtsOAK/O8a7xo2H5
MIME-Version: 1.0
X-Received: by 2002:a92:155b:: with SMTP id v88mr49464648ilk.303.1609259619418;
 Tue, 29 Dec 2020 08:33:39 -0800 (PST)
Date:   Tue, 29 Dec 2020 08:33:39 -0800
In-Reply-To: <20201229163337.GA694118@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7882005b79cf3a6@google.com>
Subject: Re: Re: UBSAN: shift-out-of-bounds in dummy_hub_control
From:   syzbot <syzbot+5925509f78293baa7331@syzkaller.appspotmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     andreyknvl@gmail.com, andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 25, 2020 at 12:05:22PM -0800, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    e37b12e4 Merge tag 'for-linus-5.11-ofs1' of git://git.kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17429937500000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=98408202fed1f636
>> dashboard link: https://syzkaller.appspot.com/bug?extid=5925509f78293baa7331
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1781fc5b500000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157cd123500000
>> 
>> The issue was bisected to:
>> 
>> commit 8442b02bf3c6770e0d7e7ea17be36c30e95987b6
>> Author: Andrey Konovalov <andreyknvl@google.com>
>> Date:   Mon Oct 21 14:20:58 2019 +0000
>> 
>>     USB: dummy-hcd: increase max number of devices to 32
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1631d0db500000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1531d0db500000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1131d0db500000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+5925509f78293baa7331@syzkaller.appspotmail.com
>> Fixes: 8442b02bf3c6 ("USB: dummy-hcd: increase max number of devices to 32")
>> 
>> ================================================================================
>> UBSAN: shift-out-of-bounds in drivers/usb/gadget/udc/dummy_hcd.c:2293:33
>> shift exponent 257 is too large for 32-bit type 'int'
>> CPU: 0 PID: 8526 Comm: syz-executor949 Not tainted 5.10.0-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:79 [inline]
>>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>>  ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>>  __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
>>  dummy_hub_control.cold+0x1a/0xbc drivers/usb/gadget/udc/dummy_hcd.c:2293
>>  rh_call_control drivers/usb/core/hcd.c:683 [inline]
>>  rh_urb_enqueue drivers/usb/core/hcd.c:841 [inline]
>>  usb_hcd_submit_urb+0xcaa/0x22d0 drivers/usb/core/hcd.c:1544
>>  usb_submit_urb+0x6e4/0x1560 drivers/usb/core/urb.c:585
>>  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>>  do_proc_control+0x4cb/0x9c0 drivers/usb/core/devio.c:1165
>>  proc_control drivers/usb/core/devio.c:1191 [inline]
>>  usbdev_do_ioctl drivers/usb/core/devio.c:2535 [inline]
>>  usbdev_ioctl+0x12c1/0x3b20 drivers/usb/core/devio.c:2708
>>  vfs_ioctl fs/ioctl.c:48 [inline]
>>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>>  __se_sys_ioctl fs/ioctl.c:739 [inline]
>>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
>>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> RIP: 0033:0x443f29
>> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007ffc10df4328 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443f29
>> RDX: 0000000020000000 RSI: 00000000c0185500 RDI: 0000000000000003
>> RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
>> R10: 000000000000000f R11: 0000000000000246 R12: 0000000000401bb0
>> R13: 0000000000401c40 R14: 0000000000000000 R15: 0000000000000000
>> ================================================================================
>
> The cause is pretty obvious.  dummy-hcd assumes that requests sent to 
> the root hub are always valid, which isn't always true when they come 
> from userspace.
>
> Alan Stern
>
> #syz test: upstream e37b12e4

"upstream" does not look like a valid git repo address.

>
> Index: usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
> ===================================================================
> --- usb-devel.orig/drivers/usb/gadget/udc/dummy_hcd.c
> +++ usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -2114,9 +2114,21 @@ static int dummy_hub_control(
>  				dum_hcd->port_status &= ~USB_PORT_STAT_POWER;
>  			set_link_state(dum_hcd);
>  			break;
> -		default:
> +		case USB_PORT_FEAT_ENABLE:
> +		case USB_PORT_FEAT_C_ENABLE:
> +		case USB_PORT_FEAT_C_SUSPEND:
> +			/* Not allowed for USB-3 */
> +			if (hcd->speed == HCD_USB3)
> +				goto error;
> +			fallthrough;
> +		case USB_PORT_FEAT_C_CONNECTION:
> +		case USB_PORT_FEAT_C_RESET:
>  			dum_hcd->port_status &= ~(1 << wValue);
>  			set_link_state(dum_hcd);
> +			break;
> +		default:
> +		/* Disallow INDICATOR and C_OVER_CURRENT */
> +			goto error;
>  		}
>  		break;
>  	case GetHubDescriptor:
> @@ -2277,18 +2289,17 @@ static int dummy_hub_control(
>  			 */
>  			dum_hcd->re_timeout = jiffies + msecs_to_jiffies(50);
>  			fallthrough;
> +		case USB_PORT_FEAT_C_CONNECTION:
> +		case USB_PORT_FEAT_C_RESET:
> +		case USB_PORT_FEAT_C_ENABLE:
> +		case USB_PORT_FEAT_C_SUSPEND:
> +			/* Not allowed for USB-3, and ignored for USB-2 */
> +			if (hcd->speed == HCD_USB3)
> +				goto error;
> +			break;
>  		default:
> -			if (hcd->speed == HCD_USB3) {
> -				if ((dum_hcd->port_status &
> -				     USB_SS_PORT_STAT_POWER) != 0) {
> -					dum_hcd->port_status |= (1 << wValue);
> -				}
> -			} else
> -				if ((dum_hcd->port_status &
> -				     USB_PORT_STAT_POWER) != 0) {
> -					dum_hcd->port_status |= (1 << wValue);
> -				}
> -			set_link_state(dum_hcd);
> +		/* Disallow TEST, INDICATOR, and C_OVER_CURRENT */
> +			goto error;
>  		}
>  		break;
>  	case GetPortErrorCount:
