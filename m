Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FB929DEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403957AbgJ2A6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731575AbgJ1WRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659D22468D;
        Wed, 28 Oct 2020 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603876040;
        bh=kieIkoX3/mUlRkKVpmRvqv/D5gjE+vzEP0MP4l0YFWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBcSruPj8y0wcCeNx8d/CP5d4+ly42T3Ed8nHMPzn7ofyHiwd11xdMlMjHS6MSRCL
         xXPyn7l/fCRm3PUXhRRGSvYWgvksBSB90eYTpgGxM9AIXyI8YPD6hMVXKjaxeDkC7K
         46uMY8tGLdH84GxEJiYMQJ5RMoA9qwjAnImo8Q4c=
Date:   Wed, 28 Oct 2020 10:08:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 31/56] usb: dwc3: fix kernel-doc markups
Message-ID: <20201028090813.GB1947336@kroah.com>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <0b964be3884def04fcd20ea5c12cb90d0014871c.1603469755.git.mchehab+huawei@kernel.org>
 <87ft60dujc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft60dujc.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:58:47AM +0200, Felipe Balbi wrote:
> 
> Hi Mauro,
> 
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > There is a common comment marked, instead, with kernel-doc
> > notation.
> >
> > Also, some identifiers have different names between their
> > prototypes and the kernel-doc markup.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  drivers/usb/dwc3/core.c        | 2 +-
> >  drivers/usb/dwc3/core.h        | 2 +-
> >  drivers/usb/gadget/composite.c | 2 +-
> >  drivers/usb/typec/mux.c        | 2 +-
> >  include/linux/usb/composite.h  | 2 +-
> 
> mind breaking this into 4 commits? One for dwc3, one for
> gadget/composite, one for type/mux, and a final for composite.h.

I'll just take these all at once, it's easy enough :)

thanks,

greg k-h
