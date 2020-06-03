Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D181EC948
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 08:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCGMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 02:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgFCGMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:12:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FDAC2068D;
        Wed,  3 Jun 2020 06:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591164773;
        bh=UvifAKAvNqqo8Y1bWJVOub1QaT730ONKJ5d4HCpPzWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niqYV5foJ4O18yth7wIZGob3Z4fCgyhekmMeGNCuiP4HKNDShHYnFgFINh4+nVllZ
         Om60cOIOC3OO05cK6RViN/v0cQW5dnErsI5Tam1tw/OEAf2b6OY72kZpoGXX0f5hkS
         xZlrPr7ocohMnia+gWi3ztyirsKRkb6gnwjvtoCk=
Date:   Wed, 3 Jun 2020 08:12:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, balbi@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in snd_usbmidi_submit_urb/usb_submit_urb
Message-ID: <20200603061251.GA531505@kroah.com>
References: <000000000000bbd09005a6fdc6cc@google.com>
 <0000000000000eb4b905a7277a7d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000eb4b905a7277a7d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:41:16PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    1ee08de1 Merge tag 'for-5.8/io_uring-2020-06-01' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f9e516100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b46ebd806238a886
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f1d24c49c1d2c427497
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1667dcca100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f9e516100000
> 
> The bug was bisected to:
> 
> commit f2c2e717642c66f7fe7e5dd69b2e8ff5849f4d10
> Author: Andrey Konovalov <andreyknvl@google.com>
> Date:   Mon Feb 24 16:13:03 2020 +0000
> 
>     usb: gadget: add raw-gadget interface

I thought this "bisect to the tool that finds bugs" issue was fixed :)

