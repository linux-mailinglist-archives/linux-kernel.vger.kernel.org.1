Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598682402F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHJHq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 03:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgHJHqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:46:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF34D2065C;
        Mon, 10 Aug 2020 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597045615;
        bh=d7yZTMaajyYYDp1xUH/+msJ7BOrEiV5LPH4/r1jiZps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUMoQJ0Rj1qEx67OX2Ceqywy2Yyj+2T8X3o+e9FmDy8FR2gT+SJGFsA/UQvR136dN
         CXt3WUVGCc0S2UXFpVGgzG9+umduUDstNjQc4eBhgYIN6uAYIMVf+Jd+R/xGfiV9Y4
         JmfripfRyZPVjP09oPKx/jtALkGprinOP82Pn2Bs=
Date:   Mon, 10 Aug 2020 09:47:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, balbi@kernel.org, dan.carpenter@oracle.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: kernel-infoleak in raw_ioctl
Message-ID: <20200810074706.GD1529187@kroah.com>
References: <000000000000ce85c405ac744ff6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ce85c405ac744ff6@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 09:27:18AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=141eb8b2900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
> dashboard link: https://syzkaller.appspot.com/bug?extid=a7e220df5a81d1ab400e
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.

The irony of a kernel module written for syzbot testing, causing syzbot
reports....

