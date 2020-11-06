Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8069B2A975A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgKFOCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgKFOCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:02:51 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB25F2071A;
        Fri,  6 Nov 2020 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604671370;
        bh=4TNhoFgbkYDg/ATGQUj1QVX+p4y66uD0YFZPpI+QAk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zJoL4Zqmg1SI1OxFRn4eXqsYOFfgargZscnuTTmKL4TwA5O0YEZNOt3ekh6tUsALO
         zmlUUtm814/OAKmTOOJZo99DKtL5u3iKRxvdavg0p3X61C9NmiBkNqiNQtkAXGuZqI
         i9jT9FAhLOaecZvQQj2ydVYQJOhecKmbM8XuPNCk=
Date:   Fri, 6 Nov 2020 15:03:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in input_register_device
Message-ID: <20201106140336.GA3319902@kroah.com>
References: <000000000000872b5405b36f8e31@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000872b5405b36f8e31@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 04:43:17AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9e39aef3 usb: misc: brcmstb-usb-pinmap: Make sync_all_pins..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=145ffa8a500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a05f5efbb00b1465
> dashboard link: https://syzkaller.appspot.com/bug?extid=92340f7b2b4789907fdb
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172ae7a8500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b24746500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+92340f7b2b4789907fdb@syzkaller.appspotmail.com
> 
> microsoft 0003:045E:07DA.0001: unknown main item tag 0x0
> HID 045e:07da: Invalid code 65791 type 1
> ------------[ cut here ]------------
> init_uevent_argv: buffer size too small
> WARNING: CPU: 0 PID: 5 at lib/kobject_uevent.c:259 init_uevent_argv lib/kobject_uevent.c:259 [inline]
> WARNING: CPU: 0 PID: 5 at lib/kobject_uevent.c:259 kobject_uevent_env+0x1640/0x1680 lib/kobject_uevent.c:608

You gave it a device with a buffer that was "too small", and it rejected
it.

Which, aside from the huge warning message, is to be expected, so I
don't think this is really a bug here.

thanks,

greg k-h
