Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4898D2A9A47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKFRBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:01:44 -0500
Received: from netrider.rowland.org ([192.131.102.5]:37935 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727886AbgKFRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:01:42 -0500
Received: (qmail 47480 invoked by uid 1000); 6 Nov 2020 12:01:19 -0500
Date:   Fri, 6 Nov 2020 12:01:19 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com>,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in input_register_device
Message-ID: <20201106170119.GD47039@rowland.harvard.edu>
References: <000000000000872b5405b36f8e31@google.com>
 <20201106140336.GA3319902@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106140336.GA3319902@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:03:36PM +0100, Greg KH wrote:
> On Fri, Nov 06, 2020 at 04:43:17AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    9e39aef3 usb: misc: brcmstb-usb-pinmap: Make sync_all_pins..
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=145ffa8a500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a05f5efbb00b1465
> > dashboard link: https://syzkaller.appspot.com/bug?extid=92340f7b2b4789907fdb
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172ae7a8500000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b24746500000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com
> > 
> > microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
> > HID 045e:07da: Invalid code 65791 type 1
> > ------------[ cut here ]------------
> > init_uevent_argv: buffer size too small
> > WARNING: CPU: 0 PID: 5 at lib/kobject_uevent.c:259 init_uevent_argv lib/kobject_uevent.c:259 [inline]
> > WARNING: CPU: 0 PID: 5 at lib/kobject_uevent.c:259 kobject_uevent_env+0x1640/0x1680 lib/kobject_uevent.c:608
> 
> You gave it a device with a buffer that was "too small", and it rejected
> it.
> 
> Which, aside from the huge warning message, is to be expected, so I
> don't think this is really a bug here.

The issue is that syzbot thinks "WARNING" indicates a problem in the 
kernel.  If the problem is really in the device then the message should 
say "Warning" instead (not all caps).

Alan Stern
