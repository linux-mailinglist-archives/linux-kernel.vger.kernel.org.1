Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6240E2F4B42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbhAMM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAMM15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:27:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C13112313E;
        Wed, 13 Jan 2021 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610540836;
        bh=aQTYqUon9yZQP1mKlj+yBr5XBmjPJ0mDRQ+vcG+TeHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMyiCcIzUpdGq79XKDPJ2t23VXkWJ+Z9yH/LL3CAkaWtE26HaMy/gnBW8R371V80L
         LyrD4XVb4JbndC9S6niTQ+SA0v9ciVVu/xpgxVp4SNa/hJ5sInZv78y0pgztnghupq
         FPpMWIrZA5YzaEucjGw5lhGgieqJB1czrwvXRt70=
Date:   Wed, 13 Jan 2021 13:28:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, landy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        indranilghsh428@gmail.com, stephen@networkplumber.org
Subject: Re: [BUG]: Kernel 4.9: Kernel crash at fs/sysfs/file.c :
 sysfs_kf_seq_show
Message-ID: <X/7nZjjJ3doGT3XO@kroah.com>
References: <CAOuPNLiUBhJdsgw9bjQxxhkeBHQFoE_vN_Na6kw3ksr89r+HOg@mail.gmail.com>
 <X/2Rr5LDNbxGz456@kroah.com>
 <CAOuPNLiVP2d29td0b20Tx7=UBy5fGk5S9Yt=usUH+VtSYORe+w@mail.gmail.com>
 <X/7m4787HEIcxZzm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/7m4787HEIcxZzm@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 01:26:11PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 13, 2021 at 05:35:18PM +0530, Pintu Agarwal wrote:
> > On Tue, 12 Jan 2021 at 17:39, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jan 12, 2021 at 05:31:54PM +0530, Pintu Agarwal wrote:
> > > > Hi,
> > > >
> > > > I am using Kernel: 4.9.217 for one of the ARM32 boards for Qualcomm SOC.
> > > > https://github.com/android-linux-stable/msm-4.9
> > > >
> > > > But I think this is a general bug applicable to :Kernel 4.9 under
> > > > fs/sysfs/file.c
> > > > So, I wanted to quickly check here if others are familiar with this
> > > > issue and if it is fixed already.
> > > > Note, this issue does not occur in 4.14 Kernel.
> > > >
> > > > When I execute below command, the Kernel is crashing.
> > > > I tried to add few debug prints to find more details. I see that the
> > > > ops->show pointer is not valid (seems corrupted).
> > > > So I wanted to understand how this can happen only for this particular node.
> > > > Other sysfs entries are working fine.
> > > >
> > 
> > I see that this issue was reported earlier as well by others.
> > https://syzkaller.appspot.com/bug?id=2ec2a9da5c711df3d3d12071bac487b96e75e103
> > https://gitlab.freedesktop.org/drm/amd/-/issues/413
> > https://bugzilla.redhat.com/show_bug.cgi?id=1615070
> > 
> > So it seems to be common issue and thus I wanted to check here if its similar.
> 
> It's "common" in that this is core kernel code that any number of
> drivers could be causing to work incorrectly.  Try fixing up the driver
> code, and odds are, that will fix this issue.
> 
> good luck, and again, go ask for support from your vendor, you are
> paying for that!

And, if you look close at the above links, you will see where the error
is, and what the out-of-tree code needs to to do be fixed up properly.
An exercise for that is left for the vendor :)

greg k-h
