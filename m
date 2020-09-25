Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C1277FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 07:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgIYFKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 01:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgIYFKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 01:10:36 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F19C2074B;
        Fri, 25 Sep 2020 05:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601010635;
        bh=gsfRTqNQ/CMzpSCeg2FHUN3hV7LlLxiSbQbWFtUxbsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqnkqUm/ARnaTL4riT/XCqvJiEh0v3EHeccYOka/8WjWetSVfob758Zn4cxGiN56C
         GbBRdxBLTtGHClvSpgW6FqRM3k8hIawuJhy7rlL3kERiAkFWVPK3o/VmsnEaQp4qeH
         lY5F4IRdodylkGUPQWvMkH7pBp3OnYRyn924xP5c=
Date:   Fri, 25 Sep 2020 07:10:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v3 2/3] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200925051031.GA603947@kroah.com>
References: <20200825194400.28960-1-scott.branden@broadcom.com>
 <20200825194400.28960-3-scott.branden@broadcom.com>
 <20200907125530.GC2371705@kroah.com>
 <767f6b6a-07fc-f1b6-f43c-b974761f1505@broadcom.com>
 <20200924050851.GA271310@kroah.com>
 <8ce85527-cb0a-7cf4-541b-b346e060e772@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ce85527-cb0a-7cf4-541b-b346e060e772@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:40:08PM -0700, Scott Branden wrote:
> > Ugh, yes, it is uncommon because those are two different things.  Why do
> > you need/want a misc driver to control a tty device?  Why do you need a
> > tty device?  What really is this beast?
> The beast consists of a PCI card.  The PCI card communicates to the host via shared memory in BAR space and MSIX interrupts.
> The host communicates through shared memory in BAR space and generates mailbox interrupts.

That describes any PCI card :)

> In addition the PCI card has DMA access to host memory to access data for processing.
> The misc driver handles these operations.  Multiple user space processes are accessing the misc device at the same time
> to perform simultaenous offload operations.  Each process opens the device and sends multiple commands with write operations
> and receives solicited and unsolicited responses read read operations.  In addition there are sysfs entries to collect statistics and errors.
> Ioctl operations are present for loading new firmware images to the card and reset operations.
> 
> In addition, the card has multiple physical UART connections to access consoles on multi processors on the card.
> But, in a real system there is no serial cable connected from the card to the server.  And, there could be 16 PCIe cards
> plugged into a server so that would make it even more unrealistic to access these consoles via a UART.
> 
> Fortunately the data sent out to each physical UART exists in a circular buffer.  These circular buffer can be access via the host in BAR space.
> So we added tty device nodes per UART (2 per PCIe).  These are not the misc device node, these are seperate tty device nodes that are opened
> and behave like tty devices.
> 
> We are not using the misc driver to control tty.
>   1) The PCI driver is the foundaton of it which provides the physical interface to the card, 2) misc driver is a presentation to user space to do its regular message - this allows user to treat it as a char-device, so its like fopen/read/write/close etc. and 3) tty is an additional debug channel which could be on or off.
> 
> Please suggest how we can access the misc device and tty device nodes other than how we have implemented it in a single driver?

You haven't described what the card actually is for.  You describe how
you have tried to hook it up to userspace, but what is the use-case
here?  Why even have a kernel driver at all and not do everything in a
uio driver?

Creating random misc devices and tty devices implies that the device
does not fit into any of the different existing kernel apis, so you need
to write your own "special" one, which is always worrying.

Without actually knowing what this device is, it's hard to judge if you
really should be using something existing or not.

thanks,

greg k-h
