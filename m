Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C4277586
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgIXPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbgIXPgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:36:20 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49C6D221EB;
        Thu, 24 Sep 2020 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600961779;
        bh=WNZTZTSVuWO/IZHrM0LOYgxpeDcxocJGS0YFoO5Jgyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cX8W6QKfoyUYTckQzaOtewjAWhre2Tpr3Dnlh95n4L4vGd5cV1+xjAbMvCPWWIQZw
         /8nu25+xQ4Bw98A3I5Yz+agLp8YJxsVo2PGVHSPxLamPBJ8lYnbZnSLMYUj/vpBtDi
         DiLSsu8nzASTO0St+GdpFQGb0HpOFMyUCh+cX8iE=
Date:   Thu, 24 Sep 2020 17:36:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Srinivasan Raju <srini.raju@purelifi.com>
Cc:     mostafa.afgani@purelifi.com, pureLiFi Ltd <info@purelifi.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: Initial driver submission for pureLiFi devices
Message-ID: <20200924153636.GA1171035@kroah.com>
References: <20200924151910.21693-1-srini.raju@purelifi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924151910.21693-1-srini.raju@purelifi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 08:48:51PM +0530, Srinivasan Raju wrote:
> +PUREILIFI USB DRIVER
> +M:	pureLiFi Ltd <info@purelifi.com>

I need a real person here, having aliases as maintainers results in a
lack of accountability :(

> --- /dev/null
> +++ b/drivers/staging/purelifi/TODO
> @@ -0,0 +1,5 @@
> +TODO:
> +	- checkpatch.pl cleanups
> +
> +Please send any patches or complaints about this driver to pureLiFi Ltd
> +<info@purelifi.com>

Why not just do these fixups on your own right now and submit it to the
"real" part of the kernel?  That should take what, a day or so max?

Just sending stuff to staging because you don't want to do coding style
cleanups feels very odd.  It takes much more work and energy to do it
this way than to just do it right the first time and get it merged to
the networking subsystem, right?

So why do you want to send it to staging?

thanks,

greg k-h
