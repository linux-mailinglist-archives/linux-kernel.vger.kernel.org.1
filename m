Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B21D2103F2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgGAG32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 02:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgGAG32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:29:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F3620663;
        Wed,  1 Jul 2020 06:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593584967;
        bh=X4+vca/mUEA3Y8838Ax2riljRXkrSPU/HPvLo+gSwbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qiGctaDPPI8hFBXPaYIWEaSsKU1t1MzJjxya1cH+T0AEuQifvhCdyX9bEHNvoua4W
         NZB0lRvH1hb3X9DrBFJZC6cgh2Q6WS5WylFVtB6tXY/1Oiuz8vk1TJS+vNqNdmCgLc
         g7z7cj0OeB1BkyJrjFjIF7ywp2WCFtidu6KYA5iA=
Date:   Wed, 1 Jul 2020 08:29:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Chen <hzpeterchen@gmail.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: Fix up terminology
Message-ID: <20200701062924.GA5927@kroah.com>
References: <20200630174123.GA1906678@kroah.com>
 <CAL411-pgboix6=1=jKNv_4JaHiC8fKDJ4_mryooMepeHdB-2AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL411-pgboix6=1=jKNv_4JaHiC8fKDJ4_mryooMepeHdB-2AA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 02:02:00PM +0800, Peter Chen wrote:
> > index 3a7179e90f4e..1a12aab208b4 100644
> > --- a/drivers/usb/gadget/udc/Kconfig
> > +++ b/drivers/usb/gadget/udc/Kconfig
> > @@ -474,7 +474,7 @@ config USB_DUMMY_HCD
> >         help
> >           This host controller driver emulates USB, looping all data transfer
> >           requests back to a USB "gadget driver" in the same host.  The host
> > -         side is the master; the gadget side is the slave.  Gadget drivers
> > +         side is the controller; the gadget side is the device.  Gadget drivers
> 
> 'the host side is the controller' may not be suitable.

Really?  It is literally a "host controller" as per the specification :)
