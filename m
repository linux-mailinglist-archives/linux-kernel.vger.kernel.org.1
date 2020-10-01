Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3611527F977
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgJAG3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAG3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:29:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC7420838;
        Thu,  1 Oct 2020 06:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601533753;
        bh=fZGGbCLnvCvTU8YE+8viQyhuUl17bRTfbA2M4DJIR9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KEHmAvsmHO8Cf3rs1KPDaLI4s8oBxsxIXcl8yk13X6+JL4+iD1slSsZIonSvgq2st
         H9zc2cjrlR+HB1p8p503AcgeoKwXHplGnc2hn8aFfYPFyS2HQrn1TgSpMPf45h2ORF
         XYtcKSQSmHJitKx+jF4FKwVXxCIpEV9LU0zO8Azk=
Date:   Thu, 1 Oct 2020 08:29:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: exclude char maintainers from things they
 do not maintain
Message-ID: <20201001062911.GB27677@kroah.com>
References: <20200930121007.GA1615300@kroah.com>
 <20200930133656.GY3674@minyard.net>
 <20200930162828.GA1672130@kroah.com>
 <ec0ed7046e170f315a100fbf7c7c2dd9d6f92958.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec0ed7046e170f315a100fbf7c7c2dd9d6f92958.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:02:46PM -0700, Joe Perches wrote:
> On Wed, 2020-09-30 at 18:28 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 30, 2020 at 08:36:56AM -0500, Corey Minyard wrote:
> > > On Wed, Sep 30, 2020 at 02:10:07PM +0200, Greg Kroah-Hartman wrote:
> > > > There are a number of subdirectories and files in drivers/char/ that
> > > > have their own maintainers and developers and ways of getting patches to
> > > > Linus.  This includes random.c, IPMI, hardware random drivers, TPM
> > > > drivers, and agp drivers.  Instead of sending those patches to Arnd and
> > > > myself, who can't do anything with them, send them to the proper
> > > > developers instead.
> > > > 
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Yes, please do.  No reason for you to get all the noise from these.
> > > 
> > > Acked-by: Corey Minyard <cminyard@mvista.com>
> > 
> > Thanks!
> > 
> > greg k-h
> 
> Your exclusion list is:
> 
> +X:	drivers/char/agp/
> +X:	drivers/char/hw_random/
> +X:	drivers/char/ipmi/
> +X:	drivers/char/random.c
> +X:	drivers/char/tpm/
> 
> But the current subdirectories of drivers/char are:
> 
> drivers/char/agp
> drivers/char/hw_random
> drivers/char/ipmi
> drivers/char/mwave
> drivers/char/pcmcia
> drivers/char/tpm
> drivers/char/tpm/eventlog
> drivers/char/tpm/st33zp24
> drivers/char/xilinx_hwicap
> drivers/char/xillybus
> 
> do you want to specifically maintain any of them?

Yes, the other ones we do maintain.

> Wouldn't it be easier to add a single subdirectory exclusion
> and add specific inclusions for subdirectories you actually
> do want to maintain>
> 
> 
> X:	drivers/char/*/
> F:	drivers/char/<whatever>

If we do that, it will be one extra line in the MAINTAINERS file, as we
are dealing with 4 we want, and 4 we don't :)

I like being explicit as to what we do NOT want to review, it's easier
to see when glancing at the file.

thanks,

greg k-h
