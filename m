Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC81C5400
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 13:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgEELKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 07:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgEELKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:10:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E3C0206D7;
        Tue,  5 May 2020 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588677030;
        bh=GczSjg2mY+zVUBwyK+x5JROwfYQz7w+f1HqDD4SgsRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCwki1USRAmdS8aGyCPfJLL9E0Xi+2JLTACEEI3+u+VJjiE0S1JA2cFDtoV+JBCFM
         6aaBfjDN/9N1JrYxckDC1PQ9cxInamd/QsLMvCTI4Dp4PZTOy+JUXzMkDjcroWR8PE
         F/61FnIJ3qm1kmp5PKmLOZtQccMbeD6Mk8Pxi2X4=
Date:   Tue, 5 May 2020 13:10:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sean.wang@mediatek.com
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, sr@denx.de, arnd@arndb.de,
        matthias.bgg@gmail.com, tthayer@opensource.altera.com,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v3] tty: serial: don't do termios for BTIF
Message-ID: <20200505111028.GA114206@kroah.com>
References: <cc41ea10be9ab96568f0371784e3b9f8d9f434b9.1587577548.git.sean.wang@mediatek.com>
 <20200422180900.GA3454664@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422180900.GA3454664@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 08:09:00PM +0200, Greg KH wrote:
> On Thu, Apr 23, 2020 at 02:02:08AM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Bluetooth Interface (BTIF) is designed dedicatedly for MediaTek SOC with
> > BT in order to be instead of the UART interface between BT module and Host
> > CPU, and not exported to user space to access.
> > 
> > As the UART design, BTIF will be an APB slave and can transmit or receive
> > data by MCU access, but doesn't provide termios function like baudrate and
> > flow control setup.
> 
> Why does it matter?  If the connection isn't exported to userspace, who
> would run those termios functions on the port?

Dropping from my patch queues due to a lack of response, please address
this question when you resend this.

greg k-h
