Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7656220F80A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389314AbgF3PPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 11:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgF3PPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:15:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92F3A20720;
        Tue, 30 Jun 2020 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593530105;
        bh=cijGjigQwhvCARTByc8A38JipYEf0DJx/FmrGjxGEcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxQ6CjyzDekpwaIVA6erERfevDWf1yalbduUhyHaduRgt6RZnlgDktxYz2j+yR5H7
         MWZT3fxjoDDPLSTT7FkIrrl7MoiXGRpVQxZU+uJipO0H1gjsL+jdaHWquGXc+a0GTg
         9i1P1svPpQvHoBhCeo4vnTvF8isXuC55JA38XHRQ=
Date:   Tue, 30 Jun 2020 17:14:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] SPI LPC information kernel module
Message-ID: <20200630151452.GA1780940@kroah.com>
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <20200630085641.GD637809@kroah.com>
 <CAD2FfiHHb=yA6MRsw2rPyJinthhFPNH2k6sLbthxcYVVaX5Mig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiHHb=yA6MRsw2rPyJinthhFPNH2k6sLbthxcYVVaX5Mig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:57:11PM +0100, Richard Hughes wrote:
> On Tue, 30 Jun 2020 at 09:56, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Again, which makes it seem like securityfs is not the thing for this, as
> > it describes the hardware, not a security model which is what securityfs
> > has been for in the past, right?
> 
> It describes the hardware platform. From a fwupd perspective I don't
> mind if the BC attributes are read from securityfs, sysfs or even read
> from an offset in a file from /proc... I guess sysfs makes sense if
> securityfs is defined for things like the LSM or lockdown status,
> although I also thought sysfs was for devices *in* the platform, not
> the platform itself.

Have you looked at /sys/devices/system/ in a while?  :)

> I guess exposing the platform registers in sysfs
> is no more weird than exposing things like the mei device and rfkill.

It is attributes that describe the hardware the system is running on,
which is what sysfs is for.

thanks,

greg k-h
