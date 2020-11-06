Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48D32A9A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgKFRDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:03:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgKFRDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:03:17 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144F1217A0;
        Fri,  6 Nov 2020 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604682196;
        bh=8qTMHsqw2tR8BoQH69u5hejd4jKL4a4QMXrqYRaNg2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3BaJyxzuCBZbIOZIZY7xuDiyfkm8O9vsQYyOHW4HoTKjkHlisX4Oc7uhcEX+WL6P
         JITz0WXmSDjg4a7xRaVxCgTCiorGnORl9TVpCL8OaHSt2c1JP+UEhj+4WcquA7pAVs
         kNEEkSv25vkK5tvP+O2XqTk/qa/XqfyZ2zMg1oX8=
Date:   Fri, 6 Nov 2020 09:03:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com>,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in input_register_device
Message-ID: <20201106170314.GA845@sol.localdomain>
References: <000000000000872b5405b36f8e31@google.com>
 <20201106140336.GA3319902@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106140336.GA3319902@kroah.com>
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
> 

The purpose of WARN is for reporting recoverable kernel bugs.  So a reachable
WARN is a bug.  Either it is reporting one, or the bug is that the use of WARN
is wrong.

- Eric
