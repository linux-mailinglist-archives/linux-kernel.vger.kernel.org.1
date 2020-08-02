Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2850235619
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 11:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHBJSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 05:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHBJSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 05:18:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EFFF2075A;
        Sun,  2 Aug 2020 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596359928;
        bh=0sI0cWie9tDag5hLKiiEIxgczqIVsId5Urn4Kg/NpKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjHZNGLz0TbQXYhHdW6OWrj7pa4joZga8CIPJb2UKyjNWCc1JkuPP9coatSZC0jyV
         76oFX1J+0RfDgog+l0JGdanPNVux7AjCoFJeHhKZcx0e6zfx1/LnTpJs+QtWbUcMSb
         +f6LrpF5CFnL/fnAGeuChwsz3k3syx0mkaxhUDcg=
Date:   Sun, 2 Aug 2020 11:18:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, christian.gromm@microchip.com,
        linux-kernel@vger.kernel.org
Subject: Re: staging: most: Build error since commit "drivers: most: add USB
 adapter driver"
Message-ID: <20200802091831.GA139182@kroah.com>
References: <7c18e466-0941-ee7e-9a0f-5a993c993152@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c18e466-0941-ee7e-9a0f-5a993c993152@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 11:08:12AM +0200, Michael Straube wrote:
> Hi,
> 
> with commit 97a6f772f36b7f52bcfa56a581bbd2470cffe23d ("drivers: most: add USB adapter driver")
> I get build errors.
> 
> $ LANG=C make clean drivers/staging/rtl8188eu/
> scripts/Makefile.clean:15: drivers/staging/most/usb/Makefile: No such file or directory
> make[5]: *** No rule to make target 'drivers/staging/most/usb/Makefile'.  Stop.
> make[4]: *** [scripts/Makefile.clean:66: drivers/staging/most/usb] Error 2
> make[3]: *** [scripts/Makefile.clean:66: drivers/staging/most] Error 2
> make[2]: *** [scripts/Makefile.clean:66: drivers/staging] Error 2
> make[1]: *** [Makefile:1763: _clean_drivers] Error 2
> make: *** [Makefile:336: __build_one_by_one] Error 2
> 
> Did you forgot to remove the below line from drivers/staging/most/Makefile ?
> 
> obj-$(CONFIG_MOST_USB)	+= usb/

Ugh, yes, let me go fix that up right now, sorry...

greg k-h
