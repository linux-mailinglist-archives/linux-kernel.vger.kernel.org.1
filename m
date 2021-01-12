Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03F2F37E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391486AbhALSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbhALSER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:04:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F02723123;
        Tue, 12 Jan 2021 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610474617;
        bh=CXtTcDMuyJD2uPirDqK5vWUSu3wwkH20NJhizi4U4aM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=py0yJMeXZCkp4tAV79O/A3LzLfLUOLetX0P9q2IvrUZS3lICBhXdv4/RlJ3wNhzM9
         Tn1Tv+sygfgy0pQq2erRU6ubFwb2tBIwXvQhjhACY6UeuYk/u6q/9w6ET4WKiv5wgN
         YlaPiRecGtsXsiFml0uQ82mLJKVjbNmmTPqjVVaQ=
Date:   Tue, 12 Jan 2021 19:04:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: Infinite recursion in device_reorder_to_tail() due to circular
 device links
Message-ID: <X/3kveeVrb35qsvb@kroah.com>
References: <X/ycQpu7NIGI969v@gerhold.net>
 <CAJZ5v0gAsZ45O8mv-gz0UvbyxnKA6fQBYvambBYEH6OSk3-m3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gAsZ45O8mv-gz0UvbyxnKA6fQBYvambBYEH6OSk3-m3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 03:32:04PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 11, 2021 at 7:46 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > Hi,
> >
> > since 5.11-rc1 I get kernel crashes with infinite recursion in
> > device_reorder_to_tail() in some situations... It's a bit complicated to
> > explain so I want to apologize in advance for the long mail. :)
> >
> >   Kernel panic - not syncing: kernel stack overflow
> >   CPU: 1 PID: 33 Comm: kworker/1:1 Not tainted 5.11.0-rc3 #1
> >   Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> >   Call trace:
> >    ...
> >    device_reorder_to_tail+0x4c/0xf0
> >    device_reorder_to_tail+0x98/0xf0
> >    device_reorder_to_tail+0x60/0xf0
> >    device_reorder_to_tail+0x60/0xf0
> >    device_reorder_to_tail+0x60/0xf0
> >    ...
> >
> > The crash happens only in 5.11 with commit 5b6164d3465f ("driver core:
> > Reorder devices on successful probe"). It stops happening when I revert
> > this commit.
> 
> Thanks for the report!
> 
> Greg, please revert commit 5b6164d3465f, it clearly is not an
> improvement, at least at this point.

Now reverted, thanks.

greg k-h
