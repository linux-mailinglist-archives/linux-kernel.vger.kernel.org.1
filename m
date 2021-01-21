Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F212FE98C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbhAUMCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:02:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbhAULTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:19:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91534238E3;
        Thu, 21 Jan 2021 11:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611227930;
        bh=PZuL4K4MYilESgvpiWC4rYkLNV2J+t9XEez4xaSZDhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toli/KAXTTPqeLTr5dhCpZSbbkR/nfPoBwIhlslp/Jr2Ej1AMLBlb8/Np8uj9qh5r
         ckT+4oKqdLY2RKQYnAGZ0EJCvXNhDz2l0w3JVn8zB8vy+O23CVfbdO/4I3UkspLJZN
         fn3hYrpjVDZgEgj+mXiPzIOcWrba1k/zzwq96sV4=
Date:   Thu, 21 Jan 2021 12:18:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: Re: [PATCH] uacce: Add uacce_ctrl misc device
Message-ID: <YAljF+Y4/SxVKmXo@kroah.com>
References: <1611220154-90232-1-git-send-email-wangzhou1@hisilicon.com>
 <YAlNTSOMmsFPFAhk@kroah.com>
 <ea0511c1309a486d9646d5a32715c861@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0511c1309a486d9646d5a32715c861@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:18:24AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> > Sent: Thursday, January 21, 2021 10:46 PM
> > To: Wangzhou (B) <wangzhou1@hisilicon.com>
> > Cc: Zhangfei Gao <zhangfei.gao@linaro.org>; Arnd Bergmann <arnd@arndb.de>;
> > linux-accelerators@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> > chensihang (A) <chensihang1@hisilicon.com>
> > Subject: Re: [PATCH] uacce: Add uacce_ctrl misc device
> > 
> > On Thu, Jan 21, 2021 at 05:09:14PM +0800, Zhou Wang wrote:
> > > When IO page fault happens, DMA performance will be affected. Pin user page
> > > can avoid IO page fault, this patch introduces a new char device named
> > > /dev/uacce_ctrl to help to maintain pin/unpin pages. User space can do
> > > pin/unpin pages by ioctls of an open file of /dev/uacce_ctrl, all pinned
> > > pages under one file will be unpinned in file release process.
> > 
> > Also, what are you really trying to do here?  If you need to mess with
> > memory pages, why can't the existing memory apis work properly for you?
> > Please work with the linux-mm developers to resolve the issue using the
> > standard apis and not creating a one-off char device node for this type
> > of thing.
> 
> Basically the purpose is implementing a pinned memory poll for userspace
> DMA to achieve better performance by removing io page fault.

And what could possibly go wrong with that :)

> I really like this can be done in generic mm code. Unfortunately there is no
> this standard API in kernel to support userspace pin. Right now, various
> subsystems depend on the ioctl of /dev/<name> to implement the pin, for example,
> v4l2, gpu, infiniband, media etc.
> 
> I feel it is extremely hard to sell a standard mpin() API like mlock()
> for this stage as mm could hardly buy this. And it will require
> huge changes in kernel.

Why?  This is what mlock() is for, why can't you use it?

> We need a way to manage what pages are pinned by process and ensure the
> pages can be unpinned while the process is killed abnormally. otherwise,
> memory gets leaked.

Can't mlock() handle that?  It works on the process that called it.

> file_operations release() is a good entry for this kind of things. In
> this way, we don't have to maintain the pinned page set in task_struct
> and unpin them during exit().
> 
> If there is anything to make it better by doing this in a driver. I
> would believe we could have a generic misc driver for pin like
> vms_ballon.c for ballon. The driver doesn't have to bind with uacce.
> 
> In this way, the pinned memory pool implementation in userspace doesn't
> need to depend on a specific uacce driver any more.

Please work with the mm developers to get them to agree with this type
of thing, as well as the dma developers, both of which you didn't cc: on
this patch :(

Remember, you are creating a new api for Linux that goes around existing
syscalls, but is in reality, a new syscall, so why not just make it a
new syscall?

thanks,

greg k-h
