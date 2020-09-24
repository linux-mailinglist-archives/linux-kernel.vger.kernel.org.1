Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A392777CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgIXR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbgIXR3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:29:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A515F238A1;
        Thu, 24 Sep 2020 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600968546;
        bh=EgHvoK5O8OM1wJYXIt7SsQoaYrj43DPOJHTVtzGAAXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twuflN/niLRnVOY3qvybHXhGHKznfT/l5Nhr21+m8WEYXmeWhADvFqwF7vWVhknlF
         MGTymZQswDqRXI4AOC7B2Y1IN4s2M0dKtpzg0BaPbIYK6U+SmG+Vd91x00ncEwmd/I
         KXzF0nuadOJU12+UtclqGK3SlkDC2OQjjC5+XimM=
Date:   Thu, 24 Sep 2020 19:29:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Srinivasan Raju <srini.raju@purelifi.com>
Cc:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Rob Herring <robh@kernel.org>, information <info@purelifi.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mostafa Afgani <mostafa.afgani@purelifi.com>,
        open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] staging: Initial driver submission for pureLiFi devices
Message-ID: <20200924172922.GA1188119@kroah.com>
References: <20200924151910.21693-1-srini.raju@purelifi.com>
 <20200924153636.GA1171035@kroah.com>
 <CWLP265MB19727D19DE7D0498EEB2B1E4E0390@CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWLP265MB19727D19DE7D0498EEB2B1E4E0390@CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 05:24:14PM +0000, Srinivasan Raju wrote:
> 
> >> --- /dev/null
> >> +++ b/drivers/staging/purelifi/TODO
> >> @@ -0,0 +1,5 @@
> >> +TODO:
> >> +     - checkpatch.pl cleanups
> >> +
> >> +Please send any patches or complaints about this driver to pureLiFi Ltd
> >> +<info@purelifi.com>
> 
> >Why not just do these fixups on your own right now and submit it to the
> >"real" part of the kernel?  That should take what, a day or so max?
> >Just sending stuff to staging because you don't want to do coding style
> >cleanups feels very odd.  It takes much more work and energy to do it
> >this way than to just do it right the first time and get it merged to
> >the networking subsystem, right?
> 
> >So why do you want to send it to staging?
> 
> Thanks for the comments Greg, This is my first kernel patch, I was under  
> the impression that the staging area is the place to start for any new "Driver" code
> We will do the fixes and send an updated patch

No, staging is for things that people do not care about and want others
to help clean up and get merged properly :)

There's nothing in the "how to submit a driver/patch" documentation that
mentions that it has to go through staging first, does it?  If so, that
needs to be changed...

thanks,

greg k-h
